
//if jumped == true
//{
//	right_key = keyboard_check(ord("D"));
//	left_key = keyboard_check(ord("A"));
//}
//else
//{
//	right_key = 0
//	left_key = 0;
//}

//up_key_pressed = keyboard_check_pressed(ord("W"));
//move_dir = right_key - left_key;
//y_dist += grav;

////left right movement
//if (-1 <= move_dir <= 1)
//{
//	x_dist = move_dir * move_speed
//	var least_pixel_distance = .5;
	
//	if (place_meeting(x + x_dist, y, oWall))
//	{
//		//make sure the player isn't stopping too far before the wall - scooting the player
//		var pixel_check = least_pixel_distance * sign(x_dist)
//		while !(place_meeting(x + pixel_check, y, oWall))
//		{
//			x += pixel_check;
//		}
//		x_dist=0;
//	}
	
//	x += x_dist;
//}

//if on_ground
//{
//	jump_count = 0;
//}
//else
//{
//	//if player in the air, count that as a jump
//	if jump_count == 0 {jump_count++;};
//}


//if up_key_pressed
//{
//	//stores jump
//	jump_buffer = true;
//	jump_buffer_time = starting_jump_buffer_time;
//}

////timer on jump storage
//if jump_buffer_time <= 0
//{
//	jump_buffer = false;
//}
//else
//{
//	jump_buffer_time--;
//}

//if jump_buffer == true && jump_count < jump_max
//{
//	//Reset the buffer, since we're done jumping
//	jump_buffer = false;
//	jump_buffer_time = 0;
	
//	//jump
//	y_dist = jump_speed;
//	jump_count++;
//	jumped = true;
//}


////checks the place you're jumping towards
//if (place_meeting(x, y + y_dist, oWall))
//{	
//	//make sure the player isn't stopping too many pixels far
//	var least_pixel_distance = .5;
//	var pixel_check = least_pixel_distance * sign(y_dist);
//	while !(place_meeting(x, y + pixel_check, oWall))
//	{
//		y += least_pixel_distance * sign(y_dist);
//	}
//	y_dist = 0;
//}



//if y_dist >= 0 && place_meeting(x, y+1, oWall) 
//{
//	on_ground = true;
//	if jumped == true
//	{
//		x = xstart;
//		y = ystart;
//		jumped=false;
//	}
//	else
//	{
//		xstart = x;
//		ystart = y;
//	}
	
//}

//if !place_meeting(x, y+1, oWall) 
//{
//	on_ground = false;
//}

//y += y_dist;

function spin()
{
	dir += rotSpd;

	var _targetX = xstart + lengthdir_x(radius, dir);
	var _targetY = ystart + lengthdir_y(radius, dir);

	xspd = _targetX - x;
	yspd = _targetY - y;

	x += xspd;
	y += yspd;

}

function print(msg)
{
	show_debug_message(msg);
}

function startTracking(player)
{
	if player != noone && instance_exists(player) { _player = player;}
	else
	{
		_player = noone;
	}
}

function jumpButtonCheck()
{
	
	////jump buffer
	//if up_key_pressed
	//{
	//	jump_buffer_time = buffer_time;
	//}
	
	//if jump_buffer_time > 0
	//{
	//	jump_buffer = true;
	//	jump_buffer_time--;
	//}
	
	//else
	//{
	//	jump_buffer = false;
	//	jump_buffer_time = 0;
	//}
	
	if(up_key_pressed && jump_count < jump_max) //add jump_buffer to this, if tracking jump buffering
	{
		if jump_count == 0
		{
			y_dist = jump_speed-2;
			jump_buffer = false;
			jump_buffer_time = 0;
			jump_count++;
		}
		
		else if jump_count == 1
		{
			var second_jump_y_dist = 7.15 //jump_speed but opposite direction (for now)
			
			if !sign(y_dist) {y_dist = 0;}
			y_dist += second_jump_y_dist;
			jump_buffer = false;
			jump_buffer_time = 0;
			jump_count++;
			show_debug_message("oMoveableWall - jumping 2");
		}
	}
}

function checkCollisionBelowDelete()
{
	//placeholder until i figure out how to delete/respawn stuff
	if place_meeting(x, y+y_dist, oWall)
	{
		//scoot first
		var pixel_check = .5; //may want to change this value based on res
	
		//move below while platform is moving below
		while !place_meeting(x, y + pixel_check, oWall)
		{
			y += pixel_check;
			
		}
		y_dist = 0;
		
		//then delete
		y = ystart;
		x = xstart;
		jump_count = 0;
	}
}

function checkCollisionBelow()
{
	//if place_meeting(x, y + 4, [oWall])
	//{
	//	print(y_dist);
	//	print("deleting");
	//	//startTracking(noone);
	//	y = ystart;
	//	y_dist = 0;
	//	jump_count = 0;
	//}
	
	//temporary till i can figure out how to reset
	if place_meeting(x, y+1, oWall)
	{
		var pixel_check = .5; //may want to change this value based on res
	
		//move below while platform is moving below
		while !place_meeting(x, y + pixel_check, oWall)
		{
			y += pixel_check;
			
		}
		y_dist = 0;
	}
}

function checkCollisionAbove()
{
	if place_meeting(x,y-1,[oPlayerV2])
	{
		jumpButtonCheck();
	} 
}


function main()
{
	
	up_key_pressed = keyboard_check_pressed(vk_up);
	y_dist += grav; //applying gravity


	if jump_count > 1
	{
		 //only check for collision below after gaining momentum
		 //can't be certain that it is a player that will be moving propelling the object downward
		 //to trigger reset
		 checkCollisionBelowDelete();
	}

	if jump_count == 0
	{
		checkCollisionBelow();
	}

	//collision above for platform jumping
	checkCollisionAbove();

	//cap fall speed //i dont think this works
	if (y_dist > y_speed_cap)
	{
		y_dist = y_speed_cap;
	}
	y+=y_dist;	
}

main();

