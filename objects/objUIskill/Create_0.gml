// Inherit the parent event
event_inherited();
bolHover = false;
skill_pointer = noone;
insSons = array_create(0);
spawn_y = array_create(3, 0);
numbFathers = 0;

funcion_ui = function () {
	if (!skill_pointer.is_unlocked()) objGrid.bolSelected = id;
}

/*var ui_inbetween = 40;
var collision = instance_place(x, y, objUIskill);

//collision_line()

if (collision != noone)
{
	while abs(y - collision.y) < sprite_get_height(sprite_index) * 2 + ui_inbetween {
		y++;
		collision.y--;
	}
}*/

bolSelected = false;