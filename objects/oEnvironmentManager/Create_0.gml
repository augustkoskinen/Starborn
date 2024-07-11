randomize();
global.addbuffer = 0;
global.loadradius = 400;
global.paused = false;

UNIV_WIDTH = 1000;
UNIV_HEIGHT = 1000;

//less is more
x1stars = 400;
x3stars = x1stars+200;

SMAIN_LENGTH = 114;
count = 0;

var amount1 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(x1stars-50,x1stars+50)

repeat(amount1) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar1x1;
	star.image_index = irandom_range(0,10)
	star.image_speed = 0;
}

var amount3 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(x3stars-50,x3stars+50)

repeat(amount3) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar3x3;
	star.image_index = irandom_range(0,21)
	star.image_speed = 0;
}

//var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
//star.sprite_index = sGalaxy;

audio_play_sound(sMain,1,false);