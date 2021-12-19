%% Fast decoupled power flow program 
%  by Xingpeng Li (xplipower@gmail.com)

%% Iteration process
for nk = 1:maxIter
       % calculate error for active power (P)
       F1 = Gij .* cos(ang(IG) - ang(JG));
       F2 = Bij .* sin(ang(IB) - ang(JB));
       dPi = Pis - sparse(IGB,1,[Vm(IG).*Vm(JG).*F1; ...
                   Vm(IB).*Vm(JB).*F2],nb,1);                   
       dPi(slack) = [];  % remove the element related to slack bus        
       
       %update criteria for dPi/V
       VmP = Vm;
       VmP(slack) = [];
       errorP = dPi./VmP;
       errorAbsP = abs(errorP);
       errorMaxAbsP = max(errorAbsP);
       errorPP = [errorPP; errorMaxAbsP];  % record dPi/V for plot
       error(1) = errorMaxAbsP;    %slack bus is not included
       
       % update voltage angle
       dangP = InvBpbus * errorP ./VmP;
       angP = angP + dangP;
       ang = [angP;angslack];
   
       
       % calculate error for reactive power (Q)
       F3 = Gij .* sin(ang(IG) - ang(JG));
       F4 = Bij .* cos(ang(IB) - ang(JB));             
       dQi = Qis - sparse(IGB,1,[Vm(IG).*Vm(JG).*F3; ...
                          -Vm(IB).*Vm(JB).*F4],nb,1);                       
       dQi(busPVandSlack) = [];  % remove the elements related to slack bus and PV bus      
       
       % update criteria for dQi/V
       VmQ = Vm;
       VmQ(busPVandSlack) = [];
       errorQ = dQi./VmQ;
       errorAbsQ = abs(errorQ);
       errorMaxAbsQ = max(errorAbsQ);
       errorQQ = [errorQQ; errorMaxAbsQ];    % record dQi/V for plot
       error(2) = errorMaxAbsQ; 
       
       % Update Vm 
       dVmQ = InvBppbus * errorQ;
       VmQ = VmQ + dVmQ;
       Vm = [VmQ;VmPVandslack];
       
       if (max(abs(error)) < epsilon)
           break;
       end
end

