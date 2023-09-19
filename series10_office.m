load R1.mat
x= R1.xT0;
y= R1.yR10;

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
p10=polyfit(logx,y,8)
disp(['y= ',num2str(p10(1)), 'x^8+' ,  num2str(p10(2)) , 'x^7+' , num2str(p10(3)) , 'x^6' , num2str(p10(4)) , 'x^5+' ...
    , num2str(p10(5)) , 'x^4+' , num2str(p10(6)) , 'x^3' , num2str(p10(7)) , 'x^2' , num2str(p10(8)) , 'x+' , num2str(p10(9))])
% Fitting
x_fit=linspace(-2,4);
y_fit = polyval(p10,x_fit);

%% Slope by linear approximation between two points with R>0.5 and R<0.5
x_linear= [5.55E+02,1.67E+03] 
y_linear= [6.67E-01,2.42E-02]

log_x=log10(x_linear)
c=polyfit(log_x,y_linear,1)

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
disp(['Slope is = ', num2str(c(1))])

%x_est = linspace(0.8,0.2)
y_est = polyval(c,log_x);
%% plotting
figure(10)
plot(logx,y,'bo')
hold on;
plot(x_fit,y_fit,'r')
plot(log_x,y_est,'g--',LineWidth=2.0) % linear fit 
hold off;
ylim([-0.2 1.2]) 
xlim([-1.9 3.333333])
grid on
title("R vs [T]_0 for K_d=50pM, L_0/K_d=1670")
xlabel("[T]_{0}/K_{d}")
ylabel("R_{9}")
yline(0.5,"-.m","R_{10}=0.5")
legend('Data','fit(8th Degree)','Linear fit','Linewidth',1.0,'AutoUpdate','off')

%% Derivation
deri=polyder(p10)
disp(['dy/dx = ' , num2str(deri(1)) , '*x^7+' , num2str(deri(2)) , '*x^6' , num2str(deri(3)) , '*x^5' ...
    , num2str(deri(4)) , '*x^4+' , num2str(deri(5)) , '*x^3' , num2str(deri(6)) , '*x^2' , num2str(deri(7)) , '*x+' , num2str(deri(8))])

% Checking value of y when x is ..
x1=[ 2.94 ] 
y1=polyval(p10,x1) % value is 0.4801

% slope, x value of y =0.5 is input into derivation
x_point=[ 2.94 ]
y_p8_slope=polyval(deri,x_point)

%% Roots
p=[-0.0001    0.0001    0.0002   -0.0011   -0.0012    0.0000   -0.0015   -0.0018  0.4996];
r=roots(p)

% sub x value into derivative(method 2 of finding slope)
slope=polyval(deri, 2.94) % 0.0032 is the x value for y =0.5