//Calculate Total Value of Each District

global.district_values = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

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
		global.stock_prices[district] = floor(global.district_values[district] / array_length(global.shops_in_district[district]) / 65536 * (2816 * district_multipliers[district]))
	}
	district++
}

/////////////////////////////////////////////////////