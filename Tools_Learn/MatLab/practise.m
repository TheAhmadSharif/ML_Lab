% 24 April 2024 %

% Ahmad Sharif %

% Duplicate Line: Ctlr + Shift + C

%% Section Variable Declaration
x = 0:0.1:10;
y = sin(x)
y = cos(x)

%% Section Data Visualization
plot(x, y)

%% Input from user 
input = input('Enter from a user: ')
input
%% Matrix
A = [4 6 12 -2 0 3]
A(1) % MatLab Matrix is 1 based
A(end)
A(1:2) %  4 6
1:4:12 % Start from 1 and increment by 4 until 12.
A = rand(2,3)
%%
a = linspace(0, 1, 200)

plot(a, sin(a))

%% 

%%
r=2;
theta=linspace(0,2*pi,200); 
x=r*cos(theta); 
y=r*sin(theta); 

plot(x,y); 
save('practise01')


