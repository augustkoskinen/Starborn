//x+=1;
//if(scr_get_gravity(self, point_distance(x,y,oPlayer.x,oPlayer.y))==150) oPlayer.x++;

for(var i = 0; i < array_length(treelist); i++) {
	var tree = array_get(treelist, i);
	if(tree!=noone&&instance_exists(tree)) {
		tree.x = x+lengthdir_x(radius,tree.image_angle+90);
		tree.y = y+lengthdir_y(radius,tree.image_angle+90);
		tree.planet = self;
	}
}