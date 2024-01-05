#!/bin/bash
# quick way to run the script to get directly into interactive mode

docker run -it --entrypoint='bash' \
  --device=/dev/blackmagic \
  -e DEVICE="DeckLink Mini Recorder 4K" \
  -e INPUT_TYPE="hdmi" \
  -v /mnt/raid1/network_storage:/media \
  michaelgillett/ffmpeg-decklink:latest