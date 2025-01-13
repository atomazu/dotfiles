#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
  # hyprsunset is running, kill it to turn it "OFF"
  pkill -x "hyprsunset"
else
  # hyprsunset is not running, start it to turn it "ON"
  hyprsunset -t 3500
fi