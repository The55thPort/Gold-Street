draw_set_font(fnt_menu_main)

//Draw Custom Sprites for Theme (if one exists)
if theme != -1 {
	
	switch state {
		
		case "main_menu":
			if pointer == 0 {draw_sprite(play_selected,0,main.play[1],main.play[2])}
			else {draw_sprite(play_unselected,0,main.play[1],main.play[2])}
			
			if pointer == 1 {draw_sprite(create_selected,0,main.create[1],main.create[2])}
			else {draw_sprite(create_unselected,0,main.create[1],main.create[2])}
			
			if pointer == 2 {draw_sprite(settings_selected,0,main.settings[1],main.settings[2])}
			else {draw_sprite(settings_unselected,0,main.settings[1],main.settings[2])}
			
			if pointer == 3 {draw_sprite(leave_selected,0,main.leave[1],main.leave[2])}
			else {draw_sprite(leave_unselected,0,main.leave[1],main.leave[2])}
			
			if pointer == 4 {draw_sprite(hosts_selected,0,main.hosts[1],main.hosts[2])}
			else {draw_sprite(hosts_unselected,0,main.hosts[1],main.hosts[2])}
		break;
		
	}
	
}

//Draw Default Menu (if no theme)
else {

	switch state {
	
		case "select_board":
			if boards != [  ] {
				draw_set_font(fnt_menu_main)
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)

				for (var i = 0; i < array_length(boards); i++) {
					var col = c_white
					if i == pointer {
						col = c_yellow
					}
					draw_text_color(128,64+24*i,boards[i],col,col,col,col,1)
				}
			}
		break;
	
		case "select_save":
			draw_set_font(fnt_menu_main)
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)

			for (var i = 0; i < array_length(files); i++) {
				var col = c_white
				if i == pointer {
					col = c_yellow
				}
				draw_text_color(128,64+24*i,files[i],col,col,col,col,1)
			}
		break;
	
	}
	
}



switch effect {
	
	case "fade_in":
		draw_sprite_ext(spr_black,0,0,0,256,224,0,c_white,lerp(1,0,timer/timer_ref))
	break;
	
	case "fade_out":
		draw_sprite_ext(spr_black,0,0,0,256,224,0,c_white,lerp(0,1,timer/timer_ref))
	break;
	
}