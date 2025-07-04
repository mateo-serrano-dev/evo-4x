function scrPathfinding(x_, y_, previous_point, instance_){	
	
	array_push(instance_.arrPath, [x_, y_]);
	
	if (previous_point != 0)
	{
		var new_previous_point = arrReachable[scrFindArray(arrReachable, [previous_point[0], previous_point[1]])][3];
		scrPathfinding(previous_point[0], previous_point[1], new_previous_point, instance_);
	}
}