//x+=1;
for(var i = 0; i < array_length(treelist); i++) {
	var tree = array_get(treelist, i);
	tree.x = x+lengthdir_x(radius,tree.image_angle+90);
	tree.y = y+lengthdir_y(radius,tree.image_angle+90);
	tree.planet = self;
}