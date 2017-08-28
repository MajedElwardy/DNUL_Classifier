function [w,Engy_start, Engy] = DNUL(x,w,N,max_epoch,stepsize,alpha)

batch = 0;
%max_epoch = 500;
%stepsize = 0.2;

M = size(x,1)/N;
dim = size(x,2);

% initialize the weights
% w = randn(dim+1,1);
winit = w;
% w = [1 1 -1]'
% pad data for bias term
x = [x ones(size(x,1),1)];


epoch = 0;
while epoch < max_epoch
    % permute the data order
%     [dummy, index] = sort(rand(M,1));
    c=0;    
    E = 0;
    update = zeros(1,dim+1);
    for k = 1:M
        R = zeros(N,1);
        Q = zeros(N,1);
        dQdw = zeros(N,dim+1);
        dEdw = zeros(1,dim+1);
        xthis = x(1+c:N+c,:);
        f = 1./(1+exp(alpha*(-xthis*w)));
        for j = 1:N
            R(j) = prod(1-f(1:j-1))*prod(1-f(j+1:N));
            Q(j) = 1 - R(j)*f(j);
        end
        E = E + (1-prod(Q));
        for m = 1:N
            temp = 0;
            for p = 1:N
                if p ~= m
                    temp2 = 1;
                    for u = 1:N
                        if u~=m && u~=p
                            temp2=temp2*(1-f(u));
                        end;
                    end;
                    temp = temp - xthis(p,:)*f(p)*(1-f(p))*temp2;
                end;
            end;
            dQdw(m,:) = -xthis(m,:)*f(m)*(1-f(m))*R(m) - f(m)*temp;
        end;
        for m = 1:N
            dEdw = dEdw - dQdw(m,:)*prod(Q(1:m-1))*prod(Q(m+1:N));
        end;
        if batch == 1
            update = update + dEdw;
        else
            w = w + stepsize*dEdw';
        end;
        c=c+6;
    end
    
%     if batch == 1
%         w = w + stepsize*update';
%     end;
    epoch = epoch + 1;
    Energy(epoch) = E/M;
end;
% dQdw
% dEdw
[winit w];
[Energy(1) Energy(end)]

% figure, plot(Energy,'k','linewidth',2)
% grid,hold on
%% negative weight
w1 = w;
E_end = Energy(end);
E_100 = Energy(100);
E_start = Energy(1);

w = -winit;

epoch = 0;
while epoch < max_epoch
    % permute the data order
%     [dummy, index] = sort(rand(M,1));
    c=0;    
    E = 0;
    update = zeros(1,dim+1);
    for k = 1:M
        R = zeros(N,1);
        Q = zeros(N,1);
        dQdw = zeros(N,dim+1);
        dEdw = zeros(1,dim+1);
        xthis = x(1+c:N+c,:);
        f = 1./(1+exp(alpha*(-xthis*w)));
        for j = 1:N
            R(j) = prod(1-f(1:j-1))*prod(1-f(j+1:N));
            Q(j) = 1 - R(j)*f(j);
        end
        E = E + (1-prod(Q));
        for m = 1:N
            temp = 0;
            for p = 1:N
                if p ~= m
                    temp2 = 1;
                    for u = 1:N
                        if u~=m && u~=p
                            temp2=temp2*(1-f(u));
                        end;
                    end;
                    temp = temp - xthis(p,:)*f(p)*(1-f(p))*temp2;
                end;
            end;
            dQdw(m,:) = -xthis(m,:)*f(m)*(1-f(m))*R(m) - f(m)*temp;
        end;
        for m = 1:N
            dEdw = dEdw - dQdw(m,:)*prod(Q(1:m-1))*prod(Q(m+1:N));
        end;
        if batch == 1
            update = update + dEdw;
        else
            w = w + stepsize*dEdw';
        end;
        c=c+6;
    end
%     if batch == 1
%         w = w + stepsize*update';
%     end;
    
    epoch = epoch + 1;
    Energy(epoch) = E/M;
end;
% dQdw
% dEdw
[-winit w];
[Energy(1) Energy(end)]
% plot(Energy,'b','linewidth',2)

if E_end>Energy(end)
    Engy = E_end;
    E_point = E_100;
    Engy_start = E_start;
    w = w1;  
else
    Engy = Energy(end);
    E_point = Energy(100);
    Engy_start = Energy(1);
end

% xlabel('No. of epochs','fontsize',14,'fontweight','b')
% ylabel('Energy','fontsize',14,'fontweight','b')
% set(gca,'fontsize',12,'fontweight','b')
% str = sprintf('Energy start: %0.4f      Energy end: %0.4f', Engy_start, Engy);
% title(str);
% legend('winit','-winit','location','best')
% % Get the Energy function at 100 epochs
% hold on,
% point_x = 100;
% point_y = E_point - 0.2;
% str1 = sprintf('      Energy %0.4f', E_point);
% text(point_x,point_y,str1)
% text(point_x,point_y,'\leftarrow')
% plot([100 100],[0 E_point],'r--','linewidth',1.3);
end