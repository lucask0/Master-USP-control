function sys =  lin_pendulum(sys, WP)
    % Linearization on working point
    states = [];
    for i = 1:max(size(sys.q))
        states = [states; sys.q{i}];
    end 
    
    for  i = 1:max(size(sys.qp))
        states = [states; sys.qp{i}];
    end
    
    linvars = [];
    for  i = 1:max(size(sys.u))
        Fq = sys.u{i};
        linvars = [states; Fq];
    end 
    
    sys.states = states;
    sys.linvars = linvars;
        
    % Auxiliarry subs variables
    n = max(size(formula(linvars)));
    u = sym('u', [n, 1]);
    u_x = u(1:n);
    u_u = u(end);
    
    % System behaviour's function 
    f_u = subs(sys.f, linvars, u);
    
    % Sensor behaviour's function
    g_u = subs(sys.g, linvars, u);
    
    % Matrix A for each working-point
    jacf_x = jacobian(f_u, u_x);
    jacf_u = jacobian(f_u, u_u);
    jacg_x = jacobian(g_u, u_x);
    jacg_u = jacobian(g_u, u_u);
    
    jacf_x
    jacf_u
    jacg_x
    jacg_u
    
    % Matrices on the provided working-point
    A = subs(jacf_x, u, WP);
    B = subs(jacf_u, u, WP);
    C = subs(jacg_x, u, WP);
    D = subs(jacg_u, u, WP);
    
    A
    B
    
    sys.A = simplify(A);
    sys.B = simplify(B);
    sys.C = simplify(C);
    sys.D = simplify(D);
end