function plotData(X, y, W)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.
%
% Note: This was slightly modified such that it expects y = 1 or y = 0

% Find Indices of Positive and Negative Examples
pos = find(y == 1); neg = find(y == 0);

% Plot Examples
plot(X(pos, 1), X(pos, 2), 'k+','LineWidth', 1, 'MarkerSize', 7)
hold on;
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7)
hold on;

    if isempty(W)>0

    else
        f = @(x1,x2) W(3,1) + W(1,1)*x1 + W(2,1)*x2;
        h2 = ezplot(f,[min(X(:,1))+0.2 max(X(:,1))+0.2 min(X(:,2))+0.2 max(X(:,2))+0.2]);
        h2.Color = 'b';
        h2.LineWidth = 2;
        hold on;
    end
xlabel('Feature (x1)','fontsize',14,'fontweight','b')
ylabel('Feature (x2)','fontsize',14,'fontweight','b')
title('Synthetic data example','fontsize',18)
legend('Target','Non-Target','Location','best')
set(gca,'fontsize',12,'fontweight','b')
hold off;
end
