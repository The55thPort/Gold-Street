/// @description All the venture cards

venture_actions = [];

if (!variable_instance_exists(id, "venture_state")) {
	venture_state = 0;
}

venture_actions[1] = {
	comment: "1: Choose your direction!",
	run: function() {
		global.player.previous_position = -1;
	}
};

venture_actions[2] = {
	comment: "2: Roll on!",
	run: function() {
		global.state = "dice_roll";
		global.substate = 0
	}
};

venture_actions[3] = {
	comment: "12: Capital Venture! You may invest in a shop",
	run: function() {
		global.state = "shop_self";
		global.substate = 0
		obj_menu.readyflag = false
	}
};

venture_actions[4] = {
	comment: "14: Give everyone 30 gold!",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				give_gold(global.player, 30, obj_game.players[pointer])
			}
			pointer++;
		}
	}
};

venture_actions[5] = {
	comment: "27: 27x the shops you own in gold coins!",
	run: function() {
		global.player.readycash += 27 * array_length(global.player.shops);
	}
};

venture_actions[6] = {
	comment: "29: Take a heart!",
	error_message: "You already have a heart, so you get 100g instead",
	run: function() {
		if global.player.suits[1] <= 0 {
			global.player.suits[1] = 1;
		} else {
			global.player.readycash += 100;
			global.state = "venture_error"
		}
	}
};

venture_actions[7] = {
	comment: "46: Lose 10% of readycash!",
	run: function() {
		global.player.readycash = floor(global.player.readycash * 0.9);
	}
};

venture_actions[8] = {
	comment: "50: Move the same number of spaces again!",
	run: function() {
		global.player.spaces_to_move = obj_dice.diceroll;
		global.state = "player_move";
	}
};

venture_actions[9] = {
	comment: "51: Move forward one more square!",
	run: function() {
		global.player.spaces_to_move = 1;
		global.state = "player_move";
	}
};

venture_actions[10] = {
	comment: "52: Move forward two more squares!",
	run: function() {
		global.player.spaces_to_move = 2;
		global.state = "player_move";
	}
};

venture_actions[11] = {
	comment: "70: Sudden promotion!",
	run: function() {
		global.player.suits = [ 0,0,0,0 ];
		global.player.readycash += global.salary_base + (global.salary_increment * global.player.level);
		global.player.level++;
	}
};

venture_actions[12] = {
	comment: "80: Take a spade!",
	error_message: "You already have a spade, so you get 100g instead",
	run: function() {
		if global.player.suits[0] <= 0 {
			global.player.suits[0] = 1;
		} else {
			global.player.readycash += 100;
			global.state = "venture_error"
		}
	}
};

venture_actions[13] = {
	comment: "82: Take a club!",
	error_message: "You already have a club, so you get 100g instead",
	run: function() {
		if global.player.suits[3] <= 0 {
			global.player.suits[3] = 1;
		} else {
			global.player.readycash += 100;
			global.state = "venture_error"
		}
	}
};

venture_actions[14] = {
	comment: "86: Take 100 gold from everyone else!",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				give_gold(obj_game.players[pointer], 100, global.player)
			}
			pointer++;
		}
	}
};

venture_actions[15] = {
	comment: "94: Take a diamond!",
	error_message: "You already have a diamond, so you get 100g instead",
	run: function() {
		if global.player.suits[2] <= 0 {
			global.player.suits[2] = 1;
		} else {
			global.player.readycash += 100;
			global.state = "venture_error"
		}
	}
};

venture_actions[16] = {
	comment: "99: Get all the suits!",
	run: function() {
		global.player.suits = [1,1,1,1];
	}
};

venture_actions[17] = {
	comment: "17: Get half of your salary!",
	run: function() {
		global.player.readycash += floor(global.salary_base + (global.salary_increment * global.player.level)/2);
	}
};

venture_actions[18] = {
	comment: "104: Give everyone 80g each!",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				give_gold(global.player, 80, obj_game.players[pointer])
			}
			pointer++;
		}
	}
};

venture_actions[19] = {
	comment: "110: 77x the shops you own in gold coins!",
	run: function() {
		global.player.readycash += 77 * array_length(global.player.shops);
	}
};

venture_actions[20] = {
	comment: "112: 100x the shops you own in gold coins!",
	run: function() {
		global.player.readycash += 100 * array_length(global.player.shops);
	}
};

venture_actions[21] = {
	comment: "114: Your level * 40g from all other players!",
	run: function() {
		var pointer = 0;
		global.player.readycash += 40 * (array_length(obj_game.players) - 1) * global.player.level;
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				give_gold(obj_game.players[pointer], 40* global.player.level, global.player)
			}
			pointer++;
		}
	}
};

