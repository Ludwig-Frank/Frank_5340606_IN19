clear; clc; close all;
%%

x0 = 0;
maxIter = 60;
feps = 1e-16;
xeps = 1e-16;

%%
[xZero, abortFlag, iters] = myNewton('function',@myPoly,'LivePlot','on','maxIter',maxIter,'feps',feps,'xeps',xeps,'startvalue',x0);