%% Calculate B' matrix and B'' matrix
% B' and B'' are calculated from the imaginary part of Ybus;
% some columns and rows are needed to be removed

%% Calculate B' matrix and its inverse matrix
Bpbus = B;
Bpbus(slack,:) = [];
Bpbus(:,slack) = [];
Bpbus = -Bpbus; 
InvBpbus = inv(Bpbus);

%% Calculate B'' matrix and its inverse matrix
Bppbus = B;
Bppbus(busPVandSlack,:) = [];
Bppbus(:,busPVandSlack) = [];
Bppbus = -Bppbus; 
InvBppbus = inv(Bppbus);
