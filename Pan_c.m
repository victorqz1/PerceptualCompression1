clear all; close all; Expect=zeros(10,3);
NIV=zeros(5,121); dev1=.4; dev2=.6; dev3=2.5;
for i=1:121
    x=-6.1+i*.1; A=normpdf(x,0,dev1);
    NIV(1,i)=A; NIV(2,i)=normpdf(x,0,dev2); NIV(3,i)=normpdf(x,0,dev3);
    NIV(4,i)=A*normcdf(x,0,dev2); NIV(5,i)=A*normcdf(x,0,dev3);
end
figure; hold on; XV=-6:.1:6; plot(XV,NIV(1,:),'ob','linewidth',1)
plot(XV,NIV(2,:),':b','linewidth',1); plot(XV,NIV(3,:),'b','linewidth',1)
plot(XV,NIV(4,:)*2,':r','linewidth',1); plot(XV,NIV(5,:)*2,'r','linewidth',1)
set(gca,'tickdir','out','ticklength',[.015 .015],'linewidth',1.5,'fontsize',22)
set(gca,'box','off','xlim',[-2.1 6.1],'ylim',[0 1.2],'ytick',0:.5:1);
xlabel('Expected percept utility (U)','fontsize',22); ylabel('p(U)','fontsize',22)
legend('PDF A: N(0,0.4)','PDF B: N(0,0.6)','PDF C: N(0,2.5)',...
    'PDF(X | E(A) > E(B))','PDF(X | E(A) > E(C))');
ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22,'location','Northeast')