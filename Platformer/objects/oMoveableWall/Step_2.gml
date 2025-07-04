function startTracking(player)
{
	_player = player;
}

function trackPlayer(instance)
{
	if instance != noone
	{
		y = instance.bbox_bottom+16;
		x = instance.x;
	}
}

if _player!=noone
{
	trackPlayer(_player);
}

//collision check
var _maxYspd = max(0,y_dist);
var _objects_touching = ds_list_create(); 
var _objects_check_for = array_create(0);
array_push(_objects_check_for, oWall);

var _size = instance_place_list(x, y + 1 + max(0,y_dist), _objects_check_for, _objects_touching, false);

for (var i = 0; i < _size; i++)
{
	
	//instance is of type 'ref'
	var _instance = _objects_touching[| i];
	if _instance.object_index==oWall && _player!=noone
	{
		ds_list_destroy(_objects_touching);
		instance_destroy();
	}
	else
	{
		my_floor_plat = _instance;
	}
}
ds_list_destroy(_objects_touching);

y+=y_dist;