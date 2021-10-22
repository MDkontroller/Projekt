clear all;
close all; 

% Anzahl Messwerte
vals    = 200;

% Streuung der Messwerte
sigma = 10;

% ZustandsÃ¼bergangsmodel
dT = 2.0;

A = [1    0    dT   0;
	0    1    0     dT;
	0    0    1     0;
	0    0    0     1];

% Realer Zustand
x = [0 0 1 1]';

% Messwerte generieren
data = generate_noisy_data(A, x, vals, sigma);

%plot(data(:,1),data(:,2), 'b');
plot(data(:,1),'b')

% SchÃ¤tzung des Anfangszustands
x = [0 0 0 0]';

% Nur die Position ist messbar, nicht die Geschwindigkeit
H = [1 0 0 0; 0 1 0 0];

% Messrauschen
R = [sigma 0; 0 sigma];

% Systemrauschen
Q = [0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];

% Kovarianz matrix
P = eye(4);


% Implementieren Sie hier den Kalmanfilter

for i =1:vals
    
    x_prio = A * x;
    y = H * x_prio;
    P = A* P * A' + Q;

    % Korrektur
    K = P * H' * inv(H * P * H'+ R);  
    x = x_prio + K *(data(i,:)' -y );

    P = (eye(4) - K *H) *P;

    % PLOT

    data_kalman(i,:)= x;

end

hold on;
plot(data_kalman(:,1),'r')
%plot(data_kalman(:,1),data_kalman(:,2), 'r');

