#!/usr/bin/env fish

function set_monitors
    if not set -q MONITORS
        echo "Detecting monitors .."
        set -Ux MONITORS (ddcutil detect | grep "I2C bus" | string match -r --groups-only "/dev/i2c-([0-9]+)")
    end

    if test (count $MONITORS) -eq 0
        echo "No monitors detected. Make sure you're part of the i2c group and i2c-dev kernel module is installed."
        exit 1
    end
end

function clear
    echo "Clearing cache .."
    set -e MONITORS
end

if contains -- "--clear" $argv
    clear
end

set_monitors

if test (count $argv) -eq 0
    echo "Usage: brightness <percentage>"
    echo "--clear: Clears monitor cache"
    return 1
end

set -l BRIGHTNESS $argv[1]

# Run ddcutil commands in parallel
for MONITOR in $MONITORS
    ddcutil --bus=$MONITOR setvcp 10 $BRIGHTNESS &
end

# Wait for all background processes to finish
wait
