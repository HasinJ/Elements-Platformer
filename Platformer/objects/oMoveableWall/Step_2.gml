
function print(msg)
{
	show_debug_message(msg);
}

function checkYcollision()
{
	if on_ground
	{
		jump_count=0;
	}
	
    // Check collision before actually does so
    if (place_meeting(x, y + vertical_speed, obj_platform)) 
    {
        var inst = instance_place(x, y + vertical_speed, obj_platform);
        if (vertical_speed > 0) // Falling
        {
            // Snap to platform top
            y = inst.bbox_top - (bbox_bottom - y);
            on_ground = true;
            platform = inst;
        }
        vertical_speed = 0;
    }
}

function main()
{
	vertical_speed += grav;
	obj_platform = oWall
	
	// Follow player if attached
	if (follow_target != noone)
	{
	    if (instance_exists(follow_target))
	    {
			is_following = true;
	        y = follow_target.bbox_bottom + follow_offset;
	    }
	    else
	    {
	        follow_target = noone;
	    }
	}

	// Start falling after second jump
	if (is_falling)
	{
		y += vertical_speed;
		//checkYcollision();
		y = round(y)
    }
	
	//obj_platform = oWall
	//checkYcollision();


}

main();
