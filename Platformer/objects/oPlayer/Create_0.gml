
function setOnGround(_val = true)
{
	on_ground = _val;
	if on_ground == true {coyote_hang_timer = coyote_hang_frames;}
	else coyote_hang_timer=0;
	
}

move_dir=0;
move_speed=2.47;
x_dist=0;
y_dist=0;

grav = .275;
y_speed_cap = 4;
jump_speed = -4.15;

jump_buffer_time = 0;
jump_buffer = false;
buffer_time = 3;
on_ground = false;

//Hang Time
//timers that transition between conditions
coyote_hang_frames = 30;
coyote_hang_timer = 0;

//Jump buffer time
coyote_jump_frames = 5;
coyote_jump_timer = 0;