#!/bin/bash

# records video from capture card

DEVICE='DeckLink Mini Recorder 4K'
FORMAT='Hp59'
INPUT_TYPE='hdmi'
OUTPUT='/media/out.mp4'

ffmpeg -y \
    -format_code $FORMAT \
    -f decklink \
    -video_input $INPUT_TYPE \
    -audio_input embedded \
    -raw_format argb \
    -i '$DEVICE' \
    -c:v libx264 \
    -c:a aac \
    '$OUTPUT'