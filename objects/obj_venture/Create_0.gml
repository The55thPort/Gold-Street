/// @description Insert description here
// You can write your code in this editor
venture_actions = [];

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
	}
};

venture_actions[3] = {
	comment: "12: Capital Venture! You may invest in a shop",
	run: function() {
		global.state = "shop_self";
	}
};

venture_actions[4] = {
	comment: "14: Give everyone 30 gold!",
	run: function() {
		var pointer = 0;
		global.player.readycash -= 30 * (array_length(obj_game.players) - 1);
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				obj_game.players[pointer].readycash += 30;
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
	run: function() {
		if global.player.suits[1] <= 0 {
			global.player.suits[1] = 1;
		} else {
			global.player.readycash += 100;
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
	run: function() {
		if global.player.suits[0] <= 0 {
			global.player.suits[0] = 1;
		} else {
			global.player.readycash += 100;
		}
	}
};

venture_actions[13] = {
	comment: "82: Take a club!",
	run: function() {
		if global.player.suits[3] <= 0 {
			global.player.suits[3] = 1;
		} else {
			global.player.readycash += 100;
		}
	}
};

venture_actions[14] = {
	comment: "86: Take 100 gold from everyone else!",
	run: function() {
		var pointer = 0;
		global.player.readycash += 100 * (array_length(obj_game.players) - 1);
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				obj_game.players[pointer].readycash -= 100;
			}
			pointer++;
		}
	}
};

venture_actions[15] = {
	comment: "94: Take a diamond!",
	run: function() {
		if global.player.suits[2] <= 0 {
			global.player.suits[2] = 1;
		} else {
			global.player.readycash += 100;
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
		global.player.readycash -= 80 * (array_length(obj_game.players) - 1);
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				obj_game.players[pointer].readycash += 80;
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
				obj_game.players[pointer].readycash -= 40* global.player.level;
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