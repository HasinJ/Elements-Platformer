
function print(msg)
{
	show_debug_message(msg);
}

//x movement
right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);


//temp stuff until I figure out how to move the player up
//if (place_meeting(x, y+1, oMoveableWall))
//{
//	up_key_pressed = 0;
	
//}

//else
//{
//	up_key_pressed = keyboard_check_pressed(vk_up);
//}

up_key_pressed = 0;
	

//-1 for left, 0 for nothing, 1 for right
move_dir = right_key - left_key;

if (-1 <= move_dir <= 1)
{
	x_dist = move_dir * move_speed
	var least_pixel_distance = .5;
	
	//x + x_dist lets me do something to object before it gets there
	if (place_meeting(x + x_dist, y, oWall))
	{
		//check if there is a slope to climb, and isn't a wall
		if !(place_meeting(x + x_dist, y - abs(x_dist)-1, oWall)) //basically checking 45 degrees upward (direction we're going)
		{
			//we only need to fix the y-coordinate, since the x is what the player is controlling
			while place_meeting(x + x_dist, y, oWall) //confine y-scooting to while we're moving towards that wall, just until we're above it, want to be above it
			{
				y -= least_pixel_distance;
			}
		}
		
		else
		{
			//ceiling slope
			if !place_meeting(x + x_dist, y + abs(x_dist) + 1, oWall)  //checking 45 downward if there isn't a wall, so I can scoot the player towards the right direction
			{
				while place_meeting(x + x_dist, y, oWall)
				{
					//put oPlayer below oWall
					y += least_pixel_distance;
				}
			}
			
			else
			{
				//no slope
				//make sure the player isn't stopping too far before the wall - scooting the player
				var pixel_check = least_pixel_distance * sign(x_dist)
				while !(place_meeting(x + pixel_check, y, oWall))
				{
					x += pixel_check;
				}
				x_dist=0;
			}
		}
	}
	
	//go down slopes
	//1st checks that we're moving down
	//2nd checks that there isn't a wall beneath
	//3rd checks checks at a 45 degree slope downward (direction we're falling)
	if ( y_dist >=0 ) && ( !place_meeting(x + x_dist, y + 1, oWall) ) && (place_meeting(x + x_dist, y + abs(x_dist) + 1, oWall))
	{
		while !place_meeting(x + x_dist, y + least_pixel_distance, oWall)
		{
			y += least_pixel_distance;
		}
	}
	
	x += x_dist;
}



y_dist += grav;

//cap jump height
if (y_dist > y_speed_cap)
{
	y_dist = y_speed_cap;
}

//the +1 offsets the ground and allows us to jump even if we're not really on the ground
//y > 0 equates to gravity 
if y_dist >= 0 && (place_meeting(x, y+1, oWall))
{
	setOnGround(true);
	
}
else if !place_meeting(x, y+1, oWall)
{
	setOnGround(false);	
}

//jump buffer
if up_key_pressed
{
	jump_buffer_time = buffer_time;
}
if jump_buffer_time > 0
{
	jump_buffer = true;
	jump_buffer_time--;
}
else
{
	jump_buffer = false;
	jump_buffer_time = 0;
}


if(jump_buffer && on_ground) 
{
	//print("jumping")
	jump_buffer = false;
	jump_buffer_time = 0;
	y_dist = jump_speed;
	setOnGround(false);
}

//if !on_ground
//{
//	print("not on ground");
//}
//else
//{
//	print("on ground");
//}
	



//checks the place you're jumping towards
if (place_meeting(x, y + y_dist, oWall))
{	
	//make sure the player isn't stopping too far
	var least_pixel_distance = .5;
	var pixel_check = least_pixel_distance * sign(y_dist);
	while !(place_meeting(x, y + pixel_check, oWall))
	{
		y += least_pixel_distance * sign(y_dist);
	}
	y_dist = 0;
}


//Floor Y collision

//Check for solid and semisolid platforms under me
var _maxYspd = max(0,y_dist);
var _objects_touching = ds_list_create(); 
var _objects_check_for = array_create(0);
array_push(_objects_check_for, oMoveableWall);

// Check and add objects to list
  // x - current x degree, left + right doesn't really matter here
  // y
	// + 1               - in the case y is 0
	// + _maxYspd        - in the case that the player is moving, it only tracks downwards, this would allow the player to travel through the platform if I wanted it
var _size = instance_place_list(x, y+1 + _maxYspd + move_wall_max_y_spd, _objects_check_for, _objects_touching, false);


// Loop through colliding instances and only return if it's top is below player
for (var i = 0; i < _size; i++)
{
	var _inst = _objects_touching[| i];
	
	
	////return any kind of walls that are below the player
	if (_inst.y_dist <= y_dist || instance_exists(my_floor_plat))
	&& (_inst.y_dist > 0 || place_meeting(x, y+1 + _maxYspd, _inst))
	{
		if _inst.object_index == oWall 
		|| object_is_ancestor(_inst.object_index, oWall)
		|| floor(bbox_bottom) <= ceil(_inst.bbox_top - _inst.y_dist) //if player is ABOVE the wall (but this gets the wall's original position before it moved)
		{
			print(_inst.name);
			var instance_future_y_pos = _inst.bbox_top + _inst.y_dist; //first, get the position of the wall in the next frame,
			if !instance_exists(my_floor_plat)
			|| instance_future_y_pos <= my_floor_plat.bbox_top + my_floor_plat.y_dist // compare with the future position of the current platform we think we're on
			|| instance_future_y_pos <= bbox_bottom // if it's above player
			{
				my_floor_plat = _inst;
				print("found moveable wall");
			}
		}
	}
	
}

ds_list_destroy(_objects_touching);

//reset floor plat 
if instance_exists(my_floor_plat) && !place_meeting(x, y + y_speed_cap, my_floor_plat)
{
	my_floor_plat = noone;
}

if instance_exists(my_floor_plat)
{
	if my_floor_plat.object_index == oMoveableWall {
		print("on moveable wall");
		up_key_pressed = keyboard_check_pressed(vk_up);
	}
	var least_pixel_distance = .5;
	while !place_meeting(x, y + least_pixel_distance, my_floor_plat)
	{
		y+=least_pixel_distance;
	}
	if my_floor_plat.object_index == oMoveableWall || object_is_ancestor(my_floor_plat.object_index, oMoveableWall)
	{
		y-=least_pixel_distance;
	}
	y = floor(y);
	
	//print("on floor plat");
	y_dist = 0;
	setOnGround(true);
}
else
{
	
}




y += y_dist;




