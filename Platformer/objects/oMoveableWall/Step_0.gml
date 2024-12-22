
right_key = keyboard_check(ord("D"));
left_key = keyboard_check(ord("A"));
up_key_pressed = keyboard_check_pressed(ord("W"));
move_dir = right_key - left_key;
y_dist += grav;

//left right movement
if (-1 <= move_dir <= 1)
{
	x_dist = move_dir * move_speed
	var least_pixel_distance = .5;
	
	if (place_meeting(x + x_dist, y, oWall))
	{
		//make sure the player isn't stopping too far before the wall - scooting the player
		var pixel_check = least_pixel_distance * sign(x_dist)
		while !(place_meeting(x + pixel_check, y, oWall))
		{
			x += pixel_check;
		}
		x_dist=0;
	}
	
	x += x_dist;
}

if on_ground
{
	jump_count = 0;
}
else
{
	//if player in the air, count that as a jump
	if jump_count == 0 {jump_count++;};
}


if up_key_pressed
{
	//stores jump
	jump_buffer = true;
	jump_buffer_time = starting_jump_buffer_time;
}

//timer on jump storage
if jump_buffer_time <= 0
{
	jump_buffer = false;
}
else
{
	jump_buffer_time--;
}

if jump_buffer == true && jump_count < jump_max
{
	//Reset the buffer, since we're done jumping
	jump_buffer = false;
	jump_buffer_time = 0;
	
	//jump
	y_dist = jump_speed;
	jump_count++;
}


//checks the place you're jumping towards
if (place_meeting(x, y + y_dist, oWall))
{	
	//make sure the player isn't stopping too far - scooting object towards ground
	var least_pixel_distance = .5;
	var pixel_check = least_pixel_distance * sign(y_dist);
	while !(place_meeting(x, y + pixel_check, oWall))
	{
		y += least_pixel_distance * sign(y_dist);
	}
	y_dist = 0;
}

//check if on ground
if y_dist >= 0 && place_meeting(x,y+1,oWall)
{
	on_ground = true;
}
else
{
	on_ground =  false;
}

y += y_dist;



//left_click = mouse_check_button(mb_left);
//left_click_release = mouse_check_button_released(mb_left);


//if (left_click && position_meeting(x, mouse_y, self) )
//{
//	mouse_track = true;
//}

//if mouse_track
//{
//	//offset mouse for centered collision
//	  //8 because half of height sprite, may want to change later
//	  //in other words, I chose 8 so that the object ONLY starts to move when the mouse is 8 pixels away from the center of the obj
//	y_to_move = mouse_y + lengthdir_y(8, point_direction(x,y,x,mouse_y)); 
	
//	//variable move speed
//	distance = distance_to_point(x, y_to_move);
//	if distance > 4
//	{
//		y_dist = y_speed + (distance*0.1);
//		move_towards_point(x, mouse_y,y_dist);
//	}
//	else
//	{
//		speed = 0;
//	}	
//}

//else
//{
//	speed = 0;
//	//offset object since collision is in the center
//	y_to_move = y_start + lengthdir_y(8, point_direction(x,y,x,y_start));
//	distance = distance_to_point(x, y_to_move);
//	if distance > 2
//	{
//		move_towards_point(x, y_start, grav);
//	}
//	else
//	{
//		speed = 0;
//		y = y_start;
//	}
//}

//if (left_click_release)
//{
//	mouse_track = false;
//}

//y = clamp(y, y_start+y_cap, y_start);