// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function find_first_place(){
	var first_place = noone;
	var highest_net_worth = 0;
	var pointer = 0;
	repeat (array_length(obj_game.players)) {
		if(obj_game.players[pointer].net_worth > highest_net_worth){
			first_place = obj_game.players[pointer]
			highest_net_worth = obj_game.players[pointer].net_worth
		}
		pointer++;
	}
	return first_place;
}