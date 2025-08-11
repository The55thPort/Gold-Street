draw_set_font(fnt_menu_game)
var menu = [  ]


function draw_menu_text(menu_array, menu_x, menu_y){
	for (var i = 0; i < array_length(menu_array); i++) {
		var color = c_white
		if i == pointer {
			color = c_yellow
		}
		draw_text_color(menu_x, menu_y +12*(i), menu_array[i], color, color, color, color, 1)
	}
}

function draw_arrowed_stat(stat, arrow_y){
	draw_sprite(spr_arrow_w, 1, 130, arrow_y) 
	draw_text(150, arrow_y-3, stat)
	draw_sprite(spr_arrow_e, 1, 180, arrow_y) 
}

switch global.state {
	
	case "dice_roll":
		if menu_toggle == 0 {stats_draw(global.player,0)}
		
		//my attempt at creating a notification hud, the text size would need to be increased and centered
		menu = menu_draw(22,118,200,25)
		draw_text(menu[0],menu[1],"Rolling Dice...")
	break;
	
	case "district_select":
		menu = menu_draw(22,18,string_width("Page 9")+10,77)
		draw_text(menu[0],menu[1],"Page " + string(page+1))
		draw_text(menu[0],menu[1]+12,"------")
		
		draw_menu_text(districts_display, menu[0], menu[1])
		
		menu = menu_draw(83,18,166,179)
		district_select_draw(menu[0]-5,menu[1]-5,district_name_convert(districts_display[pointer]))
	break;
	
	case "game_save":
		menu = menu_draw(2,2,string_width("Choose File")+10,53)
		draw_text(menu[0],menu[1],"Choose File")
		
		draw_menu_text(choose_file, menu[0], menu[1] +12)
	break;
	
	case "manage_shops":
		if menu_toggle == 0 {
			stats_draw(global.player,0)
		}
		
		menu = menu_draw(2,2,string_width("Trade Shops")+10,50)
		
		draw_menu_text(manage_shops, menu[0], menu[1])
		
	break;
	/*
	case "manage_auction":
		if menu_toggle == 0 {
			stats_draw(global.player,0)
		}
		
		menu = menu_draw(2,2,string_width("Trade Shops")+10,50)
		
		draw_menu_text(manage_shops, menu[0], menu[1])
		
	break;
	case "manage_buy":
		if menu_toggle == 0 {
			stats_draw(global.player,0)
		}
		
		menu = menu_draw(2,2,string_width("Trade Shops")+10,50)
		
		draw_menu_text(manage_shops, menu[0], menu[1])
		
	break;
	case "manage_sell":
		if menu_toggle == 0 {
			stats_draw(global.player,0)
		}
		
		menu = menu_draw(2,2,string_width("Trade Shops")+10,50)
		
		draw_menu_text(manage_shops, menu[0], menu[1])
		
	break;
	*/
	case "manage_trade_1":
		if menu_toggle == 0 {stats_draw(global.player,0)}
		
		menu = menu_draw(2,2,string_width("Exchange how many?")+10,40)
		draw_text(menu[0],menu[1],"Exchange how many?")
		
		draw_menu_text(trade_shops, menu[0], menu[1]+12)
		
	break;
	
	case "pause":
		draw_set_color(c_black);
		draw_set_alpha(0.5);
		draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
		draw_set_alpha(1); // Reset alpha to 1
		draw_set_color(c_white);
		var screen_width = display_get_gui_width();
		var text_width = string_width("Paused");
		var text_x = (screen_width - text_width) / 3;//this is supposed to work on 2 but whatever
		draw_text_transformed(text_x, 7, "Paused", 3,3,0)
		
		draw_menu_text(pause_menu, 20, 40)
		
		draw_arrowed_stat(string(obj_audio.music_volume), 43)
		draw_arrowed_stat(string(obj_audio.sfx_volume), 55)
		draw_arrowed_stat(player_speed, 67)
		draw_arrowed_stat(player_speed, 79)
		draw_arrowed_stat(toggle_stats[menu_toggle], 91)
		switch(pointer){
			case 5:
				if(controls_flag){
					for (var i = 0; i < array_length(controls_ui); i++) {
						var color = c_white
						if (i == controls_pointer) {
							if(waiting_for_key){color = c_green}
							else{color = c_yellow}
						}
						draw_text_color(130, 100 + 12*(i), controls_ui[i] + key_name(game_controls[i]), color, color, color, color, 1)
					}
				}
			break;
		}

	break;
	
	case "player_action":
		if menu_toggle == 0 {
			var player = array_length(obj_game.players)
			var pos = 0
	
			do {
				player -= 1
				stats_draw(obj_game.players[player],pos)
				pos += 1
			}
			until player = 0
		}
		
		menu = menu_draw(2,2,string_width("Manage Shops")+10,40)
		
		draw_menu_text(player_action, menu[0], menu[1])
		draw_set_font(fnt_menu_game)
	break;

	case "player_move":
		if menu_toggle == 0 {stats_draw(global.player,0)}
		
		draw_sprite_stretched(spr_overlay,0,0,0,string_width(string(global.player.spaces_to_move))+5,string_height(string(global.player.spaces_to_move))+5)
		draw_text(0,0,global.player.spaces_to_move)
	break;
	
	case "player_poor":
		if menu_toggle == 0 {stats_draw(global.player,0)}
		
		menu = menu_draw(2,2,string_width("have no cash!")+10,65)
		draw_text(menu[0],menu[1],"Oh no! You")
		draw_text(menu[0],menu[1]+12,"have no cash!")
		draw_text(menu[0],menu[1]+24,"------")
		
		for (var i = 0; i < array_length(player_poor); i++) {
			var color = c_white
			if i == pointer {color = c_yellow}
			draw_text_color(menu[0], menu[1]+24+12*(i), player_poor[i], color, color, color, color, 1)
		}
	break;

	case "player_stop": 
		menu = menu_draw(2,2,string_width("Stop here?")+10,41)
		draw_text(menu[0],menu[1],"Stop here?")
	
		draw_menu_text(yes_no, menu[0], menu[1]+12)
	break;

	case "shop_buy":
	
		menu = menu_draw(2,2,string_width("Buy shop?")+10,41)
		draw_text(menu[0],menu[1],"Buy shop?")
		
		draw_menu_text(yes_no, menu[0], menu[1]+12)
	break;
	
	case "shop_invest_2":
		menu = menu_draw(2,2,string_width("7")+29,17)
		
		for (var i = 0; i < array_length(current_number); i++) {
			var color = c_white
			if i == pointer {color = c_yellow}
			draw_text_color(menu[0]+8*i, menu[1], current_number[i], color, color, color, color, 1)
		}
	break;
	
	case "shop_self":
		
		menu = menu_draw(2,2,string_width("Spruce up?")+10, 41)
		draw_text(menu[0],menu[1],"Spruce up?")
		
		draw_menu_text(yes_no, menu[0], menu[1]+12)
		
	break;
	
	case "stocks_ask":
	
		menu = menu_draw(2,2,string_width("Buy stocks?")+10,41)
		draw_text(menu[0],menu[1],"Buy stocks?")
	
		draw_menu_text(yes_no, menu[0], menu[1]+12)
	break;
	
	case "stocks_buy_2":
	
		menu = menu_draw(2,2,string_width("7")+29,17)
		
		for (var i = 0; i < array_length(current_number); i++) {
			var color = c_white
			if i == pointer {color = c_yellow}
			draw_text_color(menu[0]+8*i, menu[1], current_number[i], color, color, color, color, 1)
		}
	break;
	
	case "stocks_sell_2":
	
		menu = menu_draw(2,2,string_width("7")+29,17)
		
		for (var i = 0; i < array_length(current_number); i++) {
			var color = c_white
			if i == pointer {color = c_yellow}
			draw_text_color(menu[0]+8*i, menu[1], current_number[i], color, color, color, color, 1)
		}
	break;
	
	case "turn_end":
		draw_sprite_stretched(spr_black,0,0,0,round(lerp(0,256,anim_timer / (anim_timer_ref-10))),112)
		draw_sprite_ext(spr_black,0,256,112,-round(lerp(0,256,anim_timer / (anim_timer_ref-10))),112,0,c_white,1)
	break;
	
	case "turn_start":
		draw_sprite_ext(spr_black,0,256,0,-round(lerp(256,0,anim_timer / (anim_timer_ref-10))),112,0,c_white,1)
		draw_sprite_ext(spr_black,0,0,112,round(lerp(256,0,anim_timer / (anim_timer_ref-10))),112,0,c_white,1)
	break;
	
}

if menu_toggle == 1 { 
	var player = array_length(obj_game.players)
	var pos = 0
	
	do {
		player -= 1
		stats_draw(obj_game.players[player],pos)
		pos += 1
	}
	until player = 0
}

if(!obj_game.paused){
	if(!obj_game.viewing_board){draw_text(10,200, controls_ui[7] + key_name(game_controls[7]))}
	else{draw_text(10,200, "Go back: " + key_name(game_controls[7]))}
}