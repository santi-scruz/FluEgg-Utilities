%% Open spawning event time series
fid             = fopen('spawning.events.2015.txt');
data.title      = textscan(fid, '%s', 1, 'Delimiter', '\n');
data.sourcefile = textscan(fid, '%s', 1, 'Delimiter', '\n');
data.header     = textscan(fid, '%s', 3, 'Delimiter', '\t');
data.sample     = textscan(fid, '%f %s %f','Delimiter', '\t');
fclose(fid)

% Vectorize data
sampleN = data.sample{1};
time    = data.sample{2};
values  = data.sample{3};

% Find lowest discharge from spawning events
indx = find(values == min(values));
minQ = values(indx);    % Lowest discharge at Fremont
time_minQ = time{indx}; % Time of lowest discharge

%% Open multiannual timeseries
fid        = fopen('Fremont.FLOWS.2011.2015.txt');
dss.path   = textscan(fid, '%s', 1, 'Delimiter', '\n');
dss.header  = textscan(fid, '%s', 3, 'Delimiter', '\t');
textscan(fid,'%*s \n')
dss.units  = textscan(fid, '%*s %*s %s', 1, 'Delimiter', '\t');
dss.type   = textscan(fid, '%*s %*s %s', 1, 'Delimiter', '\t');
dss.data   = textscan(fid, '%f %s %f','Delimiter', '\t');
fclose(fid)
