%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function is required by spawning_event_analysis.m                %%
%% Created by: Santiago Santacruz                                        %%
%% Last modified: 02/06/2017                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function [dats] = parse_date(date_text)
    dt = strsplit(date_text,','); %date_text = dd mmm yy, HH:MM
    date = strrep(dt{1},' ','-'); %Use '-' separator for date
    time = strrep(dt{2},' ','');
    dats = datenum(strcat({date},{' '}, {time}),'dd-mm-yy HH:MM');
end