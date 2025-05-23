function LoadBoard(){
	
var savefile = file_text_open_read("Boards/" + global.board_name + "/board.txt")

var savedata_json = file_text_read_string(savefile)

var savedata = json_parse(savedata_json)

file_text_close(savefile)

return savedata

}