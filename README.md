# aprs-pigate
Prebuilt Raspberry Pi image for running a HAM radio APRS Internet Gateway using [direwolf] and [rtl-sdr]

## Feature List
:star: Pre-compiled `direwolf` and `rtl-sdr` library

:star: Pre-configured cron job runs every minute to make sure direwolf is running

:star: Logrotate keeps text file logs for the last 14 days and auto deletes older logs

:star: Works out-of-the-box receive-only igate with the [rtl-sdr] v3 kit.

:star: Easily configured for digipeater operation with a usb sound card connected to a radio

## Getting Started

### Installation
1. Download & Flash the image to an SD card
2. Insert SD card into a computer and load your [wpa_supplicant.conf] into boot if you are using wifi, and drop in a [direwolf.conf](files/boot/direwolf.conf) with your callsign and password. You can use any custom direwolf config file here, enabling many different hardware configurations!
3. Insert into a raspberry pi with RTL-SDR plugged into USB, and power up! If everything was configured correctly, in about 5 minutes you should see it pop up on [aprs.fi].

Once the pi is running, it should be available on your network with hostname `aprs-pigate` and accessible via SSH `pi@aprs-pigate` using the default raspberry password. It is a good idea to change this once logged in, or disable passwords altogether and use SSH keys, which you can do by modifying the `user-data` file accessible on the boot partition after flashing.

### Viewing Dire Wolf Output
The startup script creates a `screen` and executes the startup script [`pigate-start.sh`]. If at any time you want to explore the logs, you can ssh into your pigate and run the command `screen -r direwolf`. CTRL+C to leave the screen.

Logs are also written to `/home/pi/aprslogs/aprs.log`. You can view these with commands like `less` or `tail`, and generally may be easier to work with than the direwolf screen.

### Customizing the Start Script
If you are setting up a digipeater, you can disable the Software Defined Radio by creating an empty file `DISABLE_SDR` and placing it into the boot folder of your SD card along with `direwolf.conf`. See the [`pigate-start.sh`] startup script for more details.

## Contributing & Development
This project uses the following dependencies:
- Docker for Mac >= 2.3.2.0 (currently in edge)
- [`packer-build-arm-image`] in this repo I use the public docker image, but you can checkout this repo if you need to customize the build environment and build a custom docker image
- [`flash`] I use this to set a custom hostname on each flash, and is what is referenced in Makefile. However, you can flash the images using any conventional method.

Run `make build` to start building your first image.

[aprs.fi]: https://aprs.fi
[direwolf]: https://github.com/wb2osz/direwolf
[`flash`]: https://github.com/hypriot/flash
[`pigate-start.sh`]: files/home/pi/pigate-start.sh
[`packer-build-arm-image`]: https://github.com/solo-io/packer-builder-arm-image/
[rtl-sdr]: https://www.rtl-sdr.com/
[wpa_supplicant.conf]: https://www.raspberrypi.org/documentation/configuration/wireless/headless.md
