# ffmpeg-decklink
FFmpeg with decklink support based on a Dockerfile from ffmpeg/docker-images/5.1/ubuntu2004/
It's just a Dockerfile to build your own FFmpeg with decklink support.

## Dependencies
You'll need to download 2 files from Blackmagic's support page before building the docker file:
1. [Desktop Video](https://www.blackmagicdesign.com/support/family/capture-and-playback)
2. [Desktop Video SDK](https://www.blackmagicdesign.com/support/family/capture-and-playback)

Download those files and unzip them into the same directory as the `Dockerfile`. Unzip the SDK into a folder titled `BMD_SDK` and unzip the Desktop Video tar ball into a folder called `BMD_DesktopVideo`. That's what the dockerfile references.

## Deploying
There's 2 ways of going about deploying this service. You can either compile the docker image yourself, or pull it from Docker hub.

### Building the Dockerfile
1. Download the Desktop Video and SDK files ([see above](#dependencies))
1. Unzip the files into the same directory as the Dockerfile. The folder names should be `BMD_SDK` and `BMD_DesktopVideo`
1. Build the docker file with `docker build -t ffmpeg-decklink:latest .`

### Pull the Image from Docker Hub
If you'd rather not compile it yourself (it takes a while, I get it), you can also pull it from docker hub by doing:
```
docker pull michaelgillett/ffmpeg-decklink:latest
```

## Running the Container and Interacting with the Decklink Card
There's two ways of interacting with the image. You can either run it using the Docker CLI, or you can use Docker Compose.

### Environment Variables
- `DEVICE` - The name of the capture card you have installed. Mine is `DeckLink Mini Recorder 4K`, but yours might be different. Run `./scripts/sources.sh` to find out your card's proper name.
- `FORMAT` - The ingest video format you're being sent into the capture card. You can find out what the code is below or by running `./scripts/format.sh`
- `INPUT_TYPE` - Which input you're using. That's either `hdmi` or `sdi`
- `OUTPUT` - Where you want to save. If you have the `/media` volume mapped to your host machine, save it there. For example `/media/output.mp4`
- `DURATION` - Optional: how long you want to record for in seconds.
- `RTMP_URL` - The full url including stream key for where you want to send the ingested video.

## Examples

### Docker CLI
```
docker run -it --entrypoint='bash' \
  --device=/dev/blackmagic \
  -v /mnt/media:/media \
  -e DEVICE="DeckLink Mini Recorder 4K" \
  -e FORMAT=hp60 \
  -e INPUT_TYPE=hdmi \
  -e DURATION=7200 # OPTIONAL: how long you want to record for in seconds
  -e OUTPUT=/media/output.mp4 \
  -c ./scripts/record.sh \
  michaelgillett/ffmpeg-decklink:latest
```
### Docker Compose
```
services:
  ffmpeg-decklink:
    image: michaelgillett/ffmpeg-decklink:latest
    container_name: ffmpeg-decklink
    devices:
      - /dev/blackmagic:/dev/blackmagic
    volumes:
      - /mnt/raid1/network_storage/:/media/ # change the host path to whatever you need it to be
    environment:
      - DEVICE=DeckLink Mini Recorder 4K # name of the card
      - FORMAT=Hp59 # find out what format you're using with probe.sh
      - INPUT_TYPE=hdmi # either hdmi or sdi, depending on your model
      - OUTPUT=/media/out.mp4 # for use with record.sh
      - DURATION=7200 # OPTIONAL: how long you want to record for
      - RTMP_URL=rtmp://192.168.1.1/example/here?key=key # for use with rtmp.sh
    command: ["./scripts/rtmp.sh"]
    restart: unless-stopped
```

## Scripts
There are a few scripts located in the `/utils` directory that help with interacting with the decklink card. These files are saved to `/scripts` inside the dockerfile.

### sources.sh
This script will list the available Blackmagic Capture Cards in the container.

### get_formats.sh
You can use this to determine the format you want to use for your input.

### probe.sh
This script allows you to probe the input of the decklink card. You can use it to determine the format of the input.

### record.sh
This script will record the input of the decklink card to a file. You can use it to test the input of the card. You can use the `./scripts/get_formats.sh` script to determine the format you want to use for your input.

### rtmp.sh
This script will stream the input of the decklink card to an RTMP server. You can use it to test the input of the card. You can use the `./scripts/get_formats.sh` script to determine the format you want to use for your input.