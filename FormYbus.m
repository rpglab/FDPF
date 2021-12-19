%% Calculate Ybus
% Purpose:   calculate nodal admittance matrix (Ybus)
% Input:     network topology and line parameters
% Output:    Ybus

%% MakeYbus 
% For each branch, compute the elements of the branch admittance matrix where
%      | If |   | Yff  Yft |   | Vf |
%      |    | = |          | * |    |
%      | It |   | Ytf  Ytt |   | Vt |
%  This is from Chapter 3.2 in the "Matpower user manual", here is the link:
%  https://matpower.org/docs/MATPOWER-manual.pdf
%
% Pre-processing
Ys = 1 ./ (branch(:, 3) + j * branch(:, 4));  %% series admittance
% line conductance is usually zero, so comment it out.
% Gc = branch(:, 5);                            %% line conductance
Bc = branch(:, 6);                            %% half of line charging susceptance
tap = branch(:, 7);                        %% assign non-zero tap ratios

Ytt = Ys + 1j*Bc;    % if Bc is the whole line charging susceptance, then, 50% needs to be multiplied to Bc.
Yff = Ytt ./ (tap .*tap);
Yft = - Ys ./ tap;
Ytf = Yft;

% compute shunt admittance
    % if Psh is the real power consumed by the shunt at V = 1.0 p.u.
    % and Qsh is the reactive power injected by the shunt at V = 1.0 p.u.
    % then Psh - j Qsh = V * conj(Ysh * V) = conj(Ysh) = Gs - j Bs,
    % i.e. Ysh = Psh + j Qsh, so ...
% vector of shunt admittances
Ysh = (bus(:, 3) + 1j * bus(:, 4));  
                                    
% build Ybus
f = branch(:, 1);                           %% list of "from" buses
t = branch(:, 2);                           %% list of "to" buses
Cf = sparse(f, 1:nl, ones(nl, 1), nb, nl);      %% connection matrix for line & from buses
Ct = sparse(t, 1:nl, ones(nl, 1), nb, nl);      %% connection matrix for line & to buses

Ybus = spdiags(Ysh, 0, nb, nb) + ...            %% shunt admittance    
    Cf * spdiags(Yff, 0, nl, nl) * Cf' + ...    %% Yff term of branch admittance
    Cf * spdiags(Yft, 0, nl, nl) * Ct' + ...    %% Yft term of branch admittance
    Ct * spdiags(Ytf, 0, nl, nl) * Cf' + ...    %% Ytf term of branch admittance
    Ct * spdiags(Ytt, 0, nl, nl) * Ct';         %% Ytt term of branch admittance

% Build Yf and Yt such that Yf * V is the vector of complex branch currents injected
% at each branch's from bus, and Yt is the same for the to bus end.

% The above codes are (with some modifications) from makeYbus.m in Matpower (https://matpower.org/)

%% Post-processing after Ybus is calculated
G=real(Ybus); 
B=imag(Ybus);

% fine non-zero elements
[IG,JG,Gij]=find(G);       
[IB,JB,Bij]=find(B);
IGB = [IG;IB];

