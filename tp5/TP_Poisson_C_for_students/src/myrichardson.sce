function[x,nbiter,vres] = myrichardson(A,b,tol,itermax,alpha)
    n = size(A,1);  
    x = zeros(n,1);
    vres = list();
    
    D = alpha;
    nbiter = 0;
    
    res = norm(b-A*x);
    vres($+1) = res;
    
    while res > tol && nbiter < itermax
        
        x = x + D * (b - A*x);
        res = norm(b-A*x);
        vres($+1) = res;
        nbiter = nbiter+1;
        
    end
endfunction
