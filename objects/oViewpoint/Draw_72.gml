// Evento Pre-Draw (Draw 72) del objeto oViewpoint
// --- Limpieza total del buffer de pantalla ---

// Este comando borra todo lo que hay en la ventana (no solo en la vista)
// antes de que cualquier objeto se dibuje en este frame.
// Esto elimina los "fantasmas" visuales de niveles o vistas anteriores.
draw_clear(c_black);
