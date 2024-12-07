

clear
clc
format compact

clean_data = [];
noisy_data = [];
backg_data = [];

for i = 0:1194
    file_clean = "/segmented/clean/clean" + num2str(i, "%04d") + ".wav";
    file_noisy = "/segmented/noisy/noisy" + num2str(i, "%04d") + ".wav";
    file_backg = "/segmented/noisy_background/noisy_background" + num2str(i, "%04d") + ".wav";
    clean_data = [clean_data audioread(file_clean)];
    noisy_data = [noisy_data audioread(file_noisy)];
    backg_data = [backg_data audioread(file_backg)];
end

save("audio_data")