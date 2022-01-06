; dll by floogle
; github.com/skyfloogle

; ml /coff sleep.asm /link /dll /nocoffgrpinfo /entry:dllmain /def:sleep.def /out:sleep.dll

.386
.model flat

Sleep PROTO STDCALL :DWORD
QueryPerformanceFrequency PROTO STDCALL :DWORD
QueryPerformanceCounter PROTO STDCALL :DWORD
includelib kernel32.lib

.data?
freq qword ?

.code

dllmain proc stdcall instance:dword,reason:dword,unused:dword
	invoke QueryPerformanceFrequency,addr freq
	mov eax,1
	ret
dllmain endp

__floogle_sleep proc c time:real8
LOCAL itime:dword
	fld time
	fistp itime
	invoke Sleep,[itime]
	fldz
	ret
__floogle_sleep endp

__floogle_timer proc c
LOCAL time:qword
	invoke QueryPerformanceCounter,addr time
	test eax,eax
	jz err
	fild time
	fild freq
	fdivp
	ret
err:
	; return -1
	fldz
	fld1
	fsubp
	ret
__floogle_timer endp

end
