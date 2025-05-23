function LoadGame(file){

var savefile = file_text_open_read("Boards/" + global.board_name + "/Saves/" + file)

var savedata_json = file_text_read_string(savefile)

var savedata = json_parse(savedata_json)

file_text_close(savefile)

var player = 0
var current_shop = 0
var current_stock = 0

repeat (array_length(savedata[0])) {

	repeat (array_length(savedata[0][player][0])) {
		array_push(obj_game.players[player].shops,global.board[savedata[0][player][0][current_shop][0]])
		global.board[savedata[0][player][0][current_shop][0]].properties.owner = obj_game.players[player]
		global.board[savedata[0][player][0][current_shop][0]].properties.capital = savedata[0][player][0][current_shop][1]
		current_shop++
	}
	current_shop = 0
	obj_game.players[player].suits = savedata[0][player][1]
	obj_game.players[player].level = savedata[0][player][2]
	obj_game.players[player].readycash = savedata[0][player][3]
	obj_game.players[player].current_position = savedata[0][player][4]
	if savedata[0][player][5] != -1 {obj_game.players[player].previous_position = global.board[savedata[0][player][5]]}
	repeat (array_length(savedata[0][player][6])) {
		obj_game.players[player].stocks[district_name_convert(savedata[0][player][6][current_stock][0])] = savedata[0][player][6][current_stock][1]
		current_stock++
	}
	current_stock = 0
	obj_game.players[player].x = global.board[obj_game.players[player].current_position].properties.x + 8
	obj_game.players[player].y = global.board[obj_game.players[player].current_position].properties.y + 8
	player++

}

obj_game.current_player = savedata[1]

if savedata[2] != -1 {
	var i = 0
	repeat (array_length(savedata[2])) {
		global.board[savedata[2][i][0]].properties.suit = savedata[2][i][1]
		global.board[savedata[2][i][0]].properties.suit_display = savedata[2][i][1]
		i++
	}
}

}