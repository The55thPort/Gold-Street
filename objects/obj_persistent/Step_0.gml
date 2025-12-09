if room == rm_game {
	//record current player
	player = array_get_index(players,global.player)
	//record all player colors
	if array_length(player_colors) == 0 {
		var i = 0
		repeat (array_length(players)) {
			array_push(player_colors, players[i].color)
			i++
		}
	}
}

if room == rm_pachinko {
	//after finishing, return to main game
	if readyflag == true {
		readyflag = false
		file_selected = "minigame.txt"
		global.state = "game_load"
		room_goto(rm_game)
	}
}