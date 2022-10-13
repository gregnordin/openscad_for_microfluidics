theta_code_point = 952;
theta = chr(theta_code_point);
Delta_code_point = 916;
Delta = chr(Delta_code_point);

echo();
echo();
echo(chr(952));
echo(str(chr(Delta_code_point), chr(theta_code_point)));
echo(str(Delta, theta));
echo();

scale(0.3) text(str("An angle: ", Delta, theta));