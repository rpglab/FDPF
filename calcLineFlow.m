%% Calculate line flows given voltage magnitude and angle
%   note that the G&B matrix should be consistent with bus numbers
%   if voltage magnitude and angle are re-ordered/re-numbered, so should G&B be.

fprintf(1,' \n');
Sij = zeros(nl,1);
Sji = zeros(nl,1);

% The following for-loop code (except 'fprintf') can be rewritten in vector format to improve efficiency.
for k=1:nl
    i = branch(k,1);   % frombus
    j = branch(k,2);   % tobus
    ComplexVi = Vm(i)*cos(ang(i)) + 1i * Vm(i)*sin(ang(i));
    ComplexVj = Vm(j)*cos(ang(j)) + 1i * Vm(j)*sin(ang(j));
    Iij = (ComplexVi - ComplexVj)/(branch(k,3) + 1i * branch(k,4)); % + 1i*2*branch(k,5)*ComplexVi;
    Sij(k) = ComplexVi * conj(Iij);
    Iji = - Iij;
    Sji(k) = ComplexVj * conj(Iji);
    % use the following expression of Pij to verify Sij is right.
       % Pij = -Vm(i)^2*G(i,j) + Vm(i)*Vm(j)*(G(i,j)*cos(ang(i)-ang(j)) + B(i,j)*sin(ang(i)-ang(j)));
    if showDetailResults == true
        fprintf(1,'   The active power flow on line%2.1d from bus%2.1d to bus%2.1d is %8.4f in per unit, \n',k,i,j,real(Sij(k)));
        fprintf(1,'   The reactive power flow on line%2.1d from bus%2.1d to bus%2.1d is %8.4f in per unit, \n',k,i,j,imag(Sij(k)));
        fprintf(1,' \n');
        fprintf(1,'   The active power flow on line%2.1d from bus%2.1d to bus%2.1d is %8.4f in per unit, \n',k,j,branch(k,1),real(Sji(k)));
        fprintf(1,'   The reactive power flow on line%2.1d from bus%2.1d to bus%2.1d is %8.4f in per unit, \n',k,j,i,imag(Sji(k)));
        fprintf(1,' \n');
        fprintf(1,'   The active power loss on line%2.1d is %8.4f in per unit, \n',k,real(Sij(k))+real(Sji(k)));
        fprintf(1,'   The reactive power loss on line%2.1d is %8.4f in per unit, \n',k,imag(Sij(k))+imag(Sji(k)));
        fprintf(1,' \n');
    end
end
Sloss = sum(Sij+Sji);
Ploss = real(Sloss);
Qloss = imag(Sloss);
fprintf(1,'   The total active power loss is %8.4f in per unit, \n',Ploss);
fprintf(1,'   The total reactive power loss is %8.4f in per unit, \n',Qloss);
fprintf(1,' \n');