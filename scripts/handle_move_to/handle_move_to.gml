/// @function handle_move_to(character, current_action, target_x, target_y, speed)
/// @description Handles the move_to logic for any character
/// @param character The instance id of the character
/// @param current_action The current action struct
/// @param target_x Var for target x (passed by reference)
/// @param target_y Var for target y (passed by reference)
/// @param speed Var for speed (passed by reference)
function handle_move_to(character, current_action) {
    var target_obj = noone;
    var target_name = "o" + current_action.target; // Generic (e.g., oWall, oBall)
    var num_targets = instance_number(asset_get_index(target_name));
    show_debug_message("Number of " + target_name + " instances: " + string(num_targets));
    if (num_targets > 0) {
        target_obj = instance_find(asset_get_index(target_name), 0); // First instance
        show_debug_message("Target " + target_name + " found at: " + string(target_obj.x) + ", " + string(target_obj.y));
    }
    if (target_obj != noone) {
        character.target_x = target_obj.x;
        character.target_y = target_obj.y;
        character.speed = 2;
        show_debug_message(character.my_name + " target set to: " + string(character.target_x) + ", " + string(character.target_y));
    } else {
        show_debug_message("No " + target_name + " target found, resetting action");
        current_action = noone;
    }
}