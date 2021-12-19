%% Calculate nodal power injection into the network

tempP = zeros(nb,1);
tempQ = zeros(nb,1);
Pi = zeros(nb,1);
Qi = zeros(nb,1);

Ybus=full(Ybus);
Ybus=Ybus(orderedBusIndex(:, 1), :);
Ybus=Ybus(:, orderedBusIndex(:, 1));
G=real(Ybus);
B=imag(Ybus);

for j=1:nb
    for k=1:nb
        tempP(k) = Vm(j)*Vm(k)*(G(j,k)*cos(ang(j)-ang(k)) + B(j,k)*sin(ang(j)-ang(k)));
        tempQ(k) = Vm(j)*Vm(k)*(G(j,k)*sin(ang(j)-ang(k)) - B(j,k)*cos(ang(j)-ang(k)));
    end
    Pi(j) = sum(tempP);
    Qi(j) = sum(tempQ);        
end

if showDetailResults == true
    for j=1:nb
        fprintf(1,'   The active power injection at bus%2.1d is %8.4f, \n',j,Pi(j));
        fprintf(1,'   The reactive power injection at bus%2.1d is %8.4f, \n',j,Qi(j));
        fprintf(1,' \n');
    end
end

% Compare with the results obtained withe the following codes to validate the above codes
% Pinj = zeros(nb,1);
% Qinj = zeros(nb,1);
% Pinj(gen(:,1)) = gen(:, 2);
% Qinj(gen(:,1)) = gen(:, 3);
% Pinj(load(:,1)) = Pinj(load(:,1)) - load(:, 2);
% Qinj(load(:,1)) = Qinj(load(:,1)) - load(:, 3);

