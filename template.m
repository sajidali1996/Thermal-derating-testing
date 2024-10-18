function template(app)
fprintf("AmbTemperature,Control-status,grid,battery_available,soc,VBUS_PV_MAX/10," + ...
     "VBUS_DISCHAR_MAX/10,VBUS_CHAR_MIN/10,VBUS_GRID_IMP_MAX/10,VBUS_GRID_EXP_MIN/10," + ...
     "PCS_RATED_VA,PCS_RATED_W,ICHARGE_MAX,IDISCHARGE_MAX\n");



temp=double(48);
 for i=1:65    
    cmd=strcat('{"T_AMB":' , string(temp*10),'}');
    app.inverterObj.send(char(cmd));
    pause(5);
    data=getData(app);
    fprintf("%.1f,%d,%d,%d,%.1f,%.1f,%d,%d,%d,%d,%d,%d,%.1f,%.1f\n", ...
    temp,data.control_status,data.grid,data.bat_available_,data.soc, ...
    data.VBUS_PV_MAX/10,data.VBUS_DISCHAR_MAX/10,data.VBUS_CHAR_MIN/10,data.VBUS_GRID_IMP_MAX/10, ...
       data.VBUS_GRID_EXP_MIN/10,data.PCS_RATED_VA,data.PCS_RATED_W,data.i_charge_max,data.i_discharge_max);
   
   temp=temp+0.2;
   
  
end
fprintf("End of Test \n")
function data = getData(app)
   data = struct2table(jsondecode(app.inverterObj.LatestMessage()),'AsArray',true);
end
%set inverter mode
end