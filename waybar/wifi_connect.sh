#!/bin/bash

device="wlan0"

#disconnect network
iwctl station $device disconnect

iwctl station "$device" scan

#choose SSID
network=$(iwctl station $device get-networks | awk -F '      ' 'NR>4 {print $2}' | rofi -dmenu -p "Search SSID")

#check if no network is selected
[ -z "$network" ] && exit 1

#prompt for password
password=$(rofi -dmenu -p "Enter password for $network")

iwctl --passphrase="$password" station "$device" connect "$network"
