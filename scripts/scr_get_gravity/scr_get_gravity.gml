// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//((GRAVITATIONAL_CONSTANT*m1*m2)/power(d,5))
function scr_get_gravity(planet, d){
	var G_CONST = 150;
	var G_RANGE = 128+global.addbuffer; //+3
	var dis = (d-planet.radius);
	
	//((dis<=G_RANGE) ? (dis<=global.addbuffer ? 0 : G_CONST) : (G_CONST/(d-planet.radius-G_RANGE)));
	return ((dis<=G_RANGE) ? (G_CONST) : (G_CONST/(d-planet.radius-G_RANGE)));
}

function scr_get_net_gravity(player, plist){
	var netx = 0;
	var nety = 0;
	for(var i = 0; i < array_length(plist); i++) {
		var curplanet = array_get(plist,i);
		var g = scr_get_gravity(curplanet,point_distance(player.x,player.y,curplanet.x,curplanet.y))
		netx+=lengthdir_x(g,point_direction(player.x,player.y,curplanet.x,curplanet.y))
		nety+=lengthdir_y(g,point_direction(player.x,player.y,curplanet.x,curplanet.y))
	}
	return {
		_x:netx,
		_y:nety
	}
}

function scr_get_closest_planet(player, plist) {
	var curdis = -1;
	var curplanet = noone;
	for(var i = 0; i < array_length(plist); i++) 
		if(point_distance(player.x,player.y,array_get(plist,i).x,array_get(plist,i).y)>curdis) {
			curdis = point_distance(player.x,player.y,array_get(plist,i).x,array_get(plist,i).y);
			curplanet = array_get(plist,i)
		} 
	return curplanet;
}

function scr_move_collide(obj, xmove, ymove, colobjs) {
	var precision = .001;
	
	if (place_meeting(obj.x+xmove,obj.y+ymove,colobjs)) {
		var xyratio = ymove==0 ? 1 : (abs(xmove/ymove))

		var incrx = sign(xmove)*precision*xyratio;
		var incry = sign(ymove)*precision;
		
		var totalx = abs(xmove);
		var totaly = abs(ymove);
		
		while (!place_meeting(obj.x+incrx,obj.y+incry,colobjs)&&xyratio!=0&&totalx>0&&totaly>0) {
			obj.x += incrx;
			obj.y += incry;
			
			totalx-=abs(incrx);
			totaly-=abs(incry);
		}
		xmove = 0;
		ymove = 0;
	}
	obj.x += xmove;
	obj.y += ymove;
}