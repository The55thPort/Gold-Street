function menu_draw(x_pos,y_pos,w,h){
	
var col = global.menu_color

draw_sprite_stretched_ext(spr_menu,0,x_pos,y_pos,w,h,col,1)
var start_x = x_pos + 5
var start_y = y_pos + 5
var width = x_pos + w
var height = y_pos + h
var draw_coords = [ start_x, start_y, width, height ]

return draw_coords

}