if run_once == false {
	
	if properties.type == "shop" {
		properties.owner = noone
		properties.capital = 0
		properties.capital_max = 0
		properties.value_solo = properties.value
		properties.price_solo = properties.price
		
		properties.district_number = district_name_convert(properties.district)
		array_push(global.shops_in_district[properties.district_number],id)
		
	}
	
	if properties.type == "bank" {
		properties.suits_last = [  ]
		properties.stocks_ask = false
		properties.stocks_last = [  ]
	}
	
	if properties.type == "suit-change" {
		properties.suit_display = properties.suit
		properties.timer = 30
	}
	
	run_once = true
}