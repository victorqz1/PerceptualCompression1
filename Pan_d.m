clear all; close all; EvJ2=zeros(4,4); EvJ3=zeros(6,4); EvP2=EvJ2; EvPx2=EvJ2;
EvP3=EvJ3; EvPx3=EvJ3; xval=2:51; EvT=zeros(50,3); EvG=EvT; b1=100;
EvJ3a=zeros(6,4); EvP3a=EvJ3a; EvPx3a=EvJ3a; EvTa=zeros(50,2); EvGa=EvTa;

for j=1:3
    switch j
        case 1
            dev1=1/sqrt(25); kh=1; dev3=sqrt(20+5*5^2)/25;
        case 2
            dev1=1/sqrt(32); dev2=1/sqrt(4); kh=4;
        case 3
            dev1=1/sqrt(46); dev2=1/sqrt(4); kh=6;
            dev3=1/sqrt(40); dev4=5/sqrt(10);
    end
    for k=1:kh
        switch j
            case 1
                c1=dev1; c2=dev1; c3=dev1; c4=dev1;
                c5=dev3; c6=dev3; c7=dev3; c8=dev3;
            case 2
                switch k
                    case 1
                        c1=dev2; c2=dev1; c3=dev1; c4=dev1;
                    case 2
                        c1=dev1; c2=dev2; c3=dev1; c4=dev1;
                    case 3
                        c1=dev1; c2=dev1; c3=dev2; c4=dev1;
                    case 4
                        c1=dev1; c2=dev1; c3=dev1; c4=dev2;
                end
            case 3
                switch k
                    case 1
                        c1=dev1; c2=dev1; c3=dev2; c4=dev2;
                        c5=dev3; c6=dev3; c7=dev4; c8=dev4;
                    case 2
                        c1=dev1; c2=dev2; c3=dev1; c4=dev2;
                        c5=dev3; c6=dev4; c7=dev3; c8=dev4;
                    case 3
                        c1=dev1; c2=dev2; c3=dev2; c4=dev1;
                        c5=dev3; c6=dev4; c7=dev4; c8=dev3;
                    case 4
                        c1=dev2; c2=dev2; c3=dev1; c4=dev1;
                        c5=dev4; c6=dev4; c7=dev3; c8=dev3;
                    case 5
                        c1=dev2; c2=dev1; c3=dev2; c4=dev1;
                        c5=dev4; c6=dev3; c7=dev4; c8=dev3;
                    case 6
                        c1=dev2; c2=dev1; c3=dev1; c4=dev2;
                        c5=dev4; c6=dev3; c7=dev3; c8=dev4;
                end
        end
        NIVa=zeros(4,10001); NIVb=NIVa; NIVc=NIVa; NIVd=NIVa;
        if j==2
            NIVc=NIVc+1e5; NIVd=NIVd+1e5;
        end
        for i=1:10001
            x=-5.001+i*.001;
            A1=normpdf(x,0,c1); A2=normcdf(x,0,c1); B1=normpdf(x,0,c2); B2=normcdf(x,0,c2);
            C1=normpdf(x,0,c3); C2=normcdf(x,0,c3); D1=normpdf(x,0,c4); D2=normcdf(x,0,c4);
            NIVa(1,i)=A1*B2*C2*D2; NIVa(4,i)=(1-A2)*(1-B2)*(1-C2)*D1;
            NIVa(2,i)=(1-A2)*B1*C2*D2; NIVa(3,i)=(1-A2)*(1-B2)*C1*D2; NIVb(:,i)=NIVa(:,i)*x;
            if mod(j,2)>0
                A1a=normpdf(x,0,c5); A2a=normcdf(x,0,c5); B1a=normpdf(x,0,c6); B2a=normcdf(x,0,c6);
                C1a=normpdf(x,0,c7); C2a=normcdf(x,0,c7); D1a=normpdf(x,0,c8); D2a=normcdf(x,0,c8);
                NIVc(1,i)=A1a*B2a*C2a*D2a; NIVc(4,i)=(1-A2a)*(1-B2a)*(1-C2a)*D1a;
                NIVc(2,i)=(1-A2a)*B1a*C2a*D2a; NIVc(3,i)=(1-A2a)*(1-B2a)*C1a*D2a; NIVd(:,i)=NIVc(:,i)*x;
            end
        end
        E1=sum(NIVa,2)/1000; E2=sum(NIVb,2)/1000; E3=E2./E1; [j k]
        E4=sum(NIVc,2)/1000; E5=sum(NIVd,2)/1000; E6=E5./E4;
        switch j
            case 1
                EvJ1=E3'; EvP1=E1'; EvJ1a=E6'; EvP1a=E4';
            case 2
                EvJ2(k,:)=E3'; EvP2(k,:)=E1';
            case 3
                EvJ3(k,:)=E3'; EvP3(k,:)=E1';
                EvJ3a(k,:)=E6'; EvP3a(k,:)=E4';
        end
    end
