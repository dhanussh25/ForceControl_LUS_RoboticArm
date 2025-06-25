clear all
clc
addpath ' C:\Users\biom\Desktop\Alec- Undergrad\SYSC 4906 Lab Info\matlab_HardwareAPI_CS_wrapper'
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



x = 197.565;
y = 0;
z = 224.056;

% reading the voltage from arduino 
a = arduino;

writeline(t,'SetJointVel(10)');

 str1 = 'MoveJoints(';
 str2 = ',';
 str3 = ')';

writeline(t,'MoveJoints(0,4.344,34.446,0,-38.791,0)');
% writeline(t,'MoveJoints(0,-5.412,44.097,0,-38.687,0)');
% x=279.315, y=0, z=226.304, aplha=0, beta=90, gamma=0

desired_N = 5; 

% i = 0;
totalTime = 0;
tic;
while true
    
    value = double(get(gcf,'CurrentCharacter'));  
    if value ~= 0
        writeline(t,'MoveJoints(0,0,0,0,0,0)');
        break
    end

    Volt = readVoltage(a,'A0');
    measured_v = round(Volt,2);
    b = 231.28 * measured_v - 11.507;
    force = b * 0.0098;
    force_N = round(force, 2)
    Er =  force_N - desired_N     
%   Er =  measured_v - desired_N     

    if Er < 0     
       disp = Er * 0.2;% 0.2 is the constant k
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
       disp = Er * 0.2; % 0.2 is the constant k 
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
            disp = Er * 0.2; % 0.2 is the constant k 
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
    end
totalTime = totalTime+toc;
subplot(2,1,1);
grid on;
plot(totalTime,z,'r.');hold on;drawnow;
ylim([-300 300])
xlabel('Time'); 
ylabel('displacement in mm');
subplot(2,1,2);
grid on;
plot(totalTime,force_N,'b.');hold on;drawnow;
ylim([-10 10])
xlabel('Time');
ylabel('Force in N');
toc;

end