/// @function handle_delay(character, current_action)
/// @description Pauses the character for the specified delay duration (1s, 2s, or 5s)
/// @param {instance} character The character instance (e.g., oRalsei, oKris, oSusie)
/// @param {struct} current_action The current command struct with action and target
function handle_delay(character, current_action){
    // Ensure the character has a delay timer
    if (!variable_instance_exists(character, "delay_timer")) {
        character.delay_timer = 0;
    }
    
    // Parse the delay duration from the target (e.g., "1s" -> 1)
    var duration = real(string_replace(current_action.target, "s", ""));
    
    // Convert seconds to frames (assuming 60 FPS; adjust if your game uses a different FPS)
    var frames = duration * 60;
    
    // Increment the timer
    character.delay_timer += 1;
    
    // Check if the delay is complete
    if (character.delay_timer >= frames) {
        show_debug_message(character.my_name + " completed delay of " + string(duration) + "s");
        character.delay_timer = 0; // Reset the timer
        current_action = noone; // Clear the current action to move to the next command
    } else {
        show_debug_message(character.my_name + " delaying for " + string(duration) + "s, " + string(character.delay_timer) + "/" + string(frames) + " frames");
    }
    
    return current_action; // Return the current action (or noone if complete)
}