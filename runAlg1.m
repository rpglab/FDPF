%% Fast decoupled power flow program 
%  by Xingpeng Li (xplipower@gmail.com)

%% Iteration process
convFlag = 0;  % mark whether the program converges at B' or B''
for nk = 1:maxIter
   if convFlag == 0       
       % calculate error for active power
       F1 = Gij .* cos(ang(IG) - ang(JG));
       F2 = Bij .* sin(ang(IB) - ang(JB));
       dPi = Pis - sparse(IGB,1,[Vm(IG).*Vm(JG).*F1; ...
                   Vm(IB).*Vm(JB).*F2],nb,1);                   
       dPi(slack) = [];  % remove the element related to slack bus        
       
       %update criteria 1£¬for dPi/V
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
       
       if (max(abs(error)) < epsilon)
           break;
       end    
       convFlag = 1; 
   end
   
   if convFlag == 1
       % calculate error for reactive power
       F3 = Gij .* sin(ang(IG) - ang(JG));
       F4 = Bij .* cos(ang(IB) - ang(JB));             
       dQi = Qis - sparse(IGB,1,[Vm(IG).*Vm(JG).*F3; ...
                          -Vm(IB).*Vm(JB).*F4],nb,1);                       
       dQi(busPVandSlack) = [];  % remove the elements related to slack bus and PV bus      
       
       % update criteria 2£¬for dQi/V
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
       convFlag = 0;
   end
end
