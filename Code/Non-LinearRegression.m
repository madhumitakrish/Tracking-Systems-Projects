N=height(logdataC)
x=logdataC{:,1};
y=logdataC{:,2};
plot(x,y,'o')
hold on
A=[log(x) x.^0];
b=[y];
X=inv(transpose(A)*A)*transpose(A)*b;
g=X(1,1)
truea=X(2,1)
totaliterations=50000;
an=0.1;                     %initial value of an should be near true value
i=0;

while i<500000 
    fan=0;
    fpan=0;
    j=1;                    
    while j<N+1
        fan = fan + ( (y(j)- log(an.*x(j))));
        j=j+1;
    end
    
    fpan = -(N/an);
    i=i+1;
    an1=an-(fan/fpan);         %using root finding method 
    fprintf('an: %f an1: %f \n',an,an1)
    if (abs(an-an1) < 0.0000001)
        break;
    end
    an=an1;
    
end
fprintf('iterations %i',i);     %no of iterations

Y=log(an.*x);
plot(x,Y)
title('y=ln(ax) model for logdataC')
legend('Given dataset','nonlinear model','Location','southeast')
xlabel('xi')
ylabel('yi')
hold off