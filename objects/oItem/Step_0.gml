if(state == itemstate.dropped) {
	visible = true;
	sprite_index = sItem;
	image_index = type;
	image_xscale = .25;
	image_yscale = .25;

	image_speed = 0;
	
	dropwait -= delta_time/1000000
	var planet = scr_get_closest_planet(self, oPlanetManager.planetList);
	var pdir = point_direction(x,y,planet.x,planet.y);
	image_angle = pdir+90

	var g = scr_get_gravity(planet,pdir)*.5*delta_time/1000000
	scr_move_collide(self,lengthdir_x(g,pdir),lengthdir_y(g,pdir),oCollision);
	
	if(dropwait<=0&&place_meeting(x,y,oPlayer)) {
		var added = oInventory.addItem(self)
		if(added)
			state = itemstate.held;
	}
} else {
	visible = false;
}