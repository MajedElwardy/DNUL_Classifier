function [w,Engy_start, Engy_end, E_plot_pos, E_plot_neg] = DNUL(x,w,N,max_epoch,stepsize,alpha)


M = size(x,1)/N;
dim = size(x,2);

winit = w;
x = [x ones(size(x,1),1)];

epoch = 0;
while epoch < max_epoch
    
    c=0;    
    E = 0;

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

        w = w + stepsize*dEdw';
        c=c+6;
    end
    
    epoch = epoch + 1;
    Energy(epoch) = E/M;
end;

fprintf('Positive w --> E_start(x): %f *** E_End(x): %f \n',Energy(1),Energy(end));
E_plot_pos = Energy;

%% negative weight
w1 = w;
E_end = Energy(end);
E_start = Energy(1);

w = -winit;

epoch = 0;
while epoch < max_epoch

    c=0;    
    E = 0;

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

        w = w + stepsize*dEdw';
        c=c+6;
    end

    epoch = epoch + 1;
    Energy(epoch) = E/M;
end;

fprintf('Negative w --> E_start(x): %f *** E_End(x): %f \n \n',Energy(1),Energy(end));
E_plot_neg = Energy;

    if E_end>Energy(end)
        Engy_end = E_end;
        Engy_start = E_start;
        w = w1;  
    else
        Engy_end = Energy(end);
        Engy_start = Energy(1);
    end

end