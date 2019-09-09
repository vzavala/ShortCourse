function [weight,coef] = DiPCA(X,s,npc,tol,maxiter)
    
% DiPCA Dynamic Inner Principal Component Analysis (DiPCA) on data.
% [weight,ceof] = DiPCA(X,s,npc,tol,maxiter) takes arguments
% (n+s)xm data matrix X and AR degree s.
%
% It takes optional arguments number of principal components 'npc',
% iteration tolerance 'tol', and maximum number of iteration 'maxiter'.
% The default values are npc=1, tol=1e-4, maxiter=100000.
%
% It returns arrays of weight vectors w and AR coefficients b.
%
% Make sure to make the data mean zero
    
    if ~exist('npc','var')
        npc = 1;
    end
    if ~exist('tol','var')
        tol = 1e-4;
    end
    if ~exist('maxiter','var')
        maxiter = 10000;
    end
    
    % Set the data dimension
    m = size(X,2);
    n = size(X,1)-s;

    % Initialize the output matrix
    weight = zeros(m,npc);
    coef = zeros(s,npc);
    rp = 10;
    
    for k=1:npc % For each principal component,
        
        % Initialie the iteartion variables
        w = 1/sqrt(m)*ones(m,1);
        b = 1/sqrt(s)*ones(s,1);

        % Initialize Y and y
        d = zeros(m,1);
        c = zeros(s,1);
        for i=1:s
            temp = X(s+1:n+s,:)'*X(s+1-i:n+s-i,:);
            Y{i} = (temp+temp')/2;
            y{i} = Y{i}*w;
            d = d + y{i}*b(i);
        end

        % Initialie the iteration
        r = Inf;
        cnt = 0;
        l = 1e-10; ll = 1e-10;
        fprintf('*** Finding principal component %i -----------------\n',k);
        while r > tol && cnt < maxiter;
            wo= w;
            w = d/norm(d,2);
            for i=1:s
                y{i} = Y{i}*w;
                c(i) = w'*y{i};
            end

            l = norm(c,2);
            b = c/l;
                
            d = zeros(m,1);
            for i=1:s
                d = d + y{i}*b(i);
            end
            r = norm(d-l*w,Inf);
            if mod(cnt,10)==0
                fprintf('Iter  Residual     Objective\n');
            end
            fprintf('%4i %2.6e %2.6e\n',cnt,r,l);
            cnt = cnt+1;
        end
        t = X*w;
        X = X - t* (X'*t/(t'*t))';
        weight(:,k) = w;
        coef(:,k) = b;
    end
end