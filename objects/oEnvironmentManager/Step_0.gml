if(count>SMAIN_LENGTH){
	audio_play_sound(sMain,1,false);
	count = 0;
} else {
	count += delta_time/1000000
}