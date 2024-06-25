var curmove = keyboard_check(ord("D"))-keyboard_check(ord("A"));
var _dt = delta_time / 1000000;


if(curmove>0) {
	moving = curmove
	x += MOVE_SPEED * _dt;
	sprite_index = sPlayerWR;
	image_speed = 1;
} else if(curmove<0) {
	moving = curmove
	x -= MOVE_SPEED * _dt;
	sprite_index = sPlayerWL;
	image_speed = 1;
} else {
	if(moving == 1) {
		sprite_index = sPlayer;
		image_speed = 0;
		image_index = 2;
	} else {
		sprite_index = sPlayer;
		image_speed = 0;
		image_index = 0;
	}
}