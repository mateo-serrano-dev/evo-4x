//Dibujar marco con el sprite de la habilidad
draw_self();
draw_sprite(skill_pointer.sprite, 0, x + 8, y + 8);

//Dibuja el nombre
draw_set_halign(fa_left);
draw_set_valign(fa_left);
//draw_text(x + sprite_get_width(sprite_index) / 2, y + sprite_get_width(sprite_index) + 2, skill_pointer.name);
draw_text(x, y + sprite_get_width(sprite_index) + 2, skill_pointer.name);

//Dibuja la linea de los hijos
var x_line = objUIskilltree.ui_horizontal - sprite_get_width(sprUIskill);
var _x = x + sprite_get_width(sprUIskill);
var _y = y + sprite_get_width(sprUIskill) / 2;

if array_length(insSons) > 0
{
	draw_line(_x, _y, _x + x_line / 3, _y);
	for(var i = 0; i < array_length(insSons); i++)
	{
		var _son_y = insSons[i].y + sprite_get_width(sprUIskill) / 2;
		draw_line(_x + x_line / 3, _y, _x + x_line * 2 / 3, _son_y);
		draw_line(_x + x_line * 2 / 3, _son_y, _x + x_line, _son_y);
	}
}

/*/Dibuja las lineas que relacionan las skills en el arbol de habilidades


var _spawn_y = spawn_y + sprite_get_width(sprUIskill) / 2
if skill_pointer.dependency != noone
{
	draw_line(x, _y, x - x_line / 2, _y);
	if spawn_y != y draw_line(x - x_line / 2, _y, x - x_line / 2, _spawn_y);
	draw_line(x - x_line / 2, _spawn_y, x - x_line, _spawn_y);
}*/

//Reinicia para los demas dibujados
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);