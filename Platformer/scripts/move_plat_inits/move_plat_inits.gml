// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function setMovingPlatformVariables()
/// @description Initializes variables for moving platform 
function setMovingPlatformVariables(){
	//reset variables
	on_ground = false;
	follow_target = noone;
	follow_offset = 0;
	jump_count = 0;
	is_following = false;
	is_falling = false;
	platform = noone;
	vertical_speed = 0;
	fall_speed = 2;

	walk_speed = 4;
	obj_platform = oWall;
	grav = 0.6;
}

function resetObject()
{
	y_start = y;
	x_start = x; 
	y = y_start;
	x = x_start;
	setMovingPlatformVariables();
}