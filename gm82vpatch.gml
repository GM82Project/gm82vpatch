#define __gm82vpatch_init
    if (variable_global_get("__gm82core_version")>134) {
        //recent enough core extension: let's work together
        object_event_add(core,ev_other,ev_animation_end,"
            if (fps_real>1000) {screen_wait_vsync() __floogle_sleep(2)}
            else if (fps_real>500) {screen_wait_vsync() __floogle_sleep(1)}
        ")
    } else {
        //core extension not detected: let's do it ourselves
        object_event_add(__renex_object,ev_destroy,0,"instance_copy(0)")
        object_event_add(__renex_object,ev_other,ev_room_end,"persistent=true")
        object_event_add(__renex_object,ev_other,ev_animation_end,"screen_wait_vsync() __floogle_sleep(2)")
        object_set_persistent(__renex_object,1)
        room_instance_add(room_first,0,0,__renex_object)
    }


