// Diálogos específicos para Logic
dialogos = [
    "Bienvenido a la sala Logic. Aquí explicaremos los elementos del juego.",
    "Primero, el switch: Si no hay nadie encima, no se mueve.",
    "Con 1 persona, empieza a moverse lentamente.", 
    "Con 2 personas, se mueve más rápido.",  
    "¡Pero con 3, explota! Cuidado en los niveles reales.", 
    "Ahora, el botón: Solo puede haber una persona encima.",  
    "Si pones más de una, explota.",  
    "Finalmente, las puertas: Requieren llaves doradas o grises para abrirse.",
    "Por ejemplo, una puerta dorada necesita una llave dorada.\n En general en la parte de arriba izquierda",  
	"Ahora prueba a ir a la puerta con Kris", 
	"Kris obtiene la llave, como ves ahora esta en su cabecita", 
	"Y luego lo guardas en el guardador, esa cosa gris del suelo", 
	"Una vez lo atraviesas te teletransporta, en los niveles lo entenderas",
	"Además una vez guardado nadie puede guardar ahí \ny una vez abierto una puerta esta abierto para todos",
	"Eso hace que ya no lo tenga Kris sino que cualquiera puede usarlo",
	"¡Listo! Ahora puedes ir a los niveles reales."  
];

// Personajes visibles desde el inicio
show_ralsei = true;
show_susie = true;
show_kris = true;

// Posiciones iniciales de personajes (ajusta según tu sala)
if (instance_exists(oRalsei)) oRalsei.x = 100; oRalsei.y = 100;
if (instance_exists(oSusie)) oSusie.x = 150; oSusie.y = 100;
if (instance_exists(oKris)) oKris.x = 200; oKris.y = 100;

// índice del diálogo actual
dialog_index = 0;

// control de escritura tipo Undertale (una letra a la vez)
dialog_text = "";
dialog_full = dialogos[dialog_index];
dialog_pos = 0;
dialog_speed = 2; // menor = más rápido
dialog_timer = 0;
finished = false;

// Control para saber si ya se mostró todo
finished = false;

if (string_length(dialog_full) > 0) {
    dialog_pos = 1;
    dialog_text = string_copy(dialog_full, 1, dialog_pos);
}


global.commandmode = false; 