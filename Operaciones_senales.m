clc; clearvars; close all;

% Menú para seleccionar x1
x1_choices = {'Impulso', 'Escalón', 'Rampa', 'Senoidal', 'Chirp', 'Coseno', 'Sawtooth'};
[x1_idx, x1_tf] = listdlg('ListString', x1_choices, 'SelectionMode', 'single', 'Name', 'Selecciona x1', 'PromptString', 'Elige x1:');

if ~x1_tf
    disp('No se seleccionó x1. Saliendo del programa.');
    return;
end

% Menú para seleccionar x2
x2_choices = {'Impulso', 'Escalón', 'Rampa', 'Senoidal', 'Chirp', 'Coseno', 'Sawtooth'};
[x2_idx, x2_tf] = listdlg('ListString', x2_choices, 'SelectionMode', 'single', 'Name', 'Selecciona x2', 'PromptString', 'Elige x2:');

if ~x2_tf
    disp('No se seleccionó x2. Saliendo del programa.');
    return;
end

% Generar señal x1
switch x1_idx
    case 1
        % Generar Impulso
        A = 1;
        n0 = 0;
        ni = -5;
        nf = 5;
        x1 = A * [zeros(1, abs(ni) + n0) 1 zeros(1, abs(nf) - n0)];
    case 2
        % Generar Escalón
        A = 1;
        n0 = 0;
        ni = -5;
        nf = 5;
        x1 = A * [zeros(1, abs(ni) + n0) ones(1, abs(nf) + 1 - n0)];
    case 3
        % Generar Rampa
        A = 1;
        n0 = 0;
        ni = -5;
        nf = 5;
        n3 = ni:nf;
        x1 = A * (n3 - n0);
    case 4
        % Generar Senoidal
        A = 1.5;
        Fa = 20;
        Fs = 400;
        Fase = 0.5;
        n0 = 2;
        ni = -5;
        nf = 50;
        Ts = 1 / Fs;
        n6 = ni:nf;
        x1 = A * sin(2 * pi * Fa * (n6 - n0) / Fs + Fase);
    case 5
        % Generar Chirp
        A = 1;
        Fi = 10;
        Ff = 50;
        n0 = 0;
        ni = 0;
        nf = 100;
        Fs = 400;
        Ts = 1 / Fs;
        n7 = ni:nf;
        t7 = (0:(nf - ni)) * Ts;
        x1 = A * chirp(t7, Fi, (nf - ni) * Ts, Ff);
    case 6
        % Generar Coseno
        A = 1;
        Fc = 10;
        Fase = 0;
        n0 = 0;
        ni = 0;
        nf = 100;
        Fs = 400;
        Ts = 1 / Fs;
        n8 = ni:nf;
        t8 = (0:(nf - ni)) * Ts;
        x1 = A * cos(2 * pi * Fc * t8 + Fase);
    case 7
        % Generar Sawtooth
        A = 1;
        T = 20;
        n0 = 0;
        ni = 0;
        nf = 100;
        Fs = 400;
        Ts = 1 / Fs;
        n9 = ni:nf;
        t9 = (0:(nf - ni)) * Ts;
        x1 = A * sawtooth(2 * pi * T * t9);
end

