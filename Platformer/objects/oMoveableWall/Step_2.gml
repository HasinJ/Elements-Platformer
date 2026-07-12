
function print(msg)
{
	show_debug_message(msg);
}

function stop()
{
	show_debug_message("pausing");
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

function followEdgeXAxis()
{		
	//might be deprecated, this was for x-following only when the player is moving past edge of platform
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

function startFollowing(following_id)
{
	follow_target = following_id;
	y_follow_offset = y - follow_target.bbox_bottom //storing the original gap of the center of the platform relative to player
	x_follow_offset = x - follow_target.x;	//storing original x-gap, player should be greater or equal most of the time
}

function startFalling(player_speed=0)
{
	follow_target = noone;
	is_falling = true;
	if player_speed > 0 && player_speed > fall_speed
	{
		vertical_speed = player_speed + fall_speed; //so that speed is maintained after following
	}
	else
	{
		vertical_speed = fall_speed;
	}
}

function main()
{
	// following player
	var tolerance = 2; //to continue follow with some slack
	if follow_target != noone
	{
		tolerance = abs(follow_target.vertical_speed) + 2; 
	}
	
	// Follow player if attached 
	// if it's still above -> && follow_target.bbox_bottom <= bbox_top + tolerance && follow_target.bbox_right > bbox_left && follow_target.bbox_left < bbox_right)
	if (follow_target != noone && instance_exists(follow_target) && follow_target.platform = id)
	{
		is_following = true;
		// y value stuff
		y = follow_target.bbox_bottom + y_follow_offset;
		
		// x value stuff
		x = follow_target.x + x_follow_offset;
	}
	else
	{
		is_falling = true;
	    follow_target = noone;
	}
	
	// falling
	if (is_falling)
    {
        vertical_speed += grav;

        if (!place_meeting(x, y + vertical_speed, oWall))
        {
            y += vertical_speed;
            y = round(y);
        }
        else
        {
            // Snap to the ground
            while (!place_meeting(x, y + sign(vertical_speed), oWall)) //while we're still not touching exactly, get to a point where we are
            {
                y += sign(vertical_speed);
            }

            vertical_speed = 0;
            is_falling = false;
			resetObject();
        }
    }
	
	
	//checkOnGround();
	
	//obj_platform = oWall
	//if platform!=noone
	//{
	//	yCollisionPlatform();
	//}
}

main();
