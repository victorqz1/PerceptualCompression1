clear all; close all; Ev=zeros(4,2); xval=2:51; EvT=zeros(50,4); EvG=EvT;
for r=1:4
    m=14*(r-1); dev1=2/sqrt(50-m); dev2=2/sqrt(50+m); NIV=zeros(2,10001);
    for i=1:10001
        x=-5.001+i*.001; A1=normpdf(x,0,dev1); A2=normcdf(x,0,dev2);
        A3=normpdf(x,0,dev2); A4=normcdf(x,0,dev1);
        NIV(1,i)=A1*A2*x; NIV(2,i)=A3*A4*x;
    end
    A1=sum(NIV,2)/1000; Ev(r,:)=A1';
end
for j=2:51
    P=zeros(4);
    for r=1:4
        b=50+14*(r-1); b1=(100-b)/100; b2=b/100;
        P(r,:)=[1-b1^j 1-b2^j b2^j b1^j];
    end
    Ea=[Ev -Ev].*P; EvT(j-1,:)=sum(Ea,2)'/2;
    Eb=Ea(:,1)+Ea(:,4); Ec=Ea(:,3)+Ea(:,2); EvG(j-1,:)=(Eb.*Ec)';
end

for i=1:2
    figure; hold on
    if i==1
        Pl=EvT;
    else
        Pl=EvG;
    end
    plot(xval,Pl(:,1),'b','linewidth',1); plot(xval,Pl(:,2),'r','linewidth',1);
    plot(xval,Pl(:,3),'k','linewidth',1); plot(xval,Pl(:,4),'m','linewidth',1);
    set(gca,'tickdir','out','ticklength',[.015 .015],'linewidth',1.5,'fontsize',22)
    xlabel('Number of choices','fontsize',22)
    set(gca,'box','off','xtick',0:10:50,'xlim',[0 52])
    if i==1
        set(gca,'ylim',[0 .15],'ytick',0:.05:.15)
        ylabel('Mean utility (arithmetic)','fontsize',22)
    else
        set(gca,'ylim',[-.0625 .007])
        ylabel('Mean utility (geometric^2)','fontsize',22)
        legend('50','36','22','8','location','Southeast')
        ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
        text(15,-.0225,'Items assigned','fontsize',22)
        text(15,-.0325,'to percept 2:','fontsize',22)
    end
end