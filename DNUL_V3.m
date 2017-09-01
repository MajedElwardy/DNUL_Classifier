function [w,Engy_start, Engy_end,E_plot_pos,E_plot_neg] = DNUL_V3(x,w,N,r,max_epoch,stepsize,beta)


M = size(x,1)/(N*r);
dim = size(x,2);

winit = w;
x = [x ones(size(x,1),1)];


epoch = 0;
while epoch < max_epoch

    c=0;
    E = 0;
    
    for k = 1:M
        R = zeros(r,N);
        Q = zeros(r,N);
        dQdw = zeros(r,dim+1);
        dEdw = zeros(1,dim+1);
        xthis = x(1+c:(N*r)+c,:);
        f = 1./(1+exp(beta*(-xthis*w)));
      
        temp_Q = zeros(N,1);
        for j = 1:N
            mov = 0;
            for rep = 1:r
                R(rep,j) = prod(1-f(1+mov:j+mov-1))*prod(1-f(j+mov+1:N+mov));
                Q(rep,j) = R(rep,j)*f(mov+j);
                mov = mov+N;
            end
            temp_Q(j) = prod(Q(:,j));
        end
        
        E = E + sum(temp_Q);
        
        for m = 1:N
            mov = 0;
            for rep =1:r
                temp = 0;
                for p = 1:N
                    if p ~= m
                        temp2 = 1;
                        for u = 1:N
                            if u~=m && u~=p
                                temp2=temp2*(1-f(u+mov));
                            end;
                        end;
                        temp = temp - xthis(p+mov,:)*f(p+mov)*(1-f(p+mov))*temp2;
                    end;
                end;
                dQdw(rep,:) = xthis(m+mov,:)*f(m+mov)*(1-f(m+mov))*R(rep,m) + f(m+mov)*temp;
                dEdw = dEdw + dQdw(rep,:)*prod(Q(1:rep-1,m))*prod(Q(rep+1:r,m));
                mov = mov+N;
            end;
        end;
       
        w = w + stepsize*dEdw';
        c=c+(N*r);
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
        R = zeros(r,N);
        Q = zeros(r,N);
        dQdw = zeros(r,dim+1);
        dEdw = zeros(1,dim+1);
        xthis = x(1+c:(N*r)+c,:);
        f = 1./(1+exp(beta*(-xthis*w)));
      
        temp_Q = zeros(N,1);
        for j = 1:N
            mov = 0;
            for rep = 1:r
                R(rep,j) = prod(1-f(1+mov:j+mov-1))*prod(1-f(j+mov+1:N+mov));
                Q(rep,j) = R(rep,j)*f(mov+j);
                mov = mov+N;
            end
            temp_Q(j) = prod(Q(:,j));
        end
        
        E = E + sum(temp_Q);
        
        for m = 1:N
            mov = 0;
            for rep =1:r
                temp = 0;
                for p = 1:N
                    if p ~= m
                        temp2 = 1;
                        for u = 1:N
                            if u~=m && u~=p
                                temp2=temp2*(1-f(u+mov));
                            end;
                        end;
                        temp = temp - xthis(p+mov,:)*f(p+mov)*(1-f(p+mov))*temp2;
                    end;
                end;
                dQdw(rep,:) = xthis(m+mov,:)*f(m+mov)*(1-f(m+mov))*R(rep,m) + f(m+mov)*temp;
                dEdw = dEdw + dQdw(rep,:)*prod(Q(1:rep-1,m))*prod(Q(rep+1:r,m));
                mov = mov+N;
            end;
        end;
       
        w = w + stepsize*dEdw';
        c=c+(N*r);
    end

    epoch = epoch + 1;
    Energy(epoch) = E/M;
end;

fprintf('Negative w --> E_start(x): %f *** E_End(x): %f \n  \n',Energy(1),Energy(end));
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