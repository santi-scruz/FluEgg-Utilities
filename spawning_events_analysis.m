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
indx      = find(values == min(values));
time_minQ = time{indx}; % Time of lowest discharge among spawning events
highflow.threshold = min(values);

%% Open multiannual timeseries
fid        = fopen('Fremont.FLOWS.2011.2016.txt');
dss.path   = textscan(fid, '%s', 1, 'Delimiter', '\n');
dss.header  = textscan(fid, '%s', 3, 'Delimiter', '\t');
textscan(fid,'%*s \n');
dss.units  = textscan(fid, '%*s %*s %s', 1, 'Delimiter', '\t');
dss.type   = textscan(fid, '%*s %*s %s', 1, 'Delimiter', '\t');
dss.data   = textscan(fid, '%f %s %f','Delimiter', '\t');
fclose(fid);

%Date formatting
date_time = dss.data{1,2};
T = length(date_time); %To be deleted in future ONLY FOR TEST PURPOSES
T = 4000;
dats = cellfun(@(x) parse_date(x), date_time(1:T));
values = dss.data{1,3};

%% Detect highflow events
% Start/end times
highflow_indx = find(values(1:T) >= highflow.threshold);
dummy = find((diff(highflow_indx) > 1));

highflow.event.start_indx = [highflow_indx(1); 
                        highflow_indx(dummy + 1)];
highflow.event.end_indx   = [highflow_indx(dummy); 
                             highflow_indx(end)];                    

highflow.event.start_time = dats(highflow.event.start_indx);
highflow.event.end_time   = dats(highflow.event.end_indx);

% Peak times and peak values
highflow.event.maxValue       = arrayfun(@(x,y) max(values(x:y)),...
                                   highflow.event.start_indx,...
                                   highflow.event.end_indx);
highflow.event.maxValue_indx  = arrayfun(@(x,y,z) find(values(x:y) == z, 1),...
                                   highflow.event.start_indx,...
                                   highflow.event.end_indx,...
                                   highflow.event.maxValue);
highflow.event.maxValue_time  = arrayfun(@(x) dats(x),...
                (highflow.event.maxValue_indx + highflow.event.start_indx));
            
%% Raising and descending times
% Computation of the times from start of event to peak, and peak time to
% end of event.
highflow.event.risetime = arrayfun(@(x,y) round((y - x)*24*60,2),...
                          highflow.event.start_time,...
                          highflow.event.maxValue_time);         
highflow.event.descendtime = arrayfun(@(x,y) round((y - x)*24*60,2),...
                          highflow.event.maxValue_time,...
                          highflow.event.end_time); 
%% Plotting
figure
plot(dats, values(1:T))
hold on
plot(highflow.event.end_time     , values([highflow_indx(dummy); highflow_indx(end)]),'or')
plot(highflow.event.start_time   , values([highflow_indx(1); highflow_indx(dummy)])  ,'xr')
plot(highflow.event.maxValue_time, highflow.event.maxValue,                          '+b')
dateFormat = 12; %'mmmyy'
datetick('x',12)
ylabel('Flow (cms)')
grid off

figure

%% Export to Table
id = (1:length( highflow.event.maxValue))';
t = table(id, ...
          datestr(highflow.event.start_time),...
          datestr(highflow.event.end_time),...
          datestr(highflow.event.maxValue_time),...
          highflow.event.maxValue,...
          highflow.event.risetime,...
          highflow.event.descendtime);
t.Properties.VariableNames = {'id' 'Start' 'End' 'PeakTime' ...
    'PeakFlow_cms' 'RiseTime_min' 'DescendTime_min'};
writetable(t,'Summary2.txt','Delimiter','\t')