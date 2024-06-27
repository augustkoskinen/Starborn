treelist = array_create(0);
radius = 160-global.addbuffer;

var reps = random_range(8,10);
for(var i = 0; i < reps; i++) {
	var dir = random_range(0,359);
	var tree = instance_create_layer(x+lengthdir_x(radius,dir), y+lengthdir_y(radius,dir), "Trees", oTree);
	tree.image_angle = dir-90;
	array_push(treelist, tree);
}