% Generar señal x2
switch x2_idx
    case 1
        % Generar Impulso
        A = 1;
        n0 = 0;
        ni = -5;
        nf = 5;
        x2 = A * [zeros(1, abs(ni) + n0) 1 zeros(1, abs(nf) - n0)];
    case 2
        % Generar Escalón
        A = 1;
        n0 = 0;
        ni = -5;
        nf = 5;
        x2 = A * [zeros(1, abs(ni) + n0) ones(1, abs(nf) + 1 - n0)];
    case 3
        % Generar Rampa
        A = 1;
        n0 = 0;
        ni = -5;
        nf = 5;
        n3 = ni:nf;
        x2 = A * (n3 - n0);
    case 4
        % Generar Senoidal
        A = 1.5;
        Fa = 20;
        Fs = 400;
        Fase = 0.5;
        n0 = 2;
        ni = -5;
        nf = 50;
        Ts = 1 / Fs;
        n6 = ni:nf;
        x2 = A * sin(2 * pi * Fa * (n6 - n0) / Fs + Fase);
    case 5
        % Generar Chirp
        A = 1;
        Fi = 10;
        Ff = 50;
        n0 = 0;
        ni = 0;
        nf = 100;
        Fs = 400;
        Ts = 1 / Fs;
        n7 = ni:nf;
        t7 = (0:(nf - ni)) * Ts;
        x2 = A * chirp(t7, Fi, (nf - ni) * Ts, Ff);
    case 6
        % Generar Coseno
        A = 1;
        Fc = 10;
        Fase = 0;
        n0 = 0;
        ni = 0;
        nf = 100;
        Fs = 400;
        Ts = 1 / Fs;
        n8 = ni:nf;
        t8 = (0:(nf - ni)) * Ts;
        x2 = A * cos(2 * pi * Fc * t8 + Fase);
    case 7
        % Generar Sawtooth
        A = 1;
        T = 20;
        n0 = 0;
        ni = 0;
        nf = 100;
        Fs = 400;
        Ts = 1 / Fs;
        n9 = ni:nf;
        t9 = (0:(nf - ni)) * Ts;
        x2 = A * sawtooth(2 * pi * T * t9);
end

% Verificar dimensiones y hacer padding para igualar longitudes
lx1 = length(x1);
lx2 = length(x2);

pad = abs(lx1 - lx2);

if lx1 > lx2
    x2 = [x2 zeros(1, pad)];
end
if lx1 < lx2
    x1 = [x1 zeros(1, pad)];
end

% Selección de operación
list = {'Suma', 'Resta', 'Multiplicación', 'División', 'Exponenciación', 'Log(x1+1)-x2^2'};
[indx, tf] = listdlg('ListString', list, 'SelectionMode', 'single', 'Name', 'Selecciona una Operación', 'PromptString', 'Elige una operación:');

if ~tf
    disp('No se seleccionó una operación. Saliendo del programa.');
    return;
end

% Aplicar operaciones matemáticas
switch indx
    case 1
        x = x1 + x2;
        titulo = 'Suma';
    case 2
        x = x1 - x2;
        titulo = 'Resta';
    case 3
        x = x1 .* x2;
        titulo = 'Multiplicación';
    case 4
        [r, c] = find(x2 == 0); % Verificar si hay cero para evitar error
        if isempty(c)
            x = x1 ./ x2;
            titulo = 'División';
        else
            disp('Operación No Realizada: división por cero');
            return;
        end
    case 5
        x = x1.^x2;
        titulo = 'Exponenciación';
    case 6
        x = log(x1 + 1) - x2.^2;  % Logaritmo(X1+1) - x2^2
        titulo = 'x = Log(x1+1) + x2^2';
end

% Verificar si hay valores infinitos o NaN
cond1 = isinf(x);
cond2 = isnan(x);

if ~isempty(find(cond1, 1))
    disp('Verificar: Algún resultado es Infinito');
end

if ~isempty(find(cond2, 1))
    disp('Verificar: Algún resultado es NaN');
end

% Visualización de señales x1 y x2
nx = 0:length(x) - 1; % Vector de instantes n. Por defecto: n = 0

subplot(2, 2, 1);
stem(nx, x1);
xlabel('n');
title('x1(n)');
grid on;

subplot(2, 2, 2);
stem(nx, x2);
xlabel('n');
title('x2(n)');
grid on;

% Verificar si el resultado es complejo o real para graficar x(n)
if isreal(x)
    subplot(2, 2, 3:4);
    stem(nx, x);
    ylabel('x');
    xlabel('n');
    title(titulo);
    grid on;
else
    subplot(2, 2, 3);
    stem(nx, real(x));
    ylabel('x real');
    xlabel('n');
    title(titulo);
    grid on;

    subplot(2, 2, 4);
    stem(nx, imag(x));
    ylabel('x imag');
    xlabel('n');
    title(titulo);
    grid on;
end

