event_inherited();
//Dibujado
//depth = 1000;
//Sistemas de vida principales
//Combate
intDamage = 25;
bolVulnerable = true;

//Energia y metabolismo
intMaxEnergy = 100;
intEnergia = intMaxEnergy;
intMetabolize = 0;
intMetabolicRate = 0.1;
intMaxAge = 45;
intAge = 0;

//Adaptaciones
arrAdaptations = array_create(0);
specie_number = 0;
intSize = 1;

//Movimiento
influence_active = true;
timing_influence = 15;

function check_skill(_name)
{
	return arrAdaptations[objUIskilltree.get_skill_by_name(_name)]
}

function mitosis()
{
	if intEnergia > 30
	{
		var metabolic_transfer = 15;
		intEnergia -= metabolic_transfer;
		intEnergia /= 2;
		
		var newborn = instance_create_depth(x + 1, y + 1, depth, objOrganism)
		array_push(objGrid.array_organisms, newborn);
		
		bolVulnerable = false;
		alarm[1] = 50;
		
		with (newborn)
		{
			idCreator = other.idCreator;
			intEnergia = other.intEnergia;
			intDepth = other.intDepth;
			bolVulnerable = false;
			alarm[1] = 50;
			intMetabolize = metabolic_transfer;
			set_adaptations(variable_clone(other.arrHeredit));
		}
		
		objGrid.add_points(2, x, y, idCreator);
		
		if (!array_equals(arrHeredit, arrAdaptations))
		{
			newborn.strSpecie = objSpecies.add_specie(arrHeredit, newborn, idCreator);
		}
		else 
		{
			newborn.strSpecie = strSpecie;
			strSpecie.add_individual(newborn);
		}
		
		/*if idCreator == 0 
		{
			if (!array_equals(arrHeredit, arrAdaptations))
			{
				array_push(objGrid.array_species, [newborn.arrAdaptations, [newborn]]);
				newborn.specie_number = array_length(objGrid.array_species) - 1;
			}
			else
			{
				newborn.specie_number = specie_number;
				array_push(objGrid.array_species[specie_number][1], newborn);
			}
		}
		else 
		{
			if (!array_equals(arrHeredit, arrAdaptations))
			{
				array_push(objGrid.array_altspecies, [newborn.arrAdaptations, [newborn]]);
				newborn.specie_number = array_length(objGrid.array_altspecies) - 1;
			}
			else
			{
				newborn.specie_number = specie_number;
				array_push(objGrid.array_altspecies[specie_number][1], newborn);
			}
		}*/
		
		arrHeredit = variable_clone(arrAdaptations);
	}
}

function speed_influence (_x, _y)
{
	var vec_influence = new Vector(_x, _y);
	var force = 0.5;
	if (arrAdaptations[objUIskilltree.get_skill_by_name("Flajelos")] == 1) force = 0.8;
	
	vec_influence.set_magnitude(force);
	vec_speed.add(vec_influence.x, vec_influence.y);
	
	intEnergia -= 0.2;
}

function set_adaptations (_array) {
	arrAdaptations = _array;
	arrHeredit = variable_clone(arrAdaptations);
	//arrHeredit[objUIskilltree.get_skill_by_name("Flajelos")] = 1;
	//arrHeredit[objUIskilltree.get_skill_by_name("Mitocondria")] = 1;
	//arrHeredit[objUIskilltree.get_skill_by_name("Colonia")] = 1;
	//arrHeredit[objUIskilltree.get_skill_by_name("Multicelularidad")] = 1;
	
	//Establecer el costo de mantenimiento del organismo
	intEnergyCost = 0;
	for (var i = 0; i < array_length(arrAdaptations); i++)
	{
		if (arrAdaptations[i]) intEnergyCost += objUIskilltree.arrSkillTree[i].energy_cost / 1000;
	}
	
	intEnergyCost *= intSize;
	
	
	//Animaciones
	if (check_skill("Flajelos"))
	{
		sprite_index = sprFlajelados;
	}
	
	if (check_skill("Mitocondria"))
	{
		if (check_skill("Colonia"))
		{
			if check_skill("Multicelularidad") 
			{
				sprite_index = sprMulticelular;
				intMaxEnergy = 750;
			}
			else
			{
				sprite_index = sprColonia;
				intMaxEnergy = 250;
			}
		}
		else sprite_index = sprMitocondria;
	}
	
	if (check_skill("Cloroplastos"))
	{
		if (check_skill("ClorofilaB"))
		{
			sprite_index = sprAlgaVerde;
		}
	
		if (check_skill("Ficobiliproteina"))
		{
			sprite_index = sprAlgaRoja;
		}
		else sprite_index = sprCloroplastos;
		
		//Fotosíntesis
		intFotoMax = 400;
		intFotoTimer = intFotoMax;
	}
}

//Bioritmo
intBioritmo = 450;
intBioritmoTimer = random_range(intBioritmo * 0.8, intBioritmo);

function bioritmo()
{
	var chance = random_range(0, 100);
	if ((chance > 70) && (intEnergia > intMaxEnergy * 0.9) && (intMetabolize > 0) && (objGrid.insSelected != id or idCreator == 1)) or (!array_equals(arrAdaptations, arrHeredit) && idCreator == 1 && chance > 40 && intEnergia > intMaxEnergy * 0.6)
	{
		mitosis();
	}

	intAge += 1;
	intBioritmoTimer = intBioritmo;
}

