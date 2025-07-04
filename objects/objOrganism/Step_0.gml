event_inherited();
//Seleccionar
//if position_meeting(mouse_x, mouse_y, )

//Sistemas de vida principales
intBioritmoTimer -= global.delta_multiplier;
if intBioritmoTimer <= 0 bioritmo();

//Flujo de energía
intEnergia -= intEnergyCost * global.delta_multiplier;
intEnergia = clamp(intEnergia, 0, intMaxEnergy);

if (intEnergia <= 0) or (intAge >= intMaxAge)
{
	objGrid.pop_organism(id);
	objGrid.add_points(1, x, y, idCreator);
	instance_destroy();
}

//if objGrid.arrGrid[TiledX][TiledY].get_material() != "Sea" intEnergia -= 0.5;

//Planktivoros
var plank = instance_place(x, y, objPlankton)
if plank != noone if plank.intDepth != intDepth plank = noone;

if (plank != noone)
{
	var eaten = false;
	if plank.object_index != objPlanktonEvolved eaten = true; 
	else if plank.bolVulnerable 
	{
		intEnergia -= 15;
		plank.intLife--;
		if plank.intLife <= 0 eaten = true;
		plank.bolVulnerable = false;
		plank.alarm[1] = 10;
	}
	
	if eaten
	{
		var total_points = 1
		if plank.object_index == objPlanktonEvolved 
		{
			intMetabolize += 7.5 * plank.intMaxLife;
			total_points += 1;
		}
		
		intMetabolize += 25;
		objGrid.add_points(total_points, x, y, idCreator);
		instance_destroy(plank);
	}
}

if idCreator == 1 or objGrid.insSelected != id
{
	if (objGrid.arrGrid[TiledX][TiledY].get_material() != "Sea") && (influence_active)
	{
		for (var _x = -1; _x < 2; _x++)
		{ 
			if !influence_active break;
			for (var _y = -1; _y < 2; _y++)
			{
				var x_nei = TiledX + _x;
				var y_nei = TiledY + _y;
				if x_nei < 0 or x_nei > objGrid.intTileColums continue;
				if y_nei < 0 or y_nei > objGrid.intTileRows continue;
				if y_nei == x_nei continue;
			
				if objGrid.arrGrid[x_nei][y_nei].get_material() == "Sea"
				{
					influence_active = false
					alarm[3] = timing_influence;
					speed_influence(_x, _y);
					break;
				}
		}	}
	}
	else
	{
		var near_plank = instance_nearest(x, y, objPlankton);
		var plank_x = near_plank.x - x;
		var plank_y = near_plank.y - y;

		var perception = 100;
		if check_skill("Flajelos") perception = 150;
		var distance = sqrt(plank_x * plank_x + plank_y * plank_y)
		//Si tiene plankton cerca, va y lo busca
		if distance < perception && influence_active = true && near_plank.intDepth == intDepth
		{
			influence_active = false;
			var sentido = 1;
			if near_plank.object_index == objPlanktonEvolved && intEnergia < 0.8 * intMaxEnergy
			{
				if distance < 25 sentido = -1;
				else sentido = 0;
			}
			speed_influence(plank_x * sentido, plank_y * sentido);
			alarm[3] = timing_influence;
		}
	}
}

//Fotosintesis
if (check_skill("Cloroplastos"))
{
	intFotoTimer -= global.delta_multiplier;
	if intFotoTimer <= 0 
	{
		var ecuador = objGrid.intEcuador;
		
		intFotoTimer = intFotoMax;
		
		var foto_boost = 0.75;
		if intDepth == 1 && check_skill("ClorofilaB") foto_boost *= 1.5;
		if intDepth == 2 && check_skill("Ficobiliproteina") foto_boost *= 3;
		
		intMetabolize = (objGrid.intSunStrength * foto_boost / intDepth) * (ecuador - abs(ecuador - TiledY)) / (ecuador * 2);
		
		objGrid.add_points(1, x, y, idCreator);
	}
}

//Automejoras de otro creador
if idCreator == 1
{
	var chance = random_range(0, 100);
	if chance > 99.8 && array_equals(arrHeredit, arrAdaptations) {
		
		var skilltree = objUIskilltree.arrSkillTree;
		var unlockeable = array_create(0)
		
		for (var i = 0; i < array_length(skilltree); i++) //Loopea a traves de todas las skills
		{
			if arrAdaptations[i] continue; //Si ya la tiene la ignora
			if skilltree[i].cost > global.arrEvoPoints[1] continue; //Si es muy cara la ignora
			
			var can_be_unlocked = true;
			
			//Si no tiene las dependencias necesarias, la ignora
			for (var j = 0; j < array_length(skilltree[i].dependency); j++)
			{
				if !arrAdaptations[skilltree[i].dependency[j]] can_be_unlocked = false;
			}
			
			if !can_be_unlocked continue;
			
			//Verifica por otras especies con la habilidad
			for (var j = 0; j < array_length(global.arrSpecies[1]); j++)
			{	
				if global.arrSpecies[1][j].arrAdaptations[i] 
				{
					var example_hereditor = variable_clone(arrAdaptations);
					example_hereditor[i] = 1;
					
					//Si ya hay un bicho con TODO igual, no la puede desbloquear
					if array_equals(global.arrSpecies[1][j].arrAdaptations, example_hereditor) 
					{
						can_be_unlocked = false;
						break;
					}
					else //Si otro solo la tiene y es distinto, hay una chance de 50% de evolucionarla
					{
						chance = choose(1, 0);
						can_be_unlocked = chance;
					}
				}
			}
			
			//Agregar como desbloqueable
			if can_be_unlocked array_push(unlockeable, i);
		}
		
		//Elige una y la desbloquea en su herencia.
		if array_length(unlockeable) > 0
		{
			var chosen_skill = unlockeable[irandom_range(0, array_length(unlockeable) - 1)];
			arrHeredit[chosen_skill] = 1;
			global.arrEvoPoints[1] -= skilltree[chosen_skill].cost;
		}
	}
}

//Metabolismo
if intMetabolize > 0 && intEnergia + intMetabolicRate <= intMaxEnergy
{
	var eficiencia = 1
	if (check_skill("Mitocondria")) eficiencia = 2;
	
	intMetabolize -= intMetabolicRate;
	intEnergia += intMetabolicRate * eficiencia;
}

