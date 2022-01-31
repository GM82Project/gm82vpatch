#define GMREAL __declspec(dllexport) double __cdecl
#include <windows.h>
#include "C:\DXSDK\include\d3d8.h"
#include "C:\DXSDK\include\d3dx8.h"

#pragma comment(lib, "d3d8.lib")
#pragma comment(lib, "d3dx8.lib")

IDirect3DDevice8* d3d8_device;
static D3DRASTER_STATUS raster_status;

ULONGLONG resolution = 1000000, frequency = 1;

static int has_started = 0;

GMREAL __gm82vpatch_checkstart() {
    if (has_started) return 1;
    has_started = 1;
    return 0;
}

GMREAL __gm82vpatch_finddevice(double culling_addr) {
    //find 8.1 device based on an offset jump from d3d_set_culling
    int pos = (int)culling_addr+27; // just after a call instruction
    pos = pos + *(int*)(pos-4); // go into the call instruction
    
    //thanks floogle for help figuring out the correct number of stars
    d3d8_device = **(IDirect3DDevice8***)(pos+2); // first instruction references the device
    return 0;
}

GMREAL __gm82vpatch_knowndevice(double device_addr) {
    //use device at known address
    int actual_addr = (int)device_addr;
    d3d8_device = *(IDirect3DDevice8**)actual_addr;
    return 0;
}

GMREAL __gm82vpatch_test8_1_version() {
    //detect which old version of 8.1 we're on by exe timestamp
    int timestamp = *(int*)0x400108;
    
    //modern (post 107)
    if (timestamp >= 0x4E11E4BA) return 0;
    
    //91
    if (timestamp == 0x4DD12C2E) {
        d3d8_device = *(IDirect3DDevice8**)0x64b8d8;
        return 1;
    }
    //71
    if (timestamp == 0x4DAEA1D5) {
        d3d8_device = *(IDirect3DDevice8**)0x647674;
        return 1;
    }
    //65
    if (timestamp == 0x4DA6D973) {
        d3d8_device = *(IDirect3DDevice8**)0x647674;
        return 1;
    }
    
    //not supported
    return -1;
}

GMREAL __gm82vpatch_init_dll() {
    QueryPerformanceFrequency((LARGE_INTEGER *)&frequency);
    return 0;    
}

GMREAL __gm82vpatch_time_now() {
    ULONGLONG now;
    if (QueryPerformanceCounter((LARGE_INTEGER*)&now)) {
        return (double)(now*resolution/frequency);
    } else {
        return 0.0;
    }
}

GMREAL __gm82vpatch_waitvblank() {    
    IDirect3DDevice8_GetRasterStatus(d3d8_device,&raster_status);
    if (raster_status.InVBlank) return 1;
    return 0;    
}

GMREAL __gm82vpatch_sleep(double ms) {
    SleepEx((DWORD)ms,TRUE);
    return 0;
}