draw_self()

if properties.type == "shop" {
	if properties.owner != noone {
		if properties.price < 50 {draw_sprite(spr_shop_stand,0,x,y)}
	}
	else draw_sprite(spr_shop_sale,0,x,y)
	
	draw_sprite(spr_shop_frame,0,x,y)
	draw_sprite(spr_shop_bars,properties.district_number,x+1,y+23)
	
	draw_set_font(fnt_shops)
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	
	if properties.owner == noone {
		draw_text(x+30,y+27,properties.value)
	}
	else {
		draw_text(x+30,y+27,properties.price)
	}
		
	draw_set_font(fnt_menu_game)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

if properties.type == "suit" {
	if properties.suit == 0 {draw_sprite(spr_suit_spade,0,x,y)}
	if properties.suit == 1 {draw_sprite(spr_suit_heart,0,x,y)}
	if properties.suit == 2 {draw_sprite(spr_suit_diamond,0,x,y)}
	if properties.suit == 3 {draw_sprite(spr_suit_club,0,x,y)}
}

if properties.type == "suit-change" {
	if properties.suit_display == 0 {draw_sprite(spr_suit_spade,0,x,y)}
	if properties.suit_display == 1 {draw_sprite(spr_suit_heart,0,x,y)}
	if properties.suit_display == 2 {draw_sprite(spr_suit_diamond,0,x,y)}
	if properties.suit_display == 3 {draw_sprite(spr_suit_club,0,x,y)}
}