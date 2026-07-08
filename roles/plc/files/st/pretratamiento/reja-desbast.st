PROGRAM PLC_Reja_Desbaste
VAR
    (* Entradas *)
    I_Nivel_Aguas_Arriba : REAL;      (* Nivel antes de la reja [m] *)
    I_Nivel_Aguas_Abajo  : REAL;      (* Nivel después de la reja [m] *)
    I_Reja_Manual        : BOOL;      (* Mando manual de la reja *)
    
    (* Salidas *)
    Q_Motor_Reja         : BOOL;      (* Marcha motor de la reja *)
    
    (* Variables Internas / Temporizadores *)
    X_Dif_Nivel          : REAL;      (* Diferencial de nivel calculado *)
    TON_Reja             : TON;       (* Temporizador tiempo de funcionamiento *)
    TON_Ciclo_Reja       : TON;       (* Temporizador intervalo entre limpiezas *)
    
    (* Constantes de Configuración *)
    CONST_MAX_DIF_NIVEL  : REAL := 0.25; (* Umbral de atasco [m] *)
    CONST_TIEMPO_REJA    : TIME := T#2M;  (* Duración de la limpieza *)
    CONST_INTERVALO_REJA : TIME := T#4H;  (* Intervalo máximo automático *)
END_VAR

// Cálculo de pérdida de carga (colmatación de la reja)
X_Dif_Nivel := I_Nivel_Aguas_Arriba - I_Nivel_Aguas_Abajo;

// Temporizador para arranque periódico preventivo
TON_Ciclo_Reja(IN := NOT Q_Motor_Reja, PT := CONST_INTERVALO_REJA);

// Condición de arranque: por nivel, por tiempo acumulado o por mando manual
IF (X_Dif_Nivel >= CONST_MAX_DIF_NIVEL) OR TON_Ciclo_Reja.Q OR I_Reja_Manual THEN
    Q_Motor_Reja := TRUE;
END_IF;

// Temporizador de control de marcha
TON_Reja(IN := Q_Motor_Reja, PT := CONST_TIEMPO_REJA);

// Condición de parada
IF TON_Reja.Q AND NOT I_Reja_Manual AND (X_Dif_Nivel < (CONST_MAX_DIF_NIVEL - 0.05)) THEN
    Q_Motor_Reja := FALSE;
END_IF;

END_PROGRAM