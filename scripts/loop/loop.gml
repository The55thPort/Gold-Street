function loop(variable, value_adding, array) {
	
	variable += value_adding

	if variable > array_length(array) - 1 {
		do variable -= array_length(array) until (variable >= 0 and variable <= array_length(array) - 1)
	}

	else if variable < 0 {
		do variable += array_length(array) until (variable >= 0 and variable <= array_length(array) - 1)
	}

	return variable
	
}