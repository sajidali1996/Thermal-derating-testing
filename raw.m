
start_temp=48;       %write starting temperature can be larger or smaller than end_temp
end_temp=61;         %write ending temperature can be larger or smalller than start_temp
step_temp=0.2;        %write in positive always


%initialization

if(start_temp>end_temp)   
    step_temp=step_temp*1; % positive increment for increasing temperature
else
    step_temp = step_temp*-1;   % negative increment for decreasing temperature
end

L=length(start_temp:step_temp:end_temp);



%loop for repeating the test
temp=start_temp;    %initial set value
for i=1:L
  
 %set the inverter temperature
  


 %get stats from inverter


 %parse required stats from payload

 

 %set next temperature
 temp=tem
   

end



