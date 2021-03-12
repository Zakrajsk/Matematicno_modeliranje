% vhodni podatki
% m = 104;
% c = 1;
% S = 2;
% parametri = [m,c,S];
% zac = [0;0];
% tk = 10;
% n = 50;

m = 105;
c = 1;
S = 1.2;
parametri = [m,c,S];
zac = [40000; 0];
tk = 300;
n = 10000;

[y,v,t] = padalec(parametri,zac,tk,n);

sum(v) / length(v)


%subplot(1,2,1)
%plot(t,y,'bo-')
%hold on
%title('Pozicija v odvisnosti od casa')

%subplot(1,2,2)
%plot(t,v,'bo-')
%hold on
%title('Hitrost v odvisnosti od casa')


%eksplicitna resitev (za zac=[0;0])
%ro = 1.3;
%g = 9.8;
%K = 1/2*ro*c*S;
%padalecpozicija = @(t)-log(cosh(sqrt(g*K/m)*t))*m/K
%padalechitrost = @(t)-sqrt(g*m/K)*tanh(sqrt(g*K/m)*t)

%subplot(1,2,1)
%plot(t,padalecpozicija(t),'r')

%subplot(1,2,2)
%plot(t,padalechitrost(t),'r')





