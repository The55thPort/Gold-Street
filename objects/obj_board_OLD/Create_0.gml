global.board = [  ]

_space0 = instance_create_layer(0,0,"Board",obj_space)
_space0.properties = {
	space : 0,
	type : "bank",
	connections : [3, 1],
	x : 85,
	y : 0
}

array_push(global.board, _space0)

_space1 = instance_create_layer(0,0,"Board",obj_space)
_space1.properties = {
	space : 1,
	type : "shop",
	connections : [0, 2],
	x : 170,
	y : 0
}

array_push(global.board, _space1)

_space2 = instance_create_layer(0,0,"Board",obj_space)
_space2.properties = {
	space : 2,
	type : "venture",
	connections : [1, 3],
	x : 85,
	y : 128
}

array_push(global.board, _space2)

_space3 = instance_create_layer(0,0,"Board",obj_space)
_space3.properties = {
	space : 3,
	type : "suit",
	connections : [2, 0],
	x : 170,
	y : 128,
	suit : "heart"
}

array_push(global.board, _space3)