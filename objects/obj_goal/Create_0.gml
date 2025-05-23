timer = 240
var players = [  ]
var i = 0
repeat (array_length(obj_persistent.players)) {
	array_push(players,i)
	i++
}

if x == 96 {
	player = obj_persistent.player
	image_blend = obj_persistent.player_colors[player]
}
else {
	array_shuffle_ext(players)
	player = players[0]
	image_blend = obj_persistent.player_colors[player]
}