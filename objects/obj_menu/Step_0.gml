if keyboard_check_pressed(global.key_menu) {
	toggle += 1
	if toggle > 2 {
		toggle = 0
	}
}

var pointer_temp = pointer
var i = 0

if array_length(districts) == 0 {
	repeat (array_length(global.shops_in_district)) {
		if array_length(global.shops_in_district[i]) != 0 {
			array_push(districts,district_name_convert(i))
		}
		i++
	}
	i = 0
}

switch global.state {
	
	case "district_select":
		obj_audio.state_sfx = "menu_open"
		
		districts_display = [  ]
		repeat (4) {
			if page*4+i <= array_length(districts) - 1 {
				array_copy(districts_display,0+i,districts,page*4+i,1)
			}
			else array_push(districts_display,"--")
			i++
		}
		
		if array_length(districts_display)
		if keyboard_check_pressed(global.key_up) {
			pointer_temp = loop(pointer_temp, -1, districts_display)
			if districts_display[pointer_temp] == "--" {
				do {pointer_temp--} until districts_display[pointer_temp] != "--"
			}
			pointer = pointer_temp
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer_temp = loop(pointer_temp, 1, districts_display)
			if districts_display[pointer_temp] == "--" {
				pointer_temp = 0
			}
			pointer = pointer_temp
		}
		
		if keyboard_check_pressed(global.key_left) {
			if (page-1)*4 >= 0 {
				page--
				pointer = 0
			}
		}
		
		if keyboard_check_pressed(global.key_right) {
			if (page+1)*4 <= array_length(districts) - 1 {
				page++
				pointer = 0
			}
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = district_name_convert(districts_display[pointer])
			pointer = 0
			page = 0
			readyflag = true
		}
		
		if keyboard_check_pressed(global.key_back) {
			selected = noone
			pointer = 0
			page = 0
			readyflag = true
		}
		
	break;
	
	case "game_save":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, choose_file)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, choose_file)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = choose_file[pointer]
			pointer = 0
			readyflag = true
		}
		
		if keyboard_check_pressed(global.key_back) {
			selected = noone
			pointer = 0
			readyflag = true
		}
	break;
	
	case "player_action":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, player_action)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, player_action)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = player_action[pointer]
			pointer = 0
			readyflag = true
		}
		
		if keyboard_check_pressed(global.key_back) {
			selected = -1
			pointer = 0
			readyflag = true
		}
	break;
	
	case "player_poor":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, player_poor)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, player_poor)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = player_poor[pointer]
			pointer = 0
			readyflag = true
		}
	break;
	
	case "player_stop":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = yes_no[pointer]
			pointer = 0
			readyflag = true
		}
	break;
	
	case "shop_buy":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = yes_no[pointer]
			pointer = 0
			readyflag = true
		}
	break;
	
	case "shop_invest_2":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			current_number[pointer] = loop(current_number[pointer],1,numbers)
		}
		
		if keyboard_check_pressed(global.key_left) {
			pointer--
			pointer = clamp(pointer,0,2)
		}
		
		if keyboard_check_pressed(global.key_down) {
			current_number[pointer] = loop(current_number[pointer],-1,numbers)
		}
		
		if keyboard_check_pressed(global.key_right) {
			pointer++
			pointer = clamp(pointer,0,2)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = current_number[0]*100 + current_number[1]*10 + current_number[2]
			if selected > obj_game.selected.properties.capital_max - obj_game.selected.properties.capital {
				exit;
			}
			current_number = [0,0,0]
			pointer = 0
			readyflag = true
		}
		
		if keyboard_check_pressed(global.key_back) {
			pointer = 3
			current_number = [0,0,0]
			readyflag = true
		}
	break;
	
	case "shop_self":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = yes_no[pointer]
			pointer = 0
			readyflag = true
		}
	break;
	
	case "stocks_ask":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			pointer = loop(pointer, -1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_down) {
			pointer = loop(pointer, 1, yes_no)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = yes_no[pointer]
			pointer = 0
			readyflag = true
		}
	break;
	
	case "stocks_buy_2":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			current_number[pointer] = loop(current_number[pointer],1,numbers)
		}
		
		if keyboard_check_pressed(global.key_left) {
			pointer--
			pointer = clamp(pointer,1,2)
		}
		
		if keyboard_check_pressed(global.key_down) {
			current_number[pointer] = loop(current_number[pointer],-1,numbers)
		}
		
		if keyboard_check_pressed(global.key_right) {
			pointer++
			pointer = clamp(pointer,1,2)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = current_number[0]*100 + current_number[1]*10 + current_number[2]
			if selected > floor(global.player.readycash / global.stock_prices[obj_game.selected]) {
				exit;
			}
			current_number = [0,0,0]
			pointer = 0
			readyflag = true
		}
		
		if keyboard_check_pressed(global.key_back) {
			pointer = 3
			current_number = [0,0,0]
			readyflag = true
		}
	break;
	
	case "stocks_sell_2":
		obj_audio.state_sfx = "menu_open"
		
		if keyboard_check_pressed(global.key_up) {
			current_number[pointer] = loop(current_number[pointer],1,numbers)
		}
		
		if keyboard_check_pressed(global.key_left) {
			pointer--
			pointer = clamp(pointer,0,2)
		}
		
		if keyboard_check_pressed(global.key_down) {
			current_number[pointer] = loop(current_number[pointer],-1,numbers)
		}
		
		if keyboard_check_pressed(global.key_right) {
			pointer++
			pointer = clamp(pointer,0,2)
		}
		
		if keyboard_check_pressed(global.key_select) {
			selected = current_number[0]*100 + current_number[1]*10 + current_number[2]
			if selected > global.player.stocks[obj_game.selected] {
				exit;
			}
			current_number = [0,0,0]
			pointer = 0
			readyflag = true
		}
		
		if keyboard_check_pressed(global.key_back) {
			pointer = 3
			current_number = [0,0,0]
			readyflag = true
		}
	break;
	
	case "turn_end":
		if global.player.readycash >= 0 {
			anim_timer_ref = 30
			anim_timer++
			if anim_timer == anim_timer_ref {
				anim_timer = 1
				anim_timer_ref = 11
				readyflag = true
			}
		}
	break;
	
	case "turn_start":
		anim_timer_ref = 30
		anim_timer++
		if anim_timer == anim_timer_ref {
			anim_timer = 1
			anim_timer_ref = 11
			readyflag = true
		}
	break;
	
}