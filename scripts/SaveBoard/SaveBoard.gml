function SaveBoard(){
	
var savedata = [  ]
var current_space = 0

repeat (array_length(global.board)) {
	array_push(savedata, global.board[current_space].properties)
	current_space += 1
}



var savedata_json = json_stringify(savedata)

var savefile = file_text_open_write("Boards/board.txt")

file_text_write_string(savefile, savedata_json)

file_text_close(savefile)

}