function execute_venture(number){
	// Ensure the lookup table is initialized

	// Safe dispatch: check for a defined action and call it
	if number >= 0 && number < array_length(obj_venture.venture_actions) {
		var action = obj_venture.venture_actions[number];
		if action != undefined {
			// New format: struct with .run
			if variable_instance_exists(action, "run") {
				var run_func = variable_instance_get(action, "run");
				if run_func != undefined {
					run_func();
					return;
				}
			}
		}
	}

	// Unknown venture number
	show_debug_message("Unknown venture number: " + string(number));

}