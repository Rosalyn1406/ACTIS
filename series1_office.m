load R1.mat
x= R1.xT0
y= R1.yR1

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
p1=polyfit(logx,y,8)

% display equation
disp(['y= ',num2str(p1(1)), '*x^8+' ,  num2str(p1(2)) , '*x^7+' , num2str(p1(3)) , '*x^6' , num2str(p1(4)) , '*x^5' ...
    , num2str(p1(5)) , '*x^4+' , num2str(p1(6)) , '*x^3' , num2str(p1(7)) , '*x^2' , num2str(p1(8)) , '*x+' , num2str(p1(9))])

% Fitting
x_fit=linspace(-2,4);
y_fit = polyval(p1,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [1.67E-01,5.55E-01,1.67E+00,5.55E+00] 
y_linear= [8.59E-01,6.46E-01,3.76E-01,1.53E-01]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting
figure(1)
% data 
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r') % polynomial fit 
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
legend('Data','fit(8th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')
ylim([-0.2 1.2]) 
xlim([-1.9 3.5])
grid on
title("R vs [T]_0 for K_d=50pM, L_0/K_d=0.0167")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{1}")
yline(0.5,"-.m","R_1=0.5")

%% Derivation
deri=polyder(p1)

% Display equation
disp(['dy/dx = ' , num2str(deri(1)) , '*x^7+' , num2str(deri(2)) , '*x^6' , num2str(deri(3)) , '*x^5' ...
    , num2str(deri(4)) , '*x^4+' , num2str(deri(5)) , '*x^3' , num2str(deri(6)) , '*x^2' , num2str(deri(7)) , '*x+' , num2str(deri(8))])

% Checking value of y when x ...
x1=[0.0032] 
y1=polyval(p1,x1) % value is correct 

% slope, x value of y =0.5 is input into derivation
x_point=[0.0032]
y_p1_slope=polyval(deri,x_point)

%% Roots
p=[-0.0007    0.0035    0.0055   -0.0397   -0.0115    0.1810    0.0054   -0.5579 0.0018];
r=roots(p)

% sub x value into derivative
slope=polyval(deri,0.0032) % 0.0032 is the x value for y =0.5
