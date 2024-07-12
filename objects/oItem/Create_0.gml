state = itemstate.held
dropwait = 0;

enum itemstate {
	dropped,
	held
}

function drop(_x, _y) {
	x = _x;
	y = _y;
	state = itemstate.dropped
	dropwait = .75;
	
	sprite_index = sItem
	image_index = type;
	image_speed = 0;
	image_xscale = .1;
	image_yscale = .1;
}