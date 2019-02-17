X=zeros(3,1);
Xt=zeros(3,1);
S=[.1 .0001 .0001;.0001 .1 .0001;.0001 .0001 .1];
St=zeros(3,3);
Kt=zeros(3,1);
T=1;
Q=[0 0 0;0 .001 0;0 0 0];
R=[0.0001];
t=1;
i=eye(3);
while t<=780
   
    Xt=X;
    xt1(t,1)=Xt(1,1);
    xt2(t,1)=Xt(2,1);
    g=Xt(3,1);
    p(t,1)=g(1,1);
    m=0.1*(cos(Xt(1,1)/10));
    dfdx = [1 T 0;0 1 0;m 0 0];
    dfda =[0 0 0 ;0 1 0;0 0 0];
    dgdx=[0 0 1]; 
    dgdn=[1];
    St=(dfdx*S*transpose(dfdx))+(dfda*Q*transpose(dfda));
    yt=[sindata{t,2}];
    yt1=[sindata{t,1}];
    y1(t,1)=yt1(1,1);
    y(t,1)=yt(1,1);
    Kt=St*transpose(dgdx)*inv(dgdx*St*(transpose(dgdx))+dgdn*R*transpose(dgdn));
    X=Xt+Kt*(yt-(g));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    S=(i-(Kt*dgdx))*St;
    h(t,1)=X(3,1);
    h1(t,1)=Xt(3,1);
    t1(t,1)=t;
    t=t+1;
    
end
    plot(t1,h,'r',t1,y1,'k',t1,h1,'b',t1,y,'.');
    xlabel('Sample')
    ylabel('Amplitude')
    legend('Output','Actual','Predicted','Measured')
    hold on
hold off

