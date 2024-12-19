//choosing step event over other events because I don't want it to be input specific
  
//inits
var x_origin, y_origin, x_end, y_end = 0;
var left_click = mouse_check_button(mb_left);
var left_click_release = mouse_check_button_released(mb_left);
var mouse_track = false;


if (left_click && position_meeting(x, mouse_y, self) )
{
	mouse_track = true;
}

if mouse_track
{
	x_origin = mouse_x;
	y_origin = mouse_y;
	
	dist = point_direction(x_origin, y_origin, mouse_x, mouse_y);
	
}
else
{
	mouse_track = false;
	//what if the mouse ends exactly where a slide should be created?
}



