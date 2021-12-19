%% Calculate B' matrix

Bffp = -branch(:,4)./(branch(:,3).*branch(:,3) ...
         + branch(:,4).*branch(:,4));
     
Bptt = Bffp ;    
Bpff = Bptt ;    
Bpft = - Bffp ;  
Bptf = Bpft;

Bpbus = Cf * spdiags(Bpff,0,nl,nl) * Cf' ...
           + Cf * spdiags(Bpft,0,nl,nl) * Ct' ...
           + Ct * spdiags(Bptf,0,nl,nl) * Cf' ...
           + Ct * spdiags(Bptt,0,nl,nl) * Ct';

slack = find (bus(:,2) == 3); 

Bpbus(slack,:) = [];
Bpbus(:,slack) = [];
Bpbus = -Bpbus; 
InvBpbus = inv(Bpbus);

