var curmove = inventoryopen ? 0 : keyboard_check(ord("D"))-keyboard_check(ord("A"));
var _dt = delta_time / 1000000;
var precision = .001;


if(keyboard_check_pressed(vk_tab)) inventoryopen = !inventoryopen;

if (!global.paused) {
	var planet = scr_get_closest_planet(self, oPlanetManager.planetList);
	var g = scr_get_gravity(planet, point_distance(x,y,planet.x,planet.y));
	image_angle = point_direction(x,y,planet.x,planet.y)+90;

	var addplanx = lengthdir_x(_dt*g,image_angle-90);
	var addplany = lengthdir_y(_dt*g,image_angle-90);
	
	var sidemove = 0;
	if(curmove>0) {
		moving = curmove
		sidemove = (keyboard_check(vk_control)?RUN_SPEED:MOVE_SPEED) * _dt;
		sprite_index = sPlayerWR;
		image_speed = (keyboard_check(vk_control)?RUN_SPEED/MOVE_SPEED:1);
	} else if(curmove<0) {
		moving = curmove
		sidemove = -(keyboard_check(vk_control)?RUN_SPEED:MOVE_SPEED) * _dt;
		sprite_index = sPlayerWL;
		image_speed = (keyboard_check(vk_control)?RUN_SPEED/MOVE_SPEED:1);
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
	
	
	if(collision_point(x+lengthdir_x(1,image_angle-90),y+lengthdir_y(1,image_angle-90),oTotalCollision, true, true)) {
		grounded = true;
	}
	else grounded = false;
	
	if(grounded&&keyboard_check(vk_space)&&!inventoryopen) {
		jumpvel = JUMP_SPEED;
		held_space = .1;
		grounded = false;
	}
	if(held_space>0&&!inventoryopen) {
		if(!keyboard_check(vk_space))
			held_space = 0;
		else {
			held_space-=_dt;
			jumpvel = JUMP_SPEED;
		}
	}
	
	show_debug_message(grounded)
	var netx = lengthdir_x(jumpvel * _dt,image_angle+90)+lengthdir_x(sidemove,image_angle);
	var nety = lengthdir_y(jumpvel * _dt,image_angle+90)+lengthdir_y(sidemove,image_angle);
	
	if (place_meeting(x+netx,y,oPlanetlessCollision)) {
		while (!place_meeting(x+sign(netx)*precision,y,oPlanetlessCollision)) {
			x += sign(netx)*precision;
		}
		netx = 0;
	}
	x += netx;
	
	if (place_meeting(x,y+nety,oPlanetlessCollision)) {
		while (!place_meeting(x,y+sign(nety)*precision,oPlanetlessCollision)) {
			y += sign(nety)*precision;
		}
		nety = 0;
	}
	y += nety;
	
	if(grounded) {
		/*
		var dis = point_distance(x,y,planet.x,planet.y);
		var angleadd = (sidemove/(dis*2*pi))*360;
		
		image_angle -= angleadd;
		x = planet.x+lengthdir_x(dis, image_angle+90);
		y = planet.y+lengthdir_y(dis, image_angle+90);
		*/

		
		image_angle = point_direction(x,y,planet.x,planet.y)+90;
		var addplanx = lengthdir_x(precision,image_angle-90);
		var addplany = lengthdir_y(precision,image_angle-90);
		while (!place_meeting(x+addplanx,y+addplany,oTotalCollision)) {
			x += addplanx;
			y += addplany;
		}
		
	} else {
		//gravity
		//move x
		if (place_meeting(x+addplanx,y,oTotalCollision)) {
			while (!place_meeting(x+sign(addplanx)*precision,y,oTotalCollision)) {
				x += sign(addplanx)*precision;
			}
			addplanx = 0;
		}
		x += addplanx;
		
		//move y
		if (place_meeting(x,y+addplany,oTotalCollision)) {
			while (!place_meeting(x,y+sign(addplany)*precision,oTotalCollision)) {
				y += sign(addplany)*precision;
			}
			addplany = 0;
		}
		y += addplany;
	}
	
	jumpvel*=.9;
}

/*
//slope
if(grounded) {
	if sign(sidemove)==1 && ((place_meeting(x+lengthdir_x(dcos(SLOPE_ANGLE), image_angle),y+lengthdir_x(dcos(SLOPE_ANGLE), image_angle),oCollision))&&
	(!place_meeting(x+lengthdir_x(1, image_angle+SLOPE_ANGLE),y+lengthdir_x(1, image_angle+SLOPE_ANGLE),oCollision))){
		x+=lengthdir_x(1, image_angle+SLOPE_ANGLE);
		y+=lengthdir_y(1, image_angle+SLOPE_ANGLE);
		show_debug_message("here")
	}
	
	if sign(sidemove)==-1 && ((place_meeting(x+lengthdir_x(dcos(SLOPE_ANGLE), image_angle+180),y+lengthdir_x(dcos(SLOPE_ANGLE), image_angle+180),oCollision))&&
	(!place_meeting(x+lengthdir_x(1, image_angle+180-SLOPE_ANGLE),y+lengthdir_x(1, image_angle+180-SLOPE_ANGLE),oCollision))){
		x+=lengthdir_x(1, image_angle+180-SLOPE_ANGLE);
		y+=lengthdir_y(1, image_angle+180-SLOPE_ANGLE);
		show_debug_message("here2")
	}
}
*/