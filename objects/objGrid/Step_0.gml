//Ajuste de frames
global.actual_delta = delta_time/1000000;
global.delta_multiplier = global.actual_delta / target_delta;

//Inputs
var keyLeftClick = mouse_check_button_pressed(mb_left);
var keyLeftMantain = mouse_check_button(mb_left);
var keyRightClick = mouse_check_button_pressed(mb_right);
var keyFollowCam = keyboard_check_pressed(ord("C"));
var keyKill = keyboard_check_pressed(ord("K"));
var keySpace = keyboard_check_pressed(vk_space);
//mouse_xgrid = clamp(floor(mouse_x / intTileSize), 0, intTileRows - 1);
//mouse_ygrid = clamp(floor(mouse_y / intTileSize), 0, intTileColums - 1);

//Creacion de Plankton sucesiva
var plankton_number = 20;
if (instance_number(objPlankton) < plankton_number)
{ 
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

	var lifeforms = instance_number(objPlankton);
	while lifeforms < plankton_number
	{
		var chance = random_range(0, 100);
		var type_obj = objPlankton;
		if chance > 90 type_obj = objPlanktonEvolved;
		
		//Chooses place
		var creation = irandom_range(0, array_length(arr_watertiles) - 1);
	
		//Gestiona data del organismo
		with(instance_create_depth(arr_watertiles[creation][0] * intTileSize, arr_watertiles[creation][1] * intTileSize, 11, type_obj))
		{
			intDepth = choose(1, 1, 2);
		}
	
		//Se prepara para el siguiente loop
		array_delete(arr_watertiles, creation, 1);
		lifeforms++;	
	}
}

if (global.uistate != 0) exit;

//Seleccionar organismos
insHover = noone;
insHover = instance_position(mouse_x, mouse_y, objOrganism);

if insHover != noone
{
	if insHover.intDepth != global.intDisplayLayer insHover = noone;
	
	if keyLeftClick
	{
		insSelected = insHover;
		keyLeftClick = false;
	}
}

if insSelected != noone && insSelected.idCreator == 0
{
	global.intDisplayLayer = insSelected.intDepth;
	
	//if keyKill insSelected.intEnergia = 0;
	
	if keySpace insSelected.mitosis();
	
	if keyLeftMantain && insSelected.influence_active
	{
		insSelected.influence_active = false;
		insSelected.alarm[3] = insSelected.timing_influence;
		insSelected.speed_influence(mouse_x - insSelected.x, mouse_y - insSelected.y)
	}
	
	if keyRightClick insSelected = noone;
}

if keyFollowCam global.followcam = !global.followcam;
