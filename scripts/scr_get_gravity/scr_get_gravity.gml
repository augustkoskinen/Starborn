// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//((GRAVITATIONAL_CONSTANT*m1*m2)/power(d,5))
function scr_get_gravity(planet, d){
	var G_CONST = 150;
	var G_RANGE = 128
	var dis = (d-planet.radius);
	
	return ((dis<=G_RANGE) ? (dis<=1 ? 0 : G_CONST) : (G_CONST/(d-planet.radius-G_RANGE)));
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