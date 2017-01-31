clear
fid             = fopen('spawning.events.2015.txt');
data.title      = textscan(fid, '%s', 1, 'Delimiter', '\n');
data.sourcefile = textscan(fid, '%s', 1, 'Delimiter', '\n');
data.header     = textscan(fid, '%s', 3, 'Delimiter', '\t');
data.sample     = textscan(fid, '%f %s %f','Delimiter', '\t');
fclose(fid)

sampleN = data.sample{1};
time    = data.sample{2};
values  = data.sample{3};

indx = find(values == min(values));
minQ = values(indx);
time_minQ = time{indx};
