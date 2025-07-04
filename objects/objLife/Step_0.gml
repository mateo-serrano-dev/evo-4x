objGrid.arrGrid[tl_x][tl_y][1] = id;

if (array_length(arrPath) > 0)
{
	if (!bolPathStarted) i = array_length(arrPath) - 1;
	
	goto_x = arrPath[i][0];
	goto_y = arrPath[i][1];
	
	if (x != goto_x * objGrid.intTileSize)
	{
		var direc_x = sign(goto_x - (x / objGrid.intTileSize))
	
		x += animMovSpeed * direc_x;
	}
	else if (y != goto_y * objGrid.intTileSize)
	{
		var direc_y = sign(goto_y - (y / objGrid.intTileSize))
	
		y += animMovSpeed * direc_y;
	}
	else if (i > 0)
	{
		bolPathStarted = true;
		i--;
	}
	else
	{
		array_delete(arrPath, 0, array_length(arrPath));
		objGrid.arrGrid[tl_x][tl_y][1] = noone;
		tl_x = x / objGrid.intTileSize;
		tl_y = y / objGrid.intTileSize;
		bolPathStarted = false;
	}
}
