#!/bin/bash

# get decklink sources
ffmpeg -sources decklink

# get formats
ffmpeg -f decklink -list_devices 1 -i dummy
