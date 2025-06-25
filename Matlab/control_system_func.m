clear all
clc
addpath ' C:\Users\biom\Desktop\Alec- Undergrad\SYSC 4906 Lab Info\matlab_HardwareAPI_CS_wrapper'

t = mecaSetup;
q = mecaInit(t);

function t = mecaSetup

echotcpip('on',10000);
% t = tcpip('192.168.0.101',10000)
t = tcpclient('192.168.0.100',10000)
fopen(t); 
t.Status;
configureTerminator(t,00); 
writeline(t,'ActivateRobot');
readline(t)
writeline(t,'Home');
readline(t)
writeline(t,'ResetError');
readline(t)
writeline(t,'ResumeMotion');
readline(t)
writeline(t,'SetEOB(0)');
readline(t)
get(t,{ 'RemoteHost','RemotePort'})
writeline(t,'MoveJoints(0,0,0,0,0,0)');
readline(t)
end

function q = mecaInit
i = 0;
while true
    x = 279.315;
y = 0;
z = 226.304;

% reading the voltage from arduino 
a = arduino;
% settinf the velocity of the robot 
writeline(t,'SetJointVel(10)');
% % % % % % % % % % % % % % % % % % % 
 str1 = 'MoveJoints(';
 str2 = ',';
 str3 = ')';
% initial pose of the robot 
writeline(t,'MoveJoints(0,38.611,-14.569,0,-24.042,0)');
% Setting the desired voltage
desired_v = 1.5;
% for plotting the voltage value in time series
h = animatedline;
ax = gca;
startTime = datetime('now');
% % % % % % % % % % % % % % % % % % % % % % % % 
end
while true
%    press spacebar to end the loop and move to zero poistion 
    value = double(get(gcf,'CurrentCharacter'));  
    if value ~= 0
        writeline(t,'MoveJoints(0,0,0,0,0,0)');
        break
    end
% % % % % % % % % % % % % % % % % % % % % % % % 
    Volt = readVoltage(a,'A0');
    measured_v = round(Volt,2);
    Er =  measured_v - desired_v;   


o = datetime('now') - startTime;
    addpoints(h,datenum(o),measured_v);
    ax.XLim = datenum([o-seconds(10) o]);
    datetick('x','keeplimits');
    drawnow limitrate;

    if Er < 0     
       disp = Er * 0.3;% 0.2 is the constant k
%        curr = curr + Er;
       z = z + disp;
        posn = [x;y;z;0;pi/2;0]; 
     q = wristRefInvKin(posn);
     t1 = sprintf('%.3f',q(1));
     t2 = sprintf('%.3f',q(2));
     t3 = sprintf('%.3f',q(3));
     t4 = sprintf('%.3f',q(4));
     t5 = sprintf('%.3f',q(5));
     t6 = sprintf('%.3f',q(6));
     command = strcat(str1,t1,str2,t2,str2,t3,str2,t4,str2,t5,str2,t6,str3);
    writeline(t,command);
    

     
    else if Er == 0  
       disp = Er * 0.3; % 0.2 is the constant k 
       z = z + disp;
        posn = [x;y;z;0;pi/2;0]; 
     q = wristRefInvKin(posn);
     t1 = sprintf('%.3f',q(1));
     t2 = sprintf('%.3f',q(2));
     t3 = sprintf('%.3f',q(3));
     t4 = sprintf('%.3f',q(4));
     t5 = sprintf('%.3f',q(5));
     t6 = sprintf('%.3f',q(6));
     command = strcat(str1,t1,str2,t2,str2,t3,str2,t4,str2,t5,str2,t6,str3);
    writeline(t,command);
   

    else if Er > 0
            disp = Er * 0.3; % 0.2 is the constant k 
       z = z + disp;
        posn = [x;y;z;0;pi/2;0]; 
     q = wristRefInvKin(posn);
     t1 = sprintf('%.3f',q(1));
     t2 = sprintf('%.3f',q(2));
     t3 = sprintf('%.3f',q(3));
     t4 = sprintf('%.3f',q(4));
     t5 = sprintf('%.3f',q(5));
     t6 = sprintf('%.3f',q(6));
     command = strcat(str1,t1,str2,t2,str2,t3,str2,t4,str2,t5,str2,t6,str3);
    writeline(t,command);
    end
    end
    en
% ay = gca;
% xlabel('time');
% ylabel('voltage');
% title('voltage graph');
% ay.YLim = [0 5];
% grid on;
% 
%  p = datetime('now') - startTime;
%  addpoints(h,datenum(p),z);
%  ay.XLim = datenum([p-seconds(10) p]);
%  datetick('x','keeplimits');
%  drawnow limitrate;
end
end 