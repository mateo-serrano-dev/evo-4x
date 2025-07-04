if (global.uistate == 1)
{
	draw_self();
	
	var points = global.arrEvoPoints[0];
	
	draw_text(x, display_get_gui_height() - y, "EvolPoints: " + string(points));
	if objGrid.bolSelected != noone 
	{
		draw_text(x, display_get_gui_height() - y * 3, "Cost: " + string(objGrid.bolSelected.skill_pointer.cost));
		draw_text(x, display_get_gui_height() - y * 5, string(objGrid.bolSelected.skill_pointer.name));
		
		var text_points
		if (points >= objGrid.bolSelected.skill_pointer.cost) text_points = "Press 'Space' to evolve!"
		else text_points = "Not enough points..."
		
		draw_set_halign(fa_center);
		draw_text(display_get_gui_width() / 2, display_get_gui_height() - y, text_points);
		
		draw_set_halign(fa_left);
	}
}