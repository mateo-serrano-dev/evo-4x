/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

global.active_cost = true;

funcion_ui = function()
{
	global.uistate = 0;
	objGrid.bolSelected = noone;
}

///Arbol de habilidades
//Crear habilidades
function Skill (_name, _dependencias, _cost, _ecost) constructor
{
	name = _name;
	dependency = _dependencias;
	cost = _cost;
	energy_cost = _ecost;
	sprite = asset_get_index("sprSkill_" + name);
	
	//Funciones de desbloqueo
	static evolve_skill = function ()
	{
		global.arrEvoPoints[0] -= cost * global.active_cost;
		
		var new_gene = variable_clone(objUIskilltree.arrDisplay);
		new_gene[objUIskilltree.get_skill_by_name(name)] = 1;
		return new_gene;
	}
	
	static is_unlocked = function ()
	{
		return objUIskilltree.arrDisplay[objUIskilltree.get_skill_by_name(name)];
	}
	
	//Funciones de dependencias
	ancestors = 0;
	for (var i = 0; i < array_length(dependency); i++)
	{
		ancestors = max(ancestors, objUIskilltree.dependency_index_to_skill(dependency, i).ancestors + 1);
	}
}

function add_skill(_name, _dependencias, _cost, _ecost)
{
	array_push(arrSkillTree, new Skill(_name, _dependencias, _cost, _ecost))
}

function get_skill_by_name(_string)
{
	for (var i = 0; i < array_length(arrSkillTree); i++)
	{
		if arrSkillTree[i].name == _string return i
	}
}

function dependency_index_to_skill(array_dependencys, index)
{
	return arrSkillTree[array_dependencys[index]];
}

//Crear el arbol
arrSkillTree = array_create(0);
add_skill("Nucleo", noone, 0, 5);
add_skill("Flajelos", [get_skill_by_name("Nucleo")], 5, 2);
add_skill("Mitocondria", [get_skill_by_name("Nucleo")], 10, 8);
add_skill("Esporulacion", [get_skill_by_name("Flajelos")], 8, 5);
add_skill("Colonia", [get_skill_by_name("Flajelos"), get_skill_by_name("Mitocondria")], 30, 15);
add_skill("Cloroplastos", [get_skill_by_name("Mitocondria")], 15, 8);
//add_skill("Meiosis", [get_skill_by_name("Colonia")], 40, 5);
add_skill("Multicelularidad", [get_skill_by_name("Colonia")], 150, 40);
//add_skill("Pared_Celular", [get_skill_by_name("Cloroplastos")], 40, 15);
add_skill("ClorofilaB", [get_skill_by_name("Cloroplastos")], 40, 15);
add_skill("Ficobiliproteina", [get_skill_by_name("Cloroplastos")], 45, 20);

//Dibujar el arbol de habilidades
strSpecieSkills = noone;
arrDisplay = noone;
ui_horizontal = 175;

function display_skilltree()
{
	var origin_x = 30
	var origin_y = display_get_gui_height() / 2 - 40
	var array_depth = array_create(0);
	var buffer_huerfanos = array_create(0);
	var	total_uiskill = array_create(0);
	for (var i = array_length(arrDisplay) - 1; i >= 0; i--)
	{
		#region busca si desbloqueaste las dependencias
			var can_be_unlocked = true;
			for (var j = 0; j < array_length(arrSkillTree[i].dependency); j++)
			{
				if (dependency_index_to_skill(arrSkillTree[i].dependency, j).is_unlocked() == false) can_be_unlocked = false;
			}
		#endregion
		
		if (can_be_unlocked)
		{
			var writting_skill = instance_create_layer(origin_x + ui_horizontal * arrSkillTree[i].ancestors, origin_y, "UI", objUIskill)
			
			if array_length(array_depth) <= arrSkillTree[i].ancestors 
			{
				for (var l = array_length(array_depth); l <= arrSkillTree[i].ancestors; l++)
				{
					array_depth[l] = array_create(0);
				}
				
				//array_depth = array_create(arrSkillTree[i].ancestors + 1, variable_clone(clone_me_array) );
				array_depth[arrSkillTree[i].ancestors][0] = writting_skill;
			}
			else array_push(array_depth[arrSkillTree[i].ancestors], writting_skill); 
			
			array_push(total_uiskill, writting_skill);
			
			with(writting_skill)
			{
				skill_pointer = other.arrSkillTree[i];
				numbFathers = array_length(skill_pointer.dependency);
			}
			
			array_push(buffer_huerfanos, [variable_clone(writting_skill.skill_pointer.dependency), writting_skill]);
			
			//Busqueda de descendencia
			var own_name = writting_skill.skill_pointer.name
			for (var j = 0; j < array_length(buffer_huerfanos); j++)
			{
				for (var k = 0; k < array_length(buffer_huerfanos[j][0]); k++)
				{
					var check_name = dependency_index_to_skill(buffer_huerfanos[j][0], k).name
				
					if own_name == check_name
					{
						array_push(writting_skill.insSons, buffer_huerfanos[j][1])
						array_delete(buffer_huerfanos[j][0], k, 1);
						if array_length(buffer_huerfanos[j][0]) == 0 array_delete(buffer_huerfanos, j, 1);
						j--;
						break;
					}
				}
			}
			
			
			
		}
	}
	
	//Ordenar segun parentezco
	var sprite_h = sprite_get_height(sprUIskill);
	var sep = 30;
	
	for (var j = array_length(total_uiskill) - 1; j >= 0; j--)
	{
		var father = total_uiskill[j];
		if father.numbFathers != 0 
		{
			var promedio_spawn = father.spawn_y[0] / father.numbFathers;
			//var numero_hermano = (sep + sprite_h) * father.spawn_y[1] + sprite_h / 2;
			//var ancho_hermanos = (sep + sprite_h) * father.spawn_y[2] - sep 
			
			father.y = (promedio_spawn)// + (ancho_hermanos / 2) - numero_hermano;
		}
		
		if array_length(father.insSons) == 0 continue;
		
		for (var i = 0; i < array_length(father.insSons); i++)
		{
			var son = father.insSons[i];
			son.spawn_y[0] += father.y;
			//son.spawn_y[1] = i;
			//son.spawn_y[2] = array_length(father.insSons);
		}
	}
	
	
	for (var i = 0; i < array_length(array_depth); i++)
	{
		for (var j = 0; j < array_length(array_depth[i]); j++)
		{
			var numero_hermano = (sep + sprite_h) * j + sprite_h / 2;
			var ancho_hermanos = (sep + sprite_h) * array_length(array_depth[i]) - sep;
			
			array_depth[i][j].y += (ancho_hermanos / 2) - numero_hermano;
		}
	}
}

