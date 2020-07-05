# aprs-pigate
Prebuilt Raspberry Pi image for running a HAM radio APRS Internet Gateway using [direwolf] and [rtl-sdr]

## Usage
1. Download & Flash the image to an SD card
2. Insert SD card into a computer and load your wpa_supplicant.conf into boot if you are using wifi, and drop in a [pigate.conf](files/boot/pigate.conf) with your Callsign and password. You can use any custom direwolf config file here, enabling many different hardware configurations!
3. Insert into a raspberry pi with RTL-SDR plugged into USB, and power up! If everything was configured correctly, in about 5 minutes you should see it pop up on [aprs.fi].

## Contributing & Development
This project uses the following dependencies:
- Docker for Mac >= 2.3.2.0 (currently in edge)
- [`packer-build-arm-image`] in this repo I use the public docker image, but you can checkout this repo if you need to customize the build environment and build a custom docker image
- [`flash`] I use this to set a custom hostname on each flash, and is what is referenced in Makefile. However, you can flash the images using any conventional method.

Run `make build` to start building your first image.

[aprs.fi]: https://aprs.fi
[direwolf]: https://github.com/wb2osz/direwolf
[`flash`]: https://github.com/hypriot/flash
[`packer-build-arm-image`]: https://github.com/solo-io/packer-builder-arm-image/
[rtl-sdr]: https://www.rtl-sdr.com/
