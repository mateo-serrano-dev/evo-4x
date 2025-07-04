depth = objGrid.depth + room_height - y;

intCreationTimer -= global.delta_multiplier;

var movible = instance_nearest(x, y, objStreamFollower)
if movible.TiledX == intTiledX && movible.TiledY == intTiledY movible.intDepth = 1;

if intCreationTimer <= 0
{
	//Creacion de Plankton sucesiva
	var radius = 2;

	var arr_watertiles = array_create(0);
	for (var i = (intTiledX - radius); i < (intTiledX + radius); i++)
	{
		for (var j = (intTiledY - radius); j < (intTiledY + radius); j++)
		{
			if i < 0 or j < 0 or i >= objGrid.intTileRows - 1 or j >= objGrid.intTileColums - 1 continue;
			
			if (objGrid.arrGrid[i][j].get_material() == "Sea")
			{
				array_push(arr_watertiles, [i, j]);
			}
		}	
	}

	var chance = random_range(0, 100);
	var type_obj = objPlankton;
	if chance > 75 type_obj = objPlanktonEvolved;
		
	//Chooses place
	 if array_length(arr_watertiles) > 0 
	 {
		 var creation = irandom_range(0, array_length(arr_watertiles) - 1);
	
		//Gestiona data del organismo
		with(instance_create_depth(arr_watertiles[creation][0] * objGrid.intTileSize, arr_watertiles[creation][1] * objGrid.intTileSize, 11, type_obj))
		{
			intDepth = 2;
		}
	}
	else instance_destroy();
	
	intCreationTimer = intTimeCreation;
}