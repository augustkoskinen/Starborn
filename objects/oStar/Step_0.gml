if(irandom(180)==0 && cantwinkle && twinklewait <= 0) {
	image_index+=2;
	twinklewait = random_range(.8,2);
}
if(twinklewait>0) {
	twinklewait-=delta_time/1000000
	if(twinklewait<=0)
		image_index-=2;
}