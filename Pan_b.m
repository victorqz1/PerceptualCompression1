clear all; close all; EvA=zeros(4,2); EvB=zeros(4,2); xval=2:51;
EvTA=zeros(50,4); EvGA=EvTA; EvTB=EvTA; EvGB=EvTA;
for r=1:4
    m=2*r-1.5; NIVa=zeros(2,10001); NIVb=NIVa;
    dev1=sqrt(40+10*m^2)/50; dev2=dev1; dev3=1/sqrt(80); dev4=m/sqrt(20);
    for i=1:10001
        x=-5.001+i*.001; A1=normpdf(x,0,dev1); A2=normcdf(x,0,dev2);
        A3=normpdf(x,0,dev2); A4=normcdf(x,0,dev1);
        NIVa(1,i)=A1*A2*x; NIVa(2,i)=A3*A4*x;
        A1=normpdf(x,0,dev3); A2=normcdf(x,0,dev4); A3=normpdf(x,0,dev4);
        A4=normcdf(x,0,dev3); NIVb(1,i)=A1*A2*x; NIVb(2,i)=A3*A4*x;
    end
    A1=sum(NIVa,2)/1000; EvA(r,:)=A1';
    A1=sum(NIVb,2)/1000; EvB(r,:)=A1';
end
for j=2:51
    Pa=zeros(4); Pb=Pa; b1=.2; b2=.8; b3=.5;
    for r=1:4
        Pa(r,:)=[1-b1^j 1-b2^j b2^j b1^j];
        Pb(r,:)=[1-b3^j 1-b3^j b3^j b3^j];
    end
    Ea=[EvA -EvA].*Pa; EvTA(j-1,:)=sum(Ea,2)'/2;
    Eb=Ea(:,1)+Ea(:,4); Ec=Ea(:,3)+Ea(:,2); EvGA(j-1,:)=(Eb.*Ec)';
    Ea=[EvB -EvB].*Pb; EvTB(j-1,:)=sum(Ea,2)'/2;
    Eb=Ea(:,1)+Ea(:,4); Ec=Ea(:,3)+Ea(:,2); EvGB(j-1,:)=(Eb.*Ec)';
end

for i=1:4
    figure; hold on
    switch i
        case 1
            Pl=EvTA;
        case 2
            Pl=EvGA;
        case 3
            Pl=EvTB;
        case 4
            Pl=EvGB;
    end
    plot(xval,Pl(:,1),'b','linewidth',1); plot(xval,Pl(:,2),'r','linewidth',1);
    plot(xval,Pl(:,3),'k','linewidth',1); plot(xval,Pl(:,4),'m','linewidth',1);
    set(gca,'tickdir','out','ticklength',[.015 .015],'linewidth',1.5,'fontsize',22)
    xlabel('Number of choices','fontsize',22)
    set(gca,'box','off','xtick',0:10:50,'xlim',[0 52])
    switch i
        case 1
            set(gca,'ylim',[0 .13],'ytick',0:.05:.1)
            ylabel('Mean utility (arithmetic)','fontsize',22)
            title('1: both percepts, s1 (40) & s2 (10)','fontsize',22)
        case 2
            ylabel('Mean utility (geometric^2)','fontsize',22)
        case 3
            set(gca,'ylim',[0 .31],'ytick',0:.1:.3)
            ylabel('Mean utility (arithmetic)','fontsize',22)
            title('2: s1 (80) vs. s2 (20)','fontsize',22)
        case 4
            set(gca,'ylim',[-.065 .005],'ytick',-.06:.02:0)
            ylabel('Mean utility (geometric^2)','fontsize',22)
            text(20,-.045,'s1=1, s2=','fontsize',22)
            legend('.5','2.5','4.5','6.5','location','Southeast')
            ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
    end
end
