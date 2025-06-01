//Main Effect Logic

switch state {
	
	case "arrow":
		//act as a directional arrow on the ground
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

/////////////////////////////////////////////////////