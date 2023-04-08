clear all;
close all; clc;

Na = 10;
K = 2;
k=1;
i=1;
% h_i = gethi(Na); 
% Qk = getQk(Na,h_i,k,K);
Gamma_dB = 15; % dB
delta = 0.5; % This is a placeholder and need to consult because did not find the value in the paper 


theta = 30;
Hi = get_Hi(i,Gamma_dB,K,Na);
Theta_values = [0 -75 -30 30 75];
% getting all As for the angles
len_interferences = length(Theta_values);
All_A = {};
for i =1:len_interferences
   All_A{i} =  get_A(K,Theta_values(i),delta,Na);
end

t = ones(Na*K,1);
SNR_ratio_INR = (10^2);
Po_dBm = 30;%dBm
P_o = 10^(Po_dBm/10) * 0.001;

wa = find_wa(All_A,t,SNR_ratio_INR,Na,K);
Rw_over_sigma = get_Rw_over_sigma(All_A,wa,SNR_ratio_INR);
Z_over_sigma  = Rw_over_sigma + (wa'*wa)/P_o; 
Omega = 10*All_A{1}*wa*wa'*All_A{1}';


%%%% There can be something wrong with a'. Matlab might be taking a
%%%% transpose but not comjugate so need to confirm that.


