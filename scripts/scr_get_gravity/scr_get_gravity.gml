// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function scr_get_gravity(m1, m2, d){
	var GRAVITATIONAL_CONSTANT = 1*power(10,12);
	return ((GRAVITATIONAL_CONSTANT*m1*m2)/power(d,5));
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