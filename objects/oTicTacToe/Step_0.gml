var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);
var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var enter = keyboard_check_pressed(ord("C"));

var move_col = right - left;
var move_row = down - up;

if (!game_start)
{
	if (right) player_choice = "O";	
	else if (left) player_choice = "X";	
	else if (enter)
	{
		game_start = true;
		if (turn != player_choice) alarm[0] = Sec2Frames(1);
	}
}
else if (!game_over)
{
	if (turn == player_choice)
	{
		row = clamp(row + move_row, 0, 2);
		column = clamp(column + move_col, 0, 2);
		
		if (enter && ds_grid_get(board, column, row) == "")
		{
			ds_grid_set(board, column, row, turn);
			turn = (turn == "X") ? "O": "X";
			
			alarm[1] = 1;
		}
	}
}
else if (enter)
{
	if (draw)
	{
		InitTicTacToe();
	}
	else if (turn == player_choice) // you lose
	{
		ExitMinigame(oTicTacToe, false);
	}
	else
	{
		ExitMinigame(oTicTacToe, true); // you win
	}
}




