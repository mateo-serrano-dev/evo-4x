// Inherit the parent event
event_inherited();

strSpecieUI = noone;
sprSpecieDraw = noone;
funcion_ui = function()
{
	global.uistate = 1;
	objUIskilltree.arrDisplay = strSpecieUI.arrAdaptations;
	objUIskilltree.strSpecieSkills = strSpecieUI;
	objUIskilltree.display_skilltree();
}

function set_specie_pointer(_specie)
{
	strSpecieUI = _specie
	sprSpecieDraw = strSpecieUI.arrIndividuals[0].sprite_index;
}