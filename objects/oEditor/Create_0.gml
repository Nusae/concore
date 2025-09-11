// oEditor: Create Event

menu_items = [
    {name: "Wall", obj: oWall},
    {name: "Kris", obj: oKris},
    {name: "Susie", obj: oSusie},
    {name: "Ralsei", obj: oRalsei},
    {name: "Door Gray", obj: oDoorGray},
    {name: "Door Golden", obj: oDoorGolden},
    {name: "Saver Gray", obj: oGrayKeySaver},
    {name: "Saver Gold", obj: oGoldKeySaver},
	{name: "Switch", obj: oSwitch},
	{name: "Button", obj: oButton},
];

selected_index = 0;

grid_size = 32;

// Inicializar contadores de llaves globales
global.keys_gray = 0;
global.keys_golden = 0;
global.sentado_susie = 0;
global.sentado_kris = 0;
global.sentado_ralsei = 0; 
personaje = 3;

global.commandmode = false;

global.show_fail_window = false; 