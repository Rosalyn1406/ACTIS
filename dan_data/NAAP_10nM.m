%% curve fitting to polynomial
load dan10nM.mat
x=dan10nM.xT0;
y=dan10nM.yR10;

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
p6=polyfit(logx,y,4)

% display equation
disp(['y= ',num2str(p6(1)), '*x^4+' ,  num2str(p6(2)) , '*x^3' , num2str(p6(3)) , '*x^2' , num2str(p6(4)) , '*x+', num2str(p6(5))])

% Fitting
x_fit=linspace(0.5,4.0);
y_fit = polyval(p6,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [2.08E+02,1.04E+03] 
y_linear= [0.83886,0.09809]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting 
figure(6)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')% polynomial fit 
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
legend('Data','fit(4th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')
grid on 
xlim([0.9 4])
ylim([-1.0 2.0]) 
title("R vs [T]_0 for K_d=60pM, NAAP Scaled=10nM")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{10nM}")
yline(0.5,"-.m","R_{10nM}=0.5")

%% Derivation
deri=polyder(p6)

% Display equation
disp(['dy/dx = ' , num2str(deri(1)) , '*x^3+' , num2str(deri(2)) , '*x^2+' , num2str(deri(3)), '*x^+', num2str(deri(4))])

% Checking value of y when x ...
x1=[2.6726] 
y1=polyval(p6,x1) % value is correct 

% slope, x value of y =0.5 is input into derivation
x_point=[2.6726]
y_p6_slope=polyval(deri,x_point)

%% Roots
p =[ 0.3085   -2.6796    7.9079   -9.5484    4.4482]
r=roots(p)

% sub x value into derivative to check if slope matches with y_p1_slope
slope=polyval(deri,2.6726) % 0.0504 is the x value for y =0.5
