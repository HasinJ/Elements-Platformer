
	
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
up_key_pressed = 0;


//jump stuff
grav = .5;
y_speed_cap = 8;
jump_speed = -7.15;
jump_buffer_time = 0;
jump_buffer = false;
buffer_time = 3;
jump_count = 0;
jump_max = 2;
on_earth = false;