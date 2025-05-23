draw_set_font(fnt_menu_game)
var menu = [  ]



switch global.state {
	
	case "dice_roll":
		if toggle == 0 {
			stats_draw(global.player,0)
		}
	break;
	
	case "district_select":
		menu = menu_draw(22,18,string_width("Page 9")+10,77)
		draw_text(menu[0],menu[1],"Page " + string(page+1))
		draw_text(menu[0],menu[1]+12,"------")
		
		for (var i = 0; i < array_length(districts_display); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+2), districts_display[i], color, color, color, color, 1)
		}
		
		menu = menu_draw(83,18,166,179)
		district_select_draw(menu[0]-5,menu[1]-5,district_name_convert(districts_display[pointer]))
	break;
	
	case "game_save":
		menu = menu_draw(2,2,string_width("Choose File")+10,53)
		draw_text(menu[0],menu[1],"Choose File")
		
		for (var i = 0; i < array_length(choose_file); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+1), choose_file[i], color, color, color, color, 1)
		}
	break;
	
	case "player_action":
		if toggle == 0 {
			var player = array_length(obj_game.players)
			var pos = 0
	
			do {
				player -= 1
				stats_draw(obj_game.players[player],pos)
				pos += 1
			}
			until player = 0
		}
		
		menu = menu_draw(2,2,string_width("View Board")+10,41)
	
		for (var i = 0; i < array_length(player_action); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1] + 12*(i), player_action[i], color, color, color, color, 1)
		}
		draw_set_font(fnt_menu_game)
	break;

	case "player_move":
		if toggle == 0 {
			stats_draw(global.player,0)
		}
		
		draw_sprite_stretched(spr_overlay,0,0,0,string_width(string(global.player.spaces_to_move))+5,string_height(string(global.player.spaces_to_move))+5)
		draw_text(0,0,global.player.spaces_to_move)
	break;
	
	case "player_poor":
		if toggle == 0 {
			stats_draw(global.player,0)
		}
		
		menu = menu_draw(2,2,string_width("have no cash!")+10,65)
		draw_text(menu[0],menu[1],"Oh no! You")
		draw_text(menu[0],menu[1]+12,"have no cash!")
		draw_text(menu[0],menu[1]+24,"------")
		
		for (var i = 0; i < array_length(player_poor); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+3), player_poor[i], color, color, color, color, 1)
		}
	break;

	case "player_stop": 
		menu = menu_draw(2,2,string_width("Stop here?")+10,41)
		draw_text(menu[0],menu[1],"Stop here?")
	
		for (var i = 0; i < array_length(yes_no); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+1), yes_no[i], color, color, color, color, 1)
		}
	break;

	case "shop_buy":
	
		menu = menu_draw(2,2,string_width("Buy shop?")+10,41)
		draw_text(menu[0],menu[1],"Buy shop?")
	
		for (var i = 0; i < array_length(yes_no); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+1), yes_no[i], color, color, color, color, 1)
		}
	break;
	
	case "shop_invest_2":
		menu = menu_draw(2,2,string_width("7")+29,17)
		
		for (var i = 0; i < array_length(current_number); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0]+8*i, menu[1], current_number[i], color, color, color, color, 1)
		}
	break;
	
	case "shop_self":
		
		menu = menu_draw(2,2,string_width("Spruce up?")+10, 41)
		draw_text(menu[0],menu[1],"Spruce up?")
		
		for (var i = 0; i < array_length(yes_no); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+1), yes_no[i], color, color, color, color, 1)
		}
		
	break;
	
	case "stocks_ask":
	
		menu = menu_draw(2,2,string_width("Buy stocks?")+10,41)
		draw_text(menu[0],menu[1],"Buy stocks?")
	
		for (var i = 0; i < array_length(yes_no); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0], menu[1]+12*(i+1), yes_no[i], color, color, color, color, 1)
		}
	break;
	
	case "stocks_buy_2":
	
		menu = menu_draw(2,2,string_width("7")+29,17)
		
		for (var i = 0; i < array_length(current_number); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
			draw_text_color(menu[0]+8*i, menu[1], current_number[i], color, color, color, color, 1)
		}
	break;
	
	case "stocks_sell_2":
	
		menu = menu_draw(2,2,string_width("7")+29,17)
		
		for (var i = 0; i < array_length(current_number); i++) {
			var color = c_white
			if i == pointer {
				color = c_yellow
			}
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

if toggle == 1 {
	var player = array_length(obj_game.players)
	var pos = 0
	
	do {
		player -= 1
		stats_draw(obj_game.players[player],pos)
		pos += 1
	}
	until player = 0
}