%% curve fitting to polynomial
load dan20pM.mat
% x = [1.00e-12,3.33e-12,1.00e-11,3.33e-11,1.00e-10,3.33e-10,1.00e-09,3.33e-09,1.00e-08,3.33e08,1.00e-07];
% y = [1.00,0.999,0.997,0.990,0.971,0.902,0.707,0.125,0.00888,0.00200,0.000606]
x=dan20pM.xT0;
y=dan20pM.yR20;

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
p1=polyfit(logx,y,4)

% display equation
disp(['y= ',num2str(p1(1)), '*x^4+' ,  num2str(p1(2)) , '*x^3' , num2str(p1(3)) , '*x^2' , num2str(p1(4)) , '*x+', num2str(p1(5))])

% Fitting
x_fit=linspace(-1.2,1.65);
y_fit = polyval(p1,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [3.33E-01,8.33E+00] 
y_linear= [0.893277,0.072056]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting 
figure(1)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')% polynomial fit 
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
legend('Data','fit(4th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')
grid on 
title("R vs [T]_0 for K_d=60pM, NAAP Scaled=20pM")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{20PM}")
yline(0.5,"-.m","R_{20pM}=0.5")

%% Derivation
deri=polyder(p1)

% Display equation
disp(['dy/dx = ' , num2str(deri(1)) , '*x^3+' , num2str(deri(2)) , '*x^2' , num2str(deri(3)) , '*x' ...
    , num2str(deri(4))])

% Checking value of y when x ...
x1=[0.2098] 
y1=polyval(p1,x1) % value is correct 

% slope, x value of y =0.5 is input into derivation
x_point=[0.2098]
y_p1_slope=polyval(deri,x_point)

%% Roots
p =[0.0003    0.1781   -0.1379   -0.6396    0.1386]
r=roots(p)

% sub x value into derivative to check if slope matches with y_p1_slope
slope=polyval(deri,0.2098) % 0.2098 is the x value for y =0.5
