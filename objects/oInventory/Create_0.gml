dragitem = noone;

invBody = array_create(3,noone);
invAcc = array_create(3,noone);
invHotbar = array_create(6,noone);

for(var _y = 0; _y < 3; _y++)
	array_set(invBody,_y,array_create(6,noone));
	
for(var _y = 0; _y < 3; _y++)
	array_set(invAcc,_y, array_create(2,noone));

array_set(invHotbar,0,scr_create_item(1));

function addItem(item) {
	return findSpot(item);
}

function findSpot(item) {
	for(var _x = 0; _x < 6; _x++) {
		var curitem = array_get(invHotbar,_x);
		if(curitem==noone) {
			array_set(invHotbar,_x,item);
			return true;
		}
		if(curitem.stackable&&curitem.amount<curitem.amountmax){
			curitem.amount++;
			return true;
		}
	}
	
	for(var _y = 2; _y >=0; _y--)
		for(var _x = 0; _x < 6; _x++){
			var curitem = array_get(array_get(invBody,_y),_x);
			if(curitem==noone) {
				array_set(array_get(invBody,_y),_x,item);
				return true;
			}
			if(curitem.stackable&&curitem.amount<curitem.amountmax){
				curitem.amount++;
				return true;
			}
		}
		
	return false;
}