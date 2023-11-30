#!/bin/bash

RTMP_URL=''
FORMAT=''
INPUT_TYPE=''
CARD=''

ffmpeg \
	-format_code $FORMAT \
	-f decklink \
	-video_input $INPUT_TYPE \
	-audio_input embedded \
	-raw_format argb \
	-i '$CARD’ \
	-c:v libx264 \
	-c:a aac \
	-f flv \
	$RTMP_URL
