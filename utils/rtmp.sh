#!/bin/bash

DEVICE="DeckLink Mini Recorder 4K"
FORMAT="Hp59"
INPUT_TYPE="hdmi"
RTMP_URL="" # rtmp://a.rtmp.youtube.com/live2

ffmpeg \
	-format_code $FORMAT \
	-f decklink \
	-video_input $INPUT_TYPE \
	-audio_input embedded \
	-raw_format argb \
	-i "$DEVICE" \
	-c:v libx264 \
	-c:a aac \
 	-preset superfast \
	-f flv \
	"${RTMP_URL}"
