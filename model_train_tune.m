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

dataTrain_n = noisy_data(~idx);
dataTrain_w = whiteless_data(~idx);

data_train  = [dataTrain_b dataTrain_c];

opt = genfisOptions("GridPartition");
opt.NumMembershipFunctions = 5;
fisin = genfis(dataTrain_w, dataTrain_c, opt);
[in, out, rule] = getTunableSettings(fisin);
tuneopt = tunefisOptions("Method", "anfis");
tuneopt.MethodOptions.EpochNumber = 20;
fis = tunefis(fisin, [in;out], dataTrain_w, dataTrain_c, tuneopt);

save("model")