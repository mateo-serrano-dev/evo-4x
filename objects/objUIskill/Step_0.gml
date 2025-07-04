// Inherit the parent event
event_inherited();
if (global.uistate != 1) instance_destroy();

bolHover = clamp(image_index, 0, 1);

if skill_pointer.is_unlocked() image_index = 2;
if objGrid.bolSelected == id image_index = 1;

var keySpace = keyboard_check_pressed(vk_space);

if (keySpace) && (objGrid.bolSelected == id) && (global.arrEvoPoints[0] >= skill_pointer.cost or !global.active_cost)
{
	objGrid.bolSelected = noone;
	
	var random_specimen = objUIskilltree.strSpecieSkills.arrIndividuals[irandom_range(0, array_length(objUIskilltree.strSpecieSkills.arrIndividuals) - 1)];
	random_specimen.arrHeredit = skill_pointer.evolve_skill();
	
	objGrid.insSelected = random_specimen;
	global.followcam = true;
	objUIskilltree.funcion_ui();
}