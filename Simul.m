fresh=input('fresh? 0, 1, 2, 3, 4'); psize=100; basepop=zeros(psize,2);
rounds=30; life=1000; B=11; p=.02;
if fresh>0
    switch fresh %fresh start, or continue existing simulation?
        case 2
            basepop(1:psize*.2,1)=0; %Hedged
            basepop(psize*.2+1:100,1)=1; %BestAvg
        case 3
            basepop(psize*.5+1:100,1)=1;
        case 4
            basepop(psize*.8+1:100,1)=1;
    end
    decimatepop=basepop; halfdiepop=basepop; mostdiepop=basepop;
    if fresh>1
        savethis=[];
    else %continue a paused simulation
        load A7; P0=savethis(end,:); [P0 size(savethis)]
        if P0(2)>0
            decimatepop(100-P0(2)+1:100,1)=1;
        end
        if P0(4)>0
            halfdiepop(100-P0(4)+1:100,1)=1;
        end
        if P0(6)>0
            mostdiepop(100-P0(6)+1:100,1)=1;
        end
    end
end

while rounds>0 %outermost loop, rounds of selection
    savethis=[savethis; rounds sum(decimatepop) sum(halfdiepop) sum(mostdiepop)];
    if mod(rounds,5)==2
        savethis(end-4:end,:)
    end
    Odat=zeros(psize,2); rounds=rounds-1; %c1/2 = Hedged(A)/"Optimal"(B)
    for j=1:psize %one "life set of events" for every member of population, H or O
        events=zeros(life,2);
        for i=1:life %calc outcome for organism j
            T1=100*rand(); T2=100*rand(); T3=max(T1,T2);
            if rand()<.5
                T4=T1;
            else
                T4=T2;
            end
            if rand()<p %decision based on d1
                if abs(floor(T1/50)-floor(T2/50))>.1 %diff cat, H
                    events(i,1)=B*T3;
                else
                    events(i,1)=B*T4;
                end
                events(i,2)=B*T4;
            else %decision based on d2
                if abs(floor(T1/50)-floor(T2/50))>.1 %diff cat, H
                    events(i,1)=T3;
                else
                    events(i,1)=T4;
                end
                if abs(floor(T1/25)-floor(T2/25))>.1 %diff cat, H
                    events(i,2)=T3;
                else
                    events(i,2)=T4;
                end
            end
        end
        Odat(j,:)=mean(events);
    end
    %decimatepop round update
    tInd=find(decimatepop(:,1),1);
    decimatepop(1:tInd-1,2)=Odat(1:tInd-1,1);
    decimatepop(tInd:end,2)=Odat(tInd:end,2);
    A1=sortrows(decimatepop,2); A1=sum(A1(psize*.1+1:end,1));
    A2=sum(rand(1,psize*.1)<A1/(psize*.9)); %A1/A2 are placeholder vars
    decimatepop=basepop; decimatepop(psize-A1-A2+1:psize,1)=1;
    %halfdiepop round update
    tInd=find(halfdiepop(:,1),1);
    halfdiepop(1:tInd-1,2)=Odat(1:tInd-1,1);
    halfdiepop(tInd:end,2)=Odat(tInd:end,2);
    A1=sortrows(halfdiepop,2); A1=sum(A1(psize*.5+1:end,1));
    halfdiepop=basepop; halfdiepop(psize-A1*2+1:psize,1)=1;
    %mostdiepop round update
    tInd=find(mostdiepop(:,1),1);
    mostdiepop(1:tInd-1,2)=Odat(1:tInd-1,1);
    mostdiepop(tInd:end,2)=Odat(tInd:end,2);
    A1=sortrows(mostdiepop,2); A1=sum(A1(psize*.8+1:end,1));
    mostdiepop=basepop; mostdiepop(psize-A1*5+1:psize,1)=1;
end
[savethis(end,:) size(savethis)]
