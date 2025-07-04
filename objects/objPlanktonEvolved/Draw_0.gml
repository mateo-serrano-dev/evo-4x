event_inherited();
if !bolDraw exit;

draw_self();

var sprite_size = sprite_get_width(sprPlanktonEvolved)
var adjust = 0;
if y >= room_width - 8 adjust = -sprite_size - 8;
var encuadrar_respecto_sprite = 0;

draw_set_color(c_white);
draw_rectangle(x - 1 + encuadrar_respecto_sprite, y + sprite_size + adjust + encuadrar_respecto_sprite, x + sprite_size + 1 + encuadrar_respecto_sprite, y + sprite_size + 4 + adjust + encuadrar_respecto_sprite, false);

var lenght_energy = intLife * sprite_size / intMaxLife;

draw_set_color(c_red);
if (lenght_energy > 0) draw_rectangle(x + encuadrar_respecto_sprite, y + sprite_size + 1 + adjust + encuadrar_respecto_sprite, x + lenght_energy + encuadrar_respecto_sprite, y + sprite_size + 3 + adjust + encuadrar_respecto_sprite, false);

draw_set_color(c_white);