randomize()
display_set_gui_size(256,224)

var select = -1
var board_select_text = "[ \"board1\", \"board2\", \"board3...\" ]"
var theme_select_text = "[ \"theme1\", \"theme2\", \"theme3...\" ]"

if !directory_exists("Boards") {directory_create("Boards")}
if !file_exists("Boards/select.txt") {
	select = file_text_open_write("Boards/select.txt")
	file_text_write_string(select,board_select_text)
	file_text_close(select)
}

if !directory_exists("Players") {directory_create("Players")}

if !directory_exists("Themes") {directory_create("Themes")}
if !file_exists("Themes/select.txt") {
	select = file_text_open_write("Themes/select.txt")
	file_text_write_string(select,theme_select_text)
	file_text_close(select)
}

room_goto_next()