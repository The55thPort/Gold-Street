//OBJ_GAME - Invisible, ties all other objects together
/////////////////////////////////////////////////////
//Prepare Loading Save File (if necessary)

global.state = "turn_start"
if obj_persistent.file_selected != "New Game" {
	global.state = "game_load"
}

/////////////////////////////////////////////////////
//Initialize Variables

state_stored_prev = ""
state_stored_prev_2 = ""
state_stored_next = ""
state_stored_next_2 = ""
selected = noone
timer = 0

/////////////////////////////////////////////////////
//Set Up Players

players = [  ]
array_copy(players,0,obj_persistent.players,0,array_length(obj_persistent.players))
current_player = 0
global.player = array_get(players, current_player)

repeat (array_length(players)) {
	instance_create_layer(0,0,"Players",players[current_player])
	current_player++
}
current_player = 0

/////////////////////////////////////////////////////