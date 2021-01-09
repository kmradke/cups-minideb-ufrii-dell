# cups-minideb-ufrii-dell

## Overview
Docker image based on minideb including a CUPS server with Canon MF8050cn and Dell e310dw printer drivers.

## Notes
* Intended to run on unRAID, but may be useful for others
* Assumes the host Avahi service is configured and working
* Drivers are downloaded and installed from manufacturer website(s)
* Configuration files are periodically persisted to /config (wait awhile after changes before restarting container)

## Configuration

### Volumes:
* `/config`: where the persistent printer configs will be stored
* `/services`: where the Avahi service files will be generated (typically from /etc/avahi/services)

### Variables:
* `CUPSADMIN`: the CUPS admin user you want created
* `CUPSPASSWORD`: the password for the CUPS admin user

### Ports:
* `631`: the TCP port for CUPS must be exposed

## Interface
The CUPS web interface will be available at https://[IP]:631 using the CUPSADMIN/CUPSPASSWORD specified

## Inspiration
Inspired by and based on https://github.com/quadportnick/docker-cups-airprint and https://github.com/tjfontaine/airprint-generate
* All praise should go to the original author(s)
* All complaints should be sent to me
