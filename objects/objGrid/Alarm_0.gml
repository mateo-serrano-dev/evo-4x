var ecuator = intEcuador;
var max_dist = ecuator;
var sun_strenght = intSunStrength;
var constante = 0.025;

//Calentamiento por ecuador
for(var j = 0; j < intTileColums; j++)
{	
	var dist_ecuator = abs(ecuator - j);
	var _delta_temperature = (-dist_ecuator + max_dist) * constante * sun_strenght;
	for (var i = 0; i < intTileRows; i++) {
	
	switch (arrGrid[i][j].get_material())
	{
		case "Sea": var _coeficiente = water_radiation;
		break;
			
		case "Rock": var _coeficiente = rock_radiation;
		break;
	}
	
	//Efecto coriolis oceanico
	arrGrid[i][j].add_temperature(_delta_temperature * _coeficiente);
	if (_coeficiente == water_radiation) 
	{
		arrGrid[i][j].stream.add(1 * sign(ecuator - j), 0);
	}
} }




alarm[0] = intGameTempo;