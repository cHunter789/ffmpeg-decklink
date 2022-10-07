# ffmpeg-decklink
FFmpeg with decklink support based on Dockerfile from ffmpeg/docker-images/5.1/ubuntu2004/
It's just Dockerfile to build your own FFmpeg with decklink support. You have to download yourself a BMD driver and SDK then unpack it directly to the Dockerfile directory. The folders names should be Blackmagic_Desktop_Video_Linux_12.4 and Blackmagic_DeckLink_SDK_12.4 as is set in Dockerfile. I have to turn off the libvmaf to compilation success. 

## How to use it?
The BMD driver 12.4 have to be installed at the host. Copy Dockerfile and unpack to the same directory the downloaded Blackmagic_Desktop_Video_Linux_12.4 and Blackmagic_DeckLink_SDK_12.4 then type e.g
```bash
 docker build -t ffmpeg-decklink:5.1-ubuntu2004 .
```
To run the container to check it you can type e.g:
```bash
 docker run -it --entrypoint='bash' --device=/dev/blackmagic ffmpeg-decklink:5.1-ubuntu2004
```
