//Character Animation Handling
if anim_timer == 0 {
	//remove old sprite when no longer needed
	if sprite_to_set != -1 {
		sprite_delete(sprite_to_set)
	}
	//prepare next sprite
	sprite_to_set = sprite_add(path + current_animation[anim_pointer],0,0,0,0,0)
	//set next sprite
	sprite_index = sprite_to_set
	anim_pointer++
	//set how long to hold sprite for
	anim_timer = current_animation[anim_pointer]
	anim_pointer++
	//loop animation
	if anim_pointer > array_length(current_animation) - 1 {
		anim_pointer = 0
	}
}
else anim_timer--