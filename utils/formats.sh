#!/bin/bash

ffmpeg -hide_banner -loglevel panic -f decklink -list_formats 1 -i "${DEVICE}"