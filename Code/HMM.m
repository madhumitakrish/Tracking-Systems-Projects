clc 
clear
close all
prompt='Enter the sequence:'
str = input(prompt,'s')

%State Transitional Matrix
A=[0.5 0.5;0.4 0.6];

%Initial Probabilities
p=[0.5;0.5];

%Discrete Emission Probabilities
B=[0.2 0.3 0.3 0.2;0.3 0.2 0.2 0.3];

%Log of Probabilities
A=log2(A);
B=log2(B);
p=log2(p);

t=length(str);
%Initializing Best Probabilities
prob=zeros(1,t);
prob=zeros(2,t);
BestProb=zeros(1,t);
for t=1:t
    if strcmp(str(t),'A')   
        Code(1,t)=1;
    elseif strcmp(str(t),'C')
        Code(1,t)=2;
    elseif strcmp(str(t),'G')
        Code(1,t)=3;
    elseif strcmp(str(t),'T')
        Code(1,t)=4;
   
    end
   
    if t==1
        prob(1,t)=p(1,1)+B(1,Code(1,t));
        prob(2,t)=p(2,1)+B(2,Code(1,t));
        BestProb(1,t)=max(prob(1,t),prob(2,t));
      
    else
        prob(1,t)=B(1,Code(1,t))+max(prob(1,t-1)+A(1,1),prob(2,t-1)+A(2,1));
        prob(2,t)=B(2,Code(1,t))+max(prob(1,t-1)+A(1,2),prob(2,t-1)+A(2,2));
        BestProb(1,t)=max(prob(1,t),prob(2,t));
        
        
    end
   
end
%Backtracking to find Most Probable Path
   fprintf("most probable path:")
   
   for t=t:-1:1
       if prob(1,t)>prob(2,t)
           State(1,t)="H";
           
       elseif prob(1,t)==prob(2,t)
           if prob(1,t-1)>prob(2,t-1)
               State(1,t)="H";
           else
               State(1,t)="L";
           end 
       else
           State(1,t)="L";
           
       end
   end
            
        fprintf("%s",State)
        fprintf("\n")
