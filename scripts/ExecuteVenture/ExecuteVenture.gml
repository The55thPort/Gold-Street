function ExecuteVenture(number){
	
var pointer = 0

switch number {
	
	case 1:
		log("1: Choose your direction!")
		global.player.previous_position = -1
	break;
	
	case 2:
		log("2: Roll on!")
		global.state = "dice_roll"
	break;
	
	case 3:
		log("12: Capital Venture!")
		global.state = "shop_self"
	break;
	
	case 4:
		log("14: Give everyone 30 gold!")
		global.player.readycash -= 30 * (array_length(obj_game.players) - 1)
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				obj_game.players[pointer].readycash += 30
			}
			pointer++
		}
	break;
	
	case 5:
		log("27: 27x the shops you own in gold coins!")
		global.player.readycash += 27 * array_length(global.player.shops)
	break;
	
	case 6:
		log("29: Take a heart!")
		if global.player.suits[1] <= 0 {
			global.player.suits[1] = 1
		}
		else {
			global.player.readycash += 100
		}
	break;
	
	case 7:
		log("46: Lose 10% of readycash!")
		global.player.readycash = floor(global.player.readycash * 0.9)
	break;
	
	case 8:
		log("50: Move the same number of spaces again!")
		global.player.spaces_to_move = obj_dice.diceroll
		global.state = "player_move"
	break;
	
	case 9:
		log("51: Move forward one more square!")
		global.player.spaces_to_move = 1
		global.state = "player_move"
	break;
	
	case 10:
		log("52: Move forward two more squares!")
		global.player.spaces_to_move = 2
		global.state = "player_move"
	break;
	
	case 11:
		log("70: Sudden promotion!")
		global.player.suits = [ 0,0,0,0 ]
		global.player.readycash += global.salary_base + (global.salary_increment * global.player.level)
		global.player.level++
	break;
	
	case 12:
		log("80: Take a spade!")
		if global.player.suits[0] <= 0 {
			global.player.suits[0] = 1
		}
		else {
			global.player.readycash += 100
		}
	break;
	
	case 13:
		log("82: Take a club!")
		if global.player.suits[3] <= 0 {
			global.player.suits[3] = 1
		}
		else {
			global.player.readycash += 100
		}
	break;
	
	case 14:
		log("86: Take 100 gold from everyone else!")
		global.player.readycash += 100 * (array_length(obj_game.players) - 1)
		repeat (array_length(obj_game.players)) {
			if obj_game.players[pointer] != global.player {
				obj_game.players[pointer].readycash -= 100
			}
			pointer++
		}
	break;
	
	case 15:
		log("94: Take a diamond!")
		if global.player.suits[2] <= 0 {
			global.player.suits[2] = 1
		}
		else {
			global.player.readycash += 100
		}
	break;
	
	case 16:
		log("99: Get all the suits!")
		global.player.suits = [1,1,1,1]
	break;
	
}

}