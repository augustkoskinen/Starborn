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
var g = _dt*scr_get_gravity(planet, point_distance(x,y,planet.x,planet.y));
var addplanx = lengthdir_x(g,point_direction(x,y,planet.x,planet.y));
var addplany = lengthdir_y(g,point_direction(x,y,planet.x,planet.y));

/*
playercol = MovementMath.DuplicateCirc(sprite.collision);
if (-1 != MovementMath.CheckCollisions(playercol, CollisionList, new Vector3((float) (netvect.x * Gdx.graphics.getDeltaTime() * SLOWSPEED), 0, 0), sprite.collision.radius-.5f)) {
	double sign = Math.abs(netvect.x) / (netvect.x);
	while (-1 == MovementMath.CheckCollisions(playercol, CollisionList, new Vector3((float) (sign), 0, 0), sprite.collision.radius-.5f)) {
		sprite.addPosition(new Vector3((float) (sign), 0, 0));
		playercol = MovementMath.DuplicateCirc(sprite.collision);
	}
	netvect.x = 0;
	walkvect.x = 0;
	jumpvect.x = 0;
	gpullvect.x = 0;
}
sprite.addPosition(new Vector3((float) (netvect.x * Gdx.graphics.getDeltaTime() * SLOWSPEED), 0, 0));

//move y
playercol = MovementMath.DuplicateCirc(sprite.collision);
if (-1 != MovementMath.CheckCollisions(playercol, CollisionList, new Vector3(0, (float) (netvect.y * Gdx.graphics.getDeltaTime() * SLOWSPEED), 0), sprite.collision.radius-.5f)) {
	double sign = Math.abs(netvect.y) / (netvect.y);
	while (-1 == MovementMath.CheckCollisions(playercol, CollisionList, new Vector3(0, (float) (sign), 0), sprite.collision.radius-.5f)) {
		sprite.addPosition(new Vector3(0, (float) (sign), 0));
		playercol = MovementMath.DuplicateCirc(sprite.collision);
	}
	netvect.y = 0;
	walkvect.y = 0;
	jumpvect.y = 0;
	gpullvect.y = 0;
}
sprite.addPosition(new Vector3(0, (float) (netvect.y * Gdx.graphics.getDeltaTime() * SLOWSPEED), 0));
*/

var netx = lengthdir_x(jumpvel * _dt,image_angle+90)+lengthdir_x(sidemove,image_angle)+addplanx;
var nety = lengthdir_y(jumpvel * _dt,image_angle+90)+lengthdir_y(sidemove,image_angle)+addplany;

//12x32
if (place_meeting(x+netx,y,oCollision)) {
	while (!place_meeting(x+sign(netx),y,oCollision)) {
		x += sign(netx);
	}
	netx = 0;
}
x += netx;

//move y
if (place_meeting(x,y+nety,oCollision)) {
	while (!place_meeting(x,y+sign(nety),oCollision)) {
		y += sign(nety);
	}
	nety = 0;
}
y += nety;

if(collision_point(x+lengthdir_x(1,image_angle-90),y+lengthdir_y(1,image_angle-90),oCollision, true, true)) grounded = true;
else grounded = false;


jumpvel*=.9;
image_angle = point_direction(x,y,planet.x,planet.y)+90;
camera_set_view_angle(view_camera[0], -image_angle);