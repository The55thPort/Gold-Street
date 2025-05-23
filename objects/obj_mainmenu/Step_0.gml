if theme != -1 {
	
	switch state {
		
		case "main_menu":
			bg.current_animation = main.background
			obj_audio.song_current = main.music
			
			var connection = -1
			
			if keyboard_check_pressed(global.key_up) {connection = 0}
			if keyboard_check_pressed(global.key_left) {connection = 1}
			if keyboard_check_pressed(global.key_down) {connection = 2}
			if keyboard_check_pressed(global.key_right) {connection = 3}
			if keyboard_check_pressed(global.key_select) {
				if main_menu[pointer] == "Play" {state = "select_board"}
				if main_menu[pointer] == "Create" {state = "select_create"}
				if main_menu[pointer] == "Settings" {state = "settings"}
				if main_menu[pointer] == "Leave" {state = "confirm_leave"}
				if main_menu[pointer] == "Hosts" {state = "select_host"}
			}
			
			if connection = -1 {break;}
			
			if main_menu[pointer] == "Play" {
				if main.play[0,connection] != -1 {
					pointer = array_get_index(main_menu,main.play[0,connection])
				}
			}
			else if main_menu[pointer] == "Create" {
				if main.create[0,connection] != -1 {
					pointer = array_get_index(main_menu,main.create[0,connection])
				}
			}
			else if main_menu[pointer] == "Settings" {
				if main.settings[0,connection] != -1 {
					pointer = array_get_index(main_menu,main.settings[0,connection])
				}
			}
			else if main_menu[pointer] == "Leave" {
				if main.leave[0,connection] != -1 {
					pointer = array_get_index(main_menu,main.leave[0,connection])
				}
			}
			else if main_menu[pointer] == "Hosts" {
				if main.hosts[0,connection] != -1 {
					pointer = array_get_index(main_menu,main.hosts[0,connection])
				}
			}
		break;
		
		case "welcome":
			bg.current_animation = welcome.background
			obj_audio.song_current = welcome.music
			
			if keyboard_check_pressed(global.key_select) {
				effect = "fade_out"
			}
			
			if timer == timer_ref {
				timer = 0
				state = "main_menu"
				effect = "fade_in"
			}
		break;
		
	}
	
	
	
	switch effect {
		
		case "fade_in":
			if timer != timer_ref {timer++}
		break;
		
		case "fade_out":
			if timer != timer_ref {timer++}
		break;
		
	}
	
}

else {

	switch state {
	
		case "select_board":
			if boards != [  ] {
				if keyboard_check_pressed(global.key_up) {
					pointer = loop(pointer,-1,boards)
				}
		
				if keyboard_check_pressed(global.key_down) {
					pointer = loop(pointer,1,boards)
				}
		
				if keyboard_check_pressed(global.key_select) {
					global.board_name = boards[pointer]
					pointer = 0
					state = "select_save"
				}
			}
		break;
	
		case "select_save":
			if keyboard_check_pressed(global.key_up) {
				pointer = loop(pointer,-1,files)
			}

			if keyboard_check_pressed(global.key_down) {
				pointer = loop(pointer,1,files)
			}
	
			if keyboard_check_pressed(global.key_back) {
				pointer = 0
				state = "select_board"
			}

			if keyboard_check_pressed(global.key_select) {
				if files[pointer] = "New Game" {
					obj_persistent.file_selected = "New Game"
				}
				else if files[pointer] = "Autosave" {
					obj_persistent.file_selected = "autosave.txt"
				}
				else if files[pointer] = "File 1" {
					obj_persistent.file_selected = "save1.txt"
				}
				else if files[pointer] = "File 2" {
					obj_persistent.file_selected = "save2.txt"
				}
				else if files[pointer] = "File 3" {
					obj_persistent.file_selected = "save3.txt"
				}
				pointer = 0
				room_goto(rm_game)
			}
		break;
	}
	
}