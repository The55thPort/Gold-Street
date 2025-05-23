global.player = array_get(players, current_player)

var number = 0

switch global.state {
	
	case "arcade_payout":
		global.player.depth -= 1
		global.player.image_alpha = 1
		obj_persistent.arcade_winner.readycash += obj_persistent.arcade_payout
		global.state = "turn_end"
	break;
	
	case "arcade_setup":
		SaveGame("minigame.txt")
		room_goto(rm_pachinko)
	break;
	
	case "board_select":
		if obj_camera.readyflag = true {
			obj_camera.readyflag = false
			if obj_camera.selected != noone {
				selected = obj_camera.selected
				global.state = state_stored_next
			}
			else global.state = state_stored_prev
		}
	break;
	
	case "board_view":
		if obj_camera.readyflag == true {
			obj_camera.readyflag = false
			global.state = "player_action"
		}
	break;
	
	case "dice_roll":
		if obj_dice.readyflag == true {
			obj_dice.readyflag = false
			if obj_dice.diceroll = -1 {
				state_stored_next = "player_action"
				timer = 1
				global.state = "wait"
			}
			else {
				global.player.spaces_to_move = obj_dice.diceroll
				global.state = "player_move"
			}
		}
	break;
	
	case "district_select":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == noone {
				global.state = state_stored_prev
			}
			else {
				selected = obj_menu.selected
				global.state = state_stored_next
			}
		}
	break;
	
	case "game_load":
		LoadGame(obj_persistent.file_selected)
		if obj_persistent.file_selected != "New Game" {
			var i = 0
			repeat (array_length(players)) {
				players[i].readycash_display = players[i].readycash
				players[i].net_worth_display = players[i].net_worth
				i++
			}
		}
		if obj_persistent.file_selected == "minigame.txt" {
			global.state = "arcade_payout"
			file_delete("Boards/" + global.board_name + "/Saves/minigame.txt")
		}
		else {
			global.state = "turn_start"
		}
	break;
	
	case "game_save":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "File 1" {SaveGame("save1.txt")}
			if obj_menu.selected == "File 2" {SaveGame("save2.txt")}
			if obj_menu.selected == "File 3" {SaveGame("save3.txt")}
			global.state = "player_action"
			
		}
	break;
	
	case "player_action":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "Roll" {
				global.state = "dice_roll"
			}
			
			if obj_menu.selected == "View Board" {
				global.state = "board_view"
			}
			
			if obj_menu.selected == "Save" {
				global.state = "game_save"
			}
			
			if obj_menu.selected = -1 {
				room_goto(rm_mainmenu)
			}
		}
	break;
	
	case "player_move":
		if global.board[global.player.current_position].properties.type == "bank" && global.player.x == global.board[global.player.current_position].x + 8 && global.player.y == global.board[global.player.current_position].y + 8 {
			if global.player.net_worth >= global.target_amount {
				if global.player.readyflag == true {global.player.readyflag = false}
				global.state = "player_victory"
			}
			else if global.player.promotion == true {
				global.state = "player_promotion"
			}
			else if global.board[global.player.current_position].properties.stocks_ask = true && array_length(global.player.current_path) != 0 {
				state_stored_next_2 = "player_move"
				global.state = "stocks_ask"
			}
		}
		
		if global.player.readyflag == true && global.state != "player_promotion" && global.state != "player_victory" && global.state != "stocks_ask" {
			global.player.readyflag = false
			global.state = "player_stop"
		}
	break;
	
	case "player_poor":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			if obj_menu.selected = "Sell Stocks" {
				state_stored_prev = "player_poor"
				state_stored_prev_2 = "player_poor"
				state_stored_next = "stocks_sell_1"
				state_stored_next_2 = "turn_end"
				global.state = "district_select"
			}
			
			if obj_menu.selected = "Sell Shop" {
				state_stored_prev = "player_poor"
				state_stored_next = "shop_sell"
				obj_camera.selecting = "shop"
				obj_camera.selecting_sub = global.player
				global.state = "board_select"
			}
		}
	break;
	
	case "player_promotion":
		log("You got a promotion!")
		global.player.suits = [ 0,0,0,0 ]
		var divider = 10
		if array_length(players) >= 5 {divider = 5}
		global.player.readycash += global.salary_base + (global.salary_increment * global.player.level) + floor(global.player.shops_value / divider)
		global.player.level++
		if global.player.net_worth + global.salary_base + (global.salary_increment * (global.player.level - 1)) + floor(global.player.shops_value / divider) >= global.target_amount {
			global.state = "player_victory"
		}
		else {
			state_stored_next_2 = "player_move"
			global.state = "stocks_ask"
		}
	break;
	
	case "player_stop":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "Yes" {
				global.player.previous_position = array_last(global.player.current_path)
				global.player.current_path = [  ]
				global.player.suits[0] = bool(global.player.suits[0])
				global.player.suits[1] = bool(global.player.suits[1])
				global.player.suits[2] = bool(global.player.suits[2])
				global.player.suits[3] = bool(global.player.suits[3])
				state_stored_next = "space_execute"
				timer = 30
				global.state = "wait"
			}
			else {
				UndoPlayerAction()
			}
		}
	break;
	
	case "player_victory":
		
	break;
	
	case "shop_buy":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "Yes" {
				global.board[global.player.current_position].properties.owner = global.player
				array_push(global.player.shops,global.board[global.player.current_position])
				global.player.readycash -= global.board[global.player.current_position].properties.value
			}
			state_stored_next = "turn_end"
			timer = 120
			global.state = "wait"
		}
	break;
	
	case "shop_invest_1":
		if selected.properties.capital_max - selected.properties.capital < 1000 {
			var pos = string_length(string(selected.properties.capital_max - selected.properties.capital))
			var pos2 = 2
			repeat (pos) {
				var digit = real(string_char_at(string(selected.properties.capital_max - selected.properties.capital),pos))
				obj_menu.current_number[pos2] = digit
				pos -= 1
				pos2 -= 1
			}
		}
		else obj_menu.current_number = [9,9,9]
		
		global.state = "shop_invest_2"
	break;
	
	case "shop_invest_2":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			if obj_menu.pointer != 3 {
				selected.properties.capital += obj_menu.selected
				global.player.readycash -= obj_menu.selected
				state_stored_next = "turn_end"
				timer = 120
				global.state = "wait"
			}
			else {
				obj_menu.pointer = 0
				state_stored_prev = "shop_self"
				state_stored_next = "shop_invest_1"
				obj_camera.selecting = "shop"
				obj_camera.selecting_sub = global.player
				global.state = "board_select"
			}
		}
	break;
	
	case "shop_pay":
		global.player.readycash -= global.board[global.player.current_position].properties.price
		global.board[global.player.current_position].properties.owner.readycash += global.board[global.player.current_position].properties.price
		
		var district = global.board[global.player.current_position].properties.district_number
		var player = 0
		var total_shares = 0
		repeat (array_length(obj_game.players)) {
			total_shares += obj_game.players[player].stocks[district]
			player++
		}
		if total_shares != 0 {
			player = 0
			var solo_shares = 0
			var mult = 1
			if total_shares < 5 {mult = total_shares / 5}
			var total_dividend = floor((global.board[global.player.current_position].properties.price / 5) * mult)
			var solo_dividend = 0
		
			repeat (array_length(obj_game.players)) {
				solo_shares = obj_game.players[player].stocks[district]
				if solo_shares != 0 {
					solo_dividend = floor(total_dividend * solo_shares / total_shares)
					obj_game.players[player].readycash += solo_dividend
				}
				player++
			}
		}
			
		state_stored_next = "turn_end"
		timer = 120
		global.state = "wait"
	break;
	
	case "shop_self":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "Yes" {
				state_stored_prev = "shop_self"
				state_stored_next = "shop_invest_1"
				obj_camera.selecting = "shop"
				obj_camera.selecting_sub = global.player
				global.state = "board_select"
			}
			else global.state = "turn_end"
		}
	break;
	
	case "shop_sell":
		global.player.readycash += floor(selected.properties.value * 0.75)
		selected.properties.owner = noone
		array_delete(global.player.shops,array_get_index(global.player.shops,selected),1)
		selected.properties.capital = 0
		if state_stored_prev == "player_poor" {
			state_stored_next = "turn_end"
		}
		timer = 120
		global.state = "wait"
	break;
	
	case "space_execute":
	
		if global.board[global.player.current_position].properties.type == "arcade" {
			global.state = "arcade_setup"
		}
		
		else if global.board[global.player.current_position].properties.type == "bank" {
			global.player.previous_position = -1
			global.state = "turn_end"
		}
		
		else if global.board[global.player.current_position].properties.type == "shop" {
			if global.board[global.player.current_position].properties.owner == noone {
				global.state = "shop_buy"
			}
			else if global.board[global.player.current_position].properties.owner != global.player {
				global.state = "shop_pay"
			}
			else if global.board[global.player.current_position].properties.owner == global.player {
				global.state = "shop_self"
			}
		}
		
		else if global.board[global.player.current_position].properties.type == "venture" or global.board[global.player.current_position].properties.type == "suit" or global.board[global.player.current_position].properties.type == "suit-change" {
			global.state = "venture_execute"
		}
		
		else {
			state_stored_next = "turn_end"
			timer = 90
			global.state = "wait"
		}
	break;
	
	case "stocks_ask":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "Yes" {
				state_stored_next = "stocks_buy_1"
				state_stored_prev = "stocks_ask"
				global.state = "district_select"
			}
			else if obj_menu.selected == "No" {
				if global.board[global.player.current_position].properties.type == "bank" {
					array_push(global.board[global.player.current_position].properties.stocks_last,-1)
				}
				global.state = "player_move"
			}
			global.board[global.player.current_position].properties.stocks_ask = false
		}
	break;
	
	case "stocks_buy_1":
		number = floor(global.player.readycash / global.stock_prices[selected])
		if number < 100 {
			var pos = string_length(string(number))
			var pos2 = 2
			repeat (pos) {
				var digit = real(string_char_at(string(number),pos))
				obj_menu.current_number[pos2] = digit
				pos -= 1
				pos2 -= 1
			}
		}
		else obj_menu.current_number = [0,9,9]
		obj_menu.pointer = 1
		
		global.state = "stocks_buy_2"
	break;
	
	case "stocks_buy_2":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.pointer != 3 {
				global.player.stocks[selected] += obj_menu.selected
				global.player.readycash -= obj_menu.selected * global.stock_prices[selected]
				if global.board[global.player.current_position].properties.type == "bank" {
					array_push(global.board[global.player.current_position].properties.stocks_last,[selected,obj_menu.selected,obj_menu.selected * global.stock_prices[selected]])
					log(global.board[global.player.current_position].properties.stocks_last)
				}
				state_stored_next = state_stored_next_2
				timer = 120
				global.state = "wait"
			}
			else {
				obj_menu.pointer = 0
				state_stored_prev = "stocks_ask"
				state_stored_next = "stocks_buy_1"
				global.state = "district_select"
			}
		}
	break;
	
	case "stocks_sell_1":
		number = global.player.stocks[selected]
		if number < 1000 {
			var pos = string_length(string(number))
			var pos2 = 2
			repeat (pos) {
				var digit = real(string_char_at(string(number),pos))
				obj_menu.current_number[pos2] = digit
				pos -= 1
				pos2 -= 1
			}
		}
		else obj_menu.current_number = [9,9,9]
		
		global.state = "stocks_sell_2"
	break;
	
	case "stocks_sell_2":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.pointer != 3 {
				global.player.stocks[selected] -= obj_menu.selected
				global.player.readycash += obj_menu.selected * global.stock_prices[selected]
				state_stored_next = state_stored_next_2
				timer = 120
				global.state = "wait"
			}
			else {
				obj_menu.pointer = 0
				state_stored_prev = state_stored_prev_2
				state_stored_next = "stocks_sell_1"
				global.state = "district_select"
			}
		}
	break;
	
	case "turn_end":
		if global.player.readycash < 0 {
			global.state = "player_poor"
			exit;
		}
		
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			with obj_space {
				if properties.type == "bank" {
					properties.suits_last = [  ]
					properties.stocks_last = [  ]
				}
			}
			global.player.depth += 1
			global.player.image_alpha = 0.5
			current_player = loop(current_player,1,players)
			SaveGame("autosave.txt")
			global.state = "turn_start"
		}
	break;
	
	case "turn_start":
		if obj_menu.anim_timer == 2 {
			global.player.depth -= 1
			global.player.image_alpha = 1
		}
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			global.state = "player_action"
		}
	break;
	
	case "venture_execute":
		ExecuteVenture(irandom_range(1,16))
		if global.state == "venture_execute" {
			global.state = "turn_end"
		}
	break;
	
	case "wait":
		timer--
		if timer == 0 {
			global.state = state_stored_next
		}
	break;
	
}