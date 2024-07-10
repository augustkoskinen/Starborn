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
	
	if(curmove>0) {
		moving = curmove
		movespeed = (keyboard_check(vk_control)?RUN_SPEED:MOVE_SPEED) * _dt;
		sprite_index = sPlayerWR;
		image_speed = (keyboard_check(vk_control)?RUN_SPEED/MOVE_SPEED:1);
	} else if(curmove<0) {
		moving = curmove
		movespeed = -(keyboard_check(vk_control)?RUN_SPEED:MOVE_SPEED) * _dt;
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
	
	
	if(place_meeting(x+lengthdir_x(1,image_angle-90),y+lengthdir_y(1,image_angle-90),oTotalCollision)) grounded = true;
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
	
	//show_debug_message(grounded)
	var walkx = lengthdir_x(movespeed,image_angle);
	var walky = lengthdir_y(movespeed,image_angle);
	
	if (place_meeting(x+walkx,y+walky,oTotalCollision)) {
		var slopex = lengthdir_x(movespeed,movespeed>0 ? image_angle+SLOPE_ANGLE : image_angle-SLOPE_ANGLE)
		var slopey = lengthdir_y(movespeed,movespeed>0 ? image_angle+SLOPE_ANGLE : image_angle-SLOPE_ANGLE)
		var curangle = .5;

		if(grounded&&!place_meeting(x+slopex,y+slopey,oTotalCollision)){
			slopex = walkx;
			slopey = walky;
			while(place_meeting(x+slopex,y+slopey,oTotalCollision)) {
				slopex = lengthdir_x(movespeed,movespeed>0 ? image_angle+curangle : image_angle-curangle)
				slopey = lengthdir_y(movespeed,movespeed>0 ? image_angle+curangle : image_angle-curangle)
				curangle+=.5;
			}
			walkx = slopex;
			walky = slopey;
		} else {
			var xyratio = walky==0 ? 0 : (abs(walkx/walky))

			var incrx = sign(walkx)*precision*xyratio;
			var incry = sign(walky)*precision;
		
			var totalx = abs(walkx);
			var totaly = abs(walky);
		
			while (!place_meeting(x+incrx,y+incry,oTotalCollision)&&xyratio!=0&&totalx>0&&totaly>0) {
				x += incrx;
				y += incry;
			
				totalx-=abs(incrx);
				totaly-=abs(incry);
			}
			walkx = 0;
			walky = 0;
		}
	}
	x += walkx;
	y += walky;
	
	var jumpx = lengthdir_x(jumpvel * _dt,image_angle+90);
	var jumpy = lengthdir_y(jumpvel * _dt,image_angle+90);
	
	if (place_meeting(x+jumpx,y+jumpy,oTotalCollision)) {
		var xyratio = jumpy==0 ? 0 : (abs(jumpx/jumpy))

		var incrx = sign(jumpx)*precision*xyratio;
		var incry = sign(jumpy)*precision;
		
		var totalx = abs(jumpx);
		var totaly = abs(jumpy);
		
		while (!place_meeting(x+incrx,y+incry,oTotalCollision)&&xyratio!=0&&totalx>0&&totaly>0) {
			x += incrx;
			y += incry;
			
			totalx-=abs(incrx);
			totaly-=abs(incry);
		}
		jumpx = 0;
		jumpy = 0;
	}
	x += jumpx;
	y += jumpy;
	
	//gravity
	//move x
	if (place_meeting(x+addplanx,y+addplany,oTotalCollision)) {
		var xyratio = addplany==0 ? 0 : (abs(addplanx/addplany))

		var incrx = sign(addplanx)*precision*xyratio;
		var incry = sign(addplany)*precision;
		
		var totalx = abs(addplanx);
		var totaly = abs(addplany);
		
		while (!place_meeting(x+incrx,y+incry,oTotalCollision)&&xyratio!=0&&totalx>0&&totaly>0) {
			x += incrx;
			y += incry;
			
			totalx-=abs(incrx);
			totaly-=abs(incry);
		}
		addplanx = 0;
		addplany = 0;
	}
	x += addplanx;
	y += addplany;
	
	jumpvel*=.9;
	movespeed*=.7
}

/*
// Get the unmodified mask data
var _b1 = sprite_get_bbox_left(sprite_index);
var _b2 = sprite_get_bbox_top(sprite_index);
var _b3 = sprite_get_bbox_right(sprite_index);
var _b4 = sprite_get_bbox_bottom(sprite_index);

var _xoff = sprite_get_xoffset(sprite_index);
var _yoff = sprite_get_yoffset(sprite_index);

// Get the unmodified vector for each corner
var _dis1 = point_distance(_xoff, _yoff, _b1, _b2);
var _dir1 = point_direction(_xoff, _yoff, _b1, _b2);
var _dis2 = point_distance(_xoff, _yoff, _b3, _b2);
var _dir2 = point_direction(_xoff, _yoff, _b3, _b2);
var _dis3 = point_distance(_xoff, _yoff, _b3, _b4);
var _dir3 = point_direction(_xoff, _yoff, _b3, _b4);
var _dis4 = point_distance(_xoff, _yoff, _b1, _b4);
var _dir4 = point_direction(_xoff, _yoff, _b1, _b4);

// Now modify the vectors using the current position and image angle
var _x1 = x + lengthdir_x(_dis1, image_angle + _dir1);
var _y1 = y + lengthdir_y(_dis1, image_angle + _dir1);
var _x2 = x + lengthdir_x(_dis2, image_angle + _dir2);
var _y2 = y + lengthdir_y(_dis2, image_angle + _dir2);
var _x3 = x + lengthdir_x(_dis3, image_angle + _dir3);
var _y3 = y + lengthdir_y(_dis3, image_angle + _dir3);
var _x4 = x + lengthdir_x(_dis4, image_angle + _dir4);
var _y4 = y + lengthdir_y(_dis4, image_angle + _dir4);

// Draw the mask box
draw_line(_x1, _y1, _x2, _y2);
draw_line(_x2, _y2, _x3, _y3);
draw_line(_x3, _y3, _x4, _y4);
draw_line(_x4, _y4, _x1, _y1);
*/