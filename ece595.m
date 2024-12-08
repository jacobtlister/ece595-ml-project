clear
clc
format compact

load("/data/audio_data")

cv = cvpartition(size(clean_data,1), 'HoldOut', 0.2);
idx = cv.test;

dataTrain_c = clean_data(~idx);
dataTest_c  = clean_data(idx);

dataTrain_n = noisy_data(~idx);
dataTest_n  = noisy_data(idx);

dataTrain_b = backg_data(~idx);
dataTest_b  = backg_data(idx);

data_train  = [dataTrain_b dataTrain_c];

fis = anfis(data_train);

range = fis.Inputs.Range;
dataTest_b(find(dataTest_b < range(1))) = range(1);
dataTest_b(find(dataTest_b > range(2))) = range(2);

test = evalfis(fis, dataTest_b);

sound(clean_data, 44100)

plot(1 : length(test), 5 * test, 1 : length(test), dataTest_c)
