// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrWalkable(x_, y_){
	if (arrGrid [x_][y_][0] != "Sea") or (arrGrid [x_][y_][1] != noone)
	{
		return 0;
	}
	else return 1;
}