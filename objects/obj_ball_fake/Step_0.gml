if keyboard_check(global.key_left) {
	x -= 1
}

if keyboard_check(global.key_right) {
	x += 1
}

if keyboard_check_pressed(global.key_select) {
	instance_create_layer(x,y,layer,obj_ball_real)
	instance_destroy()
}

x = clamp(x,16,208)