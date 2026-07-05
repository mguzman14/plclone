PROGRAM programa_bombeo
  VAR
    potencia_bomba AT %QW0 : INT;
  END_VAR

  
END_PROGRAM

CONFIGURATION Config0
  RESOURCE Res0 ON PLC
    TASK TaskMain(INTERVAL := T#50ms, PRIORITY := 0);
    PROGRAM Instancia0 WITH TaskMain : programa_bombeo;
  END_RESOURCE
END_CONFIGURATION