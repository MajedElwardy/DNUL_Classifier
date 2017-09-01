function [Resuts, C] = Confusion_Matrix(y, y_pred)

N = size(y_pred,1);

%% ConfusionMatrix

[C] = confusionmat(y,y_pred,'order',[1;0]);
%---%-------%-------%
% C %   1   %   0   %
%---% --------------%
% 1 %  TP   %   FP  %
%---%-------%-------%
% 0 %  FN   %   TN  %
%---%-------%-------%

%% Accuracy and FScore

Accuracy = ((C(1,1) + C(2,2))/ N)*100;                 % Accuracy(%)

Sensitivity = ( C(1,1)/ (C(1,1) + C(1,2)) )*100;       % Sensitivity/TPR(%)

Precision   = ( C(1,1)/ (C(1,1) + C(2,1)) )*100;       % Precision(%)

Specifity   = (1-(C(2,2)/ (C(2,2) + C(2,1))))*100;     % Specifity/FPR(%)

Fscore = 2 * ( (Sensitivity*Precision)/ (Sensitivity+Precision) );

%% Total results

Resuts = [ Accuracy; Fscore; Precision; Sensitivity; Specifity];

end

