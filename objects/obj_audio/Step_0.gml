if room == rm_game {

	switch state_sfx {
	
		case "menu_open":
			sfx = sfx_blip
		
			if pointer != obj_menu.pointer {
				if page == obj_menu.page && obj_menu.readyflag != true {
					audio_play_sound(sfx,40,false)
					audio_sound_gain(sfx,sfx_volume,0)
				}
			}
			pointer = obj_menu.pointer
			page = obj_menu.page
		break;
	
		case "dice_roll":
			sfx = sfx_tick
			timer_ref = 30
		
			if timer == 0 {
				audio_play_sound(sfx,40,false)
				audio_sound_gain(sfx,sfx_volume,0)
				timer = timer_ref
			}
			else timer--
		break;
	
	}
	
}

if room == rm_mainmenu {
	
	if song_current != "" {
		if music == -1 {
			music = audio_create_stream("Themes/" + global.theme_name + "/Music/" + song_current)
			audio_play_sound(music,90,true)
			audio_sound_gain(music,music_volume,0)
		}
		else {
			if song_last != "" {
				if song_current != song_last {
					music = audio_destroy_stream(music)
					music = audio_create_stream("Themes/" + global.theme_name + "/Music/" + song_current)
					audio_play_sound(music,90,true)
					audio_sound_gain(music,music_volume,0)
				}
			}
		}
	}
	song_last = song_current
	
}