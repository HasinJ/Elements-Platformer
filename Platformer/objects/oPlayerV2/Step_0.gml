
function print(msg)
{
	show_debug_message(msg);
}

function escReset()
{
	if keyboard_check_pressed(vk_escape)
	{
		room_restart();
	}
}

function applyGravity()
{
	y_dist += grav;
}

function wallScoot()
{
	//checks the place you're jumping towards
	if (place_meeting(x, y + y_dist, oWall))
	{	
		//make sure the player isn't stopping too far
		var least_pixel_distance = .5; //may want to change this value based on res
		var pixel_check = least_pixel_distance * sign(y_dist);
		while !(place_meeting(x, y + pixel_check, oWall))
		{
			y += least_pixel_distance * sign(y_dist);
		}
		y = floor(y); //to avoid being too far from obj or clipping inside it
		y_dist = 0;
	}
}

function jumpButtonCheck()
{
	
	if (on_ground)
	{
		jump_count = 0;
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
	
	if(jump_buffer && on_ground && jump_count < jump_max) 
	{
		//print("jumping")
		jump_buffer = false;
		jump_buffer_time = 0;
		y_dist = jump_speed;
		jump_count++;
		bringPlatform();
	}

	
}

function bringPlatform()
{
	if my_floor_plat != noone
	{
		following_plat = true;
		my_floor_plat.startTracking(id);
	}
}







escReset();

//x movement
right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key_pressed = keyboard_check_pressed(vk_up);

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

applyGravity();

//collision check
var _maxYspd = max(0,y_dist);
var _objects_touching = ds_list_create(); 
var _objects_check_for = array_create(0);
array_push(_objects_check_for, oMoveableWall, oWall);

var _size = instance_place_list(x, y + 1 + max(0,y_dist), _objects_check_for, _objects_touching, false);

for (var i = 0; i < _size; i++)
{
	//instance is of type 'ref'
	var _instance = _objects_touching[| i];
	if _instance.object_index == oMoveableWall
	{
		canJump(true);
		my_floor_plat = _instance;
	}
	else
	{
		canJump(false);
		my_floor_plat = _instance;
	}
	
	
}
ds_list_destroy(_objects_touching);

jumpButtonCheck();
wallScoot();


y += y_dist;