venture_actions[22] = {
	comment: "120: Lose 20% of readycash!",
	run: function() {
		global.player.readycash = floor(global.player.readycash * 0.8);
	}
};

venture_actions[23] = {
	comment: "128: 55x the shops you own in gold coins!",
	run: function() {
		global.player.readycash += 55 * array_length(global.player.shops);
	}
};

venture_actions[24] = {
	comment: "132: Placebo venture This does nothing", //beyond 128 the numbers are made up
	run: function() {
	}
};

venture_actions[25] = {
	comment: "136: Lose 100g",
	run: function() {
		global.player.readycash -= 100;
	}
};

venture_actions[26] = {
	comment: "147: Everyone gets 50g",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			obj_game.players[pointer].readycash += 50;
			pointer++;
		}
	}
};

venture_actions[27] = {
	comment: "151: Recieve 500g",
	run: function() {
		global.player.readycash += 500;
	}
};

venture_actions[28] = {
	comment: "158: Everyone gets 777g",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			obj_game.players[pointer].readycash += 777;
			pointer++;
		}
	}
};

venture_actions[29] = {
	comment: "158: Lose 10% of your net worth",
	run: function() {
		global.player.readycash -= floor(global.player.net_worth * 0.1);
	}
};

venture_actions[30] = {
	comment: "165: Lose 150g",
	run: function() {
		global.player.readycash -= 100;
	}
};

venture_actions[31] = {
	comment: "174: Recieve 50g",
	run: function() {
		global.player.readycash += 50;
	}
};

venture_actions[32] = {
	comment: "77: Take 5 of each district's stocks",
	run: function() {
		for(var i = 0; i < global.used_districts; i++){
			global.player.stocks[i] += 5
		}
	}
};

venture_actions[33] = {
	comment: "117: Everyone can choose their direction next turn",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			obj_game.players[pointer].previous_position = -1;
			pointer++;
		}
	}
};

venture_actions[34] = {
	comment: "21: Take 20 stocks in a random district",
	run: function() {
		global.player.stocks[irandom_range(1,global.used_districts)] += 20
	}
};

venture_actions[35] = {
	comment: "43: Pay 2 gold per stock you own",
	run: function() {
		for(var i = 0; i < global.used_districts; i++){
			global.player.readycash -= (global.player.stocks[i]*2)
		}
	}
};

venture_actions[36] = {
	comment: "131: Take 10 stocks in a random district",
	run: function() {
		global.player.stocks[irandom_range(1,global.used_districts)] += 10
	}
};

venture_actions[37] = {
	comment: "41: Stocks fall by 10% in a random district",
	run: function() {
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=0.9
	}
};

venture_actions[38] = {
	comment: "42: Stocks fall by 20% in a random district",
	run: function() {
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=0.8
	}
};

venture_actions[39] = {
	comment: "61: Recieve a 10% dividend on stocks",
	run: function() {
		var stock_sum = 0;
		for(var i = 0; i < global.used_districts; i++){
			stock_sum += global.player.stocks[i]*global.stock_prices[i]
		}
		global.player.readycash += floor(stock_sum*0.1)
	}
};

venture_actions[40] = {
	comment: "62: Recieve a 20% dividend on stocks",
	run: function() {
		var stock_sum = 0;
		for(var i = 0; i < global.used_districts; i++){
			stock_sum += global.player.stocks[i]*global.stock_prices[i]
		}
		global.player.readycash += floor(stock_sum*0.2)
	}
};

venture_actions[41] = {
	comment: "57: Warp to any square of your choosing!",
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_select";
				global.venture_state++;
				break;
			case 1:
				warp_player(global.player, obj_camera.selected.properties.space, obj_camera.selected.x+8, obj_camera.selected.y+8)
				global.venture_state = 0;
				global.substate = 0
				global.state = "space_execute"
				break;
		}
	}
};

venture_actions[42] = {
	comment: "3: Warp to any non-venture, non-suit square",
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_select";
				global.venture_state++;
				break;
			case 1:
				if((obj_camera.selected.properties.type != "suit" && obj_camera.selected.properties.type != "venture"
				&& obj_camera.selected.properties.type != "suit-change")){
					warp_player(global.player, obj_camera.selected.properties.space, obj_camera.selected.x+8, obj_camera.selected.y+8)
					global.venture_state = 0;
					global.substate = 0
					global.state = "space_execute"
				}
				break;
		}
	}
};

