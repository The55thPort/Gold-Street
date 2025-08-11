// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function key_name(_key) {
    // Check for A-Z letters
    if (_key >= 65 && _key <= 90) {
        return chr(_key);
    }
    // Check for 0-9 digits
    if (_key >= 48 && _key <= 57) {
        return chr(_key);
    }
    // Non-letter keys
    switch (_key) {
        case vk_up:     return "Up";
        case vk_down:   return "Down";
        case vk_left:   return "Left";
        case vk_right:  return "Right";
        case vk_enter:  return "Enter";
        case vk_escape: return "Escape";
        case vk_space:  return "Space";
        case vk_shift:  return "Shift";
        case vk_control: return "Ctrl";
        case vk_alt:    return "Alt";
        case vk_tab:    return "Tab";
        case vk_backspace: return "Backspace";
        case vk_delete: return "Delete";
        case vk_home:   return "Home";
        case vk_end:    return "End";
        case vk_pageup: return "Page Up";
        case vk_pagedown: return "Page Down";
        // Add more as needed
        default:
            var ch = chr(_key);
            if (string_length(ch) == 1 && ord(ch) >= 32 && ord(ch) <= 126) {
                return ch;
            }
            return string(_key); // fallback
    }
}