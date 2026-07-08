PROGRAM PLC_VFD_Mezcla
VAR
    (* Entradas *)
    I_Caudal_Entrada     : REAL;      (* Caudal de entrada a la ETAP [m³/h] *)
    I_VFD_Mezcla_Manual  : BOOL;      (* Modo manual para el variador *)
    I_Ref_Manual_VFD     : REAL;      (* Consigna manual de velocidad [Hz] *)
    
    (* Salidas *)
    Q_VFD_Mezcla_Vel     : REAL;      (* Consigna de velocidad al VFD [Hz] *)
    Q_VFD_Mezcla_Run     : BOOL;      (* Orden de marcha al variador *)
    
    (* Constantes de Configuración *)
    CONST_CAUDAL_MAX     : REAL := 500.0; (* Caudal máximo de diseño [m³/h] *)
    CONST_FREQ_MAX       : REAL := 50.0;  (* Frecuencia máxima del motor [Hz] *)
    CONST_FREQ_MIN       : REAL := 20.0;  (* Frecuencia mínima del motor [Hz] *)
END_VAR

// Control de marcha si hay caudal mínimo en la planta
IF I_Caudal_Entrada > 5.0 THEN
    Q_VFD_Mezcla_Run := TRUE;
    
    IF I_VFD_Mezcla_Manual THEN
        Q_VFD_Mezcla_Vel := I_Ref_Manual_VFD;
    ELSE
        // Regulación proporcional de velocidad según el caudal de entrada
        Q_VFD_Mezcla_Vel := (I_Caudal_Entrada / CONST_CAUDAL_MAX) * CONST_FREQ_MAX;
        
        // Límites de seguridad para el variador
        IF Q_VFD_Mezcla_Vel > CONST_FREQ_MAX THEN
            Q_VFD_Mezcla_Vel := CONST_FREQ_MAX;
        ELSIF Q_VFD_Mezcla_Vel < CONST_FREQ_MIN THEN
            Q_VFD_Mezcla_Vel := CONST_FREQ_MIN;
        END_IF;
    END_IF;
ELSE
    // Parada total por falta de flujo
    Q_VFD_Mezcla_Run := FALSE;
    Q_VFD_Mezcla_Vel := 0.0;
END_IF;

END_PROGRAM