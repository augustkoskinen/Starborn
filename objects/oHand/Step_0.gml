delaycount-=delta_time/1000000

if(place_meeting(x,y,oTree)&&oPlayer.state == playerstate.attacking&&(floor(oPlayer.image_index)==10||floor(oPlayer.image_index)==4)&&delaycount<=0) {
	var tree = instance_nearest(x,y,oTree)
	tree.hurt();
	
	var item = scr_create_item(0)
	var pdir = point_direction(tree.x,tree.y,tree.planet.x,tree.planet.y)
	var randir = random_range(0,359)
	var ranmag = random_range(0,10)
	item.drop(tree.x+lengthdir_x(32,pdir+180)+lengthdir_x(ranmag,randir),tree.y+lengthdir_y(32,pdir+180)+lengthdir_y(ranmag,randir));
	
	delaycount = .25;
}