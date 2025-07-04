function Vector(_x, _y) constructor {
	x = _x;
	y = _y;
	
	static set = function(_x, _y)
	{
		x = _x
		y = _y
	}
	
	static add = function(_x, _y)
	{
		x += _x
		y += _y
	}
	
	static subtract = function(_x, _y)
	{
		x -= _x
		y -= _y
	}
	
	static multiply = function(_scalar)
	{
		x *= _scalar
		y *= _scalar
	}
	
	static divide = function(_scalar)
	{
		x /= _scalar
		y /= _scalar
	}
	
	static get_magnitude = function()
	{
		return sqrt(x*x + y*y);
	}
	
	static normalize = function()
	{
		if(x != 0 or y != 0)
		{
			var _factor = 1 / get_magnitude();
			x = _factor * x;
			y = _factor * y;
		}
	}
	
	static set_magnitude = function(_scalar)
	{
		normalize();
		multiply(_scalar);
	}
	
	static limit_magnitude = function(_limit)
	{
		if(get_magnitude() > _limit)
		{
			set_magnitude(_limit)
		}
	}
	
	static get_direction = function()
	{
		return point_direction(0, 0, x, y);
	}
}