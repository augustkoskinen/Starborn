var curmove = keyboard_check(ord("D"))-keyboard_check(ord("A"));
var _dt = delta_time / 1000000;

var sidemove = 0;
if(curmove>0) {
	moving = curmove
	sidemove = MOVE_SPEED * _dt;
	sprite_index = sPlayerWR;
	image_speed = 1;
} else if(curmove<0) {
	moving = curmove
	sidemove = -MOVE_SPEED * _dt;
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

if(grounded&&keyboard_check(vk_space)) {
	jumpvel = JUMP_SPEED;
	held_space = .1;
}
if(held_space>0) {
	if(!keyboard_check(vk_space)) held_space = 0;
	else {
		held_space-=_dt;
		jumpvel = JUMP_SPEED;
	}
	
}

var planet = scr_get_closest_planet(self, oPlanetManager.planetList);
var g = _dt*scr_get_gravity(1,planet.mass,point_distance(x,y,planet.x,planet.y));
var addplanx = lengthdir_x(g,point_direction(x,y,planet.x,planet.y));
var addplany = lengthdir_y(g,point_direction(x,y,planet.x,planet.y));

if(point_distance(x,y,planet.x,planet.y)>planet.radius+1) {
	var collided = array_length(move_and_collide(addplanx, addplany, planet, 10000))>0;
	if(collided) {
		x += lengthdir_x(1,image_angle+90);
		y += lengthdir_y(1,image_angle+90);
		grounded = true;
	} else
		grounded = false;
} else
	grounded = true;

move_and_collide(lengthdir_x(sidemove,image_angle), lengthdir_y(sidemove,image_angle), planet, 100)
move_and_collide(lengthdir_x(jumpvel,image_angle+90), lengthdir_y(jumpvel,image_angle+90), planet, 100)


jumpvel*=.9;
image_angle = point_direction(x,y,planet.x,planet.y)+90;
camera_set_view_angle(view_camera[0], -image_angle);