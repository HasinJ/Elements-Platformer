
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
	//make sure the player isn't stopping too many pixels far
	var least_pixel_distance = .5;
	var pixel_check = least_pixel_distance * sign(y_dist);
	while !(place_meeting(x, y + pixel_check, oWall))
	{
		y += least_pixel_distance * sign(y_dist);
	}
	y_dist = 0;
}



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
