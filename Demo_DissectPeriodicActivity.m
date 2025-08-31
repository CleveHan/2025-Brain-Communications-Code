%% Demo_DissectPeriodicActivity
clear;clc;close all;

load('\Paper\Brain Commu\Revision\Code for Remove Artifact and Fit Commponents\DemoData_Fit.mat')

x=0.1:0.1:30;y=PowerSpectrum;

modelfun = @(b,x) [b(1)./(x.^(b(2))+b(3))]+b(4)+b(5)*exp(-(x-b(6)).^2/b(7)^2)

beta0 = [1,1,1,min(y),1,10,1];

mdl = fitnlm(x,y,modelfun,beta0);

% 显示结果
disp(mdl);
plot(x,y,'*');
hold on;
plot(x,predict(mdl,x'),'r-','linewidth',3);
legend('Data','Model')
set(gca,'linewidth',2,'fontsize',12)
box off;
set(gcf,'color','w')
xlabel('Freq/Hz');ylabel('Power')
