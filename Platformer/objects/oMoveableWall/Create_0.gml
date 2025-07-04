//mouse_track = false;
//y_cap = -150;
//y_dist = 0;
//x_dist = 0;
//grav = .275;
//move_speed = 0.5;

////jumping stuff
//jump_speed = -7.15;
//on_ground = false;
//jumped = false;
	
//	//jump buffer
//	jump_buffer = false;
//	jump_buffer_time = 0;
//	starting_jump_buffer_time = 3;

//    //double jump
//	jump_count = 0;
//	jump_max = 1;
	
//	//jump hold
//	jump_hold = 0;
//	jump_hold_timer = 0;
//	startiing_jump_hold_timer = 18;
	
////Moving platform
//my_floor_plat = noone;
//move_wall_x_spd = 0;
//move_wall_max_y_spd = 8;
//name = "moveable wall"
	
event_inherited();
dir = 0;
rotSpd = 360 / 45;
radius = 32;
y_dist = 0;
_player = noone;
grav = .275;
my_floor_plat = noone;