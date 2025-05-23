if hit == false and (place_meeting(x+1,y,obj_ball_real) or place_meeting(x-1,y,obj_ball_real) or place_meeting(x,y+1,obj_ball_real) or place_meeting(x,y-1,obj_ball_real)) {
	hit = true
	sprite_index = spr_pach_peg_hit
	obj_ball_real.points += 1
}

if place_meeting(x,y-1,obj_ball_real) or place_meeting(x-1,y,obj_ball_real) or place_meeting(x+1,y,obj_ball_real) {
	timer--
	if timer == 0 {
		instance_destroy(self)
		obj_ball_real.points += 30
	}
}