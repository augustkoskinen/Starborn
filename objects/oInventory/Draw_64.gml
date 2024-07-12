var scalew = window_get_width()/sprite_get_width(sBody);
var scaleh = window_get_height()/sprite_get_height(sBody);
var _w = sprite_get_width(sSlot)*scalew;
var _h = sprite_get_width(sSlot)*scalew;
if(oPlayer.inventoryopen) {
	var hovering = false;
	var hoveritem = noone;
	var hoverinvrow = noone;
	var hoverslotx = -1;
	
	draw_sprite_stretched(sBody,0,0,0,sprite_get_width(sBody)*scalew,sprite_get_height(sBody)*scaleh);
	
	var startx = 76;
	var starty = 111;
	var spacingx = 26;
	var spacingy = 27;
	for(var _x = 0; _x < 2; _x++)
		for(var _y = 0; _y < 3; _y++) {
			var _xx = startx*scalew+_x*spacingx*scalew;
			var _yy = starty*scaleh+_y*spacingy*scaleh;
			
			if (array_get(array_get(invAcc,_y),_x)!=noone) {
				draw_sprite_stretched(sSlot,2,_xx,_yy,_w,_h);
			}
			if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_xx,_yy,_xx+_w,_yy+_h)) {
				hoveritem = array_get(array_get(invAcc,_y),_x);
				hoverinvrow = array_get(invAcc,_y);
				hoverslotx = _x;
				hovering = true;
				draw_sprite_stretched(sSlot,1,_xx,_yy,_w,_h);
			} else {
				draw_sprite_stretched(sSlot,0,_xx,_yy,_w,_h);
			}
			if (array_get(array_get(invAcc,_y),_x)!=noone) {
				draw_sprite_stretched(sItem,array_get(array_get(invAcc,_y),_x).type,_xx,_yy,_w,_h);
				if(array_get(array_get(invAcc,_y),_x).amount>1) {
					draw_set_font(tInv)
					draw_text_transformed(_xx+40,_yy+40,array_get(array_get(invAcc,_y),_x).amount,2,2,0);
				}
			}
		}
			
	var startx = 149;
	var starty = 64;
	var spacingx = 26;
	var spacingy = 27;
	for(var _x = 0; _x < 6; _x++)
		for(var _y = 0; _y < 3; _y++) {
			var _xx = startx*scalew+_x*spacingx*scalew;
			var _yy = starty*scaleh+_y*spacingy*scaleh;
			
			if (array_get(array_get(invBody,_y),_x)!=noone) {
				draw_sprite_stretched(sSlot,2,_xx,_yy,_w,_h);
			}
			if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_xx,_yy,_xx+_w,_yy+_h)) {
				hoveritem = array_get(array_get(invBody,_y),_x);
				hoverinvrow = array_get(invBody,_y);
				hoverslotx = _x;
				hovering = true;draw_sprite_stretched(sSlot,1,_xx,_yy,_w,_h);
			} else {
				draw_sprite_stretched(sSlot,0,_xx,_yy,_w,_h);
			}
			if (array_get(array_get(invBody,_y),_x)!=noone) {
				draw_sprite_stretched(sItem,array_get(array_get(invBody,_y),_x).type,_xx,_yy,_w,_h);
				if(array_get(array_get(invBody,_y),_x).amount>1) {
					draw_set_font(tInv)
					draw_text_transformed(_xx+40,_yy+40,array_get(array_get(invBody,_y),_x).amount,2,2,0);
				}
			}
		}
	
	var startx = 149;
	var starty = 165;
	var spacingx = 26;
	var spacingy = 27;
	for(var _x = 0; _x < 6; _x++) {
		var _xx = startx*scalew+_x*spacingx*scalew;
		var _yy = starty*scaleh;
		
		if (array_get(invHotbar,_x)!=noone) {
			draw_sprite_stretched(sSlot,2,_xx,_yy,_w,_h);
		}
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_xx,_yy,_xx+_w,_yy+_h)) {
			hoveritem = array_get(invHotbar,_x);
			hoverinvrow = invHotbar;
			hoverslotx = _x;
			hovering = true;
			draw_sprite_stretched(sSlot,1,_xx,_yy,_w,_h);
		} else {
			draw_sprite_stretched(sSlot,0,_xx,_yy,_w,_h);
		}
		if (array_get(invHotbar,_x)!=noone) {
			draw_sprite_stretched(sItem,array_get(invHotbar,_x).type,_xx,_yy,_w,_h);
			if(array_get(invHotbar,_x).amount>1) {
				draw_set_font(tInv)
				draw_text_transformed(_xx+40,_yy+40,array_get(invHotbar,_x).amount,2,2,0);
			}
		}
	}
	
	if(mouse_check_button_pressed(mb_left)&&hovering) {
		if(dragitem==noone&&hoveritem!=noone) {
			dragitem = hoveritem;
			array_set(hoverinvrow, hoverslotx, noone);
		} else if(dragitem!=noone&&hoveritem==noone){
			array_set(hoverinvrow, hoverslotx, dragitem);
			dragitem = noone;
		} else if(dragitem!=noone&&hoveritem!=noone){
			if(dragitem.type==hoveritem.type) {
				if(dragitem.stackable) {
					if(dragitem.amount+hoveritem.amount<=hoveritem.amountmax) {
						hoveritem.amount += dragitem.amount;
						dragitem = noone;
					} else {
						dragitem.amount = (dragitem.amount+hoveritem.amount)-hoveritem.amountmax;
						hoveritem.amount = hoveritem.amountmax;
					}
				} else {
					array_set(hoverinvrow, hoverslotx, dragitem);
					dragitem = hoveritem;
				}
			} else {
				array_set(hoverinvrow, hoverslotx, dragitem);
				dragitem = hoveritem;
			}
		}
	} else if(mouse_check_button_pressed(mb_left)&&dragitem!=noone) {
		dragitem.drop(oPlayer.x+lengthdir_x(16,oPlayer.image_angle+90),oPlayer.y+lengthdir_y(16,oPlayer.image_angle+90));
		dragitem = noone;
	}
	
	if(dragitem!=noone) {
		draw_sprite_stretched_ext(sItem,dragitem.type,device_mouse_x_to_gui(0)-_w/2,device_mouse_y_to_gui(0)-_h/2,_w,_h,c_white,0.5);
	}
} else {
	if(keyboard_check_pressed(ord("1"))) oPlayer.curslot = 0;
	if(keyboard_check_pressed(ord("2"))) oPlayer.curslot = 1;
	if(keyboard_check_pressed(ord("3"))) oPlayer.curslot = 2;
	if(keyboard_check_pressed(ord("4"))) oPlayer.curslot = 3;
	if(keyboard_check_pressed(ord("5"))) oPlayer.curslot = 4;
	if(keyboard_check_pressed(ord("6"))) oPlayer.curslot = 5;
	
	draw_sprite_stretched(sHotbar,0,0,0,sprite_get_width(sBody)*scalew,sprite_get_height(sBody)*scaleh);
	
	for(var _x = 0; _x < 6; _x++) {
		var _xx = 111*scalew+_x*26*scalew;
		var _yy = 166*scaleh;
		
		var iscurslot = false
		if(_x==oPlayer.curslot) {
			draw_sprite_stretched(sSlot,1,111*scalew+oPlayer.curslot*26*scalew,166*scaleh,_w,_h);
			iscurslot = true;
		}	
		
		if (array_get(invHotbar,_x)!=noone) {
			if(!iscurslot)
				draw_sprite_stretched(sSlot,2,_xx,_yy,_w,_h);
			draw_sprite_stretched(sItem,array_get(invHotbar,_x).type,_xx,_yy,_w,_h);
			if(array_get(invHotbar,_x).amount>1) {
				draw_set_font(tInv)
				draw_text_transformed(_xx+40,_yy+40,array_get(invHotbar,_x).amount,2,2,0);
			}
		}
	}
	
}