//OBJ_PLAYER - Visible, holds all logic and art for player pieces
/////////////////////////////////////////////////////
//Initialize Variables
readyflag = false

current_animation = [  ]
prev_animation = [  ]
sprite_to_set = -1
anim_timer = 0
anim_pointer = 0
anim_ready = true

current_position = 0
current_path = [  ]
previous_position = -1
promotion = false
spaces_to_move = 0

shops = [  ]
shops_value = 0
readycash = global.starting_ready
readycash_display = readycash
suits = [ 0,0,0,0 ]
stocks = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
stocks_value = 0
level = 1
net_worth = readycash
net_worth_display = net_worth
display_timer = 0

moving = false
timer = 1
move_length = 10
x_start = 0
y_start = 0
x_goto = 0
y_goto = 0
suit_to_give = -1

//Set Starting Position and Push into Background
x = global.board[current_position].properties.x + 8
y = global.board[current_position].properties.y + 8
depth += 10
image_alpha = 0.5

//Load Player Character
var char_to_load = obj_persistent.player1
if object_index == obj_player2 {char_to_load = obj_persistent.player2}
if object_index == obj_player3 {char_to_load = obj_persistent.player3}
if object_index == obj_player4 {char_to_load = obj_persistent.player4}
if object_index == obj_player5 {char_to_load = obj_persistent.player5}
if object_index == obj_player6 {char_to_load = obj_persistent.player6}
if object_index == obj_player7 {char_to_load = obj_persistent.player7}
if object_index == obj_player8 {char_to_load = obj_persistent.player8}

var character = LoadPlayer(char_to_load)

path = "Players/" + char_to_load + "/"

name = character[1,0]
name_menu = character[1,1]
color = make_color_rgb(character[2][0][0], character[2][0][1], character[2][0][2])
color_spade = make_color_rgb(character[2][1][0], character[2][1][1], character[2][1][2])
color_heart = make_color_rgb(character[2][2][0], character[2][2][1], character[2][2][2])
color_diamond = make_color_rgb(character[2][3][0], character[2][3][1], character[2][3][2])
color_club = make_color_rgb(character[2][4][0], character[2][4][1], character[2][4][2])

icon = sprite_add(path + character[0][0][0],0,false,0,0,0)

idle_down = character[0,0]

walk_up = character[0,1]
walk_left = character[0,2]
walk_down = character[0,3]
walk_right = character[0,4]



//Start Character Idling Downwards
array_copy(current_animation,0,idle_down,0,array_length(idle_down))