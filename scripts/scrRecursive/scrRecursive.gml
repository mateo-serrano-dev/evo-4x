// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrRecursive(x_, y_, range, parent_){
	
	array_push(arrReachable, [x_, y_, range, parent_]);
	
	range--;
	
	if (range > -1)
	{
		for (var i = x_ - 1; i <= x_ + 1; i++)
		{ for (var j = y_ - 1; j <= y_ + 1; j++)
			{
				if (i != x_) xor (j != y_)
				{
					var index_ = scrFindArray(arrReachable, [i, j]);
					
					//Condiciones para ser caminable
					
					//Estar dentro del mapa
					if (i < 0) or (i >= intTileRows) or (j < 0) or (j >= intTileColums)
					{
						continue;
					}
					
					//Caracteristicas de las casillas que no deja que pases por ellas
					if (!scrWalkable(i, j))
					{
						continue;
					}
					
					// Si no se encuentra, escribir. Si se encuentra con menor rango, borrar y reescribir.
					if (scrFindArray(arrReachable, [i, j]) == -1)
					{
						scrRecursive(i, j, range, [x_, y_]);
					}
					else if (arrReachable[index_][2] < range)
					{
						array_delete(arrReachable, index_, 1);
						scrRecursive(i, j, range, [x_, y_]);
					}
				}
			}
		}	
	}
}