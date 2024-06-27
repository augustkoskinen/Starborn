dragitem = noone;

invBody = array_create(3,noone);
invAcc = array_create(3,noone);
invHotbar = array_create(6,noone);

for(var _y = 0; _y < 3; _y++)
	array_set(invBody,_y,array_create(6,noone));
	
for(var _y = 0; _y < 3; _y++)
	array_set(invAcc,_y, array_create(2,noone));

array_set(array_get(invAcc,irandom_range(0,3)),irandom_range(0,2),scr_create_item(0,irandom_range(1,16)));
array_set(array_get(invBody,irandom_range(0,3)),irandom_range(0,6),scr_create_item(0,irandom_range(1,16)));
array_set(invHotbar,irandom_range(0,6),scr_create_item(0,irandom_range(1,16)));