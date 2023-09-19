% simulated data L_0/K_d
x= [1.67E-02,5.55E-02,1.67E-01,5.56E-01,1.67E+00,5.56E+00,1.67E+01,5.56E+01,1.67E+02,1.67E+03];
y= [-0.5579,-0.5611,-0.5733,-0.6110,-0.6875,-0.7466,-0.8420,-0.8983,-1.1306,-1.1746];
% dan's experimental data 
x1= [0.333333333,0.833333333,1.666666667,8.333333333,33.33333333,166.6666667];
y1= [-0.6740,-0.5867,-0.6624,-0.8680,-0.9252,-1.1382];

% new slope
x2= [0.333333333,0.833333333,1.666666667,8.333333333,33.33333333,166.6666667]; %L0/Kd_real
%x2= [2.86E-01,0.819672131,0.227272727,0.819672131,0.8,0.526315789];
y2= [-0.786333333,-0.596478333,-4.8576,-8.824666667,-38.55,-360.43];

logx=log10(x);
logx1=log10(x1);
logx2=log10(x2)
logy2=log10(y2)

figure(1)
plot(logx,y,'o--')
hold on;
plot(logx1,y1,'go--')
hold off;
title("slope vs [L]_0/K_d")
xline(0,"-.m")
xline(0.3,"-.k")
xlabel("[L]_0/K_d")
ylabel("slope")

legend('Simulated Data','Experimental Data','Linewidth',1.0,'AutoUpdate','off')
grid on

figure (2)
plot(logx2,logy2,'o--')
title("slope vs [L]_0/K_d")
xlabel("[L]_0/K_{d_{real}}")
ylabel("new slope")
xline(0,"-.m")
xline(0.3,"-.k")
grid on

figure(3)
% Simulated data linear fit 
% x_simulated= [1.67E-02,5.55E-02,1.67E-01,5.56E-01,1.67E+00,5.56E+00,1.67E+01,5.56E+01,1.67E+02,1.67E+03];
y_simulated= [-0.56435,-0.56644,-0.57898,-0.60616,-0.64995,-0.79375,-0.99493,-1.1158,-1.2447,-1.3436];
% Experimental data linear 
% x_data= [0.333333333,0.833333333,1.666666667,8.333333333,33.33333333,166.6666667];
y_data= [-0.58734,-0.60764,-0.58202,-0.81687,-0.78575,-1.0598];

% log_simulated=log10(x_simulated);
% log_data=log10(x_data);

plot(logx,y_simulated,'o--')
hold on;
plot(logx1,y_data,'go--')
hold off;
title("slope (linear fit) vs [L]_0/K_d")
xlabel("[L]_0/K_d")
ylabel("slope (linear fit)")
legend('Simulated Data(linear)','Experimental Data(linear)','Linewidth',1.0,'AutoUpdate','off')
grid on