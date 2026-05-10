
function print(msg)
{
	show_debug_message(msg);
}

function resetObject()
{
	y = ystart;
	x = xstart;
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
	    var margin = 0.5;
	    var ground_top = platform.bbox_top;
	    var my_bottom = bbox_bottom;
	    var horizontal_overlap = bbox_right > platform.bbox_left && bbox_left < platform.bbox_right;
	    var touching_top = my_bottom >= ground_top - margin && my_bottom <= ground_top + margin;

	    if (horizontal_overlap && touching_top)
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
		// to stop setting on_ground when my right is equal or greater than platform.left (and vice versa)
		if (bbox_right > inst.bbox_left && bbox_left < inst.bbox_right)
		{
	        on_ground = true;
	        platform = inst;
			print("setting ground");
		}
		else
		{
			print("aint doing anything")
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
	// Follow player if attached
	if (follow_target != noone)
	{
	    if (instance_exists(follow_target))
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
}

function checkFalling()
{
    // Start falling after second jump
	if (is_falling)
	{
		y += vertical_speed;
		can_reset = true;
		y = round(y)
    }
}

function main()
{
	vertical_speed += grav;
	checkToFollow();
	checkFalling();
	checkOnGround()
	//obj_platform = oWall
	if platform!=noone
	{
		yCollisionPlatform();
	}
}

main();