venture_actions[43] = {
	comment: "5: Warp to any shop",
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_select";
				global.venture_state++;
				break;
			case 1:
				if(obj_camera.selected.properties.type == "shop"){
					warp_player(global.player, obj_camera.selected.properties.space, obj_camera.selected.x+8, obj_camera.selected.y+8)
					global.venture_state = 0;
					global.substate = 0
					global.state = "space_execute"
				}
				break;
		}
	}
};

venture_actions[44] = {
	comment: "6: Warp to any venture or suit square",
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_select";
				global.venture_state++;
				break;
			case 1:
				if(obj_camera.selected.properties.type == "venture" || obj_camera.selected.properties.type == "suit" 
				|| obj_camera.selected.properties.type == "suit-change"){
					warp_player(global.player, obj_camera.selected.properties.space, obj_camera.selected.x+8, obj_camera.selected.y+8)
					global.venture_state = 0;
					global.substate = 0
					global.state = "space_execute"
				}
				break;
		}
	}
};

venture_actions[45] = {
	comment: "53: Warp to the bank",
	run: function() {
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "bank"){
				warp_player(global.player, global.board[i].properties.space, global.board[i].x+8,global.board[i].y+8)
				global.state = "space_execute"
				global.substate = 0

			}
		}
	}
};

venture_actions[46] = {
	comment: "95: All other players warp to you",
	run: function() {
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			warp_player(obj_game.players[pointer], global.player.current_position, global.player.x ,global.player.y)
			obj_game.players[pointer].previous_position = -1;
			pointer++;
		}
	}
};

venture_actions[47] = {
	comment: "96: Everyone warps to a random player",
	run: function() {
		var player_warp = irandom_range(0,array_length(obj_game.players)-1)
		var pointer = 0;
		repeat (array_length(obj_game.players)) {
			warp_player(obj_game.players[pointer], obj_game.players[player_warp].current_position, obj_game.players[player_warp].x, obj_game.players[player_warp].y)
			obj_game.players[pointer].previous_position = -1;
			pointer++;
		}
	}
};

venture_actions[48] = {
	comment: "152: Every district's stock prices increases by 10%",
	run: function() {
		for(var i = 0; i < global.used_districts; i++){
			obj_board.district_multipliers[i] *= 1.1
		}
	}
};

venture_actions[49] = {
	comment: "156: Every district's stock prices increases by 15%",
	run: function() {
		for(var i = 0; i < global.used_districts; i++){
			obj_board.district_multipliers[i] *= 1.15
		}
	}
};

venture_actions[50] = {
	comment: "152: Every district's stock prices increases by 5%",
	run: function() {
		for(var i = 0; i < global.used_districts; i++){
			obj_board.district_multipliers[i] *= 1.05
		}
	}
};

venture_actions[51] = {
	comment: "15: Roll the dice and get 50 times your roll in gold",
	error_message: "You got a " +string(obj_dice.diceroll) + ", so you get " + string(50 * obj_dice.diceroll) + " gold", 
	//this doesn't show the proper diceroll for some reason
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_roll";
				global.venture_state++;
				break;
			case 1:
				global.player.readycash += 50 * obj_dice.diceroll
				global.venture_state = 0;
				global.substate = 0
				global.state = "venture_error"
				break;
		}
	}
};

venture_actions[52] = {
	comment: "63: Stocks increase by 20% in a random district",
	run: function() {
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=1.2
	}
};

venture_actions[53] = {
	comment: "64: Stocks increase by 30% in a random district",
	run: function() {
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=1.3
	}
};

venture_actions[54] = {
	comment: "85: Roll the dice and get 85 times your roll in gold",
	error_message: "You got a " +string(obj_dice.diceroll) + ", so you get " + string(85 * obj_dice.diceroll) + " gold", 
	//this doesn't show the proper diceroll for some reason
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_roll";
				global.venture_state++;
				break;
			case 1:
				global.player.readycash += 85 * obj_dice.diceroll
				global.venture_state = 0;
				global.substate = 0
				global.state = "venture_error"
				break;
		}
	}
};

venture_actions[55] = {
	comment: "113: Roll the dice and get 20 times your level times your roll in gold",
	error_message: "You got a " +string(obj_dice.diceroll) + ", so you get " + string(20 * obj_dice.diceroll* global.player.level) + " gold", 
	//this doesn't show the proper diceroll for some reason
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_roll";
				global.venture_state++;
				break;
			case 1:
				global.player.readycash += 20 * obj_dice.diceroll * global.player.level
				global.venture_state = 0;
				global.substate = 0
				global.state = "venture_error"
				break;
		}
	}
};

