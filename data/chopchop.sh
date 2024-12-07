#!/bin/bash
# File: chopchop.sh

: <<'info'
    description
        chops the audio files in /concatenated/ into 20ms chunks and puts them into their own folders.

    required packages
        ffmpeg

    additional notes
        EXTRA INFO IF NEEDED
info

# my goat
# https://superuser.com/a/525217

ffmpeg -i ./concatenated/concat_clean.wav -f segment -segment_time 0.02 -c copy ./segmented/clean/clean%04d.wav

ffmpeg -i ./concatenated/concat_noisy.wav -f segment -segment_time 0.02 -c copy ./segmented/noisy/noisy%04d.wav

ffmpeg -i ./concatenated/concat_noisy_background.wav -f segment -segment_time 0.02 -c copy ./segmented/noisy_background/noisy_background%04d.wav