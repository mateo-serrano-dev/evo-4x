if (position_meeting(mouse_x_gui, mouse_y_gui, id))
{
	image_index = 1
	if mouse_check_button_pressed(mb_left)
	{
		image_index = 2;
		script_execute(funcion_ui);
	}
}
else image_index = 0;

