if place_meeting(x,y,obj_ball_real) {
	timer--
}

if timer <= 0 {
	obj_persistent.arcade_winner = obj_persistent.players[player]
	obj_persistent.arcade_payout = obj_ball_real.points
	obj_persistent.readyflag = true
}
