if(irandom(180)==0 && cantwinkle && twinklewait <= 0) {
	twinklewait = random_range(.8,2);
}
if(twinklewait>0) {
	twinklewait-=delta_time/1000000
		
	gpu_set_fog(true, c_white, 500, 500)
	draw_self()
	gpu_set_fog(false, c_white,0,1000)
	draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,.5)
} else {
	draw_self()
}

x+=addx
y+=addy