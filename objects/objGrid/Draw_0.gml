//Tipo de casilla
if (global.intDisplayLayer == 1)
{
	for(var i = 0; i < intTileRows; i++)
	{ for(var j = 0; j < intTileColums; j++) {
		//show_message(arrGrid[i][j].sprite)
		draw_sprite(arrGrid[i][j].sprite, 0, i * intTileSize, j * intTileSize);
		//draw_sprite_ext(sprTilePointed, 0, i * intTileSize, j * intTileSize, 1, 1, 0, c_red, 0.01 * arrGrid[i][j].temperature);
		//draw_arrow(i * intTileSize + 8, j * intTileSize + 8, i * intTileSize + 8 + arrGrid[i][j].stream.x, j * intTileSize + 8 + arrGrid[i][j].stream.y, 2);
	}	}
}
else
{
	for(var i = 0; i < intTileRows; i++)
	{ for(var j = 0; j < intTileColums; j++) {
		draw_sprite(arrGrid[i][j].spritedeep, 0, i * intTileSize, j * intTileSize);
	}	}
}


if (global.intDisplayLayer == 2)
{
	draw_set_color(c_blue);
	draw_set_alpha(0.2);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

if (insHover != noone) 
{
	var color = c_white;
	if insHover.idCreator != 0 color = c_red;
	draw_sprite_ext(sprTilePointed, 0, insHover.x, insHover.y, 1, 1, 0, color, 1.0);
}

if (insSelected != noone) && (insSelected.idCreator == 0)
{
	if insSelected.idCreator != 0 draw_set_color(c_red);
	draw_sprite(sprTileSelected, 0, insSelected.x, insSelected.y);
	draw_set_color(c_white);
}

if (global.uistate == 1)
{
	draw_set_color(c_black);
	draw_set_alpha(0.5);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}