target_x = x; target_y = y;
look_x = 0; look_y = -1;
center_x = x + (sprite_get_bbox_right(sprite_index) / 2);
center_y = y + (sprite_get_bbox_bottom(sprite_index) / 2);

can_move = true;
walk_sp = 1; // must be able to divide by 16 with no remainder
speed = 0;

invunerable = false;
invunerable_timer = Sec2Frames(1);

sprite_idle = sPlayerIdle;
//sprite_walk = sPlayerWalk; // TODO

image_speed = 0;
sprite_index = sprite_idle;
local_frame = 0;
