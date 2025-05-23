x = properties.x
y = properties.y

switch properties.type {
	
	case "bank":
		sprite_index = spr_bank
	break;
	
	case "event":
		sprite_index = spr_event
	break;
	
	case "shop":
		sprite_index = spr_shop
		if properties.owner != noone {
			image_blend = properties.owner.color
			var pos = 0
			var district_shops = 0
			do {
				if properties.owner.shops[pos].properties.district_number == properties.district_number {
					district_shops += 1
				}
				pos++
			} until pos = array_length(properties.owner.shops)
			
			properties.capital_max = LookupCapital(district_shops)
			properties.price = LookupPrice(district_shops)
			if properties.capital > properties.capital_max {
				properties.capital = properties.capital_max
			}
	
		}
		else {
			image_blend = c_white
			properties.capital = 0
		}
		
		properties.value = properties.value_solo + properties.capital
	break;
	
	case "suit":
	
		switch properties.suit {
			
			case 0:
				sprite_index = spr_suit_base_spade
			break;
			
			case 1:
				sprite_index = spr_suit_base_heart
			break;
			
			case 2:
				sprite_index = spr_suit_base_diamond
			break;
			
			case 3:
				sprite_index = spr_suit_base_club
			break;
			
		}
	break;
	
	case "suit-change":
		sprite_index = spr_suit_base_change
		
		var suit_next = properties.suit_display + 1
		if suit_next == 4 {suit_next -= 4}
		
		if suit_next == properties.suit {
			properties.timer--
			if properties.timer == 0 {
				properties.timer = 30
				properties.suit_display = properties.suit
			}
		}
		else {
			properties.timer = 30
			properties.suit_display = properties.suit
		}
	break;
	
	case "venture":
		sprite_index = spr_venture
	break;
	
	case "arcade":
		sprite_index = spr_arcade
	break;
	
}