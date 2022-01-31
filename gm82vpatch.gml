#define __gm82vpatch_init
    globalvar __gm82vpatch_time;__gm82dx8_time=__gm82vpatch_time_now()
    
    //don't initialize more than once!
    //this fixes games that use game_restart()
    if (__gm82vpatch_checkstart()) exit
    
    //create a daemon to run the vpatch code
    object_event_add(__vpatch_object,ev_destroy,0,"instance_copy(0)")
    object_event_add(__vpatch_object,ev_other,ev_room_end,"persistent=true")
    object_event_add(__vpatch_object,ev_other,ev_animation_end,"__gm82vpatch_dovsync()")
    
    //switch depending on gm version
    if (gamemaker_version==800) {
        __gm82vpatch_knowndevice($58d388)        
    } else {
        var __version;__version=__gm82vpatch_test8_1_version()

        if (__version==-1) {
            show_error(
                "This old version of GM 8.1 is not currently supported by VPatch; Please let renex#4506 on discord know about this."
                +chr($0d)+chr($0a)+chr($0d)+chr($0a)+"In the meantime, you can patch a fresh copy of the game without VPatch enabled.",
                1
            )
            game_end()
            exit
        }
        
        if (__version==0) {
            //modern 8.1
            execute_string("__gm82vpatch_finddevice(get_function_address('d3d_set_culling'))")
        }
    }
    
    object_set_persistent(__vpatch_object,1)
    room_instance_add(room_first,0,0,__vpatch_object)


#define __gm82vpatch_dovsync
    //only activate if vsyncable
    if (display_get_frequency() mod room_speed == 0) {
        set_synchronization(false)
        //we do timed wakeups every 1ms to check the time
        while (!__gm82vpatch_waitvblank()) {
             __gm82vpatch_sleep(1)
             if (__gm82vpatch_time_now()-__gm82vpatch_time>1000000/room_speed-2000) {
                //Oh my fur and whiskers! I'm late, I'm late, I'm late!
                break
            }
        }

        //busywait for vblank
        while (!__gm82vpatch_waitvblank()) {/*òwó*/}
        __gm82vpatch_time=__gm82vpatch_time_now()

        //sync DWM
        __gm82vpatch_sleep(2)

        //epic win
    }


