// Returns the comment string associated with a venture number (or empty string)
function get_venture_comment(number) {
	if number >= 0 && number < array_length(obj_venture.venture_actions) {
		var entry = obj_venture.venture_actions[number];
		if entry != undefined {
			if entry.comment != undefined return string(entry.comment);
			// Backwards-compat: if someone kept the inline comment as a separate array
			if obj_venture.venture_comments != undefined {
				return string(obj_venture.venture_comments[number]);
			}
		}
	}
	return "";
}