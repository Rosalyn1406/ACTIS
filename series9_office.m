load R1.mat
x= R1.xT0;
y= R1.yR9;

%log scale x axis
logx=log10(x);

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
p9=polyfit(logx,y,8)
disp(['y= ',num2str(p9(1)), 'x^8+' ,  num2str(p9(2)) , 'x^7+' , num2str(p9(3)) , 'x^6' , num2str(p9(4)) , 'x^5+' ...
    , num2str(p9(5)) , 'x^4+' , num2str(p9(6)) , 'x^3' , num2str(p9(7)) , 'x^2' , num2str(p9(8)) , 'x+' , num2str(p9(9))])
% Fitting
x_fit=linspace(-2,4);
y_fit = polyval(p9,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [1.67E+01,5.55E+01,1.67E+02,5.55E+02] 
y_linear= [9.01E-01,6.70E-01,7.45E-02,2.56E-03]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);

%% plotting
figure(9)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
ylim([-0.2 1.2]) 
xlim([-1.9 3.333333])
grid on
title("R vs [T]_0 for K_d=50pM, L_0/K_d=167")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{9}")
yline(0.5,"-.m","R_9=0.5")
legend('Data','fit(8th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')

%% Derivation
deri=polyder(p9)
disp(['dy/dx = ' , num2str(deri(1)) , '*x^7+' , num2str(deri(2)) , '*x^6' , num2str(deri(3)) , '*x^5' ...
    , num2str(deri(4)) , '*x^4+' , num2str(deri(5)) , '*x^3' , num2str(deri(6)) , '*x^2' , num2str(deri(7)) , '*x+' , num2str(deri(8))])

% Checking value of y when x is ..
x1=[1.8648] 
y1=polyval(p9,x1) % value is 0.5011 

% slope, x value of y =0.5 is input into derivation
x_point=[1.8648]
y_p9_slope=polyval(deri,x_point)

%% Roots
p=[-0.0071    0.0343    0.0135   -0.1999    0.0316    0.2948   -0.0753   -0.1308    0.5006];
r=roots(p)

% sub x value into derivative(method 2 of finding slope)
slope=polyval(deri,1.8648) % 0.0032 is the x value for y =0.5