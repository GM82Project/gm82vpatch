call "%VS120COMNTOOLS%vsvars32.bat"

cl gm82vpatch.c /O2 /GS- /nologo /link /nologo /dll /out:..\gm82vpatch.dll
del ..\gm82vpatch.exp
del ..\gm82vpatch.lib
del gm82vpatch.obj

pause