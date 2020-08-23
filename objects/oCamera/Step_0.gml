// update camera's destination to sushi ball
// (or whatever object)
if(instance_exists(follow))
{
	xToFollow = follow.x;
	yToFollow = follow.y;
}

// update position of camera
x += (xToFollow - x) / strength;
y += (yToFollow - y) / strength;

// prevent from viewing outside border of room
x = clamp(x, view_w_half+buff, room_width-view_w_half-buff);
y = clamp(y, view_h_half+buff, room_height-view_h_half-buff);

// update view of camera
camera_set_view_pos(cam,x-view_w_half,y-view_h_half);