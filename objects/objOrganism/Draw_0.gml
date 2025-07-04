event_inherited();
if global.intDisplayLayer != intDepth bolDraw = false;
if !global.bolMicroLens && !check_skill("Multicelularidad") bolDraw = false;
if !bolDraw exit;

draw_self();
var sprite_size = sprite_get_width(sprCelulas);
var adjust = 0;
if y >= room_height - sprite_size - 4 adjust = -24

draw_set_color(c_white);
draw_rectangle(x - 1, y + sprite_size + adjust, x + sprite_size + 1, y + sprite_size + 4 + adjust, false);

var lenght_energy = intEnergia * sprite_size / intMaxEnergy


if idCreator == 1 draw_set_color(c_red);
else draw_set_color(c_teal);

if (lenght_energy > 0) draw_rectangle(x, y + sprite_size + 1 + adjust, x + lenght_energy, y + sprite_size + 3 + adjust, false);

draw_set_color(c_white);


if (!array_equals(arrHeredit, arrAdaptations)) draw_sprite(sprNotificate, 0, x, y);