//Transferencia de calor
var temp_grid = array_create(0);

for(var j = 0; j < intTileColums; j++)
{ 
	for (var i = 0; i < intTileRows; i++) {
		
		temp_grid[i][j] = arrGrid[i][j];
	}
}

for(var j = 0; j < intTileColums; j++)
{ for (var i = 0; i < intTileRows; i++) {
	var vecinos_x = 2;
	var vecinos_y = 2;
	
	if i > 0 and i < intTileRows - 1 vecinos_x++;
	if j > 0 and j < intTileRows - 1 vecinos_y++;
	
	var vecinos = vecinos_x * vecinos_y;
		
		switch (temp_grid[i][j].get_material())
		{
			case "Sea": var _coeficiente = water_radiation;
			break;
			
			case "Rock": var _coeficiente = rock_radiation;
			break;
		}
		
		var rad_per_vecino = temp_grid[i][j].temperature * _coeficiente / vecinos;
		arrGrid[i][j].add_temperature(temp_grid[i][j].temperature * -_coeficiente * 2);
		
		for(var _x = -1; _x < 2; _x++)
		{
		for(var _y = -1; _y < 2; _y++)
		{
			if i + _x < 0 or i + _x >= intTileRows or j + _y < 0 or j + _y >= intTileColums or _x == _y continue;
			
			arrGrid[i + _x][j + _y].add_temperature(rad_per_vecino);
		}}
}}

alarm[1] = intGameTempo;