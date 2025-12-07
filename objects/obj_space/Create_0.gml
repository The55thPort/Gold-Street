//OBJ_SPACE - Visible, holds art and data for each individual space
/////////////////////////////////////////////////////
//Initialize Variables
run_once = false

properties = {
	//General
	space : 0,
	type : "",
	connections : [  ],
	blocked : [  ], //blocked connections depending on last space
	x : 0,
	y : 0,
	timer : 0, //only for spaces that need it
	
	//Banks Only
	suits_last : [  ], //Holds snapshots of players' suits as they pass
	stocks_last : [  ],
	
	//Shops Only
	owner : noone, //do not add to board data
	value : 0,
	value_initial : 0, //do not add to board data
	price : 0,
	price_initial : 0, //do not add to board data
	capital : 0, //do not add to board data
	capital_max : 0, //do not add to board data
	district : "",
	
	//Suits & Change-of-Suits Only
	suit : 0, //0 - Spade, 1 - Heart, 2 - Diamond, 3 - Club
	suit_display : 0, //CoS tiles only, do not add to board data
}