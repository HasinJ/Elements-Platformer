function startTracking(player)
{
	_player = player;
}

function trackPlayer(instance)
{
	if instance != noone
	{
		//offset mouse for centered collision
			//8 because half of height sprite, may want to change later
			//in other words, I chose 8 so that the object ONLY starts to move when the mouse is 8 pixels away from the center of the obj
		
		y_to_move = instance.y + lengthdir_y(16, point_direction(x,y,x,instance.y));
		show_debug_message(grav);
		
		y_dist = distance_to_point(x,y_to_move);
		move_towards_point(x, y_dist, instance.y_dist);
		show_debug_message(y_dist);
		//y_dist += grav;
		
		
		//speed = 0;
		////offset object since collision is in the center
		//y_to_move = ystart + lengthdir_y(8, point_direction(x,y,x,ystart));
		
		//distance = distance_to_point(x, y_to_move)
		//if distance > 2
		//{
		//	move_towards_point(x, y_start, grav);
		//}
		//else
		//{
		//	speed = 0;
		//	y = ystart;
		//}
		
		////variable move speed since object is moving and we don't want to clip into player
		//distance = distance_to_point(x, y_to_move);
		//if distance > 4
		//{
		//	y_dist = instance. + (distance*0.1);
		//	move_towards_point(x, y_to_move, y_dist);
		//}
		//else
		//{
		//	speed = 0;
		//}	
	}

	//resets object back to starting position (with offset)
	//else
	//{
	//	speed = 0;
	//	//offset object since collision is in the center
	//	y_to_move = y_start + lengthdir_y(8, point_direction(x,y,x,y_start));
	//	distance = distance_to_point(x, y_to_move);
	//	if distance > 2
	//	{
	//		move_towards_point(x, y_start, grav);
	//	}
	//	else
	//	{
	//		speed = 0;
	//		y = y_start;
	//	}
	//}
}


if _player!=noone
{
	trackPlayer(_player);
}

//y+=y_dist;