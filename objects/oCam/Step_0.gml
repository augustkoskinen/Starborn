if(keyboard_check(ord("W"))){
	camera_set_view_size(view_camera[0],lerp(CamW,960,.05),lerp(CamH,540,.05))
} else {
	camera_set_view_size(view_camera[0],lerp(CamW,320,.05),lerp(CamH,180,.05))
}

CamW = camera_get_view_width(view_camera[0]);
CamH = camera_get_view_height(view_camera[0]);

camera_set_view_pos(
	view_camera[0],
	lerp(camera_get_view_x(view_camera[0]), oPlayer.x - (CamW / 2), .05),
	lerp(camera_get_view_y(view_camera[0]), oPlayer.y - (CamH / 2), .05)
);

var filter = 0.01;
var rate = 0.07;
var ad = angle_difference(-oPlayer.image_angle, camera_get_view_angle(view_camera[0]));

if (abs(ad) <= filter) {
    camera_set_view_angle(view_camera[0],-oPlayer.image_angle);
} else {
    camera_set_view_angle(view_camera[0],camera_get_view_angle(view_camera[0]) + ad*rate);
}