function params = load_endeffector_params(params)
% For this simulation, the geometry of the end-effector is an equilater 
% triangle of side, thickness and material specified below
    % Material: Alluminum 
    %   density [kg/m^3]
    params.rhoe = 2700;

    % Triangle's side [m]
    params.Le = 5/100;
    
    % End-effector thickness [m]
    params.he = 4/1000;
    
    % End-effector volume [m^3]
    params.Ve = params.he*(params.Le^2)*sqrt(3)/4;
    
    % Mass [Kg]
    params.me = params.rhoe*params.Ve;   

    % Inertia [Kg*m^2] - Source: https://bit.ly/2yMkxQS
    params.Je = 0.5*params.me*params.Le^2;
    
    % Joint relatiev position 
    % By symmetry, the reference point is baricenter of the triangle
    
    % End-effector distance between reference frame and  [m] 
    % Geometrically, the radius of an equilater triangle MUST a*sqrt(3)/3
    params.Le1 = params.Le*sqrt(3)/3;
    params.Le2 = params.Le*sqrt(3)/3;
    params.Le3 = params.Le*sqrt(3)/3;
    
    % Angles relative to coordinate frame system attached to the
    % end-effector
    params.gamma1 = 0;
    params.gamma2 = 2*pi/3;
    params.gamma3 = 4*pi/3;
end