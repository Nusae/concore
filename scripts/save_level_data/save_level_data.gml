/// @function save_level(filename)
function save_level(filename) {
    var level_data = {
        objects: [],
        commands: char_commands
    };
    with (all) {
        if (object_index == obj_ralsei || object_index == obj_ball || object_index == obj_key) {
            array_push(level_data.objects, {
                obj: object_get_name(object_index),
                x: x,
                y: y
            });
        }
    }
    var json = json_stringify(level_data);
    var buffer = buffer_create(string_byte_length(json) + 1, buffer_fixed, 1);
    buffer_write(buffer, buffer_string, json);
    buffer_save(buffer, filename + ".json");
    buffer_delete(buffer);
}