camera_set_view_pos(
	view_camera[0],
	lerp(camera_get_view_x(view_camera[0]), oPlayer.x - (CamW / 2), .05),
	lerp(camera_get_view_y(view_camera[0]), oPlayer.y - (CamH / 2), .05)
);