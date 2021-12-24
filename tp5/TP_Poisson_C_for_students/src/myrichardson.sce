function[x,nbiter,vres] = myrichardson(A,b,tol,itermax)
    n = size(A,1);  
    x = zeros(n,1);
    vres = list();
    
    D = diag(diag(A));
    nbiter = 0;
    
    res = norm(b-A*x);
    vres($+1) = res;
    
    while res > tol && nbiter < itermax
        
        x = x + 1/2 * (b - A*x);
        res = norm(b-A*x);
        vres($+1) = res;
        nbiter = nbiter+1;
        
    end
endfunction
