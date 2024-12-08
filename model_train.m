clear
clc
format compact

load("./data/audio_data")

cv = cvpartition(size(clean_data,1), 'HoldOut', 0.2);
idx = cv.test;

dataTrain_c = clean_data(~idx);
dataTest_c  = clean_data(idx);

dataTrain_b = backg_data(~idx);
dataTest_b  = backg_data(idx);

data_train  = [dataTrain_b dataTrain_c];

opt = anfisOptions("EpochNumber", 50);

fis = anfis(data_train, opt);

save("model")