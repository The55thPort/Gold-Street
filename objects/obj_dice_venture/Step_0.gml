/// @description Insert description here
// You can write your code in this editor
if readyflag == false {
	
	//Main Logic
	
	switch global.state {
		
		case "dice_roll":
		
			//roll the dice
			if keyboard_check_pressed(global.key_select) {
				readyflag = true
				turns_left--;
				log("it's venture time")
				if(turns_left = 0){
					instance_destroy(id)
					instance_create_depth(x,y, 200, obj_dice)
				}
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