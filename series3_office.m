load R1.mat
x= R1.xT0;
y= R1.yR3;

%log scale x axis
logx=log10(x)

%% Curve Fit
% polyval:evaluate polynomial at some point x
% polyint:integrate polynomial
% polyder:derivative of polynomial
% roots: return roots of a polynomial
% conv: multiply two polynomial
% deconv: divide two polynomial
% polyfit: least-squares polynomial curve fit

%fitting to eight degree
% coefficeint
p3=polyfit(logx,y,8)

% display equation
disp(['y= ',num2str(p3(1)), 'x^8+' ,  num2str(p3(2)) , 'x^7+' , num2str(p3(3)) , 'x^6' , num2str(p3(4)) , 'x^5' ...
    , num2str(p3(5)) , 'x^4+' , num2str(p3(6)) , 'x^3' , num2str(p3(7)) , 'x^2' , num2str(p3(8)) , 'x+' , num2str(p3(9))])
% Fitting
x_fit=linspace(-2,4);
y_fit = polyval(p3,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [1.67E-01,5.55E-01,1.67E+00,5.55E+00] 
y_linear= [8.73E-01,6.67E-01,3.90E-01,1.56E-01]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting
figure(3)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')
plot(log_x,y_est,'g--',LineWidth=2.0)
hold off;
ylim([-0.2 1.2]) 
xlim([-1.9 3.333333])
grid on
title("R vs [T]_0 for K_d=50pM, L_0/K_d=0.167")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{3}")
yline(0.5,"-.m","R_3=0.5")
legend('Data','fit(8th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')

%% Derivation
deri=polyder(p3)
disp(['dy/dx = ' , num2str(deri(1)) , '*x^7+' , num2str(deri(2)) , '*x^6' , num2str(deri(3)) , '*x^5' ...
    , num2str(deri(4)) , '*x^4+' , num2str(deri(5)) , '*x^3' , num2str(deri(6)) , '*x^2' , num2str(deri(7)) , '*x+' , num2str(deri(8))])

% Checking value of y when x is ..
x1=[0.0352] 
y1=polyval(p3,x1) % value is correct 

% slope, x value of y =0.5 is input into derivation
x_point=[0.0352]
y_p3_slope=polyval(deri,x_point)

%% Roots
p=[-0.0009    0.0046    0.0050   -0.0470   -0.0031    0.1978   -0.0158   -0.5729  0.0202];
r=roots(p)

% sub x value into derivative
slope=polyval(deri,0.0352) % 0.0032 is the x value for y =0.5
