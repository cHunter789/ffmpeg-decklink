# ffmpeg-decklink
FFmpeg with decklink support based on a Dockerfile from ffmpeg/docker-images/5.1/ubuntu2004/
It's just a Dockerfile to build your own FFmpeg with decklink support. You have to download a BMD driver and SDK then unpack it directly to the Dockerfile directory. The folders names should be Blackmagic_Desktop_Video_Linux_12.4 and Blackmagic_DeckLink_SDK_12.4 as is set in the Dockerfile. I have to turn off the libvmaf to compilation success. 

## Dependencies
You'll need to download 2 files from Blackmagic's support page before building the docker file. You'll need:
1. [Desktop Video](https://www.blackmagicdesign.com/support/family/capture-and-playback)
2. [Desktop Video SDK](https://www.blackmagicdesign.com/support/family/capture-and-playback)

Download those files and unzip them into the same director as the `dockerfile`. Unzip the SDK into a folder titled `BMD_SDK` and unzip the Desktop Video tar ball into a folder called `BMD_DesktopVideo`. That's what the docker file references.

## How to use it?
The BMD driver has to be installed at the host. Copy the Dockerfile and unpack it to the same directory as the folders outlined above then type e.g
```bash
docker build -t ffmpeg-decklink:latest .
```
To run the container and go inside you can type e.g:
```bash
docker run -it --entrypoint='bash' --device=/dev/blackmagic ffmpeg-decklink:latest
```

## Available Formats
You can get the formats for your card using: `ffmpeg -f decklink -list_formats 1 -i '{card_name}'`
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
