function stats_draw(player,position){
	
draw_set_font(fnt_shops)

var menu_top = 206 - 18 * position
var menu_right = 169

draw_sprite_ext(spr_stats_base,0,menu_right,menu_top,1,1,0,player.color,1)
draw_sprite(player.icon,0,menu_right+1,menu_top+1)

var c = c_white

if player.promotion == true {c = player.color_spade}
if player.suits[0] >= 1 {draw_sprite_ext(spr_stats_spade,0,menu_right+55,menu_top+1,1,1,0,c,1)}
if player.promotion == true {c = player.color_heart}
if player.suits[1] >= 1 {draw_sprite_ext(spr_stats_heart,0,menu_right+63,menu_top+1,1,1,0,c,1)}
if player.promotion == true {c = player.color_diamond}
if player.suits[2] >= 1 {draw_sprite_ext(spr_stats_diamond,0,menu_right+71,menu_top+1,1,1,0,c,1)}
if player.promotion == true {c = player.color_club}
if player.suits[3] >= 1 {draw_sprite_ext(spr_stats_club,0,menu_right+79,menu_top+1,1,1,0,c,1)}



draw_set_valign(fa_bottom)
draw_set_halign(fa_right)

var col = c_white
if player.net_worth_display < player.net_worth {col = #C8FFC8}
if player.net_worth_display > player.net_worth or player.net_worth_display < 0 {col = #FFC8C8}
if player.net_worth >= global.target_amount {col = #FFFF7D}
draw_text_color(menu_right+87,menu_top+19,player.net_worth_display,col,col,col,col,1)

col = c_white
if player.readycash_display < player.readycash {col = #C8FFC8}
if player.readycash_display > player.readycash or player.readycash_display < 0 {col = #FFC8C8}
draw_text_color(menu_right+50,menu_top+19,player.readycash_display,col,col,col,col,1)

draw_text(menu_right+50,menu_top+10,string_upper(player.name_menu))

col = global.menu_color
draw_sprite_ext(spr_stats_border,0,menu_right-3,menu_top-3,1.25,1.25,0,col,1)
if global.state == "player_action" or menu_toggle == 1 {
	if player == global.player {
		draw_sprite_ext(spr_stats_border_cursor,0,menu_right-3,menu_top-3,1,1,0,col,1)
	}
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)
draw_set_font(fnt_menu_game)

}