if readyflag == false {
	
	//Main Logic
	
	switch global.state {
		
		case "dice_roll":
			
			//cycle through sprites while about to roll [UNUSED]
			timer++
			if timer == idle_timer {
				diceroll = irandom_range(0,array_length(global.die_sprites)-1)
				timer = 0
			}
		
			//roll the dice
			if keyboard_check_pressed(global.key_select) {
				diceroll = irandom_range(roll_min,roll_max)
				readyflag = true
			}
			
			//return to previous menu
			if keyboard_check_pressed(global.key_back) {
				diceroll = -1
				readyflag = true
			}
		break;
		
	}
	
	/////////////////////////////////////////////////////
	
}