if globalstate_last != global.state {
	run_once = false
}
globalstate_last = global.state

var num = 0

switch global.state {
	
	case "player_action":
		if run_once = false {
			repeat (4) {
				
				var current_connection = global.board[global.player.current_position].properties.connections[num]
				if current_connection != -1 {
					dir = point_direction(
						global.player.x+8,
						global.player.y+8,
						global.board[current_connection].x + 16,
						global.board[current_connection].y + 16
					)
					effect = instance_create_depth(
						global.player.x+8+lengthdir_x(arrows_radius,dir),
						global.player.y+8+lengthdir_y(arrows_radius,dir),
						layer_get_depth("Board") - 1,
						obj_effect
					)
					effect.dir = dir
					effect.state = "arrow"
					
					if global.board[current_connection] == global.player.previous_position {
						instance_destroy(effect)
					}
					
					if global.player.previous_position != -1 or array_length(global.player.current_path) > 0 {
						if variable_struct_exists(global.board[global.player.current_position].properties,"blocked") {
							var blocked = global.board[global.player.current_position].properties.blocked
							var block = 0
							var space = 0
							repeat (array_length(blocked)) {
								if global.player.previous_position.properties.space == blocked[block,space] {
									repeat (array_length(blocked[block]) - 1) {
										space++
										if current_connection == blocked[block,space] {
											instance_destroy(effect)
										}
									}
								}
								block++
								space = 0
							}
						}
					}
				}
				num++
				
			}
			
			run_once = true
		}
	break;
	
	case "player_move":
		if global.player.moving == false && arrows_drawn == false {
			run_once = false
		}
	
		if run_once == false && global.player.spaces_to_move != 0 {
			repeat (4) {
				
				var current_connection = global.board[global.player.current_position].properties.connections[num]
				if current_connection != -1 {
					dir = point_direction(
						global.player.x+8,
						global.player.y+8,
						global.board[current_connection].x + 16,
						global.board[current_connection].y + 16
					)
					effect = instance_create_depth(
						global.player.x+8+lengthdir_x(arrows_radius,dir),
						global.player.y+8+lengthdir_y(arrows_radius,dir),
						layer_get_depth("Board") - 1,
						obj_effect
					)
					effect.dir = dir
					effect.state = "arrow"
					
					if array_length(global.player.current_path) != 0 {
						if global.board[current_connection] == array_last(global.player.current_path) {
							instance_destroy(effect)
						}
					}
					else if global.board[current_connection] == global.player.previous_position {
						instance_destroy(effect)
					}
					
					if global.player.previous_position != -1 or array_length(global.player.current_path) > 0 {
						if variable_struct_exists(global.board[global.player.current_position].properties,"blocked") {
							var blocked = global.board[global.player.current_position].properties.blocked
							var block = 0
							var space = 0
							repeat (array_length(blocked)) {
								if array_length(global.player.current_path) != 0 {
									if array_last(global.player.current_path).properties.space == blocked[block,space] {
										repeat (array_length(blocked[block]) - 1) {
											space++
											if current_connection == blocked[block,space] {
												instance_destroy(effect)
											}
										}
									}
								}
								else if global.player.previous_position.properties.space == blocked[block,space] {
									repeat (array_length(blocked[block]) - 1) {
										space++
										if current_connection == blocked[block,space] {
											instance_destroy(effect)
										}
									}
								}
								block++
								space = 0
							}
						}
					}
				}
				num++
				
			}
			
			arrows_drawn = true
			run_once = true
		}
	break;
	
}