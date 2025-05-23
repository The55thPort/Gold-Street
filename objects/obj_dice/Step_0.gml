if readyflag == false {
	
	switch global.state {
		
		case "dice_roll":
		
			timer++
			if timer == idle_timer {
				diceroll = irandom_range(0,array_length(global.die_sprites)-1)
				timer = 0
			}
		
			if keyboard_check_pressed(global.key_select) {
				diceroll = irandom_range(roll_min,roll_max)
				readyflag = true
			}
		
			if keyboard_check_pressed(global.key_back) {
				diceroll = -1
				readyflag = true
			}
		break;
		}
	
}