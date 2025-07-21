
function canJump(_val = true)
{
	on_earth = _val;
	if on_earth == true 
	{
		coyote_hang_timer = coyote_hang_frames;
	}
	else 
	{
		coyote_hang_timer=0;
		
	}
	
}

move_dir=0;
move_speed=2.47;
x_dist=0;
y_dist=0;

grav = .275;
y_speed_cap = 8;
jump_speed = -7.15;

jump_buffer_time = 0;
jump_buffer = false;
buffer_time = 3;
jump_count = 0;
jump_max = 2;
on_earth = false;

//Hang Time
//timers that transition between conditions
coyote_hang_frames = 30;
coyote_hang_timer = 0;

//Jump buffer time
coyote_jump_frames = 5;
coyote_jump_timer = 0;

//Moving platform
my_floor_plat = noone;
following_plat = false;
move_wall_x_spd = 0;
move_wall_max_y_spd = 8;
can_jump = false;