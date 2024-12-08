clear
clc
format compact

load("model")

range = fis.Inputs.Range;
backg_data(find(backg_data < range(1))) = range(1);
backg_data(find(backg_data > range(2))) = range(2);

test = evalfis(fis, backg_data);

%sound(15 * test(1 : (44100 * 10)), 44100)
%pause(15)
%sound(8*backg_data(1:(44100*10)), 44100)
pure_noise = backg_data - clean_data;

subplot(4,1,1)
plot(1 : length(test), test);
title("Filtered Data")
ylim([-0.6 0.6])
subplot(4,1,2)
plot(1 : length(test), clean_data);
title("Clean Data")
ylim([-0.6 0.6])
subplot(4,1,3)
plot(1 : length(test), backg_data);
title("Data with Noise")
ylim([-0.6 0.6])
subplot(4,1,4)
plot(1 : length(test), pure_noise);
title("Noise")
ylim([-0.6 0.6])

set(gcf, 'Position', [100 100 1200 600])

backg_spec = stft(backg_data, 44100);
backg_filt = wiener2(backg_spec, [16 16]);
backg_sign = abs(istft(backg_filt, 44100));

%sound(backg_sign(1 : (44100 * 10)), 44100);

fprintf("SNR for clean data: %.5f\n", snr(clean_data, pure_noise))
fprintf("SNR for data with background noise: %.5f\n", snr(backg_data, pure_noise))
fprintf("SNR for ANFIS filtered data: %.5f\n", snr(test, pure_noise))
fprintf("SNR fir Wiener fitered data: %.5f\n", snr(backg_sign, clean_data(1 : end - 2) - backg_sign))

