// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrCelularAutomata(grid, map_heigh, map_widght){
	
	var arrTempGrid = array_create(0);
	
	for (var i = 0; i < map_widght; i++)
	{ for (var j = 0; j < map_heigh; j++)
		{
			arrTempGrid[i][j] = grid[i][j].material;	//Sets a temporary grid, to read
		}
	}
	
	for (var j = 0; j < map_heigh; j++)
	{ for (var k = 0; k < map_widght; k++) //Loops through the map
		{
			var neighbor_sea_count = 0;	
			
			#region //Count Neighboars
			for (var y_ = j - 1; y_ <= j + 1; y_++)
			{ for (var x_ = k - 1; x_ <= k + 1; x_++)
				{
					if (y_ <= -1 or y_ >= map_heigh) or (x_ <= -1 or x_ >= map_widght)
					{
						neighbor_sea_count += 1;
						continue;
					}
					
					if (y_ == j) && (x_ == k)
					{
						continue;
					}
					
					if (arrTempGrid[x_][y_] == "Sea")
					{
						neighbor_sea_count += 1;
					}
				}
			} #endregion
			
			if (neighbor_sea_count <= 4)
			{
				grid[k][j].set_tile("Rock", 0);
				continue;
			}
			
			grid[k][j].set_tile("Sea", 0);
			
			
		}
	}
}