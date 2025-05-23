switch state {
	
	case "arrow":
		timer_ref = 60
		timer++
		
		if timer == timer_ref {
			timer = 0
			blinking = !blinking
		}
		
		if global.state != "player_action" and global.state != "player_move" {
			instance_destroy()
		}
		
		if global.state == "player_move" {
			if global.player.moving == true {
				obj_effects_master.arrows_drawn = false
				instance_destroy()
			}
		}
	break;
	
}