end

Ep2=[EvP2(1,1) .5-EvP2(1,1) .5-EvP2(1,1) EvP2(1,1)];
ea=.1434; eb=.4283; Ep3=[eb^2 ea*eb*2 ea^2 eb^2 ea*eb*2 2*eb^2];
ea=.05; eb=.475; Ep3a=[eb^2 ea*eb*2 ea^2 eb^2 ea*eb*2 2*eb^2];
for n=2:51
    for j=1:3
        switch j
            case 1
                kh=1;
            case 2
                kh=4;
            case 3
                kh=6;
        end
        for k=1:kh
            switch j
                case 1
                    b2=75; b3=50; b4=25;
                case 2
                    switch k
                        case 1
                            b2=96; b3=64; b4=32;
                        case 2
                            b2=68; b3=64; b4=32;
                        case 3
                            b2=68; b3=36; b4=32;
                        case 4
                            b2=68; b3=36; b4=4;
                    end
                case 3
                    switch k
                        case 1
                            b2=54; b3=8; b4=4;
                            b2a=60; b3a=20; b4a=10;
                        case 2
                            b2=54; b3=50; b4=4;
                            b2a=54; b3a=50; b4a=10;
                        case 3
                            b2=54; b3=50; b4=46;
                            b2a=60; b3a=50; b4a=40;
                        case 4
                            b2=96; b3=92; b4=46;
                            b2a=90; b3a=80; b4a=40;
                        case 5
                            b2=96; b3=50; b4=46;
                            b2a=90; b3a=50; b4a=40;
                        case 6
                            b2=96; b3=50; b4=4;
                            b2a=90; b3a=50; b4a=10;
                    end
            end
            P=[b1^n-b2^n b2^n-b3^n b3^n-b4^n b4^n]/b1^n;
            switch j
                case 1
                    EvPx1=P; EvPx1a=P;
                case 2
                    EvPx2(k,:)=P;
                case 3
                    Pa=[b1^n-b2a^n b2a^n-b3a^n b3a^n-b4a^n b4a^n]/b1^n;
                    EvPx3(k,:)=P; EvPx3a(k,:)=Pa;
            end
        end
    end
    ea=sum(EvPx1.*EvJ1); g=[ea; ea]; E2=sum(EvPx2.*EvJ2,2);
    E3=sum(EvPx3.*EvJ3,2); g1=[sum(E2.*Ep2') sum(E3.*Ep3');...
        prod(E2'.^Ep2) prod(E3'.^Ep3)]; g=[g g1];
    EvT(n-1,:)=g(1,:); EvG(n-1,:)=g(2,:);
    ea=sum(EvPx1a.*EvJ1a); g=[ea; ea]; E3=sum(EvPx3a.*EvJ3a,2);
    g1=[sum(E3.*Ep3a'); prod(E3'.^Ep3a)]; g=[g g1];
    EvTa(n-1,:)=g(1,:); EvGa(n-1,:)=g(2,:);
end

for i=1:4
    figure; hold on
    switch i
        case 1
            Pl=EvT;
        case 2
            Pl=EvG;
        case 3
            Pl=EvTa;
        case 4
            Pl=EvGa;
    end
    plot(xval,Pl(:,1),'b','linewidth',1);
    if i<3
        plot(xval,Pl(:,2),'m','linewidth',1);
        plot(xval,Pl(:,3),'r','linewidth',1);
    else
        plot(xval,Pl(:,2),'r','linewidth',1);
    end
    set(gca,'tickdir','out','ticklength',[.015 .015],'linewidth',1.5,'fontsize',22)
    xlabel('Number of choices','fontsize',22)
    set(gca,'box','off','xtick',0:10:50,'xlim',[0 52])
    switch i
        case 1
            ylabel('Mean utility (arithmetic)','fontsize',22)
            set(gca,'ylim',[0 .35],'ytick',0:.1:.3)
            title('1: s=1','fontsize',22)
        case 2
            ylabel('Mean utility (geometric)','fontsize',22)
            set(gca,'ytick',0:.1:.3)
            legend('25,25,25,25','32,32,32,4','46,46,4,4','location','Southeast')
            ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
            text(10,.15,'Items in each','fontsize',22)
            text(10,.125,'percept:','fontsize',22)
        case 3
            ylabel('Mean utility (arithmetic)','fontsize',22)
            set(gca,'ylim',[0 1.1],'ytick',0:.5:1)
            title('2: s1=1, s2=5','fontsize',22)
        case 4
            ylabel('Mean utility (geometric)','fontsize',22)
            set(gca,'ylim',[0 .75],'ytick',0:.25:.75)
            legend('20s1 & 5s2 (x4)','40s1 (x2), 10s2 (x2)','location','Southeast')
            ch=get(gcf,'children'); set(ch(1),'box','off','fontsize',22)
    end
end