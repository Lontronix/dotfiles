#! /usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch draculabar
polybar draculabar >>/tmp/draculabar.log 2>&1
