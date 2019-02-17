clc 
clear
close all
x=zeros(2,1);
t=1;
T=1;
table=dlmread("magnets-data.txt");
xpos=zeros(2,1);
M=100;

sm=4.0;
sn=0.004;
xm1= -10;
xm2=  10;
actualpos=table(:,1);
actualvel=table(:,2);
sensor=table(:,3);
%State Initialization
xpos=zeros(1,M);
xvel=zeros(1,M);
xposprev=zeros(1,M);
xvelprev=zeros(1,M);

ytM=zeros(1,M);

%Weight initialization
wt=ones(1,M)*1/M;
wtprev=ones(1,M)*1/M;
wtn=ones(1,M)*1/M;

E=zeros(1,length(sensor));

%Plot Init
rc=0;
sf=15;
plt=0;
X2=1:M;

for t=1:length(sensor) 
     
    for m=1:M
        
        at= randn*(0.0625);
        
        xpos(m)=xposprev(m)+(xvelprev(m)*1);
        if xposprev(m) < (-20)
            xvel(m)=2;
        elseif xposprev(m) >= (-20) && xposprev(m) < 0
            xvel(m)=xvelprev(m)+ abs(at);
        elseif xposprev(m) >= 0 && xposprev(m) <= 20
            xvel(m)=xvelprev(m)- abs(at);
        elseif xposprev(m) > 20
            xvel(m)=-2;
        end
      
        ytM(m)=(1/(sqrt(2*pi)*sm))*exp(-(xpos(m)-xm1)^2/(2*(sm^2)))+(1/(sqrt(2*pi)*sm))*exp(-(xpos(m)-xm2)^2/(2*(sm^2)));
      
        p= (1/(sqrt(2*pi)*sn))*exp(-(ytM(m)-sensor(t))^2/(2*(sn^2)));
        wt(m)=wtprev(m)*p;
       
        wtprev(m)=wt(m);
        xposprev(m)=xpos(m);
        xvelprev(m)=xvel(m);
    end
    
    sum1=cumsum(wt);
    
    wtn=wt./sum1(M);
    mul1=(xpos .* wtn);
    sum2=cumsum(mul1);
    %Expected Output
    E(t)=sum2(M);
    
    mul2=M.*wtn;
    sub1=(mul2-1).^2;
    sum3=cumsum(sub1);
    CV=1/M*(sum3(M));
    ESS=M/(1+CV);
    if(plt)
        figure(t)
        bar(X2,wtn)
      
        xlabel('Particle Position')
        ylabel('Particle Weight')
        legend('Particle')
    end
    %Resampling
    if(ESS< 0.5*M)
        rc=rc+1;
        if(rc==sf)
            plt=1;
        end
        Q=cumsum(wtn);
        k=rand(1,M);
        K=sort(k);
        K(1,M+1)=1.0;
        i=1;
        j=1;
        while(i<=M)
            if (K(i)<=Q(j))
                Index(i)=j;
                i=i+1;
            else
                j=j+1;
            end 
        end 
        p1=1;
        while(p1<=M)
            xpos(p1)=xpos(Index(p1)) ;
            xposprev(p1)=xposprev(Index(p1));
            xvel(p1)=xvel(Index(p1));
            xvelprev(p1)=xvelprev(Index(p1));
            wtprev(p1)=1/M;
            wt(p1)=1/M;
            wtn(p1)=1/M;
            p1=p1+1;
            
        end
        if(plt)
            figure(t)
            bar(X2,wtn)
            
            xlabel('Particle Position')
            ylabel('Particle Weight')
            legend('Particle')
        end
        if(rc==sf+1)
            plt=0;
        end
       
    end
   
end

%Plot
X1=1:length(sensor);

figure(1)
plot(X1,E, 'k-');
hold on 
plot(X1,actualpos,'k-.','LineWidth',1)
hold off
legend('Expected Output','Actual Position')
xlabel('Sample')
ylabel('Position')
