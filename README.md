# ffmpeg-decklink
FFmpeg with decklink support based on a Dockerfile from ffmpeg/docker-images/5.1/ubuntu2004/
It's just a Dockerfile to build your own FFmpeg with decklink support. You have to download a BMD driver and SDK then unpack it directly to the Dockerfile directory. The folders names should be Blackmagic_Desktop_Video_Linux_12.4 and Blackmagic_DeckLink_SDK_12.4 as is set in the Dockerfile. I have to turn off the libvmaf to compilation success. 

## Dependencies
You'll need to download 2 files from Blackmagic's support page before building the docker file. You'll need:
1. [Desktop Video](https://www.blackmagicdesign.com/support/family/capture-and-playback)
2. [Desktop Video SDK](https://www.blackmagicdesign.com/support/family/capture-and-playback)

Download those files and unzip them into the same director as the `Dockerfile`. Unzip the SDK into a folder titled `BMD_SDK` and unzip the Desktop Video tar ball into a folder called `BMD_DesktopVideo`. That's what the docker file references.

## Building the Dockerfile
1. Install Docker
2. Download the Desktop Video and SDK files (see above)
3. Unzip the files into the same directory as the Dockerfile. The folder names should be `BMD_SDK` and `BMD_DesktopVideo`
4. Build the docker file with `docker build -t ffmpeg-decklink:latest .`

## Running the Container and Interacting with the Decklink Card
Start the container using the command:
```
docker run -it --entrypoint='bash' --device=/dev/blackmagic ffmpeg-decklink:latest
```

## Scripts
There are a few scripts located in the `/utils` directory that help with interacting with the decklink card.

### sources.sh
This script will list the available Blackmagic Capture Cards in the container.

### get_formats.sh
You can use this to determine the format you want to use for your input. An example of its output is below in the [Available Formats](#available-formats) section.

### probe.sh
This script allows you to probe the input of the decklink card. You can use it to determine the format of the input.

### record.sh
This script will record the input of the decklink card to a file. You can use it to test the input of the card. You can use the `utils/get_formats.sh` script to determine the format you want to use for your input.

### rtmp.sh
This script will stream the input of the decklink card to an RTMP server. You can use it to test the input of the card. You can use the `utils/get_formats.sh` script to determine the format you want to use for your input.

## Available Formats
You can get the formats for your card using: `utils/get_formats.sh`
```
Supported formats for 'DeckLink Mini Recorder 4K':
format_code	description
ntsc		720x486 at 30000/1001 fps (interlaced, lower field first)
pal 		720x576 at 25000/1000 fps (interlaced, upper field first)
23ps		1920x1080 at 24000/1001 fps
24ps		1920x1080 at 24000/1000 fps
Hp25		1920x1080 at 25000/1000 fps
Hp29		1920x1080 at 30000/1001 fps
Hp30		1920x1080 at 30000/1000 fps
Hp50		1920x1080 at 50000/1000 fps
Hp59		1920x1080 at 60000/1001 fps
Hp60		1920x1080 at 60000/1000 fps
Hi50		1920x1080 at 25000/1000 fps (interlaced, upper field first)
Hi59		1920x1080 at 30000/1001 fps (interlaced, upper field first)
Hi60		1920x1080 at 30000/1000 fps (interlaced, upper field first)
hp50		1280x720 at 50000/1000 fps
hp59		1280x720 at 60000/1001 fps
hp60		1280x720 at 60000/1000 fps
2d23		2048x1080 at 24000/1001 fps
2d24		2048x1080 at 24000/1000 fps
2d25		2048x1080 at 25000/1000 fps
4k23		3840x2160 at 24000/1001 fps
4k24		3840x2160 at 24000/1000 fps
4k25		3840x2160 at 25000/1000 fps
4k29		3840x2160 at 30000/1001 fps
4k30		3840x2160 at 30000/1000 fps
4d23		4096x2160 at 24000/1001 fps
4d24		4096x2160 at 24000/1000 fps
4d25		4096x2160 at 25000/1000 fps
4d29		4096x2160 at 30000/1001 fps
4d30		4096x2160 at 30000/1000 fps
```
