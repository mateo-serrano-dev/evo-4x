// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrGuiButton(x1, y1, widght, height){
	var mousexgui = device_mouse_x_to_gui(0);
	var mouseygui = device_mouse_y_to_gui(0);
	var x2 = x1 + widght;
	var y2 = y1 + height;
	
	if (point_in_rectangle(mousexgui, mouseygui, x1, y1, x2, y2)) 
	{
		global.GUIinteraction = true;
		
		if (mouse_check_button(mb_left))
		{
			return 2;
		}
	
		return 1;
	}
	else
	{
		global.GUIinteraction = false;
	}
	return 0;
}