/// @description set target

moving_towards_target = true;

xtarget = oPlayer.x;
ytarget = oPlayer.y;

switch (deg_to_cardinal(direction))
{
	case 0: xtarget -= UNIT; break;
	case 1: ytarget += UNIT; break;
	case 2: xtarget += UNIT; break;
	case 3: ytarget -= UNIT; break;
}