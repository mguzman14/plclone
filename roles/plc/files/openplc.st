PROGRAM Blank_Prog
  VAR
    DummyVar : BOOL;
  END_VAR

  DummyVar := NOT DummyVar;
END_PROGRAM

CONFIGURATION Config0
  RESOURCE Res0 ON PLC
    TASK TaskMain(INTERVAL := T#20ms, PRIORITY := 0);
    PROGRAM Inst0 WITH TaskMain : Blank_Prog;
  END_RESOURCE
END_CONFIGURATION