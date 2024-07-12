randomize();
global.addbuffer = 0;
global.loadradius = 400;
global.paused = false;

UNIV_WIDTH = 1000;
UNIV_HEIGHT = 1000;

//less is more
var amount = irandom_range(4,9)
driftxlist = array_create(amount)
driftylist = array_create(amount)

for(var i = 0; i < amount; i++)
	array_set(driftxlist,i,random_range(-.02,.02))

for(var i = 0; i < amount; i++)
	array_set(driftylist,i,random_range(-.02,.02))

x1stars = 1000;
x3stars = x1stars+1000;
x7stars = x1stars+20000;

SMAIN_LENGTH = 253.5;//114
count = 0;

var amount1 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(x1stars-50,x1stars+50)

repeat(amount1) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar1x1;
	star.image_index = irandom_range(0,7)
	star.image_speed = 0;
	
	var rani = irandom(amount-1)
	star.addx = array_get(driftxlist,rani);
	star.addy = array_get(driftylist,rani);

}

var amount3 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(x3stars-50,x3stars+50)

repeat(amount3) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar3x3;
	star.image_index = irandom_range(0,15)
	star.image_speed = 0;
	
	var rani = irandom(amount-1)
	star.addx = array_get(driftxlist,rani);
	star.addy = array_get(driftylist,rani);
}

var amount7 = (UNIV_HEIGHT*UNIV_WIDTH)/irandom_range(x7stars-50,x7stars+50)

repeat(amount7) {
	var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
	star.sprite_index = sBgStar7x7;
	star.image_index = irandom_range(0,7)
	star.image_speed = 0;
	
	var rani = irandom(amount-1)
	star.addx = array_get(driftxlist,rani);
	star.addy = array_get(driftylist,rani);
}

//var star = instance_create_layer(irandom_range(0,UNIV_WIDTH),irandom_range(0,UNIV_HEIGHT),"Stars",oStar);
//star.sprite_index = sGalaxy;

audio_play_sound(sMain,1,false);