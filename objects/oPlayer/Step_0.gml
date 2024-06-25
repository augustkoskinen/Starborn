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

var planet = scr_get_closest_planet(self, oPlanetManager.planetList);
var g = _dt*scr_get_gravity(1,planet.mass,point_distance(x,y,planet.x,planet.y));
var addplanx = lengthdir_x(g,point_direction(x,y,planet.x,planet.y));
var addplany = lengthdir_y(g,point_direction(x,y,planet.x,planet.y));

if collision_circle(x+addplanx, y, planet.radius, self, false, false) {
	while !collision_circle(x+addplanx, y, planet.radius, self, false, false) {
		x += sign(addplanx);
		addplanx = 0;
	}
}
x+= addplanx;

if collision_circle(x, y+addplany, planet.radius, self, false, false) {
	while !collision_circle(x, y+addplany, planet.radius, self, false, false) {
		y += sign(addplany);
		addplany = 0;
	}
}
y+= addplanx;
