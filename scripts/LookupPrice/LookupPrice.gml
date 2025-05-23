function LookupPrice(district_shops){
	
var overflow = 0
if district_shops >= 8 {
	overflow = district_shops - 8
	district_shops = 8
}

var price_base = 0

switch district_shops {
	
	case 1:
		if array_length(global.shops_in_district[properties.district_number]) == 1 {
			price_base = properties.price_solo
			return floor(price_base) + floor((price_base * 2) * (properties.capital / properties.capital_max))
		}
		else {
			price_base = properties.price_solo
			return floor(price_base) + floor(price_base * (properties.capital / properties.capital_max))
		}
		
	case 2:
		if array_length(global.shops_in_district[properties.district_number]) == 2 {
			price_base = properties.price_solo * 2
			return floor(price_base) + floor((price_base * 4) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 3 {
			price_base = properties.price_solo * 1.5
			return floor(price_base) + floor((price_base * 2.5) * (properties.capital / properties.capital_max))
		}
		else {
			price_base = properties.price_solo * 1.25
			return floor(price_base) + floor((price_base * 2) * (properties.capital / properties.capital_max))
		}
		
	case 3:
		if array_length(global.shops_in_district[properties.district_number]) == 3 {
			price_base = properties.price_solo * 3.75
			return floor(price_base) + floor((price_base * 10) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 4 {
			price_base = properties.price_solo * 2.5
			return floor(price_base) + floor((price_base * 6) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 5 or global.shops_in_district[properties.district_number] == 6 {
			price_base = properties.price_solo * 2
			return floor(price_base) + floor((price_base * 6) * (properties.capital / properties.capital_max))
		}
		else {
			price_base = properties.price_solo * 1.75
			return floor(price_base) + floor((price_base * 6) * (properties.capital / properties.capital_max))
		}
		
	case 4:
		if array_length(global.shops_in_district[properties.district_number]) == 4 {
			price_base = properties.price_solo * 5
			return floor(price_base) + floor((price_base * 18) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 5 {
			price_base = properties.price_solo * 3.25
			return floor(price_base) + floor((price_base * 18) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 6 or global.shops_in_district[properties.district_number] == 7 {
			price_base = properties.price_solo * 2.75
			return floor(price_base) + floor((price_base * 18) * (properties.capital / properties.capital_max))
		}
		else {
			price_base = properties.price_solo * 2.5
			return floor(price_base) + floor((price_base * 18) * (properties.capital / properties.capital_max))
		}
		
	case 5:
		if array_length(global.shops_in_district[properties.district_number]) == 5 {
			price_base = properties.price_solo * 6
			return floor(price_base) + floor((price_base * 22) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 6 {
			price_base = properties.price_solo * 4.25
			return floor(price_base) + floor((price_base * 22) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 7 {
			price_base = properties.price_solo * 3.75
			return floor(price_base) + floor((price_base * 22) * (properties.capital / properties.capital_max))
		}
		else {
			price_base = properties.price_solo * 3.5
			return floor(price_base) + floor((price_base * 22) * (properties.capital / properties.capital_max))
		}
		
	case 6:
		if array_length(global.shops_in_district[properties.district_number]) == 6 {
			price_base = properties.price_solo * 6.75
			return floor(price_base) + floor((price_base * 26) * (properties.capital / properties.capital_max))
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 7 {
			price_base = properties.price_solo * 5.25
			return floor(price_base) + floor((price_base * 26) * (properties.capital / properties.capital_max))
		}
		else {
			price_base = properties.price_solo * 4.5
			return floor(price_base) + floor((price_base * 26) * (properties.capital / properties.capital_max))
		}
		
	case 7:
		if array_length(global.shops_in_district[properties.district_number]) == 7 {
			price_base = properties.price_solo * 7.5
			return floor(price_base) + floor((price_base * 30) * (properties.capital / properties.capital_max))
		}
		price_base = properties.price_solo * 6
		return floor(price_base) + floor((price_base * 30) * (properties.capital / properties.capital_max))
		
	case 8:
		price_base = properties.price_solo * (8 + (2.5 * overflow))
		return floor(price_base) + floor((price_base * (37 + 6 * overflow)) * (properties.capital / properties.capital_max))
		
}

}