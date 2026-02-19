/// @description Insert description here
// You can write your code in this editor

readyflag = false

diceroll = get_venture_property(obj_game.venture_number, "dice_roll")
dice_rolls = [spr_die_1, spr_die_2, spr_die_3, spr_die_4, spr_die_5, spr_die_6, spr_die_7, spr_die_8, spr_die_9]

turns_left = array_length(obj_game.players)

roll_min = 1
roll_max = 6 // this is just here for the draw sprite