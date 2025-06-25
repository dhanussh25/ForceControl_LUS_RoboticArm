clear all 

a = arduino;
f = readVoltage(a,'A0');
% For Loop
theSum = 0; % Initialize
for k = 100 : length(f);
  % Accumulate the sum
  theSum = theSum + f(k);
  % Compute the running mean and print out.
  fprintf(theSum/k);
end




% plot = line(nan,nan,'color','blue');
% i=0;
% while true 
%     force = readVoltage(a,'A0');
%     r = round(force, 2)
%     x1 = get(plot,'xData');
%     y1 = get(plot,'yData');
%     x1 = [x1,i];
%     y1 = [y1, r];
%     set(plot,'xData', x1,'yData',y1);
%     i = i+1;
% end


