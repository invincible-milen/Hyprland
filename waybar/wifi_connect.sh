#!/bin/bash

device="wlan0"
logfile="/home/milen/.local/logs/wifi_connect.log"

#log function
log(){
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$logfile"
}

if ! iwctl station "$device" scan; then
	log "scan failed, ensure $device is enabled"
	exit 1
fi
log "scan successfull"

#choose SSID
network=$(iwctl station wlan0 get-networks | tail -n +5 | sed 's/[>]//;s/\x1b\[[0-9;]*m//g;s/^[[:space:]]*//' | awk '{print $1}'| rofi -dmenu -p "Enter SSID")

#check if no network is selected
if [ -z "$network" ]; then
	log "No network selected"
	exit 1
fi
log "Selected network: $network"

iwctl station $device disconnect
log "Disconnected from current network"

#prompt for password
password=$(rofi -dmenu -p "Enter password for $network")

if [ -z "$password" ]; then
	log "No password entered"
	exit 1
fi
log "Password entered"

if iwctl --passphrase="$password" station "$device" connect "$network"; then
	log "Successfully connected to $network"
else
	log "Failed to connect. Incorrect password"
	exit 1
fi
