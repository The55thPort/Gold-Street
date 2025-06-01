//Remove Current Song from Memory (when no longer in use)

if music != -1 {
	music = audio_destroy_stream(music)
}

/////////////////////////////////////////////////////