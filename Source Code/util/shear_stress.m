function TX = shear_stress(x)

h = x(1);
L = x(2);
t = x(3);

t1 = 6000/sqrt(2)*h*L;
R= sqrt(0.25*(L^2 + (h+t)^2));

A = (6000*(14+(0.5*L))*R);
B = 2*(0.707*h*L*((L^2/12)+0.25*(h+t)^2));
t2= A/B;
TX = sqrt(t1^2 +t2^2+(L*t1*t2) /sqrt(0.25*(L^2+(h*t)^2)));


end


