#region transitions
if (screen_transition == FADE.OUT)
{
	percent+=0.025;
	if (percent == 1)
	{
		screen_transition = FADE.IN;
		if (!game_start)
		{
			msg = "";
			game_start = true;
		}
		else
		{
			game_over = true;
			if (!instance_exists(oTMASTreasure))
			{
				with (treasure_instance)
				{
					instance_change(object_assigned, false);	
				}
			}

			with (oTMASCamera)
			{
				follow = oTMASTreasure;
			}
		}
	}
	exit;
}
else if (screen_transition == FADE.IN)
{
	percent-=0.025;
	if (percent == 0) screen_transition = FADE.OFF;
	exit;
}
#endregion

#region game
// pre-game
if (!game_start)
{
	msg = "A pirate hid her\ntreasure\nin the island... Find it,\nand dig it up with 'c'.";
	if (keyboard_check_pressed(global.k_interact))
	{
		screen_transition = FADE.OUT;
	}
}
// in-game
else if (!game_over)
{
	#region calculate closeness and perform some effects if can
	var _color = c_white;
	var dist = point_distance(oTMASPlayer.x, oTMASPlayer.y, treasure_instance.x, treasure_instance.y);
	var has_shake = ds_map_find_value(oTMASPlayer.inventory, oTMASShake);
	if (dist < 16*2)
	{
		_color = c_red;
		if (has_shake) ScreenShake(5, 1, room_speed * 0.5);
	}
	else if (dist < 16*4)
	{
		_color = c_orange;
		if (has_shake) ScreenShake(2, 1, room_speed * 1);
	}
	else if (dist < 16*10)
	{
		_color = c_yellow;
		if (has_shake) ScreenShake(1, 1, room_speed * 2);
	}
	else
	{
		_color = c_aqua;
		ScreenShake(0, 0, 1);
	}
	
	var has_color = ds_map_find_value(oTMASPlayer.inventory, oTMASColor);
	if (has_color)
	{
		with (all) image_blend = _color;	
	}
	#endregion
	
	if (oTMASPlayer.state == TMASPlayerStateIdle)
	{
		msg = "";
		time_left = clamp(time_left-1, 0, time_max);
	}
	else if (oTMASPlayer.thing_found != noone)
	{
		switch (oTMASPlayer.thing_found)
		{
			case oTMASColor:
				msg = "Red is hot, Blue is cold!";
				break;
			case oTMASShake:
				msg = "More shake, more treasure!";
				break;
			case oTMASApple:
				msg = "yum.";
				break;
			case oTMASClock:
				msg = "Time bonus.";
				break;
			default:
				msg = "";
		}
	}
	
	if (time_left == 0)
	{
		screen_transition = FADE.OUT;
		did_win = false;
	}
}
// post-game
else
{
	msg = "Game Over! ";
	msg += (did_win) ? "You win!" : "You lose.";
	if (keyboard_check_pressed(global.k_interact))
		ExitMinigame(quarters_if_win, did_win);	
}
#endregion