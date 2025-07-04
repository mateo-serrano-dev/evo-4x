x = 0;
y = 0;
if global.intDisplayLayer == 1 sprite_index = sprTileBckg;
else sprite_index = sprTileDeepBckg;

image_xscale = room_width / sprite_get_width(sprite_index);
image_yscale = room_height / sprite_get_height(sprite_index);

depth = objGrid.depth + 1000 + room_height;