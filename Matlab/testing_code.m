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

x = 245.116;
y = 0;
z = 223.076;

% reading the voltage from arduino 
a= arduino;

writeline(t,'SetJointVel(10)');

 str1 = 'MoveJoints(';
 str2 = ',';
 str3 = ')';

writeline(t,'MoveJoints(0,23.741,10.211,0,-33.952,0)');

z = 223.076;

i=0;
while true

    b = readVoltage(a,'A0');
    Volt = round(b,2)
     i = i+1; 

    if Volt < 0.15
        z = z - 0.05;
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
     
    else if (2 < Volt  &&  Volt < 2.5 ) 
        writeline(t,'Movejoints(0,0,20,0,0,0)');
    else if Volt > 2.5

         writeline(t,'Movejoints(0,0,0,0,0,0)');   
break 
    end
    end
    end
end

