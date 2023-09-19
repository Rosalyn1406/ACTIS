%% curve fitting to polynomial
load unscaled500pM.mat
x=unscaled500pM.xT0;
y=unscaled500pM.yR500;

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
p4=polyfit(logx,y,4)

% display equation
disp(['y= ',num2str(p4(1)), '*x^4+' ,  num2str(p4(2)) , '*x^3' , num2str(p4(3)) , '*x^2' , num2str(p4(4)) , '*x+', num2str(p4(5))])
% Fitting
x_fit=linspace(0.2,3.05);
y_fit = polyval(p4,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [8.33E+00,4.17E+01] 
y_linear= [0.74301,0.20764]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting 
figure(4)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')% polynomial fit 
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
legend('Data','fit(4th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')
grid on 
ylim([0 1.2])
title("R vs [T]_0 for K_d=60pM, NAAP Unscaled=500pM")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{500PM}")
yline(0.5,"-.m","R_{500pM}=0.5")

%% Derivation
deri=polyder(p4)

% Display equation
disp(['dy/dx = ' , num2str(deri(1)) , '*x^3+' , num2str(deri(2)) , '*x^2+' , num2str(deri(3)), '*x+', num2str(deri(4))])

% Checking value of y when x ...
x1=[1.1996] 
y1=polyval(p4,x1) % value is correct 

% slope, x value of y =0.5 is input into derivation
x_point=[1.1996]
y_p4_slope=polyval(deri,x_point)

%% Roots
p =[ -0.2036    1.4108   -3.1004    1.9054    0.1621]
r=roots(p)

% sub x value into derivative to check if slope matches with y_p1_slope
slope=polyval(deri,1.1996) % 0.0504 is the x value for y =0.5