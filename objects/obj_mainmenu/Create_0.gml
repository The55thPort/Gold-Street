state = "welcome"
pointer = 0
selected = ""
effect = ""
timer = 0
timer_ref = 60
main_menu = ["Play","Create","Settings","Leave","Hosts"]

var i = 0
var boards_data_json = [  ]
var boards_file = file_text_open_read("Boards/select.txt")
var boards_data = file_text_read_string(boards_file)
if boards_data != "[ \"board1\", \"board2\", \"board3...\" ]" {
	boards_data_json = json_parse(boards_data)
	if array_contains(boards_data_json,"board1") {
		i = array_get_index(boards_data_json,"board1")
		array_delete(boards_data_json,i,1)
	}
	if array_contains(boards_data_json,"board2") {
		i = array_get_index(boards_data_json,"board2")
		array_delete(boards_data_json,i,1)
	}
	if array_contains(boards_data_json,"board3...") {
		i = array_get_index(boards_data_json,"board3...")
		array_delete(boards_data_json,i,1)
	}
}
file_text_close(boards_file)

var themes_data_json = [  ]
var themes_file = file_text_open_read("Themes/select.txt")
var themes_data = file_text_read_string(themes_file)
if themes_data != "[ \"theme1\", \"theme2\", \"theme3...\" ]" {
	themes_data_json = json_parse(themes_data)
	if array_contains(themes_data_json,"theme1") {
		i = array_get_index(themes_data_json,"theme1")
		array_delete(themes_data_json,i,1)
	}
	if array_contains(themes_data_json,"theme2") {
		i = array_get_index(themes_data_json,"theme2")
		array_delete(themes_data_json,i,1)
	}
	if array_contains(themes_data_json,"theme3...") {
		i = array_get_index(themes_data_json,"theme3...")
		array_delete(themes_data_json,i,1)
	}
}
file_text_close(themes_file)

boards = boards_data_json
themes = themes_data_json
files = ["New Game", "Autosave", "File 1", "File 2", "File 3"]

theme = -1
state = "select_board"
if array_contains(themes,global.theme_name) {
	theme = LoadTheme(global.theme_name)
	var path = "Themes/" + global.theme_name + "/Graphics/"
	
	welcome = theme[0]
	main = theme[1]
		play_selected = sprite_add(path + main.play[3],0,false,0,0,0)
		create_selected = sprite_add(path + main.create[3],0,false,0,0,0)
		settings_selected = sprite_add(path + main.settings[3],0,false,0,0,0)
		leave_selected = sprite_add(path + main.leave[3],0,false,0,0,0)
		hosts_selected = sprite_add(path + main.hosts[3],0,false,0,0,0)
		play_unselected = sprite_add(path + main.play[4],0,false,0,0,0)
		create_unselected = sprite_add(path + main.create[4],0,false,0,0,0)
		settings_unselected = sprite_add(path + main.settings[4],0,false,0,0,0)
		leave_unselected = sprite_add(path + main.leave[4],0,false,0,0,0)
		hosts_unselected = sprite_add(path + main.hosts[4],0,false,0,0,0)
	
	state = "welcome"
}

bg = instance_create_layer(0,0,"Instances",obj_background)