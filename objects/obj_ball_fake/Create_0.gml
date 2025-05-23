positions = [

	[32,240],
	[96,240],
	[160,240],
	[64,304],
	[128,304],
	[32,368],
	[96,368],
	[160,368],
	[64,432],
	[128,432],
	[32,496],
	[96,496],
	[160,496],
	[64,560],
	[128,560],
	[32,624],
	[96,624],
	[160,624],
	[64,688],
	[128,688],
	
]

var position_index = 0
var position_selected = 0

repeat (3) {
	position_index = irandom(array_length(positions) - 1)
	position_selected = array_get(positions,position_index)
	instance_create_layer(position_selected[0],position_selected[1],"Ribbons",obj_ribbon_blue)
	array_delete(positions,position_index,1)
}

repeat (3) {
	position_index = irandom(array_length(positions) - 1)
	position_selected = array_get(positions,position_index)
	instance_create_layer(position_selected[0],position_selected[1],"Ribbons",obj_ribbon_red)
	array_delete(positions,position_index,1)
}