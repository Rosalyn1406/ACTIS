%% curve fitting to polynomial
load dan2nM.mat
x=dan2nM.xT0;
y=dan2nM.yR2;

% plot log scale for x, linear for y
logx=log10(x)

% curve fit 
% polyval: evaluate polynomial at some point x 
% polyint: integrate polynomial 
% polyder: derivative of polynomial
% roots: return roots of a polynomial
% conv:multiply two polynomial
% deconv: divide two polynomial
% polyfit: least-squares polynomial curve fit

% fitting to degree 8 
% coefficeint
p5=polyfit(logx,y,4)

% display equation
disp(['y= ',num2str(p5(1)), '*x^4+' ,  num2str(p5(2)) , '*x^3' , num2str(p5(3)) , '*x^2' , num2str(p5(4)) , '*x+', num2str(p5(5))])

% Fitting
x_fit=linspace(0.5,4.0);
y_fit = polyval(p5,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [4.17E+01,2.08E+02] 
y_linear= [0.650062,0.101664]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting 
figure(5)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')% polynomial fit 
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
legend('Data','fit(4th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')
grid on 
%xlim([0.8 4])
ylim([0 1.0]) 
title("R vs [T]_0 for K_d=60pM, NAAP Scaled=2nM")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{2nM}")
yline(0.5,"-.m","R_{2nM}=0.5")

%% Derivation
deri=polyder(p5)

% Display equation
disp(['dy/dx = ' , num2str(deri(1)) , '*x^3+' , num2str(deri(2)) , '*x^2+' , num2str(deri(3)), '*x^+', num2str(deri(4))])

% Checking value of y when x ...
x1=[1.7814] 
y1=polyval(p5,x1) % value is correct 

% slope, x value of y =0.5 is input into derivation
x_point=[1.7814]
y_p5_slope=polyval(deri,x_point)

%% Roots
p =[ -0.2159    2.0751   -6.8656    8.6617   -3.1992]
r=roots(p)

% sub x value into derivative to check if slope matches with y_p1_slope
slope=polyval(deri,1.7814) % 0.0504 is the x value for y =0.5