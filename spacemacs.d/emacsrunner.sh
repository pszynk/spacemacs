#!/usr/bin/env bash

# Checks if frame open
emacsclient -n -e "(f (> (length (frame-list)) 1) ‘t)" 2> /dev/null | grep t &> /dev/null

if [ "$?" -eq "1" ]; then
    emacsclient -a '' -nwc "$@" &> /dev/null
else
    emacsclient -nwc "$@" &> /dev/null
fi

