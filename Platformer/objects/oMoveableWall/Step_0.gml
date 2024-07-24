left_click = mouse_check_button(mb_left);
left_click_release = mouse_check_button_released(mb_left);


if (left_click && position_meeting(x, mouse_y, self) )
{
	mouse_track = true;
}

if mouse_track
{
	//offset mouse for centered collision
	y_to_move = mouse_y + lengthdir_y(8, point_direction(x,y,x,mouse_y)); //8 because half of height sprite, may want to change later
	
	//variable move speed
	distance = distance_to_point(x, y_to_move);
	if distance > 4
	{
		y_dist = y_speed + (distance*0.1);
		move_towards_point(x, mouse_y,y_dist);
	}
	else
	{
		speed = 0;
	}	
}

else
{
	speed = 0;
	//offset object since collision is in the center
	y_to_move = y_start + lengthdir_y(8, point_direction(x,y,x,y_start));
	distance = distance_to_point(x, y_to_move);
	if distance > 2
	{
		move_towards_point(x, y_start, grav);
	}
	else
	{
		speed = 0;
		y = y_start;
	}
}

if (left_click_release)
{
	mouse_track = false;
}

y = clamp(y, y_start+y_cap, y_start);





	







