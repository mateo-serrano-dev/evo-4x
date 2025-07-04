// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrRandomAdjacent(x_, y_){
	
	var posible_reproduction = array_create(0);
	
	
	for (var j = y_ - 1; j <= y_ + 1; j++)
	{ for (var i = x_ - 1; i <= x_ + 1; i++)
		{
			if (i == x_) && (j == y_)
			{
				continue;
			}
			
			if (scrWalkable(i, j))
			{
				array_push(posible_reproduction, [i, j])
			}
		}
	}
	
	if (array_length(posible_reproduction) > 0)
	{
		var choise = irandom_range(0, array_length(posible_reproduction) - 1)
		return posible_reproduction[choise];
	}
}