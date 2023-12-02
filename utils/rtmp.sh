#!/bin/bash

# DEVICE="DeckLink Mini Recorder 4K"
# FORMAT="hp60"
# INPUT_TYPE="hdmi"
# RTMP_URL=""

ffmpeg \
        -format_code $FORMAT \
        -f decklink \
        -video_input $INPUT_TYPE \
        -audio_input embedded \
        -raw_format argb \
        -i "$DEVICE" \
        -c:v libx264 \
        -preset medium \
        -pix_fmt yuv420p \
        -profile:v main \
        -c:a aac \
        -shortest \
        -f flv \
        "${RTMP_URL}"