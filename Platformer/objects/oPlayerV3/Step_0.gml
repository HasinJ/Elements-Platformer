
function print(msg)
{
	show_debug_message(msg);
}

function escReset()
{
	if keyboard_check_pressed(vk_escape)
	{
		print("\n\n\n New Room:");
		room_restart();
	}
}

function checkXcollision()
{
	if (place_meeting(x + horizontal_speed, y, obj_platform)) 
	{
	    while (!place_meeting(x + sign(horizontal_speed), y, obj_platform)) 
		{
	        x += sign(horizontal_speed);
	    }
	    horizontal_speed = 0;
	}
}

function checkOnGround()
{
	on_ground = false;
    platform = noone;

    var inst = instance_place(x, y + 1, obj_platform);
	
    if (inst!=noone && inst.object_index == oMoveableWall.object_index && !inst.is_following)
    {
        on_ground = true;
        platform = inst;
    }
	else if (inst != noone)
	{
        on_ground = true;
        platform = inst;
	}
}

function checkYcollision()
{
    // Check collision before reaching target
	// TODO:
	// - Have object recognition be one thing, and actual application of object be another
	var inst = instance_place(x, y + vertical_speed, obj_platform);
    if (inst != noone)
    {
		if (vertical_speed > 0) // Falling
		{
			// Snap to platform top
			if (inst.object_index==oWall.object_index || (inst.object_index == oMoveableWall.object_index && inst.is_following == false)) // ignores collision for instances that are following, but keeps track of oWalls
			{
				y = inst.bbox_top - (bbox_bottom - y);
				vertical_speed = 0;
			}
		}
		else if (vertical_speed < 0) // Hitting ceiling
		{
			// Snap below platform
			y = inst.bbox_bottom + (y - bbox_top);
			vertical_speed = 0;
		}
    }
}

function checkJumping()
{
	if (on_ground && keyboard_check_pressed(vk_up)) 
	{
	    // Only allow jump-follow if standing on the special platform
	    if (platform != noone && platform.object_index == oMoveableWall.object_index)
	    {	
			platform.jump_count += 1;
			if platform.jump_count == 1 //first jump
			{
				 // Tell platform to follow player
				platform.follow_target = id;
				platform.follow_offset = platform.y - bbox_bottom //storing the original gap of the center of the platform relative to player
			    vertical_speed = jump_speed;
			}

			else if platform.jump_count >= 2
			{
				 platform.follow_target = noone;
				 platform.is_falling = true;
				 vertical_speed = jump_speed - 0.5; //second jump is a little higher
			} 
	    }
	    else if (platform != noone) //normal jump
	    {
	        // Normal jump from regular platform
	        //vertical_speed = jump_speed;
			platform.jump_count=0;
	        platform = noone;
	    }
	}
}


	
function main()
{
	escReset();
	obj_platform = oWall

	//-1 for left, 0 for nothing, 1 for right
	var move_dir = keyboard_check(vk_right) - keyboard_check(vk_left);
	horizontal_speed = move_dir * walk_speed
	
	if (vertical_speed < 0) // upwards motion (lower # means = more float)
	    vertical_speed += grv * 0.7;
	else					// downwards motion
	    vertical_speed += grv;
	
	// X collision
	checkXcollision();
	x += horizontal_speed;

	// Y collision
	// 1. Vertical speed needs to be applied before collision actually happens, can't be too late colliding
	// 2. Scoot to whatever is next to it
	// 3. Check if on ground after scooting, that way it's more precise to whatever it's scooted to
	// 4. Can now jump after checking on ground and scooted
	checkYcollision();
	checkOnGround();
	checkJumping();
	
	y += vertical_speed;
	y = round(y)
}

main();