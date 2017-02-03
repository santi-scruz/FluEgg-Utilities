%% Open spawning event time series
fid             = fopen('spawning.events.2015.txt');
data.title      = textscan(fid, '%s', 1, 'Delimiter', '\n');
data.sourcefile = textscan(fid, '%s', 1, 'Delimiter', '\n');
data.header     = textscan(fid, '%s', 3, 'Delimiter', '\t');
data.sample     = textscan(fid, '%f %s %f','Delimiter', '\t');
fclose(fid);

% Vectorize data
sampleN = data.sample{1};
time    = data.sample{2};
values  = data.sample{3};

% Find lowest discharge from spawning events
indx = find(values == min(values));
highflow.threshold = values(indx);    % Lowest discharge at Fremont
time_minQ = time{indx}; % Time of lowest discharge

%% Open multiannual timeseries
fid        = fopen('Fremont.FLOWS.2011.2015.txt');
dss.path   = textscan(fid, '%s', 1, 'Delimiter', '\n');
dss.header  = textscan(fid, '%s', 3, 'Delimiter', '\t');
textscan(fid,'%*s \n');
dss.units  = textscan(fid, '%*s %*s %s', 1, 'Delimiter', '\t');
dss.type   = textscan(fid, '%*s %*s %s', 1, 'Delimiter', '\t');
dss.data   = textscan(fid, '%f %s %f','Delimiter', '\t');
fclose(fid);

%Date formatting
date_time = dss.data{1,2};
T =4000;
for i = 1:T
    %date = cellfun(@(x) strsplit(x,','), date_time);
    dt = strsplit(date_time{i},',');
    date = strrep(dt{1},' ','-');
    time = strrep(dt{2},' ','');
    dats(i,1) = datenum(strcat({date},{' '}, {time}),'dd-mm-yy HH:MM');
end
precip = dss.data{1,3};

% Detect highflow evets
highflow_indx = find(precip(1:T) >= highflow.threshold);
dummy = find((diff(highflow_indx) > 1));
highflow.event.start = dats([highflow_indx(1); 
                        highflow_indx(dummy(1:(end - 1)) + 1)]);
highflow.event.end   = dats(highflow_indx(dummy));

%% Plotting
figure
plot(dats, precip(1:T))
hold on
plot(highflow.event.end, precip(highflow_indx(dummy)),'or')
plot(highflow.event.start, ones(length(highflow.event.start))*highflow.threshold,'xr')

