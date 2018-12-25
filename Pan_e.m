clear all; close all; xval=2:51;
Ev=zeros(6,2); EvT=zeros(50,6); EvG=EvT;
for r=1:6
    switch r
        case 1
            a1=.5; b1=.1; m1=8; m2=92;
            dev1=sqrt(m1^2*a1^2+b1^2*m1)/m1; dev2=sqrt(m2^2*a1^2+b1^2*m2)/m2;
        case 2
            a1=.1; b1=.5; m1=8; m2=92;
            dev1=sqrt(m1^2*a1^2+b1^2*m1)/m1; dev2=sqrt(m2^2*a1^2+b1^2*m2)/m2;
        case 3
            a1=.5; b1=.1; m1=50; dev1=sqrt(m1^2*a1^2+b1^2*m1)/m1; dev2=dev1;
        case 4
            a1=.1; b1=.5; m1=50; dev1=sqrt(m1^2*a1^2+b1^2*m1)/m1; dev2=dev1;
        case 5
            b1=.1; dev1=b1/sqrt(50); dev2=dev1;
        case 6
            b1=.5; dev1=b1/sqrt(50); dev2=dev1;
    end
    NIVa=zeros(2,10001); r
    for i=1:10001
        x=-5.001+i*.001; A1=normpdf(x,0,dev1); A2=normcdf(x,0,dev2);
        A3=normpdf(x,0,dev2); A4=normcdf(x,0,dev1);
        NIVa(1,i)=A1*A2*x; NIVa(2,i)=A3*A4*x;
    end
    A1=sum(NIVa,2)/1000; Ev(r,:)=A1';
end
for j=2:51
    P=zeros(6,4); b3=.5; P(3,:)=[1-b3^j 1-b3^j b3^j b3^j];
    m=92; b2=(100-m)/100; b1=m/100; P(1,:)=[1-b1^j 1-b2^j b2^j b1^j];
    P(2,:)=P(1,:); P(4,:)=P(3,:); P(5:6,:)=P(3:4,:);
    Ea=[Ev -Ev].*P; EvT(j-1,:)=sum(Ea,2)'/2;
    Eb=Ea(:,1)+Ea(:,4); Ec=Ea(:,3)+Ea(:,2); EvG(j-1,:)=(Eb.*Ec)';
end
for i=1:4
    switch i
        case 1
            Pl=EvT(:,1:2:5);
        case 2
            Pl=EvG(:,1:2:5);
        case 3
            Pl=EvT(:,2:2:6);
        case 4
            Pl=EvG(:,2:2:6);
    end
    figure; hold on; plot(xval,Pl(:,1),'b','linewidth',1);
    plot(xval,Pl(:,2),'r','linewidth',1); plot(xval,Pl(:,3),'k','linewidth',1);
    set(gca,'tickdir','out','ticklength',[.015 .015],'linewidth',1.5,'fontsize',22)
    xlabel('Number of choices','fontsize',22)
    set(gca,'box','off','xtick',0:10:50,'xlim',[0 52])
    switch i
        case 1
            ylabel('Mean utility (arithmetic)','fontsize',22)
            set(gca,'ylim',[0 .15],'ytick',0:.05:.15)
            title('(a,b)=(.5,.1)','fontsize',22)
        case 2
            ylabel('Mean utility (geometric^2)','fontsize',22)
            set(gca,'ylim',[-.015 .02],'ytick',-.01:.01:.02)
            legend('92 & 8','50 & 50','split','location','Southeast')
            ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
        case 3
            ylabel('Mean utility (arithmetic)','fontsize',22)
            set(gca,'ylim',[0 .0475],'ytick',0:.02:.04)
            title('(a,b)=(.1,.5)','fontsize',22)
        case 4
            ylabel('Mean utility (geometric^2)','fontsize',22)
            set(gca,'ylim',[-.0002 .0016],'ytick',0:.0005:.0015)
            legend('92 & 8','50 & 50','split','location','East')
            ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
    end
end