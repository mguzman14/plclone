PROGRAM deposito
  VAR
    (* Vinculamos el nivel al primer registro Modbus que envía Node-RED *)
    Nivel_Tanque AT %IW0 : UINT;
    (* Vinculamos una salida virtual para la bomba *)
    Bomba_Entrada AT %QX0.0 : BOOL;
  END_VAR

  IF Nivel_Tanque < 20 THEN
    Bomba_Entrada := TRUE;
  ELSIF Nivel_Tanque > 80 THEN
    Bomba_Entrada := FALSE;
  END_IF;
END_PROGRAM

CONFIGURATION Config0
  RESOURCE Res0 ON PLC
    TASK TaskMain(INTERVAL := T#50ms, PRIORITY := 0);
    PROGRAM Inst0 WITH TaskMain : deposito;
  END_RESOURCE
END_CONFIGURATION