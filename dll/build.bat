call "%VS120COMNTOOLS%vsvars32.bat"

ml /coff sleep.asm /link /dll /nocoffgrpinfo /entry:dllmain /def:sleep.def /out:sleep.dll

pause