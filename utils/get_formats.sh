#!/bin/bash

DEVICE='DeckLink Mini Recorder 4K'

ffmpeg -f decklink -list_formats 1 -i '$DEVICE'