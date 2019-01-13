clear all; close all; Ev=zeros(3,2); xval=2:51; EvT=zeros(50,3); EvG=EvT;
%integrate
for r=1:3
    m=20*(r-1); dev1=2/sqrt(50-m); dev2=2/sqrt(50+m); NIV=zeros(2,10001);
    for i=1:10001
        x=-5.001+i*.001; A1=normpdf(x,0,dev1); A2=normcdf(x,0,dev2);
        A3=normpdf(x,0,dev2); A4=normcdf(x,0,dev1);
        NIV(1,i)=A1*A2*x; NIV(2,i)=A3*A4*x;
    end
    A1=sum(NIV,2)/1000; Ev(r,:)=A1';
end

for rr=1:4
    %crunch data
    switch rr
        case 1
            shh=0;
        case 3
            shh=2;
        case 4
            shh=20;
    end
    if rr~=2
        Ea1=Ev+shh/2; Ea1=[Ea1*2 -2*Ea1+2*shh];
        for j=2:51
            P=zeros(3,4);
            for r=1:3
                b=50+20*(r-1); b1=(100-b)/100; b2=b/100;
                P(r,:)=[1-b1^j 1-b2^j b2^j b1^j];
            end
            Ea=Ea1.*P; EvT(j-1,:)=sum(Ea,2)'/2;
            Eb=Ea(:,1)+Ea(:,4); Ec=Ea(:,3)+Ea(:,2); Ed=(Eb.*Ec)';
            if rr<3
                EvG(j-1,:)=Ed;
            else
                EvG(j-1,:)=sqrt(Ed);
            end
        end
    end
    
    %plot
    if rr==1
        Pl=EvT;
    else
        Pl=EvG;
    end
    figure; hold on; plot(xval,Pl(:,1),'b','linewidth',1);
    plot(xval,Pl(:,2),'r','linewidth',1); plot(xval,Pl(:,3),'k','linewidth',1);
    set(gca,'tickdir','out','ticklength',[.015 .015],'linewidth',1.5,'fontsize',22)
    xlabel('Number of choices (n)','fontsize',22)
    set(gca,'box','off','xtick',0:10:50,'xlim',[0 52])
    switch rr
        case 1
            ylabel('Mean utility (arithmetic)','fontsize',22)
            title('u=0','fontsize',22)
            set(gca,'ylim',[0 .3],'ytick',0:.1:.3)
            legend('50','30','10','location','Southeast')
            ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
            text(18,.13,'Items assigned','fontsize',22)
            text(18,.09,'to percept 2:','fontsize',22)
        case 2
            ylabel('Mean utility (geometric^2)','fontsize',22)
            title('u=0','fontsize',22)
        case 3
            ylabel('Mean utility (geometric)','fontsize',22)
            title('u=2','fontsize',22)
        case 4
            ylabel('Mean utility (geometric)','fontsize',22)
            title('u=20','fontsize',22)
            set(gca,'ylim',[20 20.3],'ytick',20:.1:20.3)
    end
end