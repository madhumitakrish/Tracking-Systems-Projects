
x=zeros(2,1);
xt=zeros(2,1);
s=zeros(2,2);
st=zeros(2,2);
kt=zeros(2,1);
i=zeros(2,2);

T=10;
i=eye(2);
phi=[1 T;0 1];
q=[.0001 0.00001;0.00001 .0001];
r=0.01;
m=[1 0] ;
t=1;

while t<=639
    xt=phi*x;
    xt1(t,1)=xt(1,1);
    st=(phi*s*transpose(phi))+q;
    yt=Ddata{t,1};
    y(t,1)=yt(1,1);
    kt=st*transpose(m)*inv(m*st*(transpose(m))+r)
    x=xt+kt*(yt-(m*xt));
    s=(i-(kt*m))*st;
    g(t,1)=x(1,1);
    t1(t,1)=t;
   
      t=t+1;
end
plot(t1,xt1,'k',t1,g,'b',t1,y,'r');
    xlabel('Sample')
    ylabel('Position')
    legend('Predicted','Output','Measured')
    
   
    