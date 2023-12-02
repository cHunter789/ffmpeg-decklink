#!/bin/bash

# returns what type of video the capture card is receiving

# DEVICE="DeckLink Mini Recorder 4K"
# INPUT_TYPE="hdmi"

ffprobe \
    -f decklink \
    -i "${DEVICE}" \
    -select_streams v:0 \
    -video_input $INPUT_TYPE \
    -audio_input embedded