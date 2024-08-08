#!/bin/bash
# This script will run the timer program

# Set the path to the timer program
TIMER_PATH="/home/zerq/RiderProjects/CliTimer/bin/Release/net8.0/linux-x64/publish/"

# Check if the TIMER_PATH exists
if [ ! -d "$TIMER_PATH" ]; then
  echo "The directory $TIMER_PATH does not exist. Exiting."
  exit 1
fi

# Define the timer options
TIMER_OPTIONS="Custom\nm5\nm10\nm15\nm20\nm30\nh1\nh2"

# Run the timer program
TIMER_DURATION=$(echo -e "$TIMER_OPTIONS" | rofi -dmenu -p "Select timer duration:")

# Check if the user provided a duration
if [ -z "$TIMER_DURATION" ]; then
  echo "No duration provided. Exiting."
  exit 1
fi

# Convert the selected duration to seconds
case $TIMER_DURATION in
  m5) TIMER_DURATION=$((60 * 5)) ;;
  m10) TIMER_DURATION=$((60 * 10)) ;;
  m15) TIMER_DURATION=$((60 * 15)) ;;
  m20) TIMER_DURATION=$((60 * 20)) ;;
  m30) TIMER_DURATION=$((60 * 30)) ;;
  h1) TIMER_DURATION=$((60 * 60)) ;;
  h2) TIMER_DURATION=$((60 * 60 * 2)) ;;
  Custom)
    TIMER_DURATION=$(rofi -dmenu -p "Enter custom timer duration in seconds:")
    if [ -z "$TIMER_DURATION" ]; then
      echo "No custom duration provided. Exiting."
      exit 1
    fi
    ;;
  *)
    # Assume the user entered a custom duration directly
    ;;
esac

# Run the timer program in a new kitty terminal
kitty --directory "$TIMER_PATH" ./CliTimer "$TIMER_DURATION"