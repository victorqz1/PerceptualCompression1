clear all; A=[]; B=[]; C=[]; D=[]; E=[]; F=[];
for i=1:10
    switch i
        case 1
            load A1; D1=[savethis(1,:); savethis(end,:)];
            load B1; D2=[savethis(1,:); savethis(end,:)];
            load C1; D3=[savethis(1,:); savethis(end,:)];
            load D1; D4=[savethis(1,:); savethis(end,:)];
            load E1; D5=[savethis(1,:); savethis(end,:)];
            load F1; D6=[savethis(1,:); savethis(end,:)];
        case 2
            load A2; D1=[savethis(1,:); savethis(end,:)];
            load B2; D2=[savethis(1,:); savethis(end,:)];
            load C2; D3=[savethis(1,:); savethis(end,:)];
            load D2; D4=[savethis(1,:); savethis(end,:)];
            load E2; D5=[savethis(1,:); savethis(end,:)];
            load F2; D6=[savethis(1,:); savethis(end,:)];
        case 3
            load A3; D1=[savethis(1,:); savethis(end,:)];
            load B3; D2=[savethis(1,:); savethis(end,:)];
            load C3; D3=[savethis(1,:); savethis(end,:)];
            load D3; D4=[savethis(1,:); savethis(end,:)];
            load E3; D5=[savethis(1,:); savethis(end,:)];
            load F3; D6=[savethis(1,:); savethis(end,:)];
        case 4
            load A4; D1=[savethis(1,:); savethis(end,:)];
            load B4; D2=[savethis(1,:); savethis(end,:)];
            load C4; D3=[savethis(1,:); savethis(end,:)];
            load D4; D4=[savethis(1,:); savethis(end,:)];
            load E4; D5=[savethis(1,:); savethis(end,:)];
            load F4; D6=[savethis(1,:); savethis(end,:)];
        case 5
            load A5; D1=[savethis(1,:); savethis(end,:)];
            load B5; D2=[savethis(1,:); savethis(end,:)];
            load C5; D3=[savethis(1,:); savethis(end,:)];
            load D5; D4=[savethis(1,:); savethis(end,:)];
            load E5; D5=[savethis(1,:); savethis(end,:)];
            load F5; D6=[savethis(1,:); savethis(end,:)];
        case 6
            load A6; D1=[savethis(1,:); savethis(end,:)];
            load B6; D2=[savethis(1,:); savethis(end,:)];
            load C6; D3=[savethis(1,:); savethis(end,:)];
            load D6; D4=[savethis(1,:); savethis(end,:)];
            load E6; D5=[savethis(1,:); savethis(end,:)];
            load F6; D6=[savethis(1,:); savethis(end,:)];
        case 7
            load A7; D1=[savethis(1,:); savethis(end,:)];
            load B7; D2=[savethis(1,:); savethis(end,:)];
            load C7; D3=[savethis(1,:); savethis(end,:)];
            load D7; D4=[savethis(1,:); savethis(end,:)];
            load E7; D5=[savethis(1,:); savethis(end,:)];
            load F7; D6=[savethis(1,:); savethis(end,:)];
        case 8
            load A8; D1=[savethis(1,:); savethis(end,:)];
            load B8; D2=[savethis(1,:); savethis(end,:)];
            load C8; D3=[savethis(1,:); savethis(end,:)];
            load D8; D4=[savethis(1,:); savethis(end,:)];
            load E8; D5=[savethis(1,:); savethis(end,:)];
            load F8; D6=[savethis(1,:); savethis(end,:)];
        case 9
            load A9; D1=[savethis(1,:); savethis(end,:)];
            load B9; D2=[savethis(1,:); savethis(end,:)];
            load C9; D3=[savethis(1,:); savethis(end,:)];
            load D9; D4=[savethis(1,:); savethis(end,:)];
            load E9; D5=[savethis(1,:); savethis(end,:)];
            load F9; D6=[savethis(1,:); savethis(end,:)];
        case 10
            load A10; D1=[savethis(1,:); savethis(end,:)];
            load B10; D2=[savethis(1,:); savethis(end,:)];
            load C10; D3=[savethis(1,:); savethis(end,:)];
            load D10; D4=[savethis(1,:); savethis(end,:)];
            load E10; D5=[savethis(1,:); savethis(end,:)];
            load F10; D6=[savethis(1,:); savethis(end,:)];
    end
    A=[A; D1]; B=[B; D2]; C=[C; D3]; D=[D; D4]; E=[E; D5]; F=[F; D6];
end
raw=input('show raw data?');
if raw==1
    [A B]
    [C D]
    [E F]
elseif raw==2
    [A(2:2:end,2:2:6) B(2:2:end,2:2:6)]
    [C(2:2:end,2:2:6) D(2:2:end,2:2:6)]
    [E(2:2:end,2:2:6) F(2:2:end,2:2:6)]
else
    x2d=zeros(10,6); x2d(:,1)=A(2:2:end,6); x2d(:,2)=B(2:2:end,6);
    x2d(:,3)=C(2:2:end,6); x2d(:,4)=D(2:2:end,6); x2d(:,5)=E(2:2:end,6);
    x2d(:,6)=F(2:2:end,6); x2d
    dOut=zeros(5,1); x2d=sum(x2d/100);
    for i=1:5
        K=x2d(i)+x2d(i+1); x=min(x2d(i),x2d(i+1)); 
        dOut(i)=2*hygecdf(x,20,K,10);
    end
    dOut
end
