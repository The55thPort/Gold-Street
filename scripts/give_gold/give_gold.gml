// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function give_gold(gold_giver, gold_amount, gold_receiver){
	gold_giver.readycash -= floor(gold_amount);
	gold_receiver.readycash += floor(gold_amount);
}