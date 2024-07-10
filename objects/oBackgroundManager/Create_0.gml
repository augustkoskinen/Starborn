UNIV_WIDTH = 500;
UNIV_HEIGHT = 500;

var amount1 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(190,210)

repeat(amount1) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar1x1;
	star.image_index = irandom_range(0,10)
	star.image_speed = 0;
}

var amount3 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(390,410)

repeat(amount3) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar3x3;
	star.image_index = irandom_range(0,21)
	star.image_speed = 0;
}

//var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
//star.sprite_index = sGalaxy;

audio_play_sound(sMain,1,true);