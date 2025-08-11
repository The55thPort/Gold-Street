//Main Camera Logic

if room == rm_game {
	
	if keyboard_check(global.key_shift) {
		scroll_speed = 1
	}
	else scroll_speed = 2

	switch global.state {
	
		case "board_select":
			//allow player control over camera to select a space
			
			sprite_index = spr_camera
	
			if keyboard_check(global.key_up) {
				y -= scroll_speed
				if y < top {y += scroll_speed}
			}
	
			if keyboard_check(global.key_left) {
				x -= scroll_speed
				if x < left {x += scroll_speed}
			}
	
			if keyboard_check(global.key_down) {
				y += scroll_speed
				if y > bottom - 16 {y -= scroll_speed}
			}
	
			if keyboard_check(global.key_right) {
				x += scroll_speed
				if x > right - 16 {x -= scroll_speed}
			}
		
			if keyboard_check_pressed(global.key_select) {
				var space = instance_position(x+8,y+8,obj_space)
				if space != noone {
					if space.properties.type == selecting {
				
						if space.properties.type == "shop" {
							if space.properties.owner == selecting_sub {
								selected = space
								sprite_index = noone
								readyflag = true
							}
						}
				
					}
				}
			}
	
			if keyboard_check_pressed(global.key_back) {
				selected = noone
				sprite_index = noone
				readyflag = true
			}
		break;
	
		case "board_view":
			//allow player control over camera
	
			if keyboard_check(global.key_up) {
				y -= scroll_speed
				if y < top {y += scroll_speed}
			}
	
			if keyboard_check(global.key_left) {
				x -= scroll_speed
				if x < left {x += scroll_speed}
			}
	
			if keyboard_check(global.key_down) {
				y += scroll_speed
				if y > bottom - 16 {y -= scroll_speed}
			}
	
			if keyboard_check(global.key_right) {
				x += scroll_speed
				if x > right - 16 {x -= scroll_speed}
			}
	
		break;
	
		case "shop_invest_1":
			//focus on selected shop
			x = selected.x+8
			y = selected.y+8
		break;
	
		case "shop_invest_2":
			//focus on selected shop
			x = selected.x+8
			y = selected.y+8
		break;
	
		default:
			//follow the current player by default
			x = global.player.x
			y = global.player.y
		break;
	

	
	}


	
	//parallax all backgrounds when moving
	with (obj_background) {
		x = round(lerp(obj_camera.left-128,obj_camera.right+112-sprite_width,(obj_camera.x-obj_camera.left)/(obj_camera.right-obj_camera.left-16)))
		y = round(lerp(obj_camera.top-112,obj_camera.bottom+96-sprite_height,(obj_camera.y-obj_camera.top)/(obj_camera.bottom-obj_camera.top-16)))
	}

}

/////////////////////////////////////////////////////
//Pachinko Camera Logic

if room = rm_pachinko {
	
	if !instance_exists(obj_ball_real) {
		//when undropped, focus on the ball
		x = obj_ball_fake.x
		y = obj_ball_fake.y
	}
	else {
		//when dropped, focus a bit ahead of the ball
		x = obj_ball_real.x
		y = obj_ball_real.y + 32
	}
	
}

/////////////////////////////////////////////////////