function LookupCapital(district_shops){

var overflow = 0
if district_shops >= 8 {
	overflow = district_shops - 8
	district_shops = 8
}
	
	
switch district_shops {
	
	case 1:
		if array_length(global.shops_in_district[properties.district_number]) == 1 {
			return properties.value_solo
		}
		else {
			return properties.value_solo / 2
		}
		
	case 2:
		if array_length(global.shops_in_district[properties.district_number]) == 2 {
			return properties.value_solo * 2
		}
		else if array_length(global.shops_in_district[properties.district_number]) == 3 {
			return floor(properties.value_solo * 1.25)
		}
		else {
			return properties.value_solo
		}
		
	case 3:
		if array_length(global.shops_in_district[properties.district_number]) == 3 {
			return properties.value_solo * 5
		}
		else {
			return properties.value_solo * 3
		}
		
	case 4:
		return properties.value_solo * 9
		
	case 5:
		return properties.value_solo * 11
		
	case 6:
		return properties.value_solo * 13
		
	case 7:
		return properties.value_solo * 15
		
	case 8:
		return properties.value_solo * (18 + (2 * overflow))
		
}
		
	

}