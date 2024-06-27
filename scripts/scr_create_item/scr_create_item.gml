// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_item(type){
	var item = instance_create_layer(0,0,"Items",oItem)
	item.type = type;
	
	switch(type) {
		case 0: {
			item.stackable = true;
			item.amountmax = 16;
			break;
		}
	}
	
	if(item.stackable&&argument_count>1) {
		item.amount = min(item.amountmax, argument[1]);
	}
	
	return item;
}