function increase_temperature(app)
start_temp=48;       %write starting temperature can be larger or smaller than end_temp
end_temp=61;         %write ending temperature can be larger or smalller than start_temp
step_temp=0.2;        %write in positive always
step_dur = 2;        %write duration between each step in seconds


%initialization

if(start_temp<end_temp)   
    step_temp=step_temp*1; % positive increment for increasing temperature
else
    step_temp = step_temp*-1;   % negative increment for decreasing temperature
end

L=length(start_temp:step_temp:end_temp);



%loop for repeating the test
% fprintf("Headers\n");    %display headers for the data acquisition
fprintf("Temp,Ctrl,grid,batt,soc,VBUS_PV_MAX,VBUS_DISCHAR_MAX,VBUS_CHAR_MIN,VBUS_GRID_IMP_MAX,VBUS_GRID_EXP_MIN,PCS_RATED_VA,PCS_RATED_W,ICHARGE_MAX,IDISCHARGE_MAX,PCLIP_LIMIT\n");
temp=start_temp;    %initial set value
for i=1:L
  
 %set the inverter temperature(temperature set value is scaled by 10x
 app.inverterObj.send(char(strcat('{"T_AMB":' , string(temp*10),'}')));
 pause(1);

 %take a pause for inverter state to adjust according to the set value
 pause(step_dur);
 %get stats from inverter
 data = struct2table(jsondecode(app.inverterObj.LatestMessage()),'AsArray',true);

 %parse required stats from payload
 %array_data=[temp,data.control_status,data.grid,data.bat_available_,data.soc,data.VBUS_PV_MAX/10,data.VBUS_DISCHAR_MAX/10,data.VBUS_CHAR_MIN/10,data.VBUS_GRID_IMP_MAX/10, ...
  %     data.VBUS_GRID_EXP_MIN/10,data.PCS_RATED_VA,data.PCS_RATED_W,data.i_charge_max,data.i_discharge_max,data.PCLIP_LIMIT];
fprintf('%.1f, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %.1f\n', ...
    temp, data.control_status, data.grid, data.bat_available_, data.soc, data.VBUS_PV_MAX/10, ...
    data.VBUS_DISCHAR_MAX/10, data.VBUS_CHAR_MIN/10, data.VBUS_GRID_IMP_MAX/10, ...
    data.VBUS_GRID_EXP_MIN/10, data.PCS_RATED_VA, data.PCS_RATED_W, data.i_charge_max, ...
    data.i_discharge_max, data.PCLIP_LIMIT);

 %display the acquired parameters

%


 %set next temperature
 temp=temp+step_temp;

 

end

end

