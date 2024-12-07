% ---------------------------------------------------------------------------
% Oliver Bartz
% Jacob Lister
% ECE 595 Term Project
% MATLAB Data Formatting Script
% Reads all of the chopped audio files in and creates a .mat file
% containing all of the data for easy reading at the start of each run
% of the main program.
% ---------------------------------------------------------------------------

clear
clc
format compact

clean_data = audioread("/concatenated/concat_clean.wav");
noisy_data = audioread("/concatenated/concat_noisy.wav");
backg_data = audioread("/concatenated/concat_noisy_background.wav");

save("audio_data")