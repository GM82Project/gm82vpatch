; dll by floogle
; github.com/skyfloogle

; ml /coff sleep.asm /link /dll /nocoffgrpinfo /entry:dllmain /def:sleep.def /out:sleep.dll

.386
.model flat

Sleep PROTO STDCALL :DWORD
includelib kernel32.lib

.code

dllmain proc stdcall instance:dword,reason:dword,unused:dword
	mov eax,1
	ret
dllmain endp

__gm82vpatch_sleep proc c time:real8
LOCAL itime:dword
	fld time
	fistp itime
	invoke Sleep,[itime]
	fldz
	ret
__gm82vpatch_sleep endp

end
