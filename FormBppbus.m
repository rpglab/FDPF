%% Calculate B'' matrix

Bffpp = -1./branch(:,4);

Bpptt = Bffpp + Bc;    %
Bppff = Bpptt ./ (tap .*tap);
Bppft = - Bffpp ./ tap;
Bpptf = Bppft;

Bppbus = Cf * spdiags(Bppff,0,nl,nl) * Cf' ...
           + Cf * spdiags(Bppft,0,nl,nl) * Ct' ...
           + Ct * spdiags(Bpptf,0,nl,nl) * Cf' ...
           + Ct * spdiags(Bpptt,0,nl,nl) * Ct';


Bppbus(busPVandSlack,:) = [];
Bppbus(:,busPVandSlack) = [];

Bppbus = -Bppbus; 
InvBppbus = inv(Bppbus);

