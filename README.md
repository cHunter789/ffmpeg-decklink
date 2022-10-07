# ffmpeg-decklink
FFmpeg with decklink support based on a Dockerfile from ffmpeg/docker-images/5.1/ubuntu2004/
It's just a Dockerfile to build your own FFmpeg with decklink support. You have to download a BMD driver and SDK then unpack it directly to the Dockerfile directory. The folders names should be Blackmagic_Desktop_Video_Linux_12.4 and Blackmagic_DeckLink_SDK_12.4 as is set in the Dockerfile. I have to turn off the libvmaf to compilation success. 

## How to use it?
The BMD driver 12.4 have to be installed at the host. Copy the Dockerfile and unpack it to the same directory as the downloaded Blackmagic_Desktop_Video_Linux_12.4 and Blackmagic_DeckLink_SDK_12.4 then type e.g
```bash
 docker build -t ffmpeg-decklink:5.1-ubuntu2004 .
```
To run the container and go inside you can type e.g:
```bash
 docker run -it --entrypoint='bash' --device=/dev/blackmagic ffmpeg-decklink:5.1-ubuntu2004
```
