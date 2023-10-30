clc; clearvars; close all;

% Menú para seleccionar el tipo de señal
prompt = 'Selecciona el tipo de señal (1: Impulso, 2: Escalón, 3: Rampa, 4: Senoidal, 5: Chirp, 6: Coseno, 7: Diente de Sierra): ';
signal_type = input(prompt);

switch signal_type
    case 1
        % Señal Impulso
        % Introducir parámetros señal Impulso
        dlgtitle = 'Impulse Signal Parameters';
        prompt = {'Amplitud:', 'Desplazamiento', 'n_inicio:', 'n_final:'};
        dims = [1 35];
        default_input = {'1', '2', '-5', '20'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);

        A = str2num(answer{1});
        n0 = str2num(answer{2});
        ni = str2num(answer{3});
        nf = str2num(answer{4});

        x1 = A * [zeros(1, abs(ni) + n0) 1 zeros(1, abs(nf) - n0)]; % Señal impulso
        n1 = ni:nf; % Instantes de tiempo
        subplot(2, 2, 1);
        stem(n1, x1);
        xlabel('n');
        ylabel('x(n)');
        title('Señal Impulso');
        grid on

    case 2
        % Señal Escalón
        % Introducir parámetros señal Escalón
        dlgtitle = 'Step Signal Parameters';
        prompt = {'Amplitud:', 'Desplazamiento', 'n_inicio:', 'n_final:'};
        dims = [1 35];
        default_input = {'1', '2', '-5', '20'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);

        A = str2num(answer{1});
        n0 = str2num(answer{2});
        ni = str2num(answer{3});
        nf = str2num(answer{4});

        x2 = A * [zeros(1, abs(ni) + n0) ones(1, abs(nf) + 1 - n0)];

        n2 = ni:nf; % Instantes de tiempo
        subplot(2, 2, 2);
        stem(n2, x2);
        xlabel('n');
        ylabel('x(n)');
        title('Señal Escalón');
        grid on

    case 3
        % Señal Rampa
        % Introducir parámetros señal Rampa
        dlgtitle = 'Ramp Signal Parameters';
        prompt = {'Pendiente:', 'Desplazamiento', 'n_inicio:', 'n_final:'};
        dims = [1 35];
        default_input = {'1', '2', '-5', '20'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);

        A = str2num(answer{1}); % Pendiente de la rampa
        n0 = str2num(answer{2});
        ni = str2num(answer{3});
        nf = str2num(answer{4});

        n3 = ni:nf; % Instantes de tiempo
        x3 = A * (n3 - n0);
        subplot(2, 2, 3);
        stem(n3, x3);
        xlabel('n');
        ylabel('x(n)');
        title('Señal Rampa');
        grid on

    case 4
        % Señal Senoidal
        % Introducir parámetros señal Senoidal
        dlgtitle = 'Sine Signal Parameters';
        prompt = {'Amplitud:', 'Frecuencia Análoga:', 'Frecuencia Muestreo:', 'Fase (rad)', 'Desplazamiento:', 'n_inicio:', 'n_final:'};
        dims = [1 35];
        default_input = {'1.5', '20', '400', '0.5', '2', '-5', '50'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);

        A = str2num(answer{1}); % Ganancia de la exponencial
        Fa = str2num(answer{2}); % Frecuencia análoga
        Fs = str2num(answer{3}); % Frecuencia de muestreo
        Fase = str2num(answer{4}); % Fase de la señal análoga (Rad)
        n0 = str2num(answer{5});
        ni = str2num(answer{6});
        nf = str2num(answer{7});
        Ts = 1 / Fs; % Periodo de muestreo
        n6 = ni:nf; % Instantes de tiempo
        x6 = A * sin(2 * pi * Fa * (n6 - n0) / Fs + Fase);
        subplot(2, 2, 4);
        stem(n6, x6);
        xlabel('n');
        ylabel('x(n)');
        title(['Señal Senoidal, Fa=' num2str(Fa) ' Fs= ' num2str(Fs)]);
        grid on

    case 5
        % Señal Chirp
        % Introducir parámetros señal Chirp
        dlgtitle = 'Chirp Signal Parameters';
        prompt = {'Amplitud:', 'Frecuencia Inicial:', 'Frecuencia Final:', 'Desplazamiento:', 'n_inicio:', 'n_final:', 'Frecuencia de Muestreo:'};
        dims = [1 35];
        default_input = {'1', '10', '50', '0', '0', '100', '400'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);
        A = str2num(answer{1}); % Amplitud
        Fi = str2num(answer{2}); % Frecuencia inicial
        Ff = str2num(answer{3}); % Frecuencia final
        n0 = str2num(answer{4});
        ni = str2num(answer{5});
        nf = str2num(answer{6});
        Fs = str2num(answer{7}); % Frecuencia de muestreo
        Ts = 1 / Fs; % Periodo de muestreo
        n7 = ni:nf; % Instantes de tiempo
        t7 = (0:(nf - ni)) * Ts;
        x7 = A * chirp(t7, Fi, (nf - ni) * Ts, Ff);
        figure;
        plot(t7, x7);
        xlabel('t');
        ylabel('x(t)');
        title('Señal Chirp');
        grid on

    case 6
        % Señal Coseno
        % Introducir parámetros señal Coseno
        dlgtitle = 'Cosine Signal Parameters';
        prompt = {'Amplitud:', 'Frecuencia:', 'Fase (rad)', 'Desplazamiento:', 'n_inicio:', 'n_final:', 'Frecuencia de Muestreo:'};
        dims = [1 35];
        default_input = {'1', '10', '0', '0', '0', '100', '400'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);
        A = str2num(answer{1}); % Amplitud
        Fc = str2num(answer{2}); % Frecuencia
        Fase = str2num(answer{3}); % Fase de la señal (Rad)
        n0 = str2num(answer{4});
        ni = str2num(answer{5});
        nf = str2num(answer{6});
        Fs = str2num(answer{7}); % Frecuencia de muestreo
        Ts = 1 / Fs; % Periodo de muestreo
        n8 = ni:nf; % Instantes de tiempo
        t8 = (0:(nf - ni)) * Ts;
        x8 = A * cos(2 * pi * Fc * t8 + Fase);
        figure;
        plot(t8, x8);
        xlabel('t');
        ylabel('x(t)');
        title('Señal Coseno');
        grid on

    case 7
        % Señal Diente de Sierra
        % Introducir parámetros señal Diente de Sierra
        dlgtitle = 'Sawtooth Signal Parameters';
        prompt = {'Amplitud:', 'Periodo:', 'Desplazamiento:', 'n_inicio:', 'n_final:', 'Frecuencia de Muestreo:'};
        dims = [1 35];
        default_input = {'1', '20', '0', '0', '100', '400'};
        answer = inputdlg(prompt, dlgtitle, dims, default_input);
        A = str2num(answer{1}); % Amplitud
        T = str2num(answer{2}); % Periodo
        n0 = str2num(answer{3});
        ni = str2num(answer{4});
        nf = str2num(answer{5});
        Fs = str2num(answer{6}); % Frecuencia de muestreo
        Ts = 1 / Fs; % Periodo de muestreo
        n9 = ni:nf; % Instantes de tiempo
        t9 = (0:(nf - ni)) * Ts;
        x9 = A * sawtooth(2 * pi * T * t9);
        figure;
        plot(t9, x9);
        xlabel('t');
        ylabel('x(t)');
        title('Señal Diente de Sierra');
        grid on

    otherwise
        disp('Opción no válida.');
end

