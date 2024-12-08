clear
clc
format compact

load("model")

range = fis.Inputs.Range;
backg_data(find(backg_data < range(1))) = range(1);
backg_data(find(backg_data > range(2))) = range(2);

test = evalfis(fis, backg_data);

sound(15 * test(1 : (44100 * 10)), 44100)

plot(1 : length(test), 15 * test, 1 : length(test), clean_data)