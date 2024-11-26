#!/bin/bash

wifi_status=$(nmcli -t -f WIFI g)
connection_name=$(nmcli -t -f NAME connection show --active | head -n 1)

if [[ "$wifi_status" == "enabled" && -n "$connection_name" ]]; then
    echo -n '{"icon": "", "tooltip": "'"$connection_name"'"}'
else
    echo -n '{"icon": "󰖪", "tooltip": "WiFi disconnected"}'
fi
