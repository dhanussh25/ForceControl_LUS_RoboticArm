clear all 

desired_v = 2.25;

a = arduino;
% i=0;
% h = animatedline;
% ax = gca;
% xlabel('time');
% ylabel('voltage');
% title('voltage graph');
% ax.YLim = [-5 5];
% grid on;
% 
% startTime = datetime('now');
% 
% while true 
%     force = readVoltage(a,'A0');
%     r = round(force, 2);
%     
%     Er = r - desired_v
%     t = datetime('now') - startTime;
%     addpoints(h,datenum(t),r);
%     ax.XLim = datenum([t-seconds(10) t]);
%     datetick('x','keeplimits');
%     drawnow limitrate;
% 
% 
% 
% %     x1 = get(plot,'xData');
% %     y1 = get(plot,'yData');
% %     x1 = [x1,i];
% %     y1 = [y1, Er];
% %     set(plot,'xData', x1,'yData',y1);
% %     i = i+1;
% end 
totalTime = 0;
tic;
while true 
    force = readVoltage(a,'A0');
    r = round(force, 2);

    totalTime = totalTime+toc;
    plot(totalTime,r,'r.');hold on;drawnow;
    toc;
end 