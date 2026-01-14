function move_arrayed_cursor(menu_option){
	if key_pressed(global.key_up) {
		pointer = loop(pointer, -1, menu_option)
	}
		
	if key_pressed(global.key_down) {
		pointer = loop(pointer, 1, menu_option)
	}
}

function move_numeric_cursor(up_key, down_key, menu_variable, maximum){
	if(key_pressed(up_key)){menu_variable--}
	if(key_pressed( down_key)){menu_variable++}
	if(menu_variable>maximum){menu_variable = maximum}
	if(menu_variable<0){menu_variable = 0}
	return menu_variable
}

function reset_option(menu_option){
	if key_pressed(global.key_select) {
		selected = menu_option[pointer]
		pointer = 0
		readyflag = true
	}
}

function array_find_string(_array, _string) {
    for (var i = 0; i < array_length(_array); i++) {
        if (_array[i] == _string) {
            return i;
        }
    }
    return -1;
}

function previous_state(){
	if key_pressed(global.key_back) {
		selected = noone
		pointer = 0
		page = 0
		readyflag = true
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

//substates are allowed, but only if there's more than 3. Keep that in mind.

switch global.state {
	
	case "district_select":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//load districts to display
		districts_display = [  ]
		repeat (4) {
			if page*4+i <= array_length(districts) - 1 {
				array_copy(districts_display,0+i,districts,page*4+i,1)
			}
			else array_push(districts_display,"--")
			i++
		}
		
		//menu controls
		if key_pressed(global.key_up) {
			pointer_temp = loop(pointer_temp, -1, districts_display)
			if districts_display[pointer_temp] == "--" {
				do {pointer_temp--} until districts_display[pointer_temp] != "--"
			}
			pointer = pointer_temp
		}
		
		if key_pressed(global.key_down) {
			pointer_temp = loop(pointer_temp, 1, districts_display)
			if districts_display[pointer_temp] == "--" {
				pointer_temp = 0
			}
			pointer = pointer_temp
		}
		
		if key_pressed(global.key_left) {
			if (page-1)*4 >= 0 {
				page--
				pointer = 0
			}
		}
		
		if key_pressed(global.key_right) {
			if (page+1)*4 <= array_length(districts) - 1 {
				page++
				pointer = 0
			}
		}
		
		if key_pressed(global.key_select) {
			selected = district_name_convert(districts_display[pointer])
			pointer = 0
			page = 0
			readyflag = true
		}
		
		previous_state();
		
	break;
	
	case "game_save":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(choose_file)
		
		reset_option(choose_file)
		
		previous_state();
	break;
	
	case "manage_shops"://this state is unfinished and abandoned for now
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(manage_shops)
		
		reset_option(manage_shops)
		
		previous_state();
	break;
	
	case "manage_auction":
		obj_audio.state_sfx = "menu_open"
		
		switch(global.substate){
			case 1:
				move_arrayed_cursor(yes_no)
				if key_pressed(global.key_select) {
					selected = yes_no[pointer]
					pointer = 0
					readyflag = true
				}
			break;
		}
		
		previous_state();// maybe not need this
	break;
	
	//buy and sell are unfinished
	case "manage_buy":
		obj_audio.state_sfx = "menu_open"
		

		switch(global.substate){
			case 1:
			break;
		}
	break;
	
	case "manage_sell":
		obj_audio.state_sfx = "menu_open"
		
		move_arrayed_cursor(manage_shops)
		
		reset_option(manage_shops)
		
		if key_pressed(global.key_back) {
			selected = noone
			pointer = 0
			readyflag = true
		}
	break;
	
	case "manage_trade":
		obj_audio.state_sfx = "menu_open"
		
		switch(global.substate){
			case 0:
				move_arrayed_cursor(trade_shops)
				if key_pressed(global.key_select) {
					selected = trade_shops[pointer]
					pointer = 0
					readyflag = true
				}
				previous_state()
				break;
			case 1:
				move_arrayed_cursor(trade_shops)
				if key_pressed(global.key_select) {
					selected = trade_shops[pointer]
					pointer = 0
					readyflag = true
				}
				previous_state()
				break;
			case 2: 
				
				break;
		}
	break;
	
	case "pause":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		if(!controls_flag){move_arrayed_cursor(pause_menu)}
		
		switch(pointer){
			case 0:
				obj_audio.music_volume= move_numeric_cursor(global.key_left, global.key_right, obj_audio.music_volume, 5)
				break;
			case 1:
				obj_audio.sfx_volume = move_numeric_cursor(global.key_left, global.key_right, obj_audio.sfx_volume, 5)
				break;
			case 2:
				
				if(key_pressed(global.key_down) || key_pressed(global.key_up)){
					page = (obj_player_parent.move_length/10)-1
				}
				page = move_numeric_cursor(global.key_left, global.key_right,page, 2)
				
				player_speed = game_speeds[page]
				obj_player_parent.move_length = (page+1)*10
				break;
			case 3:
				if(key_pressed(global.key_down) || key_pressed(global.key_up)){
					page = array_find_string(player_chats, global.player_chat)
				}
				page = move_numeric_cursor(global.key_left, global.key_right,page, 2)
				global.player_chat = player_chats[page]
				break;
			case 4:
				if(key_pressed(global.key_down) || key_pressed(global.key_up)){
					page = menu_toggle
				}
				menu_toggle = move_numeric_cursor(global.key_left, global.key_right,menu_toggle, 2)
				break;
			case 5:
				if (waiting_for_key) {
					var found_key = 0
					for (var k = 0; k < 256; k++) {
						if (keyboard_check_pressed(k)) { //if anyone can find a solution that doesn't involve this loop let me know
						    // Ignore mouse buttons and menu keys
						    if (k != 1 && k != 2 && k != 4 && k != global.key_select && k != global.key_back &&
						        k != global.key_up && k != global.key_down && k != global.key_left && k != global.key_right) {
						        found_key = k;
						        break;
						    }
						}
					}
			        if (found_key != 0) {
						if(controls_pointer == 0){global.key_up = found_key}// this is horribly inefficient but I can't think of a better way to do this
						else if(controls_pointer == 1){global.key_down = found_key}
						else if(controls_pointer == 2){global.key_left = found_key}
						else if(controls_pointer == 3){global.key_right = found_key}
						else if(controls_pointer == 4){global.key_select = found_key}
						else if(controls_pointer == 5){global.key_back = found_key}
						else if(controls_pointer == 6){global.key_pause = found_key}
						else if(controls_pointer == 7){global.key_view = found_key}
						else if(controls_pointer == 8){global.key_shift = found_key}
						game_controls[controls_pointer] = found_key
			            waiting_for_key = false;
			        }
					exit
			    }
				if(controls_flag && !waiting_for_key){
					controls_pointer = move_numeric_cursor(global.key_up, global.key_down, controls_pointer, array_length(controls_ui)-1)
					if(key_pressed(global.key_select)){ waiting_for_key = true}
				}
				if(key_pressed(global.key_select)){ controls_flag = true}
				
				if(key_pressed(global.key_back)){
					controls_flag = false
					controls_pointer = 0
				}
				break;
			case 9:
				if(key_pressed(global.key_select)){game_end()}
		}
	break;
	
	case "player_action":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(player_action)
		
		reset_option(player_action)
		
		if key_pressed(global.key_back) {
			selected = -1
			pointer = 0
			readyflag = true
		}
	break;
	
	case "player_poor":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(player_poor)
		
		reset_option(player_poor)
	break;
	
	case "player_shopless":
	obj_audio.state_sfx = "menu_open"
	reset_option(manage_shops)
	break;
	
	case "player_stop":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(yes_no)
		
		reset_option(yes_no)
	break;
	
	case "select_square_on_board":
		if key_pressed(global.key_back) { //duct tape code
			selected = noone
		}
	break;
	
	case "shop_buy":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(yes_no)
		
		reset_option(yes_no)
	break;
	
	case "shop_invest_2":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls - raise number
		if key_pressed(global.key_up) {
			current_number[pointer] = loop(current_number[pointer],1,numbers)
		}
		
		//menu controls - raise digit
		if key_pressed(global.key_left) {
			pointer--
			pointer = clamp(pointer,0,2)
		}
		
		//menu controls - lower number
		if key_pressed(global.key_down) {
			current_number[pointer] = loop(current_number[pointer],-1,numbers)
		}
		
		//menu controls - lower digit
		if key_pressed(global.key_right) {
			pointer++
			pointer = clamp(pointer,0,2)
		}
		
		//menu controls - confirm
		if key_pressed(global.key_select) {
			selected = current_number[0]*100 + current_number[1]*10 + current_number[2]
			if selected > obj_game.selected.properties.capital_max - obj_game.selected.properties.capital {
				exit;
			}
			current_number = [0,0,0]
			pointer = 0
			readyflag = true
		}
		
		//menu controls - return
		if key_pressed(global.key_back) {
			pointer = 3
			current_number = [0,0,0]
			readyflag = true
		}
	break;
	
	case "shop_self":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(yes_no)
		
		reset_option(yes_no)
	break;
	
	case "stocks_ask":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls
		move_arrayed_cursor(yes_no)
		
		reset_option(yes_no)
	break;
	
	case "stocks_buy_2":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls - raise number
		if key_pressed(global.key_up) {
			current_number[pointer] = loop(current_number[pointer],1,numbers)
		}
		
		//menu controls - raise digit
		if key_pressed(global.key_left) {
			pointer--
			pointer = clamp(pointer,1,2)
		}
		
		//menu controls - lower number
		if key_pressed(global.key_down) {
			current_number[pointer] = loop(current_number[pointer],-1,numbers)
		}
		
		//menu controls - lower digit
		if key_pressed(global.key_right) {
			pointer++
			pointer = clamp(pointer,1,2)
		}
		
		//menu controls - confirm
		if key_pressed(global.key_select) {
			selected = current_number[0]*100 + current_number[1]*10 + current_number[2]
			if selected > floor(global.player.readycash / global.stock_prices[obj_game.selected]) {
				exit;
			}
			current_number = [0,0,0]
			pointer = 0
			readyflag = true
		}
		
		//menu controls - return
		if key_pressed(global.key_back) {
			pointer = 3
			current_number = [0,0,0]
			readyflag = true
		}
	break;
	
	case "stocks_sell_2":
		//play sound effect
		obj_audio.state_sfx = "menu_open"
		
		//menu controls - raise number
		if key_pressed(global.key_up) {
			current_number[pointer] = loop(current_number[pointer],1,numbers)
		}
		
		//menu controls - raise digit
		if key_pressed(global.key_left) {
			pointer--
			pointer = clamp(pointer,0,2)
		}
		
		//menu controls - lower number
		if key_pressed(global.key_down) {
			current_number[pointer] = loop(current_number[pointer],-1,numbers)
		}
		
		//menu controls - lower digit
		if key_pressed(global.key_right) {
			pointer++
			pointer = clamp(pointer,0,2)
		}
		
		//menu controls - confirm
		if key_pressed(global.key_select) {
			selected = current_number[0]*100 + current_number[1]*10 + current_number[2]
			if selected > global.player.stocks[obj_game.selected] {
				exit;
			}
			current_number = [0,0,0]
			pointer = 0
			readyflag = true
		}
		
		//menu controls - return
		if key_pressed(global.key_back) {
			pointer = 3
			current_number = [0,0,0]
			readyflag = true
		}
	break;
	
	case "turn_end":
		//load start of transition effect (if player not poor)
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
		//load end of transition effect
		anim_timer_ref = 30
		anim_timer++
		if anim_timer == anim_timer_ref {
			anim_timer = 1
			anim_timer_ref = 11
			readyflag = true
		}
	break;
	
	case "venture_execute":
		if key_pressed(global.key_select) {readyflag = true}
	break;
	
}

