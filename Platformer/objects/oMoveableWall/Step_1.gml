
if jumped == true
{
	right_key = keyboard_check(ord("D"));
	left_key = keyboard_check(ord("A"));
}
else
{
	right_key = 0
	left_key = 0;
}

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
	jumped = true;
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



////Floor Y collision

////Check for solid and semisolid platforms under me
//var _maxYspd = max(0,y_dist);
//var _objects_touching = ds_list_create(); 
//var _objects_check_for = array_create(0);
//_objects_check_for[0] = oWall;

//// Check and add objects to list
//  // x - current x degree, left + right doesn't really matter here
//  // y
//	// + 1               - in the case y is 0
//	// + _maxYspd        - in the case that the player is moving, it only tracks downwards
//	// + moveplatMaxYspd - in the case that the platformer is moving faster than the player can potentially move
//var _size = instance_place_list(x, y+1 + _maxYspd + move_wall_max_y_spd, _objects_check_for, _objects_touching, false);

//// Loop through colliding instances and only return if it's top is below player
//for (var i = 0; i < _size; i++)
//{
//	var _inst = _objects_touching[| i];
//	if floor(bbox_bottom) <= ceil(_inst.bbox_top) && destroyable && floor()
//	{
//		show_debug_message("found");
//		if (on_ground == false)
//		{
//			x = xstart;
//			y = ystart;
//		}
//	}
	
//}

if y_dist >= 0 && place_meeting(x, y+1, oWall) 
{
	on_ground = true;
	if jumped == true
	{
		x = xstart;
		y = ystart;
		jumped=false;
	}
	else
	{
		xstart = x;
		ystart = y;
	}
	
}
else if !place_meeting(x, y+1, oWall) 
{
	on_ground = false;
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