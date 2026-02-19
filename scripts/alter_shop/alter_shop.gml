// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function alter_shop(shop, percentage){
	shop.capital *= percentage
	shop.capital_max *= percentage
	shop.price_solo *= percentage
	shop.price *= percentage
	shop.value *= percentage
}