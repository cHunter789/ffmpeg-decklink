#!/bin/bash

### DESCRIPTION ###
# records video from capture card
# run this script by doing `./record.sh {RECORDING_NAME} {record_duration_minutes: integer}`
# for example:
    # ./record.sh tape_01 120

### DEFAULT VALUES ###
RECORDING_NAME="recording"
DURATION=0

### ENVIRONMENT VARIABLE CHECKS ###
if [[ -v DEVICE ]]; then
  echo "Recording capture device: $DEVICE"
else
  echo "Environment Variable DEVICE is not defined"
  exit 1
fi

if [[ -v INPUT_TYPE ]]; then
  echo "Recording input: $INPUT_TYPE"
else
  echo "Environment Variable INPUT_TYPE is not defined"
  exit 1
fi

### ARGUMENT CHECKS ###
if [ "$#" -ge 1 ]; then
  RECORDING_NAME="$1"
fi

if [ "$#" -ge 2 ]; then
  DURATION=$2
  echo "Record duration set to ${DURATION} minutes"
fi

# get the format of incoming video
PROBE_RESPONSE=$(ffprobe -hide_banner \
-f decklink \
-i "${DEVICE}" \
-select_streams v:0 \
-video_input ${INPUT_TYPE} \
-audio_input embedded \
-show_entries stream=width,height,r_frame_rate,field_order \
-of default=noprint_wrappers=1:nokey=1 -v quiet)

width=$(echo "$PROBE_RESPONSE" | awk 'NR==1')
height=$(echo "$PROBE_RESPONSE" | awk 'NR==2')
field_order=$(echo "$PROBE_RESPONSE" | awk 'NR==3')
r_frame_rate=$(echo "$PROBE_RESPONSE" | awk 'NR==4')

echo "Source dimensions: ${width}x${height} at ${r_frame_rate} fps"

FORMAT_CODE=$(grep "${width}x${height} at ${r_frame_rate} fps" ./formats.txt | awk '{print $1}')
echo "Input format code: ${FORMAT_CODE}"

COMMAND="ffmpeg -hide_banner -y \
-format_code $FORMAT_CODE \
-f decklink \
-video_input $INPUT_TYPE \
-audio_input embedded \
-raw_format argb \
-i \"${DEVICE}\""

if [ "$DURATION" != 0 ]; then
    DURATION = DURATION * 60 # convert minutes to seconds
    COMMAND="${COMMAND} -t $DURATION"
fi

TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")
RECORD_PATH="/media/${TIMESTAMP}_${RECORDING_NAME}.mkv"

echo "Recording destination set to: $RECORD_PATH"

COMMAND="${COMMAND} \
-c:v libx264 \
-preset ultrafast \
-crf 18 \
-pix_fmt yuv420p \
-profile:v main \
-c:a aac \"${RECORD_PATH}\""

echo "Running ffmpeg command: $COMMAND"
eval "${COMMAND}"