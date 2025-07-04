for(var j = 0; j < intTileColums; j++)
{ for (var i = 0; i < intTileRows; i++) {
	if (arrGrid[i][j].get_material() == "Sea")
	{
		var delta_density = [arrGrid[i][j].temperature, i, j]
		for (var _x = -1; _x < 2; _x++)
		{ for (var _y = -1; _y < 2; _y++)
		{
			if (_x == 0 and _y == 0) continue;
			if i + _x < 0 or  i + _x >= intTileRows continue;
			if j + _y < 0 or  j + _y >= intTileColums continue;
			if arrGrid[i + _x][j + _y].get_material() != "Sea" continue;
			
			if delta_density[0] <= arrGrid[i + _x][j + _y].temperature continue;
			delta_density = [arrGrid[i + _x][j + _y].temperature, i + _x, j + _y]
		}}
		
		var _xdir = delta_density[1] - i;
		var _ydir = delta_density[2] - j;
		
		if j == 0 _ydir = -1;
		if j == intTileColums - 1 _ydir = 1;
		
		var magnitude = 2;
		var points_to = point_direction(0, 0, _xdir, _ydir);
		arrGrid[i][j].stream.set(lengthdir_x(magnitude, points_to), lengthdir_y(magnitude, points_to));
	}
}}

alarm[2] = intGameTempo;