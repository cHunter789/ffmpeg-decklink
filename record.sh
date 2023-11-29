#!/bin/bash

# https://forum.blackmagicdesign.com/viewtopic.php?f=12&t=50941

# hp59 = 720p59.96
# replace hp59 with whatever format you like from:
# ffmpeg -f decklink -list_formats 1 -i '$DEVICE'


DEVICE='DeckLink Mini Recorder 4K'
FORMAT='Hp59'
PORT='hdmi'

ffprobe -f decklink -i '$DEVICE' -select_streams v:0 -video_input $PORT -audio_input embedded

ffmpeg -y -format_code $FORMAT -f decklink -video_input $PORT -audio_input embedded -raw_format argb -i '$DEVICE' -c:v libx264 -b:v 2000k /media/out.mp4