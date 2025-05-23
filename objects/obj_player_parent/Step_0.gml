if readycash_display != readycash or net_worth_display != net_worth {
	display_timer++
	if display_timer == 240 {
		display_timer = 0
		readycash_display = readycash
		net_worth_display = net_worth
	}
}
else display_timer = 0

readycash_display += sign(readycash - readycash_display)
net_worth_display += sign(net_worth - net_worth_display)

shops_value = 0
var shop_pointer = 0
repeat (array_length(shops)) {
	shops_value += shops[shop_pointer].properties.value
	shop_pointer += 1
}
shop_pointer = 0

stocks_value = 0
var district = 0
repeat (array_length(stocks)) {
	if stocks[district] != 0 {
		stocks_value += stocks[district] * global.stock_prices[district]
	}
	district++
}

net_worth = readycash + shops_value + stocks_value

if bool(suits[0]) + bool(suits[1]) + bool(suits[2]) + bool(suits[3]) == 4 {
	promotion = true
}
else {
	promotion = false
}

if readyflag == false && global.player == object_index {
	
	if global.state == "player_move" {
		
		if moving == true {
			var x_lerp = lerp(x_start, x_goto, timer / move_length)
			var y_lerp = lerp(y_start, y_goto, timer / move_length)
			x = round(x_lerp)
			y = round(y_lerp)
			
			if timer >= move_length {
				timer = 1
				moving = false
				if suit_to_give != -1 {
					suits[suit_to_give] += 1
					suit_to_give = -1
				}
				current_animation = [  ]
				array_copy(current_animation,0,idle_down,0,array_length(idle_down))
				anim_timer = 0
				anim_pointer = 0
				
				if spaces_to_move == 0 {
					readyflag = true
					exit;
				}
				
				if global.board[current_position].properties.type == "bank" {
					exit;
				}
			}
			else {
				timer++
				exit;
			}
		}
		
		if moving == false {
			
			var next_position = -1
			var anim = [  ]
			var anim_prev = [  ]
		
			if keyboard_check(global.key_up) {
				next_position = global.board[current_position].properties.connections[0]
				anim = walk_up
				anim_prev = walk_down
			}
			if keyboard_check(global.key_left) {
				next_position = global.board[current_position].properties.connections[1]
				anim = walk_left
				anim_prev = walk_right
			}
			if keyboard_check(global.key_down) {
				next_position = global.board[current_position].properties.connections[2]
				anim = walk_down
				anim_prev = walk_up
			}
			if keyboard_check(global.key_right) {
				next_position = global.board[current_position].properties.connections[3]
				anim = walk_right
				anim_prev = walk_left
			}
		
			if next_position == -1 {
				exit;
			}
		
			if global.board[next_position] == previous_position && array_length(current_path) == 0 {
				exit
			}
			
			if variable_struct_exists(global.board[current_position].properties,"blocked") {
				var block = 0
				var space = 0
				var blocked = global.board[current_position].properties.blocked
				repeat (array_length(blocked)) {
					if array_length(current_path) != 0 {
						if array_last(current_path).properties.space == blocked[block,space] {
							repeat (array_length(blocked[block]) - 1) {
								space++
								if next_position == blocked[block,space] {exit}
							}
						}
					}
					else if previous_position == global.board[blocked[block,space]] {
						repeat (array_length(blocked[block]) - 1) {
							space++
							if next_position == blocked[block,space] {exit}
						}
					}
					block++
					space = 0
				}
			}
			
			
		
			x_start = x
			y_start = y
			x_goto = global.board[next_position].properties.x + 8
			y_goto = global.board[next_position].properties.y + 8
			moving = true
		
			if global.board[next_position].properties.type == "bank" {
				if global.board[next_position] != array_last(current_path) {
					var suits_temp = [  ]
					array_copy(suits_temp,0,suits,0,4)
					array_push(global.board[next_position].properties.suits_last,suits_temp)
					global.board[next_position].properties.stocks_ask = true
				}
			}
		
			if global.board[next_position].properties.type == "suit" or global.board[next_position].properties.type == "suit-change" {
				if global.board[next_position] != array_last(current_path) {
					suit_to_give = global.board[next_position].properties.suit
					if global.board[next_position].properties.type == "suit-change" {
						global.board[next_position].properties.suit += 1
						if global.board[next_position].properties.suit > 3 {
							global.board[next_position].properties.suit = 0
						}
					}
				}
			}
		
			if global.board[next_position] == array_last(current_path) {
				if global.board[current_position].properties.type == "bank" {
					if array_length(global.board[current_position].properties.suits_last) > 0 {
						if !array_contains(array_last(global.board[current_position].properties.suits_last),0) {
							level--
							var divider = 10
							if array_length(obj_game.players) >= 5 {divider = 5}
							readycash -= global.salary_base + (global.salary_increment * level) + floor(shops_value / divider)
						}
						suits = array_last(global.board[current_position].properties.suits_last)
						array_copy(array_last(global.board[current_position].properties.suits_last),0,suits,0,4)
						array_pop(global.board[current_position].properties.suits_last)
						var last_stock = array_last(global.board[current_position].properties.stocks_last)
						if last_stock != -1 {
							stocks[last_stock[0]] -= last_stock[1]
							readycash += last_stock[2]
						}
						array_pop(global.board[current_position].properties.stocks_last)
					}
				}
				if global.board[current_position].properties.type == "suit" or global.board[current_position].properties.type == "suit-change" {
					if global.board[current_position].properties.type == "suit-change" {
						global.board[current_position].properties.suit -= 1
						if global.board[current_position].properties.suit < 0 {
							global.board[current_position].properties.suit = 3
						}
					}
					suits[global.board[current_position].properties.suit] -= 1
				}
				array_pop(current_path)
				spaces_to_move += 1
			}
			
			else {
				array_push(current_path, global.board[current_position])
				spaces_to_move -= 1
			}
			
			current_position = next_position
			anim_pointer = 0
			anim_timer = 0
			current_animation = [  ]
			array_copy(current_animation,0,anim,0,array_length(anim))
			array_copy(prev_animation,0,anim_prev,0,array_length(anim_prev))
			
		}
				
	}
	
}