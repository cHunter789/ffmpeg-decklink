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
 docker build -t ffmpeg-decklink:5.1-ubuntu2004 .
```
To run the container and go inside you can type e.g:
```bash
 docker run -it --entrypoint='bash' --device=/dev/blackmagic ffmpeg-decklink:5.1-ubuntu2004
```
