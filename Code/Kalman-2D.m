
x=zeros(4,1);
xt=zeros(4,1);
s=zeros(4,4);
st=zeros(4,4);
r=zeros(1,1);
kt=zeros(2,1);
T=5;
i=eye(4);
phi=[1 0 T 0;0 1 0 T;0 0 1 0;0 0 0 1];
q=[0 0 0 0;0 0 0 0;0 0 .000001 .00001  ;0 0 .00001 .000001 ];
r=[.01 .001;.001 .01];
m=[1 0 0 0;0 1 0 0] ;
t=1;
figure(1)
while t<=134
    xt=phi*x;
    xt1(t,1)=xt(1,1);   %values are stored in an array
    xt2(t,1)=xt(2,1);
    st=(phi*s*transpose(phi))+q;
    yt=[DUWBdata{t,1};DUWBdata{t,2}];
    y(t,1)=yt(1,1);
    y1(t,1)=yt(2,1);
    kt=st*transpose(m)*inv(m*st*(transpose(m))+r);
    x=xt+kt*(yt-(m*xt));
    s=(i-(kt*m))*st;
    g(t,1)=x(1,1);
    
    h(t,1)=x(2,1);
    t1(t,1)=t;
    t=t+1;
    
end
subplot(2,1,1)
    plot(t1,g,'b',t1,y,'r');
    xlabel('Sample')
    ylabel('X position')
    legend('Output','Measured')
    hold on
    subplot(2,1,2)
    plot(t1,h,'b',t1,y1,'r');
    xlabel('Sample')
    ylabel('Y position')
    legend('Output','Measured')
hold off