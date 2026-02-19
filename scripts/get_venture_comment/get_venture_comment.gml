// Generic function to retrieve a property from venture_actions array
function get_venture_property(number, property_name) {
	if number >= 0 && number < array_length(obj_venture.venture_actions) {
		var entry = obj_venture.venture_actions[number];
		if entry != undefined {
			if variable_instance_exists(entry, property_name) {
				var value = variable_instance_get(entry, property_name);
				if value != undefined return string(value);
			}
		}
	}
	return "";
}

// Returns the comment string associated with a venture number (or empty string)
function get_venture_comment(number) {
	return get_venture_property(number, "comment");
}