%% Demo_RemoveArtifact
clear;clc;close all
load('Paper\Brain Commu\Revision\Code for Remove Artifact and Fit Commponents\DemoData_RemoveArtifact.mat')

Thre=3.5;

a=Data;
Len=floor(length(a)/SRate);
DD=a-mean(a);
DD=Filter_Data_HCL(DD,SRate,45,0.5);

for tt=1:Len
    FF(tt,:)=DD((tt-1)*SRate+1:tt*SRate);
end

[id,C]=kmeans(FF,10);   %% C: K cluster centroid locations

for ii=1:10
    subplot(4,5,ii+5)
    plot(1/512:1/512:1,C(ii,:),'linewidth',2);
    box off;%legend('C1','C2','C3','C4','C5','C6');
    set(gca,'linewidth',2,'fontsize',12);
    title([num2str(ii),'th cluster ',num2str(length(find(id==ii))),'s'])
    xlabel('Time/s');ylabel('Amp')
end
set(gcf,'color','w')


%%   reject artifacts

pos1=find(id~=1);
pos2=find(id~=2);
pos3=find(id~=3);
pos=intersect([pos1,pos2],pos3);

FF1=FF;FF1(pos,:)=[];
FF_Rec=reshape(FF1',1,size(FF1,1)*size(FF1,2));

subplot(4,5,1:5)
plot(DD,'k','linewidth',1.5);box off;title('Raw Data')
set(gca,'linewidth',2,'fontsize',12);xlim([0,length(DD)]);ylabel('Amp')
subplot(4,5,16:20)
plot(FF_Rec,'k','linewidth',1.5);box off;title(['Remove Arti'])
set(gca,'linewidth',2,'fontsize',12);xlim([0,length(DD)])
xlabel('Time/ 1/512 s');ylabel('Amp')


set(gcf,'color','w')
set(gcf,'Units','centimeters','Position',[0 1 40 25])



