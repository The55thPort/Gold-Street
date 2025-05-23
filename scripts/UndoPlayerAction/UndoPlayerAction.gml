function UndoPlayerAction(){

if global.board[global.player.current_position].properties.type == "bank" {
	if array_length(global.board[global.player.current_position].properties.suits_last) > 0 {
		if !array_contains(array_last(global.board[global.player.current_position].properties.suits_last),0) {
			global.player.level--
			var divider = 10
			if array_length(players) >= 5 {divider = 5}
			global.player.readycash -= global.salary_base + (global.salary_increment * global.player.level) + floor(global.player.shops_value / divider)
		}
		global.player.suits = array_last(global.board[global.player.current_position].properties.suits_last)
		array_copy(array_last(global.board[global.player.current_position].properties.suits_last),0,global.player.suits,0,4)
		array_pop(global.board[global.player.current_position].properties.suits_last)
		var last_stock = array_last(global.board[global.player.current_position].properties.stocks_last)
		if last_stock != -1 {
			global.player.stocks[last_stock[0]] -= last_stock[1]
			global.player.readycash += last_stock[2]
		}
		array_pop(global.board[global.player.current_position].properties.stocks_last)
	}
}
if global.board[global.player.current_position].properties.type == "suit" or global.board[global.player.current_position].properties.type == "suit-change" {
	if global.board[global.player.current_position].properties.type == "suit-change" {
		global.board[global.player.current_position].properties.suit -= 1
		if global.board[global.player.current_position].properties.suit < 0 {
			global.board[global.player.current_position].properties.suit = 3
		}
	}
	global.player.suits[global.board[global.player.current_position].properties.suit] -= 1
}
global.player.spaces_to_move = 1
global.player.current_position = array_last(global.player.current_path).properties.space
global.player.x_start = global.player.x
global.player.y_start = global.player.y
global.player.x_goto = array_last(global.player.current_path).x + 8
global.player.y_goto = array_last(global.player.current_path).y + 8
global.player.moving = true
array_pop(global.player.current_path)
global.player.anim_pointer = 0
global.player.anim_timer = 0
array_copy(global.player.current_animation,0,global.player.prev_animation,0,array_length(global.player.prev_animation))
global.state = "player_move"

}