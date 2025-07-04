//Variables miscelaneas
	global.winstate = 0;
	global.uistate = 0;
	global.intDisplayLayer = 2;
	global.bolMicroLens = true;

global.followcam = true;

	//Deltas
	target_delta = 1/60;
	global.actual_delta = delta_time/1000000;
	global.delta_multiplier = global.actual_delta / target_delta;

fntBitfont = font_add_sprite_ext(sprBitfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÁÉÍÓÚáéíóúÑñ.,:'?¿!¡-+%/()0123456789 ", true, 1);
draw_set_font(fntBitfont);

//Variables de juego
instance_create_layer(x, y, "Instances", objSpecies);

insSelected = noone;
function add_points(_points, _x, _y, _creator)
{
	global.arrEvoPoints[_creator] += _points;
	if _creator == 0 with(instance_create_depth(_x, _y, depth - 1, show_points)) points = _points;
}

influence_active = true;
intSunStrength = 40;

bolSelected = noone;
//arrSpecieUis = array_create(0);
randomize();

//Celdas
intTileSize = 16;
intTileRows = room_width / intTileSize;
intTileColums = room_height / intTileSize;
intEcuador = intTileColums / 2;

///Celular automata
var density = 62;
var iterations = 12;

function Tile_id (_material, _temperature) constructor {
	material = _material;
	temperature = _temperature;
	//salinity = 0;
	sprite = asset_get_index("sprTile" + material);
	spritedeep = asset_get_index("sprTileDeep" + material);
	stream = new Vector(0, 0);
	
	/*acidity = 0;
	humidity = 0;
	nutrients = 0;*/
	
	static set_tile = function(_material, _temperature)
	{
		material = _material;
		sprite = asset_get_index("sprTile" + material);
		spritedeep = asset_get_index("sprTileDeep" + material);
		temperature = _temperature;
	}
	
	static get_material = function()
	{
		return material;
	}
	
	static add_temperature = function(_delta)
	{
		temperature += _delta;
	}
}

function get_tile (i, j)
{
	return arrGrid[i, j]
}

//Mapa de noise
for (var i = 0; i < intTileRows; i++)
{
	for (var j = 0; j < intTileColums; j++)
	{
		var noise = irandom(100);
		
		if (noise > density)
		{
			arrGrid[i][j] = new Tile_id("Rock", 25);
		}
		else
		{
			arrGrid[i][j] =  new Tile_id("Sea", 25);
		}
	}
}

//Smoothness
for(var i = 0; i < iterations; i++)
{
	scrCelularAutomata(arrGrid, intTileColums, intTileRows);
}

var arr_watertiles = array_create(0);
for (var i = 0; i < intTileRows; i++)
{
	for (var j = 0; j < intTileColums; j++)
	{
		if (arrGrid[i][j].get_material() == "Sea")
		{
			array_push(arr_watertiles, [i, j]);
		}
	}	
}

instance_create_layer(15, 15, "UI", objUIskilltree);

//Crea vida
var lifeforms = 0;
array_organisms = array_create(0);
while lifeforms < 2
{
	//Chooses place
	var creation = irandom_range(0, array_length(arr_watertiles) - 1);
	
	//Gestiona data del organismo
	var organism = instance_create_depth(arr_watertiles[creation][0] * intTileSize, arr_watertiles[creation][1] * intTileSize, depth + 1, objOrganism)
	
	with(organism)
	{
		idCreator = lifeforms;
		var initial_adaptations = array_create(array_length(objUIskilltree.arrSkillTree), 0);
		initial_adaptations[0] = 1;
		
		set_adaptations(initial_adaptations);
		
		strSpecie = objSpecies.add_specie(arrAdaptations, id, idCreator);
	}
	
	//Se prepara para el siguiente loop
	array_delete(arr_watertiles, creation, 1);
	lifeforms++;	
}

with (objCamera)
{
	x = global.arrSpecies[0][0].arrIndividuals[0].x + 8;
	y = global.arrSpecies[0][0].arrIndividuals[0].y + 8;
}

//Crea geiseres
var geisers = 0;
while geisers < 5
{
	var creation = irandom_range(0, array_length(arr_watertiles) - 1);
	
	instance_create_depth(arr_watertiles[creation][0] * intTileSize, arr_watertiles[creation][1] * intTileSize, depth + 2, objGeiser)
	
	geisers++;
}


function pop_organism(_individual)
{
	//Elimina de selección
	if insHover == _individual insHover = noone;
	if insSelected == _individual insSelected = noone;
	
	//Lo elimina de la especie
	var familia = _individual.strSpecie.arrIndividuals;
	
	for (var i = 0; i < array_length(familia); i++)
	{
		if familia[i] == _individual array_delete(familia, i, 1);
	}
	
	//Si era el último, destruir especie
	if array_length(familia) <= 0
	{
		for (var i = 0; i < array_length(global.arrSpecies[_individual.idCreator]); i++)
		{
			if global.arrSpecies[_individual.idCreator][i] == _individual.strSpecie 
			{
				instance_destroy(global.arrSpecies[_individual.idCreator][i].UIbox);
				array_delete(global.arrSpecies[_individual.idCreator], i, 1);
			}
		}
	}
	
	objSpecies.reorganize_ui();
	
	/*for (var i = 0; i < array_length(array_organisms); i++)
	{
		if (array_organisms[i].intEnergia <= 0) 
		{
			if insHover == array_organisms[i] insHover = noone;
			if insSelected == array_organisms[i] insSelected = noone;
			array_delete(array_organisms, i, 1);
		}
	}
	
	var specie_arr
	if _creator == 0 specie_arr = array_species;
	else specie_arr = array_altspecies;
	
	for (var i = 0; i < array_length(specie_arr[_specie_number][1]); i++)
	{
		if (specie_arr[_specie_number][1][i].intEnergia <= 0) 
		{
			array_delete(specie_arr[_specie_number][1], i, 1);
		}
	}
	
	if array_length(specie_arr[_specie_number][1]) == 0
	{
		array_delete(specie_arr, _specie_number, 1);
		for (var i = _specie_number; i < array_length(specie_arr); i++)
		{
			for (var j = 0; j < array_length(specie_arr[i][1]); j++)
			{
				if _creator == 0 arrSpecieUis[j].specie_pointer--;
				specie_arr[i][1][j].specie_number--;
			}
		}
		
		if _creator == 0 
		{
			instance_destroy(arrSpecieUis[_specie_number]);
			array_delete(arrSpecieUis, _specie_number, 1);
			if objUIskilltree.specie_pointer == _specie_number objUIskilltree.funcion_ui();
		}
	}*/
}

//array_species = array_create(1, [array_organisms[0].arrAdaptations, [array_organisms[0].id]]);
//array_altspecies = array_create(1, [array_organisms[1].arrAdaptations, [array_organisms[1].id]]);

//Físicas
intGameTempo = 200;

alarm[0] = intGameTempo;
alarm[1] = intGameTempo * 1.5;
alarm[2] = intGameTempo * 4/3;

water_radiation = 0.1;
rock_radiation = 0.2;