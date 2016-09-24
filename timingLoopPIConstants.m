function [ K1, K2 ] = timingLoopPIConstants(Kp, K0, xi, Bn_Ts, L)
% Compute the constants for the symbol timing loop PI controller
%
%    Inputs:
% Kp     ->  TEQ Gain
% K0     ->  Counter (interpolator controller) gain
% Xi     ->  Damping factor
% Bn_Ts  ->  PLL Noise Bandwith normalized by the symbol rate
%            (multiplied by the symbol period Ts)
% L      ->  Oversampling factor
%
%    Outputs:
% K1     ->  Proportional gain
% K2     ->  Integrator gain
%
%
%    Note:
% Assuming L = Ts/T and that Bn*Ts is given, we can obtain Bn*T by
% considering that:
%
%   Bn * T = Bn * (Ts/L) = (Bn * Ts)/L

%% Main

% Convert (Bn*Ts), i.e. multiplied by symbol period, to (Bn*T), i.e.
% multiplied by the sampling period.
Bn_times_T = Bn_Ts / L;

% Theta_n (a definition in terms of T and Bn)
Theta_n = (Bn_times_T)/(xi + (1/(4*xi)));

% Constants obtained by analogy to the continuous time transfer function:
Kp_K0_K1 = (4 * xi * Theta_n) / (1 + 2*xi*Theta_n + Theta_n^2);
Kp_K0_K2 = (4 * Theta_n^2) / (1 + 2*xi*Theta_n + Theta_n^2);

% K1 and K2 (PI constants):
K1 = Kp_K0_K1/(Kp*K0);
K2 = Kp_K0_K2/(Kp*K0);

end

