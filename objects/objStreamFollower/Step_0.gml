depth = objGrid.depth + room_height - y;

var _x, _y;

_x = clamp(x + 8, 0, room_width - 1);
_y = clamp(y + 8, 0, room_height - 1);

TiledX = floor(_x / objGrid.intTileSize);
TiledY = floor(_y / objGrid.intTileSize);

//Suma de todas las velocidades
var vec_surface = objGrid.arrGrid[TiledX][TiledY].stream;
vec_surface.set_magnitude(1/intMass);

var sentido = 1;
if intDepth == 2 sentido = -1;
vec_speed.add(vec_surface.x, vec_surface.y * sentido);

var otro = instance_place(x, y, objOrganism);
if otro != noone if otro.intDepth != intDepth otro = noone;

var vec_expulsion = new Vector (0, 0)
if (otro != noone)
{
	vec_expulsion.set(x - otro.x, y - otro.y);
	vec_expulsion.set_magnitude(3/intMass);
	
	if object_index == objOrganism && otro.idCreator != idCreator
	{
		var recovery = 80;
		
		if check_skill("Multicelularidad") == otro.check_skill("Multicelularidad")
		{
			if (bolVulnerable && otro.bolVulnerable)
			{
				vec_expulsion.multiply(50);
				otro.vec_speed.add(-vec_expulsion.x, -vec_expulsion.y);
				
				intEnergia -= otro.intDamage;
				otro.intEnergia -= intDamage;
			
				bolVulnerable = false;
				otro.bolVulnerable = false
				
				alarm[1] = recovery;
				otro.alarm[1] = recovery;
			}
		}
		else if check_skill("Multicelularidad") && (otro.bolVulnerable)
		{
				vec_expulsion.multiply(50);
				otro.vec_speed.add(-vec_expulsion.x, -vec_expulsion.y);
				vec_expulsion.multiply(0);
				
				otro.intEnergia -= intDamage;
			
				otro.bolVulnerable = false
				
				otro.alarm[1] = recovery;
		}
	}
	
	else if object_index == objPlanktonEvolved 
	{
		var collision_force = 1;
		vec_expulsion.set_magnitude(collision_force);
		if !otro.check_skill("Multicelularidad") otro.vec_speed.add(-vec_expulsion.x, -vec_expulsion.y);
	}
}

vec_speed.add(vec_expulsion.x, vec_expulsion.y);

//Colisiones
vec_speed.set(lerp(vec_speed.x, 0, 0.1), lerp(vec_speed.y, 0, 0.1));
if intDepth == 2
{
	var vec_collision_speed = new Vector(vec_speed.x, vec_speed.y);
	var next_tileX = floor((vec_pos.x + vec_speed.x + 8 + 8 * sign(vec_speed.x)) / objGrid.intTileSize);
	var next_tileY = floor((vec_pos.y + vec_speed.y + 8 + 8 * sign(vec_speed.y)) / objGrid.intTileSize);

	if next_tileX != TiledX
	{
		if objGrid.get_tile(clamp(sign(vec_speed.x) + TiledX, 0, objGrid.intTileRows - 1), TiledY).get_material() != "Sea"
		{
			vec_collision_speed.x = 0;
		}
	}

	if  next_tileY != TiledY
	{
		if objGrid.get_tile(TiledX, clamp(sign(vec_speed.y) + TiledY, 0, objGrid.intTileColums - 1)).get_material() != "Sea"
		{
			vec_collision_speed.y = 0;
		}
	}
	vec_speed.set(vec_collision_speed.x, vec_collision_speed.y);
}

//Definir la posicion final
vec_pos.add(vec_speed.x * global.delta_multiplier, vec_speed.y * global.delta_multiplier);

if (vec_pos.x >= room_width) vec_pos.x = 0;
if (vec_pos.x < 0) vec_pos.x = room_width - 1;
vec_pos.y = clamp(vec_pos.y, 0, room_height - 16);
x = floor(vec_pos.x);
y = floor(vec_pos.y);

if objGrid.arrGrid[TiledX][TiledY].get_material() == "Sea" 
{
	//depth = 100;
	
	if (TiledY < 1 or TiledY > objGrid.intTileColums - 2) && intDepth == 1 intDepth = 2;
}
else depth = room_height - y;

