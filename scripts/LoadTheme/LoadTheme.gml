function LoadTheme(theme){

var savefile = file_text_open_read("Themes/" + theme + "/theme.txt")

var savedata_json = file_text_read_string(savefile)

var savedata = json_parse(savedata_json)

return savedata

}