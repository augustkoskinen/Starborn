planet = noone;//scr_get_closest_planet(self, oPlanetManager.planetList);;

//particles
global.psystem = part_system_create();
global.treeps = part_type_create()
global.treepsem = part_emitter_create(global.psystem)

part_type_sprite(global.treeps,sTreeParticles,0,0,1);
part_type_size(global.treeps,1,1,0,0);
part_type_life(global.treeps,20,50)
part_type_speed(global.treeps,1,3,0,0);
part_type_direction(global.treeps,0,359,0,0);
part_type_gravity(global.treeps,.3,0)
part_type_orientation(global.treeps, 180,180, 0, 0, 0);
part_emitter_region(global.psystem, global.treepsem, x,x,y,y, ps_shape_ellipse, ps_distr_invgaussian);
part_emitter_relative(global.psystem, global.treepsem, true);
part_emitter_stream(global.psystem, global.treepsem, global.treeps, 50);


function hurt() {
	var pdir = point_direction(x,y,planet.x,planet.y)
	
	part_type_gravity(global.treeps,.3,pdir)
	part_type_orientation(global.treeps, 180+pdir, 180+pdir, 0, 0, 0);
	part_system_layer(global.psystem,layer_get_id("TreeParticles"))
	part_particles_create(global.psystem,x+lengthdir_x(32,pdir+180),y+lengthdir_y(32,pdir+180),global.treeps,50)
}