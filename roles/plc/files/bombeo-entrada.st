PROGRAM bombeo_entrada
  VAR
    sensor_raw AT %MW100 : INT;
  END_VAR

  sensor_raw := sensor_raw;
END_PROGRAM

CONFIGURATION Config0
  RESOURCE Res0 ON PLC
    TASK TaskMain(INTERVAL := T#50ms, PRIORITY := 0);
    PROGRAM Inst0 WITH TaskMain : bombeo_entrada;
  END_RESOURCE
END_CONFIGURATION