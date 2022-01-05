#define renex_start
    object_event_add(__renex_object,ev_destroy,0,"instance_copy(0)")
    object_event_add(__renex_object,ev_other,ev_room_end,"persistent=true")
    object_event_add(__renex_object,ev_other,ev_animation_end,"screen_wait_vsync() __gm82vpatch_sleep(2)")
    
    object_set_persistent(__renex_object,1)
    room_instance_add(room_first,0,0,__renex_object)



