function district_name_convert(input){
	
var output = -1
var letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

if is_string(input) {output = array_get_index(letters,input)}
else {output = letters[input]}

return output
	

}