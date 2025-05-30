//Find the Images folder

if room == rm_mainmenu {
	path = "Themes/" + global.theme_name + "/Graphics/"
}
else if room == rm_game {
	path = "Boards/" + global.board_name + "/Graphics/"
}

/////////////////////////////////////////////////////
//Animation Handling

if prev_animation != current_animation {
	anim_timer = 0
	anim_pointer = 0
	prev_animation = current_animation
}

if array_length(current_animation) != 0 {
	
	if anim_timer == 0 {
		if sprite_to_set != -1 {
			sprite_delete(sprite_to_set)
		}
		sprite_to_set = sprite_add(path + current_animation[anim_pointer],0,0,0,0,0)
		sprite_index = sprite_to_set
		anim_pointer++
		anim_timer = current_animation[anim_pointer]
		anim_pointer++
		if anim_pointer > array_length(current_animation) - 1 {
			anim_pointer = 0
		}
		anim_ready = false
	}
	else anim_timer--
	
}

/////////////////////////////////////////////////////