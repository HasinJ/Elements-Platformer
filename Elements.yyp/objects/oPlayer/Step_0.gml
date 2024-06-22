
//x movement
right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key_pressed = keyboard_check_pressed(vk_up);

//-1 for left, 0 for nothing, 1 for right
move_dir = right_key - left_key;

if (-1 <= move_dir <= 1)
{
	x_dist = move_dir * move_speed
	
	if (place_meeting(x + x_dist, y, oWall))
	{
		//make sure the player isn't stopping too far before the wall
		var least_pixel_distance = .5;
		var pixel_check = least_pixel_distance * sign(x_dist)
		while !(place_meeting(x + pixel_check, y, oWall))
		{
			x += pixel_check;
		}
		x_dist=0;
	}
	
	x += x_dist;	
}



//y movement
y_dist += grav;
if (y_dist > y_speed_cap){y_dist = y_speed_cap;}

if(up_key_pressed && place_meeting(x, y+1, oWall))
{
	y_dist = jump_speed;	
}

if (place_meeting(x, y + y_dist, oWall))
{	
	var least_pixel_distance = .5;
	var pixel_check = least_pixel_distance * sign(y_dist);
	while !(place_meeting(x, y + pixel_check, oWall))
	{
		y += least_pixel_distance * sign(y_dist);
	}
	y_dist = 0;
}

y += y_dist;




