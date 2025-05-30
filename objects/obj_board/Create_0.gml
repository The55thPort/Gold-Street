//OBJ_BOARD - Invisible, handles all board-specific data
/////////////////////////////////////////////////////
//Initialize Variables

global.board = [  ]
global.district_values = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
global.shops_in_district = [ [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ], [  ] ]
global.stock_prices = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
district_multipliers = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
stock_price_changes = [  ]

board_top = 0
board_left = 0
board_bottom = 0
board_right = 0

board_data = LoadBoard() //Get Board Data

/////////////////////////////////////////////////////
//Create All Spaces

repeat (array_length(board_data[0])) {
	//Initialize Current Space
	var space_number = instance_number(obj_space)
	var current_space = instance_create_layer(0,0,"Board",obj_space)

	//Assign Current Space's Properties
	current_space.properties = board_data[0,space_number]
	
	//Initialize Board Dimensions (if space 0)
	if space_number == 0 {
		board_top = current_space.properties.y
		board_left = current_space.properties.x
		board_bottom = current_space.properties.y
		board_right = current_space.properties.x
	}
	
	//Recalculate New Board Dimensions (if necessary)
	if current_space.properties.x > board_right {board_right = current_space.properties.x}
	if current_space.properties.x < board_left {board_left = current_space.properties.x}
	if current_space.properties.y > board_bottom {board_bottom = current_space.properties.y}
	if current_space.properties.y < board_top {board_top = current_space.properties.y}
	
	//Finalize Space
	array_push(global.board,current_space)
}

/////////////////////////////////////////////////////
//Finish Board Dimensions

board_bottom += 32 //(due to the spaces' origins being at the top)
board_right += 32 //(due to the spaces' origins being on the left)

obj_camera.top = board_top
obj_camera.left = board_left
obj_camera.bottom = board_bottom
obj_camera.right = board_right

/////////////////////////////////////////////////////
//Create Backgrounds

var path = "Boards/" + global.board_name + "/"

var bg = -1
var anim = 0

repeat (5) {
	//Load Lower 5 Backgrounds
	if board_data[1][0][anim] != -1 {
		bg = instance_create_layer(0,0,"Background",obj_background) //Initialize BG
		bg.current_animation = board_data[1][0][anim] //Assign Current BG's Animation
		bg.depth += 5 - anim //Set Current BG to Correct Depth
	}
	anim++
}

anim = 0
repeat (5) {
	//Load Upper 5 Backgrounds
	if board_data[1][1][anim] != -1 {
		bg = instance_create_layer(0,0,"Players",obj_background) //Initialize BG
		bg.current_animation = board_data[1][1][anim] //Assign Current BG's Animation
		bg.depth -= 5 + anim //Set Current BG to Correct Depth
	}
	anim++
}

/////////////////////////////////////////////////////
//Set Board-Specific Values

global.salary_base = board_data[2,0]
global.salary_increment = board_data[2,1]
global.target_amount = board_data[2,2]
global.starting_ready = board_data[2,3]

global.menu_color = make_color_rgb(board_data[3,0],board_data[3,1],board_data[3,2])

if board_data[4,0] != -1 {
	global.board_theme = audio_create_stream(path + "Music/" + board_data[4,0])
}
else global.board_theme = -1

obj_dice.roll_min = board_data[5,0]
obj_dice.roll_max = board_data[5,1]

/////////////////////////////////////////////////////