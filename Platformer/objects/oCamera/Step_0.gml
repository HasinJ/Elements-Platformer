if keyboard_check_pressed(vk_f8)
{
	window_set_fullscreen(!window_get_fullscreen());
}

if !instance_exists(oPlayer) exit;

var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

//since the top left corner of a rectangle is the coordinate of the cam
var _camX = oPlayer.x - (_camWidth/2);
var _camY = oPlayer.y - (_camHeight/2);

_camX = clamp(_camX, 0, room_width - _camWidth); //since the coordinate the top left of the camera, the room_width (or height) wouldnt be accurate, need to offset
_camY = clamp(_camY, 0, room_height - _camHeight);


// making the camera approach the X/Y coordinate
// subtraction shows the distance the camera needs to move to meet "camX", the place where we want to be
// this way we aren't snapping to player coordinate
finalX += trailSpeed * (_camX - finalX); 
finalY += trailSpeed * (_camY - finalY);


camera_set_view_pos(view_camera[0], finalX, finalY);


