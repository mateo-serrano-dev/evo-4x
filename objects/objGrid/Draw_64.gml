if (global.uistate == 1) exit;

arrayDraw = ["FPS: " + string(fps), "Evolution points: " + string(global.arrEvoPoints[0]), "AltEvopts: " + string(global.arrEvoPoints[1])];
if insSelected != noone 
{
	array_push(arrayDraw, "Age: " + string(insSelected.intAge));
	array_push(arrayDraw, "Bioritmo: " + string(insSelected.intBioritmoTimer));
}

for (var i = 0; i < array_length(arrayDraw); i++)
{
	draw_text(15, 35 + i * 20, arrayDraw[i]);
}

for (var i = 0; i < array_length(global.arrSpecies[0]); i++)
{
	draw_text(400, 35 + i * 20, global.arrSpecies[0][i].arrAdaptations);
}


if (global.winstate == -1) 
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text(window_get_width() / 2, window_get_height() / 2, "You lose");
}

if (insSelected != noone) && (insSelected.intEnergia > 30) && (insSelected.idCreator == 0)
{
	draw_set_halign(fa_right);
	draw_text(display_get_gui_width() - 20, display_get_gui_height() - 40, "Mitosis: ");
	draw_text(display_get_gui_width() - 20, display_get_gui_height() - 20, "Press Space!");
}

//Resetea todo anashe
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

