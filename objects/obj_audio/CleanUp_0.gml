//Remove Current Song from memory when no longer in use

if music != -1 {
	music = audio_destroy_stream(music)
}

/////////////////////////////////////////////////////