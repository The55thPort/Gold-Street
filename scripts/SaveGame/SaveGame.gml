function SaveGame(file){

var savedata = [  ]

var players = [  ]
var pos_player = 0
var pos_shops = 0
var player_stats = [  ]
var player_shops = [  ]
var current_shop = [  ]
var district = 0
var player_stocks = [  ]
var current_stock = [  ]

repeat (array_length(obj_game.players)) {

	repeat (array_length(obj_game.players[pos_player].shops)) {
		array_push(current_shop, obj_game.players[pos_player].shops[pos_shops].properties.space)
		array_push(current_shop, obj_game.players[pos_player].shops[pos_shops].properties.capital)
		array_push(player_shops, current_shop)
		current_shop = [  ]
		pos_shops++
	}
	array_push(player_stats,player_shops)
	array_push(player_stats,obj_game.players[pos_player].suits)
	array_push(player_stats,obj_game.players[pos_player].level)
	array_push(player_stats,obj_game.players[pos_player].readycash)
	array_push(player_stats,obj_game.players[pos_player].current_position)
	if obj_game.players[pos_player].previous_position != -1 {array_push(player_stats,obj_game.players[pos_player].previous_position.properties.space)}
	else array_push(player_stats,-1)
	log(array_length(obj_game.players[pos_player].stocks))
	repeat (array_length(obj_game.players[pos_player].stocks)) {
		if obj_game.players[pos_player].stocks[district] != 0 {
			array_push(current_stock,district_name_convert(district))
			array_push(current_stock,obj_game.players[pos_player].stocks[district])
			array_push(player_stocks,current_stock)
			current_stock = [  ]
		}
		district++
	}
	array_push(player_stats,player_stocks)
	array_push(players,player_stats)
	player_shops = [  ]
	player_stats = [  ]
	pos_shops = 0
	player_stocks = [  ]
	district = 0
	pos_player++

}
array_push(savedata,players)
array_push(savedata,obj_game.current_player)

var suit_changes = [  ]
with (obj_space) {
	var suit_change_current = [  ]
	if properties.type == "suit-change" {
		array_push(suit_change_current,properties.space)
		array_push(suit_change_current,properties.suit)
		array_push(suit_changes,suit_change_current)
	}
}
if array_length(suit_changes) != 0 {array_push(savedata,suit_changes)}
else array_push(savedata,-1)



if !directory_exists("Boards/" + global.board_name + "/Saves/") {
	directory_create("Boards/" + global.board_name + "/Saves/")
}

var savedata_json = json_stringify(savedata)

var savefile = file_text_open_write("Boards/" + global.board_name + "/Saves/" + file)

file_text_write_string(savefile, savedata_json)

file_text_close(savefile)

}