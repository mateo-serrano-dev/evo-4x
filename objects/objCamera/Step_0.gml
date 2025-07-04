//Pantalla Completa
var keyFullscreen = keyboard_check_pressed(vk_f11);
if (keyFullscreen)
{
	if (window_get_fullscreen() == false)
	{
		window_set_fullscreen(true);
	}
	else window_set_fullscreen(false);
}

//Movimiento de la camara
var keyCameraMove = mouse_check_button(mb_middle);
var keyCameraZoom = mouse_wheel_down() - mouse_wheel_up();


if (keyCameraMove)
{
	//Cada step ve la diferencia que hay entre el mouse y la camara
	intDiferenceX = mouse_x - x;
	intDiferenceY = mouse_y - y;
	if (mouse_check_button_pressed(mb_middle))
	{
		//Esto se ejecuta solo al pulsar
		intOriginX = mouse_x;
		intOriginY = mouse_y;
	}
	
	if (x > room_width)
	{
		x = 0;
		intOriginX -= room_width;
	}
	
	if (x < 0)
	{
		x = room_width;
		intOriginX += room_width;
	}
	
	//Si la distancia entre la camara y el mouse aumenta, la camara se aleja del eje. Lo contrario tambien es cierto. 
	x = intOriginX - intDiferenceX;
	y = intOriginY - intDiferenceY;
}

if (intCamWidth > 64 && !keyCameraZoom) or (intCamWidth < room_width && keyCameraZoom)
{
	if (objGrid.insSelected != noone) && global.followcam
	{
		x = lerp(x, objGrid.insSelected.x + 8, 0.1);
		y = lerp(y, objGrid.insSelected.y + 8, 0.1);
	}
	
	intCamWidth += (64 * keyCameraZoom);
	intCamHeigh += (36 * keyCameraZoom);
	
	if (intCamWidth > room_width)
	{
		intCamWidth = room_width;
		intCamHeigh = (intCamWidth * 9) / 16;
	}
}	

//Limite Vertical
x = clamp(x, intCamWidth / 2, room_width - intCamWidth / 2);
y = clamp(y, intCamHeigh / 2, room_height - intCamHeigh / 2);

//Mundo redondo
if (x > room_width - intCamWidth / 2) or (x < intCamWidth / 2)
{
	var _x;
	
	if (x > room_width / 2)
	{
		_x = objCamera.x - room_width;
	}
	else
	{
		_x = objCamera.x + room_width;
	}
	
	//view_visible[0] = true;
	camera_set_view_size(view_camera[0], intCamWidth, intCamHeigh);
	camera_set_view_pos(view_camera[0], _x - intCamWidth / 2, y - intCamHeigh / 2);
}
else
{
	view_visible[0] = false;
}


//Actualizacion de tamaño y posicion de la cámara
camera_set_view_size(view_camera[1], intCamWidth, intCamHeigh);
camera_set_view_pos(view_camera[1], x - intCamWidth/2, y - intCamHeigh/2);