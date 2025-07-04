function scrFindArray(array, finding){
	
	var index = -1;
	
	for (var i = 0; i < array_length(array); i++)
	{
		if (array[i][0] == finding[0]) && (array[i][1] == finding [1])
		{
			var index = i;
		}
	}
	
	return index;
	
}