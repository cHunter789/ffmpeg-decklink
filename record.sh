#!/bin/bash

DEVICE='DeckLink Mini Recorder 4K'
FORMAT='hp59'
# hp59 = 720p59.96
# replace hp59 with whatever format you like from:
# ffmpeg -f decklink -list_formats 1 -i '$DEVICE'

ffmpeg -format_code $FORMAT -f decklink -i '$DEVICE' -c:v libx264 -b:v 2000k output.mp4
