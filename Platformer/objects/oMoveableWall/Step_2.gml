
function print(msg)
{
	show_debug_message(msg);
}

function stop()
{
	show_debug_message("pausing");
}

function resetObject()
{
	y = y_start;
	x = x_start;
	setMovingPlatformVariables();
}

function yCollisionPlatform()
{
	if on_ground
	{
		jump_count=0;
	}
	
	if platform != noone
	{
	    var offset = 0.5; 
	    var ground_top = platform.bbox_top;
	    var my_bottom = bbox_bottom;
	    var horizontal_bounds = bbox_right > platform.bbox_left && bbox_left < platform.bbox_right; //within boundaries of platform
	    var touching_top = my_bottom >= ground_top - offset && my_bottom <= ground_top + offset; 
		
	    if (touching_top)
	    {
	        resetObject();
	    }
	}
}

function checkOnGround()
{      
	on_ground = false;
    platform = noone;

    var inst = instance_place(x, y + 1, obj_platform);
    if (inst!=noone)
    {
		//(copied from playerv3)
		// to stop setting on_ground when my right is equal or greater than platform.left (and vice versa)
		if (bbox_right > inst.bbox_left && bbox_left < inst.bbox_right)
		{
	        on_ground = true;
	        platform = inst;
		}
	}
}

function followXAxis()
{		
	var player_left = follow_target.bbox_left;
	var player_right = follow_target.bbox_right;
	var margin = 0.5; //to offset and trigger action before collision gets tight
	var left_edge = bbox_left + margin;
	var right_edge = bbox_right - margin;
			
	// Player pushing right edge
	if (player_right > right_edge)
	{
		return x + (player_right - right_edge);
	}

	// Player pushing left edge
	else if (player_left < left_edge)
	{
		return x - (left_edge - player_left);
	}
	
	return x;
}

function checkToFollow()
{
	// TODO: if statement to check if player is even above anymore
	
	// Follow player if attached and if it's still above
	if (follow_target != noone && instance_exists(follow_target) && place_meeting(x, y - follow_target.vertical_speed, follow_target))
	{
		can_reset = false;
		is_following = true;
		y = follow_target.bbox_bottom + follow_offset;
		//x = follow_target.x;
		//x = followXAxis();
	}
	else
	{
	    follow_target = noone;
	}
}

function checkFalling()
{
    // Start falling after second jump
	if (is_falling)
	{
		can_reset = true;
		vertical_speed += grav;
		y += vertical_speed;
		y = round(y)
    }
}

function startFollowing(following_id, following_bottom)
{
	follow_target = following_id;
	follow_offset = y - following_bottom //storing the original gap of the center of the platform relative to player
}

function startFalling()
{
	follow_target = noone;
	is_falling = true;
}

function main()
{
	checkToFollow();
	checkFalling();
	//checkOnGround();
	
	//obj_platform = oWall
	//if platform!=noone
	//{
	//	yCollisionPlatform();
	//}
}

main();
