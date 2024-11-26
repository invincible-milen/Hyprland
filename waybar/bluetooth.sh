#!/bin/bash

# Check if Bluetooth is powered on
POWER_STATE=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
if [[ "$POWER_STATE" == "yes" ]]; then
  # Check if any devices are connected
  CONNECTED_DEVICE=$(bluetoothctl info | grep "Device" | awk '{print $2}')
  if [[ -n "$CONNECTED_DEVICE" ]]; then
    echo 0 # Bluetooth On, Device Connected
  else
    echo 2 # Bluetooth On, No Device Connected
  fi
else
  echo 1 # Bluetooth Off
fi

