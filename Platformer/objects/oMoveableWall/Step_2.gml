function startTracking(player)
{
	_player = player;
}

function trackPlayer(instance)
{
	if instance != noone
	{
		//might not work because the object isnt actually moving
		y = instance.bbox_bottom+16;
		x = instance.x;
		//y_dist = instance.y_dist;
	}
}

function jumpButtonCheck()
{
	
	if (jump_count >= jump_max)
	{
		instance_destroy();
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
	
	if(jump_buffer && jump_count < jump_max) 
	{
		if jump_count < 1
		{
			//print("jumping")
			jump_buffer = false;
			jump_buffer_time = 0;
			y_dist = jump_speed;
			jump_count++;
			show_debug_message("jumping");
		}
		else if jump_count == 2
		{
			
		}
	}
	
}


//if _player!=noone
//{
	//trackPlayer(_player);
//}

up_key_pressed = keyboard_check_pressed(vk_up);

//collision check
var _maxYspd = max(0,y_dist);
var _objects_touching = ds_list_create(); 
var _objects_check_for = array_create(0);
array_push(_objects_check_for, oPlayerV2);

var _size = instance_place_list(x, y - 1 - max(0,y_dist), _objects_check_for, _objects_touching, false);

for (var i = 0; i < _size; i++)
{
	//instance is of type 'ref'
	var _instance = _objects_touching[| i];
	if _instance.object_index==oPlayerV2 
	{
		_player = _instance;
		//ds_list_destroy(_objects_touching);
		//_player.stopFollowingMe();
		//instance_destroy();
		////show_debug_message("try deleting");
	}
	else
	{
		_player = noone;
	}
}

ds_list_destroy(_objects_touching);



if instance_exists(_player)
{
	jumpButtonCheck();
}

if y_dist < grav && (y_dist!=0 || jump_buffer)
{
	y_dist += grav;
}

//cap jump height
if (y_dist > y_speed_cap)
{
	y_dist = y_speed_cap;
}

y+=y_dist;