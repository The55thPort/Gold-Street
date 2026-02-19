/// @description Insert description here
// You can write your code in this editor

		
if readyflag == false {
	switch global.state {
		case "dice_roll":
			draw_sprite(dice_rolls[irandom_range(roll_min, roll_max)-1], 1, 120, 55)
			//I'm seeing the 8 dice in the roll, I don't know why
			break;
		case "venture_roll":
			draw_sprite(dice_rolls[irandom_range(1, 6)], 1, 120, 55)
			//I'm seeing the 8 dice in the roll, I don't know why
			break;
		case "player_move":
			if(global.player.spaces_to_move >=1){draw_sprite(dice_rolls[global.player.spaces_to_move-1], 1, 120, 55)}
	}
}