venture_actions[56] = {
	comment: "105: Roll the dice and get 40 times your level times your roll in gold",
	error_message: "You got a " +string(obj_dice.diceroll) + ", so you get " + string(40 * obj_dice.diceroll* global.player.level) + " gold", 
	//this doesn't show the proper diceroll for some reason
	run: function() {
		switch(global.venture_state){
			case 0:
				global.state = "venture_roll";
				global.venture_state++;
				break;
			case 1:
				global.player.readycash += 40 * obj_dice.diceroll * global.player.level
				global.venture_state = 0;
				global.substate = 0
				global.state = "venture_error"
				break;
		}
	}
};

venture_actions[57] = {
	comment: "16: Stocks increase by 10% in three random districts",
	run: function() {
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=1.1
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=1.1
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=1.1
	}
};

venture_actions[58] = {
	comment: "60: Stocks increase by 10% in a random district",
	run: function() {
		obj_board.district_multipliers[irandom_range(1,global.used_districts)] *=1.1
	}
};

venture_actions[59] = {
	comment: "84: The winning player pays you 10% of their ready cash",
	error_message: "You're already in first place, so nothing happens",
	run: function() {
		var pointer = 0;
		var first_place = find_first_place();
		if(first_place == global.player || first_place == noone){
			global.venture_state = 0;
			global.substate = 0
			global.state = "venture_error"
		}else{
			give_gold(first_place, first_place.readycash*0.1, global.player)
		}
	}
};

venture_actions[60] = {
	comment: "7: All your shops increase by 7%",
	run: function() {
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "shop"){
				if(global.board[i].properties.owner == global.player){
					alter_shop(global.board[i].properties, 1.07)
				}
			}
		}
	}
};

venture_actions[61] = {
	comment: "13: All your shops decrease by 13%",
	run: function() {
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "shop"){
				if(global.board[i].properties.owner == global.player){
					alter_shop(global.board[i].properties, 0.87)
				}
			}
		}
	}
};

venture_actions[62] = {
	comment: "103: All your shops decrease by 25%",
	run: function() {
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "shop"){
				if(global.board[i].properties.owner == global.player){
					alter_shop(global.board[i].properties, 0.75)
				}
			}
		}
	}
};

venture_actions[63] = {
	comment: "103: All your shops increase by 21%",
	run: function() {
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "shop"){
				if(global.board[i].properties.owner == global.player){
					alter_shop(global.board[i].properties, 1.21)
				}
			}
		}
	}
};

venture_actions[64] = {
	comment: "170: All your shops double in value",
	run: function() {
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "shop"){
				if(global.board[i].properties.owner == global.player){
					alter_shop(global.board[i].properties, 2)
				}
			}
		}
	}
};

venture_actions[65] = {
	comment: "81: All players move 1 on their next turn",
	dice_roll: 1,// if we were to actually do this this would have to be an array for card 87 and the cards that removes one number from the roll
	run: function() {
			var dice_id = noone;
			if (instance_exists(obj_dice)) {
			    dice_id = instance_find(obj_dice, 0);
			} else if (instance_exists(obj_dice_venture)) {
			    dice_id = instance_find(obj_dice_venture, 0);
			}
			instance_create_depth(dice_id.x, dice_id.y, 200, obj_dice_venture)
			instance_destroy(dice_id)
			
		}
};

venture_actions[66] = {
	comment: "115: All players move 7 on their next turn",
	dice_roll: 7,// if we were to actually do this this would have to be an array for card 87 and the cards that removes one number from the roll
	run: function() {
			var dice_id = noone;
			if (instance_exists(obj_dice)) {
			    dice_id = instance_find(obj_dice, 0);
			} else if (instance_exists(obj_dice_venture)) {
			    dice_id = instance_find(obj_dice_venture, 0);
			}
			instance_create_depth(dice_id.x, dice_id.y, 200, obj_dice_venture)
			instance_destroy(dice_id)
			
		}
};



//looking at the dice cards more, I think we're gonna need another string variable for them

/*
venture_actions[62] = {
	comment: "31: Shops expand by 10% in a random district",
	run: function() {
		var chosen_district = district_name_convert(irandom_range(0, global.used_districts-1))
		log("chosen district: " + string(chosen_district))
		for(var i = 0; i < array_length(global.board); i++){
			if(global.board[i].properties.type == "shop"){
				log("shop district: " + string(global.board[i].properties.district))
				if(global.board[i].properties.district == chosen_district){
					log("yup, this is it")
					alter_shop(global.board[i].properties, 1.1)
				}
			}
		}
	}
};
*/
//ok this should work but it doesn't, we'll need to check this later


//check card 176, it seems incredibly broken