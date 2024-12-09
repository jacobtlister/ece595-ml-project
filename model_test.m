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

set(gcf, 'Position', [100 100 1200 600])

backg_spec = stft(backg_data, 44100);
backg_filt = wiener2(backg_spec, [16 16]);
backg_sign = real(istft(backg_filt, 44100));

%sound(backg_sign(1 : (44100 * 10)), 44100);

fprintf("SNR for data with background noise: %.5f\n", db2mag(snr(backg_data, backg_data - clean_data)))
fprintf("SNR for ANFIS filtered data: %.5f\n", db2mag(snr(test, clean_data - test)))
fprintf("SNR for Wiener filtered data: %.5f\n", db2mag(snr(backg_sign, clean_data(1 : end - 2) - backg_sign)))

audiowrite("concat_anfis.wav", test, 44100)
audiowrite("concat_wiener.wav", backg_sign, 44100)

figure(1)
subplot(4,1,1)
plot(1 : length(test), clean_data);
title("Clean Data")
ylim([-0.6 0.6])
subplot(4,1,2)
plot(1 : length(test), backg_data);
title("Input Noisy Data")
ylim([-0.6 0.6])
subplot(4,1,3)
plot(1 : length(test), test);
title("ANFIS Filtered Data")
ylim([-0.6 0.6])
subplot(4,1,4)
plot(1 : length(backg_sign), backg_sign);
title("Wiener Filtered Data")
ylim([-0.6 0.6])

figure(2)
spectrogram(clean_data, 44100, 'yaxis')
title("Clean Data")
ylabel("Frequency (Hz)")
xlabel("Time (sec)")
yticks([0 0.2 0.4 0.6 0.8 1])
yticklabels([0 (44100 * 0.1)  (44100 * 0.2)  (44100 * 0.3)  (44100 * 0.4)  (44100 * 0.5)])
xticks(0 : (5 * 44100) : (60 * 44100))
xticklabels(0 : 5 : 60)
figure(3)
spectrogram(backg_data, 44100, 'yaxis')
title("Input Noisy Data")
ylabel("Frequency (Hz)")
xlabel("Time (sec)")
yticks([0 0.2 0.4 0.6 0.8 1])
yticklabels([0 (44100 * 0.1)  (44100 * 0.2)  (44100 * 0.3)  (44100 * 0.4)  (44100 * 0.5)])
xticks(0 : (5 * 44100) : (60 * 44100))
xticklabels(0 : 5 : 60)
figure(4)
spectrogram(test, 44100, 'yaxis')
title("ANFIS Filtered Data")
ylabel("Frequency (Hz)")
xlabel("Time (sec)")
yticks([0 0.2 0.4 0.6 0.8 1])
yticklabels([0 (44100 * 0.1)  (44100 * 0.2)  (44100 * 0.3)  (44100 * 0.4)  (44100 * 0.5)])
xticks(0 : (5 * 44100) : (60 * 44100))
xticklabels(0 : 5 : 60)
figure(5)
spectrogram(backg_sign, 44100, 'yaxis')
title("Wiener Filtered Data")
ylabel("Frequency (Hz)")
xlabel("Time (sec)")
yticks([0 0.2 0.4 0.6 0.8 1])
yticklabels([0 (44100 * 0.1)  (44100 * 0.2)  (44100 * 0.3)  (44100 * 0.4)  (44100 * 0.5)])
xticks(0 : (5 * 44100) : (60 * 44100))
xticklabels(0 : 5 : 60)