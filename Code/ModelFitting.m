%part1
A=[5 1;6 1;7 1;8 1;9 1];
b =[1;1;2;3;5];
X=inv(transpose(A)*A)*transpose(A)*b
x1=[5,6,7,8,9]; y1=[1,1,2,3,5];
g=X(1,1);
h=X(2,1);
plot(x1,y1,'ko')
hold on
Y= g*x1+h
legend('Data points','Predicted model','Location','Northeast')

xlabel('x')
ylabel('y')
plot(x1,Y,'k')

hold off


%part3
y =  peopleallmeals{:,4}./peopleallmeals{:,3}
peopleallmeals{:,5} = y;
x=peopleallmeals{:,3};
plot(x,y,'o')

hold on
A=[1./x] 
b=y;
X=inv(transpose(A)*A)*transpose(A)*b
g=(X(1,1))

x1=sort(x);
Y1=(g./x1);

legend('Given data','Predicted model')    
xlabel('Number of bites')
ylabel('Number of kilocalories per byte')
plot(x1,Y1)
hold off

