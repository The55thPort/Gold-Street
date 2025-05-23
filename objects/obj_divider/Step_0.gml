if place_meeting(x,y-1,obj_ball_real) {
	timer--
	if timer == 0 {
		obj_ball_real.points += 1000
	}
}

if !place_meeting(x,y-1,obj_ball_real) {
	timer = 300
}