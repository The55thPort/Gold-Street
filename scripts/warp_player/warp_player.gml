// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function warp_player(player, destination, x_pos, y_pos){
	player.current_position = destination
	player.x = x_pos
	player.y = y_pos
	player.previous_position = -1
}