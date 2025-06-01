//OBJ_AUDIO - Invisible, controls every song and sound effect
/////////////////////////////////////////////////////
//Initialize Variables

state_sfx = ""
music_volume = 1
sfx_volume = 1

timer_ref = 0
timer = timer_ref
pointer = 0
page = 0
music = -1
song_current = ""
song_last = song_current

/////////////////////////////////////////////////////
//Load Main Theme (if board has one)

if room == rm_game {
	if global.board_theme != -1 {
		music = global.board_theme
	}
	else music = -1
	sfx = -1

	if music != -1 {
		audio_play_sound(music,90,true)
	}
}

/////////////////////////////////////////////////////