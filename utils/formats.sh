#!/bin/bash

ffmpeg -hide_banner -f decklink -list_formats 1 -i "${DEVICE}"