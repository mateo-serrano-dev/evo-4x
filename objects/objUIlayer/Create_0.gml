// Inherit the parent event
event_inherited();

funcion_ui = function ()
{
	global.intDisplayLayer++;
	if global.intDisplayLayer > 2 global.intDisplayLayer = 1;
	
	objGrid.insSelected = noone;
}