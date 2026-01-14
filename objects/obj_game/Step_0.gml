global.player = array_get(players, current_player)

function sell_shop(){
	global.player.readycash += floor(selected.properties.value * 0.75)
	selected.properties.owner = noone
	array_delete(global.player.shops,array_get_index(global.player.shops,selected),1)
	selected.properties.capital = 0
}

function select_shop(prev_state){
	state_stored_prev = "manage_shops"
	state_stored_next = prev_state
	obj_camera.selecting = "shop"
	obj_camera.selecting_sub = global.player
	global.state = "select_square_on_board"
	obj_camera.sprite_index = spr_camera
}

var number = 0

switch global.state {
	
	//Arcade Logic
	
	case "arcade_payout":
		//give prizes to players when returning from arcade
		global.player.depth -= 1
		global.player.image_alpha = 1
		obj_persistent.arcade_winner.readycash += obj_persistent.arcade_payout
		global.state = "turn_end"
	break;
	
	case "arcade_setup":
		//save game to special file, then go to arcade room
		SaveGame("minigame.txt")
		room_goto(rm_pachinko)
	break;
	
	/////////////////////////////////////////////////////
	//Board Logic
	
	case "select_square_on_board":
		//this is just board_view but you select a square on the board to move on to the next state
		if obj_camera.readyflag = true {
			obj_camera.readyflag = false
			if obj_camera.selected != noone { // if there is something selected
				if(trade_counter > 0){ //checks if we are doing trading
					if(give_or_receive && ds_list_find_index(shops_to_give, obj_camera.selected) == -1){ // are we giving or receiving?
						log("give index: " + string(ds_list_find_index(shops_to_give, obj_camera.selected)))
						ds_list_add(shops_to_give, obj_camera.selected);
						trade_counter--;
					}
					else if(!give_or_receive && ds_list_find_index(shops_to_receive, obj_camera.selected) == -1){
						log("receive index: " + string(ds_list_find_index(shops_to_receive, obj_camera.selected)))
						ds_list_add(shops_to_receive, obj_camera.selected);
						trade_counter--;
					}
				}
				if(trade_counter <= 0){
					give_or_receive = false
					selected = obj_camera.selected
					global.state = state_stored_next // goes to whatever state was stored here, refer to the states that store it
				}
				log("trade counter: " + string(trade_counter))
			}
			else {
				log("previous state: " + string(state_stored_prev))
				global.state = state_stored_prev
				global.substate =0
				}
		}
	break;
	
	case "board_view":
		//views the board
		if obj_camera.readyflag == true {
			obj_camera.readyflag = false
			global.state = "player_action" 
		}
	break;
	
	/////////////////////////////////////////////////////
	//Dice Logic
	
	case "dice_roll":
		//pass the dice roll to the current player
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
	
	/////////////////////////////////////////////////////
	//District Logic
	
	case "district_select":
		//move to next state after selecting district
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
	
	/////////////////////////////////////////////////////
	//Game Logic
	
	case "game_load":
		//load selected file
		LoadGame(obj_persistent.file_selected)
		if obj_persistent.file_selected != "New Game" {
			var i = 0
			repeat (array_length(players)) {
				players[i].readycash_display = players[i].readycash
				players[i].net_worth_display = players[i].net_worth
				i++
			}
		}
		//if selected file was minigame.txt, switch state to "arcade_payout"
		if obj_persistent.file_selected == "minigame.txt" {
			global.state = "arcade_payout"
			file_delete("Boards/" + global.board_name + "/Saves/minigame.txt")
		}
		else {
			global.state = "turn_start"
		}
	break;
	
	case "game_save":
		//save game to file
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			if obj_menu.selected == "File 1" {SaveGame("save1.txt")}
			if obj_menu.selected == "File 2" {SaveGame("save2.txt")}
			if obj_menu.selected == "File 3" {SaveGame("save3.txt")}
			global.state = "player_action"
		}
	break;
	
	/////////////////////////////////////////////////////
	//Shop Management
	
	case "manage_shops":
	
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			global.state = "player_action"
			}
			
		if obj_menu.selected == "Auction"{
			if (array_length(global.player.shops) > 0) {global.state = "manage_auction"}
			else{global.state = "player_shopless"}
			}
		else if obj_menu.selected == "Buy Shop"{
			if (array_length(global.player.shops) > 0) {global.state = "manage_buy"}// this should actually check if nobody else has a shop
			//but we'll get to that eventually
			else{global.state = "player_shopless"}
			}
		else if obj_menu.selected == "Sell Shop"{
			if (array_length(global.player.shops) > 0) {global.state = "manage_sell"} 
			else{global.state = "player_shopless"}
		}
		else if obj_menu.selected == "Trade Shop"{
			if (array_length(global.player.shops) > 0) {global.state = "manage_trade"}
			else{global.state = "player_shopless"}
		}
	
		break;
	
	case "manage_auction":
		switch (global.substate){
			case 0:
				select_shop("manage_auction")
				global.substate = 1
				log("new state:" + global.state)
	
				if obj_menu.selected == noone {global.state = "player_action"}
				break;
			case 1:
				if obj_menu.readyflag == true {
					obj_menu.readyflag = false;
					if obj_menu.selected == "Yes" {
						sell_shop();
						global.substate++;
					}else{global.substate--;}
				}
				break;
		}
	break;
	
	case "manage_buy":
		switch (global.substate){
			case 0:
				select_shop("manage_buy")
				global.substate = 1
				log("new state:" + global.state)
	
				if obj_menu.selected == noone {global.state = "player_action"}
				break;
			case 1:
				if obj_menu.readyflag == true {
					obj_menu.readyflag = false;
					
				}
				break;
		}
	break;
	
	case "manage_sell":
		switch (global.substate){
			case 0:
				select_shop("manage_sell")
				global.substate = 1
				log("new state:" + global.state)
	
				if obj_menu.selected == noone {global.state = "player_action"}
				break;
			case 1:
				if obj_menu.readyflag == true {
					obj_menu.readyflag = false;

				}
				break;
		}
	break;
	
	case "manage_trade":
		switch(global.substate){
			case 0:
				if obj_menu.readyflag == true {
					obj_menu.readyflag = false
					global.state = "player_action"
					if(obj_menu.selected != noone){
						if obj_menu.selected == "Two Shops" {trade_counter = 2}
						else if obj_menu.selected == "One Shop"{trade_counter = 1}
						select_shop("manage_trade")
						global.substate++;
					}
				}
				break;
			case 1:
				if obj_menu.readyflag == true {
					obj_menu.readyflag = false
					global.state = "player_action"
					if(obj_menu.selected != noone){
						if obj_menu.selected == "Two Shops" {trade_counter = 2}
						else if obj_menu.selected == "One Shop"{trade_counter = 1}
						select_shop("manage_trade")
						global.substate++;
					}
				}
				break;
			case 2:
				trade_counter = 0;
				break;
		}
		
	break;
	
	/////////////////////////////////////////////////////
	//Player Logic
	
	case "player_action":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			//at start of turn, change state depending on player action
			if obj_menu.selected == "Roll" {global.state = "dice_roll"}
			else if obj_menu.selected == "View Board" {
				state_stored_prev_2 = "player_action"
				global.state = "board_view"
				}
			else if obj_menu.selected == "Manage Shops" {global.state = "manage_shops"}
			else if obj_menu.selected == "Save" {global.state = "game_save"}
			
			if obj_menu.selected = -1 {room_goto(rm_mainmenu)}
		}
	break;
	
	
	case "player_move":
		//if player reaches bank...
		if global.board[global.player.current_position].properties.type == "bank" && global.player.x == global.board[global.player.current_position].x + 8 && global.player.y == global.board[global.player.current_position].y + 8 {
			//...with target amount, declare them a winner
			if global.player.net_worth >= global.target_amount {
				if global.player.readyflag == true {global.player.readyflag = false}
				global.state = "player_victory"
			}
			//...with all suits, promote them
			else if global.player.promotion == true {
				global.state = "player_promotion"
			}
			//...moving forward on their path, ask about stocks.
			else if global.board[global.player.current_position].properties.stocks_ask = true && array_length(global.player.current_path) != 0 {
				state_stored_next_2 = "player_move"
				global.state = "stocks_ask"
			}
		}
		
		//bandaid code, prevents a common glitch when you land directly on the bank
		if global.player.readyflag == true && global.state != "player_promotion" && global.state != "player_victory" && global.state != "stocks_ask" {
			global.player.readyflag = false
			global.state = "player_stop"
		}
	break;
	
	case "player_poor":
		//if player is too poor, change state depending on player action
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
				global.state = "select_square_on_board"
			}
		}
	break;
	
	case "player_promotion":
		//promote player
		log("You got a promotion!") //record to output
		global.player.suits = [ 0,0,0,0 ] //remove player suits
		var divider = 10 //used in the regular salary calculations
		if array_length(players) >= 5 {divider = 5} //increases salary if 5+ players on board, allows faster growth.
		global.player.readycash += global.salary_base + (global.salary_increment * global.player.level) + floor(global.player.shops_value / divider) //give player their salary
		global.player.level++ //increase player level
		//if new net worth is over target amount, declare player victory
		if global.player.net_worth + global.salary_base + (global.salary_increment * (global.player.level - 1)) + floor(global.player.shops_value / divider) >= global.target_amount {
			global.state = "player_victory"
		}
		//ask player about stocks
		else {
			state_stored_next_2 = "player_move"
			global.state = "stocks_ask"
		}
	break;
	
	case "player_shopless":
		if obj_menu.readyflag == true {global.state = "player_action"}
	break;
	
	case "player_stop":
		//if player has no spaces left to move, change state depending on player action
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
		//currently blank. game just softlocks when beaten.
	break;
	
	/////////////////////////////////////////////////////
	//Shop Logic
	
	case "shop_buy":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			//purchase shop
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
		//set the initial number for the selector
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
			//when player selects amount to invest, change state depending on player action
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
				global.state = "select_square_on_board"
			}
		}
	break;
	
	case "shop_pay":
		//directly pay the owner of the shop
		global.player.readycash -= global.board[global.player.current_position].properties.price
		global.board[global.player.current_position].properties.owner.readycash += global.board[global.player.current_position].properties.price
		
		//pay out the district's stockholders
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
			
			//when choosing to invest, change state depending on player action
			if obj_menu.selected == "Yes" {
				state_stored_prev = "shop_self"
				state_stored_next = "shop_invest_1"
				obj_camera.selecting = "shop"
				obj_camera.selecting_sub = global.player
				global.state = "select_square_on_board"
			}
			else global.state = "turn_end"
		}
	break;
	
	case "shop_sell":
		sell_shop();
		//end turn if player was forced to sell
		if state_stored_prev == "player_poor" {
			state_stored_next = "turn_end"
		}
		timer = 120
		global.state = "wait"
	break;
	
	/////////////////////////////////////////////////////
	//Space Logic
	
	case "space_execute":
	
		//play minigame at arcade
		if global.board[global.player.current_position].properties.type == "arcade" {
			global.state = "arcade_setup"
		}
		
		//unlock player's direction at bank
		else if global.board[global.player.current_position].properties.type == "bank" {
			global.player.previous_position = -1
			global.state = "turn_end"
		}
		
		//buy, pay, or invest at shops
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
		
		//draw random venture card at ventures/suits.
		else if global.board[global.player.current_position].properties.type == "venture" or global.board[global.player.current_position].properties.type == "suit" or global.board[global.player.current_position].properties.type == "suit-change" {
			global.state = "venture_execute"
		}
		
		else {
			state_stored_next = "turn_end"
			timer = 90
			global.state = "wait"
		}
	break;
	
	/////////////////////////////////////////////////////
	//Stocks Logic
	
	case "stocks_ask":
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			
			//when choosing to buy stocks, change state depending on player action
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
			//prevent asking for stocks again when going backwards
			global.board[global.player.current_position].properties.stocks_ask = false
		}
	break;
	
	case "stocks_buy_1":
		//calculate number to use for selector
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
			
			//when player selects amount to buy, change state depending on player action
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
		//calculate number to use for selector
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
		//when player selects amount to sell, change state depending on player action
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
	
	/////////////////////////////////////////////////////
	//Turn Logic
	
	case "turn_end":
		//disallow the turn to end if player is broke
		if global.player.readycash < 0 {
			global.state = "player_poor"
			exit;
		}
		
		//reset board variables, push player to background, move to next player
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
		//bring player from background
		if obj_menu.anim_timer == 2 {
			global.player.depth -= 1
			global.player.image_alpha = 1
		}
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			global.state = "player_action"
		}
	break;
	
	/////////////////////////////////////////////////////
	//Venture Logic
	
	case "venture_execute":
		switch(global.substate){
			case 0:
				if key_pressed(global.key_select) {irandom_range(1,23)}
				break;
			case 1:
				if key_pressed(global.key_select) {
					execute_venture(venture_number)
					}
				break;
			case 2:
				global.state = "turn_end"
				global.substate = 0
				break;
		}
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			global.substate++
		}
		//executes a random venture card
	break;
	
	/////////////////////////////////////////////////////
	//Wait
	
	case "wait":
		//inserts a pause before going to next state
		timer--
		if timer == 0 {
			global.state = state_stored_next
		}
	break;
	
	/////////////////////////////////////////////////////
	//Pause

}

if(key_pressed(global.key_pause)){
	if(!paused){
		obj_menu.state_stored_prev = global.state
		global.state = "pause"
		paused = true
	}else{
		obj_menu.controls_flag = false
		obj_menu.page = 0
		obj_menu.pointer = 0
		obj_menu.controls_pointer = 0
		global.state = obj_menu.state_stored_prev
		paused = false
	}
}

if(key_pressed(global.key_view) && !paused && !obj_player_parent.moving && global.state != "manage_auction" && global.state != "select_square_on_board"){
	if(!viewing_board){
		obj_camera.sprite_index = spr_camera
		obj_menu.state_stored_prev_2 = global.state
		global.state = "board_view"
		viewing_board = true
	}else{
		global.state = obj_menu.state_stored_prev_2
		viewing_board = false
		obj_camera.sprite_index = noone
	}
}