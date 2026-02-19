//Calculate Total Value of Each District

global.district_values = array_create(26, 0) // DO NOT MOVE THIS, otherwise the stock prices skyrocket

with (obj_space) {
	if properties.type == "shop" {
		global.district_values[properties.district_number] += properties.value
	}
}

/////////////////////////////////////////////////////
//Calculate Stock Prices

var district = 0
repeat (array_length(global.shops_in_district)) {
	if array_length(global.shops_in_district[district]) != 0 {
		global.stock_prices[district] = floor(global.district_values[district]* district_multipliers[district] / 100) //array_length(global.shops_in_district[district]) / 65536 * (2816 * district_multipliers[district]))
		//what the hell are these multipliers
	}
	district++
}

/////////////////////////////////////////////////////