function LoadPlayer(character){
	
var savefile = file_text_open_read("Players/" + character + "/data.txt")

var savedata_json = file_text_read_string(savefile)

var savedata = json_parse(savedata_json)

file_text_close(savefile)

return savedata

}