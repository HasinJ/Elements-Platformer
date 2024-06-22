left_click = mouse_check_button(mb_left);
left_click_release = mouse_check_button_released(mb_left);



if (left_click && position_meeting(x, mouse_y, self) )
{
	mouse_track = true;
}

if mouse_track
{
	move_towards_point(self.x, mouse_y, y_dist);
}

if (left_click_release)
{
	speed=0;
	mouse_track = false;
}


//make it so that the trigger to stop is slightly farther than the mouse  
//this way the object movement doesn't stop when the mouse collides with the object
x_to_move = mouse_x + lengthdir_x(8, direction); //8 because it's half of the 16x16 object
y_to_move = mouse_y + lengthdir_y(8, direction);

//if distance is < 4, don't move the object
distance = distance_to_point(x_to_move, y_to_move); 
if (distance < y_dist)
{
	speed = 0;
}



	







