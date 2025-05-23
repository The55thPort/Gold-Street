function district_select_draw(x_pos,y_pos,district){
	
draw_sprite_stretched(spr_shop_bars,district,x_pos+14,y_pos+13,30,30)

draw_set_font(fnt_menu_main)
draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_text(x_pos+103,y_pos+9,"District")

draw_set_valign(fa_bottom)
draw_text(x_pos+103,y_pos+48,districts_display[pointer])

draw_sprite_ext(spr_menu_divider,0,x_pos+7,y_pos+51,152/3,1,0,global.menu_color,1)

draw_set_font(fnt_menu_game)
draw_set_valign(fa_middle)
draw_text(x_pos+88,y_pos+61,"Prices: " + string(global.stock_prices[district]))
draw_text(x_pos+88,y_pos+69,"Value: " + string(global.district_values[district]))

var shop = 0
var mult = 0
var sprite = noone
repeat (4) {
	var current_pos = x_pos+3+(40*mult)
	if shop > array_length(global.shops_in_district[district]) - 1 {
		draw_sprite_ext(spr_menu_shop,0,current_pos,y_pos+77,1,1,0,c_grey,0.3)
	}
	else if global.shops_in_district[district,shop].properties.owner != noone {
		draw_sprite_ext(spr_menu_shop,0,current_pos,y_pos+77,1,1,0,global.shops_in_district[district,shop].properties.owner.color,1)
		draw_text(current_pos+27,y_pos+86,global.shops_in_district[district,shop].properties.value)
		draw_text(current_pos+27,y_pos+94,global.shops_in_district[district,shop].properties.price)
	}
	else {
		draw_sprite_ext(spr_menu_shop,0,current_pos,y_pos+77,1,1,0,c_white,1)
		draw_text(current_pos+27,y_pos+90,global.shops_in_district[district,shop].properties.value)
	}
	shop++
	mult++
}
mult = 0

repeat (4) {
	var current_pos = x_pos+3+(40*mult)
	if shop == 7 && array_length(global.shops_in_district[district]) > 8 {
		draw_set_font(fnt_menu_main)
		draw_text(current_pos+20,y_pos+115,"+" + string(array_length(global.shops_in_district[district]) - shop))
		draw_set_font(fnt_menu_game)
	}
	else if shop > array_length(global.shops_in_district[district]) - 1 {
		draw_sprite_ext(spr_menu_shop,0,current_pos,y_pos+102,1,1,0,c_grey,0.3)
	}
	else if global.shops_in_district[district,shop].properties.owner != noone {
		draw_sprite_ext(spr_menu_shop,0,current_pos,y_pos+102,1,1,0,global.shops_in_district[district,shop].properties.owner.color,1)
		draw_text(current_pos+27,y_pos+111,global.shops_in_district[district,shop].properties.value)
		draw_text(current_pos+27,y_pos+119,global.shops_in_district[district,shop].properties.price)
	}
	else {
		draw_sprite_ext(spr_menu_shop,0,current_pos,y_pos+102,1,1,0,c_white,1)
		draw_text(current_pos+27,y_pos+115,global.shops_in_district[district,shop].properties.value)
	}
	shop++
	mult++
}

draw_sprite_ext(spr_menu_divider,0,x_pos+7,y_pos+132,152/3,1,0,global.menu_color,1)

var player = 0
mult = 0
repeat (4) {
	var current_pos = x_pos+3+(40*mult)
	if player <= array_length(obj_game.players) - 1 {
		draw_sprite_ext(spr_menu_stock,0,current_pos,y_pos+140,1,1,0,obj_game.players[player].color,1)
		draw_sprite(obj_game.players[player].icon,0,current_pos+1,y_pos+141)
		if obj_game.players[player].stocks[district] > 0 {
			draw_text(current_pos+29,y_pos+150,string(obj_game.players[player].stocks[district]))
		}
		else draw_text(current_pos+29,y_pos+150,"--")
	}
	else draw_sprite_ext(spr_menu_stock,0,current_pos,y_pos+140,1,1,0,c_grey,0.3)
	player++
	mult++
}
mult = 0

repeat (4) {
	var current_pos = x_pos+3+(40*mult)
	if player <= array_length(obj_game.players) - 1 {
		draw_sprite_ext(spr_menu_stock,0,current_pos,y_pos+158,1,1,0,obj_game.players[player].color,1)
		draw_sprite(obj_game.players[player].icon,0,current_pos+1,y_pos+159)
		if obj_game.players[player].stocks[district] > 0 {
			draw_text(current_pos+29,y_pos+168,string(obj_game.players[player].stocks[district]))
		}
		else draw_text(current_pos+29,y_pos+168,"--")
	}
	else draw_sprite_ext(spr_menu_stock,0,current_pos,y_pos+158,1,1,0,c_grey,0.3)
	player++
	mult++
}

}