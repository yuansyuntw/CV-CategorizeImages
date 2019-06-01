function [centers] = myKmeans(allDescriptors, kmenasNum)

f = uifigure;
d = uiprogressdlg(f, 'Title', 'Progrem KMeans');

d.Message  = "progress vl_ikmeans...";
[centers, assignements] = vl_kmeans(single(allDescriptors), kmenasNum, 'Initialization', 'plusplus');

close(d);
close(f);



