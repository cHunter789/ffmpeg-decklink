#!/bin/bash

# get decklink sources
ffmpeg -sources decklink

# get formats
ffmpeg -f decklink -list_devices 1 -i dummy

# list what input format is detected
ffprobe -f decklink -i 'DeckLink Mini Recorder 4K' -select_streams v:0 -video_input hdmi -audio_input embedded
