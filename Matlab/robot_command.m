clear all
clc
addpath 'C:\Users\biom\Desktop\Alec- Undergrad\SYSC 4906 Lab Info'
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



while true
%     count = count + 1;
%     [pos, vel] = robot.EndEffectorForce(request);
%     velocity = norm([vel(1),vel(2),vel(3)]);
%     velocity = 65*velocity+75;
%     if velocity >=100
%         velocity = 99;
%     end
%     velocity_ = sprintf('%.3f',velocity);
%     velcmd = strcat(SetJointVel,velocity_,endVar)
%     writeline(t,velcmd);
%     while toc < 0.01  
%         
%     end
if 450*pos(3)-80 > 10
    posn = [190-150*pos(2);235*(pos(1)+0.05);450*pos(3)+130;0;pi/2;0]; %%make function of [x,y,z+\-ek,0,pi/2,0]
    q = wristRefInvKin(posn);
    t1 = sprintf('%.3f',q(1));
    t2 = sprintf('%.3f',q(2));
    t3 = sprintf('%.3f',q(3));
    t4 = sprintf('%.3f',q(4));
    t5 = sprintf('%.3f',q(5));
    t6 = sprintf('%.3f',q(6));
    command = strcat(str1,t1,str2,t2,str2,t3,str2,t4,str2,t5,str2,t6,str3);
    writeline(t,command);
else
    if pos(3)>pos_const(3) 
        pos_const = [pos(1),pos(2),pos(3)]
    end

posn = [const(1,1)-50*(pos(2)-pos_const(2));const(2,1)+50*(pos(1)-pos_const(1));150*pos(3)+5];

 q = needleConstrainedInvKin(const,posn);
    t1 = sprintf('%.3f',q(1));
    t2 = sprintf('%.3f',q(2));
    t3 = sprintf('%.3f',q(3));
    t4 = sprintf('%.3f',q(4));
    t5 = sprintf('%.3f',q(5));
    t6 = sprintf('%.3f',q(6));
    command = strcat(str1,t1,str2,t2,str2,t3,str2,t4,str2,t5,str2,t6,str3);
    writeline(t,command);
end

%     if mod(count, 100) == 0 
%        x = pos(1)
%        force = request(1)
%     end

%     while toc < 0.001  
%         
%     end
    
    totalTimeElapsed = totalTimeElapsed + toc;
    tic;

    if (totalTimeElapsed > 180.0)
        break
    end
    
end