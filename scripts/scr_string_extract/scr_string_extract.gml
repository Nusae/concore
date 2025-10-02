/// @param str The input string
/// @param delimiter The delimiter to split on
/// @param index The index of the part to return (0-based)
function string_extract(str, delimiter, index) {
    var parts = [];
    var current = "";
    var delim_pos = string_pos(delimiter, str);
    
    // If no delimiter, return the whole string for index 0, empty otherwise
    if (delim_pos == 0) {
        if (index == 0) return str;
        return "";
    }
    
    // Split the string
    while (string_length(str) > 0) {
        delim_pos = string_pos(delimiter, str);
        if (delim_pos == 0) {
            array_push(parts, str);
            break;
        }
        array_push(parts, string_copy(str, 1, delim_pos - 1));
        str = string_delete(str, 1, delim_pos);
    }
    
    // Return the requested part, or empty string if index is out of bounds
    if (index < array_length(parts)) {
        return parts[index];
    }
    return "";
}