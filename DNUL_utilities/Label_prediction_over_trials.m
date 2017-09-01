function [predicted_Label,f] = Label_prediction_over_trials(x,w)

predicted_Label = [];
N = size(x,1);
x = [x ones(size(x,1),1)];
f = [];

%% Getting labels from updated Weights
for i=1:N
    f(i) = 1./(1+ exp(-x(i,:)*w));
    if ge(f,0.5)
        Label(i) = 1;
        predicted_Label = [predicted_Label; Label(i)];
    else
        Label(i) = -1;
        predicted_Label = [predicted_Label; Label(i)];
    end
end
    
end

