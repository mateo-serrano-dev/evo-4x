global.arrEvoPoints = array_create(2, 0);
global.arrSpecies = array_create(2, 0);

function specie(_adaptations, _individual) constructor
{
	arrAdaptations = _adaptations;
	arrIndividuals = array_create(1, _individual);
	UIbox = noone;
	
	function add_individual(_individual)
	{
		array_push(arrIndividuals, _individual)
	}
}

function add_specie(_adaptations, _individual, _creator)
{
	var new_specie = new specie(_adaptations, _individual); 
	
	if !is_array(global.arrSpecies[_creator]) 
	{
		global.arrSpecies[_creator] = [new_specie];
	}
	else array_push(global.arrSpecies[_creator], new_specie);
	
	if _creator == 0
	{
		new_specie.UIbox = instance_create_layer(display_get_gui_width() - 60, 35 + 35 * (instance_number(objUIspecie)), "UI", objUIspecie);
		new_specie.UIbox.set_specie_pointer(new_specie);
	}
	
	return new_specie;
}

function reorganize_ui()
{
	for (var i = 0; i < array_length(global.arrSpecies[0]); i++)
	{
		global.arrSpecies[0][i].UIbox.y = 35 + 35 * i;
	}
}