PROGRAM PLC_Purga_Fangos
VAR
    (* Entradas *)
    I_Purga_Manual       : BOOL;      (* Apertura manual de la válvula *)
    
    (* Salidas *)
    Q_Valvula_Fangos     : BOOL;      (* Salida física: Abrir/Cerrar válvula de fangos *)
    
    (* Variables Internas / Temporizadores *)
    TON_Espera_Purga     : TON;       (* Temporizador: Tiempo entre purgas *)
    TON_Duracion_Purga   : TON;       (* Temporizador: Duración de la purga *)
    X_Purga_En_Progreso  : BOOL;      (* Estado interno del ciclo *)
    
    (* Constantes de Configuración *)
    CONST_TIEMPO_ESPERA  : TIME := T#8H;  (* Intervalo de purga (Cada 8 horas) *)
    CONST_TIEMPO_PURGA   : TIME := T#1M;  (* Duración de la purga (1 minuto) *)
END_VAR

// Control del tiempo de espera entre ciclos de purga
TON_Espera_Purga(IN := NOT X_Purga_En_Progreso, PT := CONST_TIEMPO_ESPERA);

IF TON_Espera_Purga.Q THEN
    X_Purga_En_Progreso := TRUE;
END_IF;

// Control de la duración de la apertura de la válvula
TON_Duracion_Purga(IN := X_Purga_En_Progreso, PT := CONST_TIEMPO_PURGA);

IF TON_Duracion_Purga.Q THEN
    X_Purga_En_Progreso := FALSE;
END_IF;

// Activación de la salida física (Automático o por mando manual)
Q_Valvula_Fangos := X_Purga_En_Progreso OR I_Purga_Manual;

END_PROGRAM