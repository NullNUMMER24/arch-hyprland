#!/bin/bash

# Load the MAC address from the configuration file
source config.sh

# Start bluetoothctl and wait for prompt
echo -e 'power on\nconnect '$AIRPODS_MAC'\nquit' | bluetoothctl

# Wait for AirPods to connect
echo "Waiting for AirPods to connect..."
while ! bluetoothctl info $AIRPODS_MAC | grep -q "Connected: yes"; do
    sleep 1
done

echo "AirPods connected."

