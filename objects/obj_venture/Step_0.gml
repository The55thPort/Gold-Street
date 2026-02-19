/// @description States exclusive to venture cards

switch global.state{
	
	case "venture_error": //in case the venture cannot be executed i.e. suit ventures
		if obj_menu.readyflag == true {
			obj_menu.readyflag = false
			global.state = "turn_end"
			global.substate = 0
		}
		break;
	
	case "venture_pay":
		break;
		
	case "venture_select":
		if obj_camera.readyflag == true {
			obj_camera.readyflag = false
			execute_venture(obj_game.venture_number)
			log("venture state: " + string(global.venture_state))
		}
		break;
		
	case "venture_roll":
		if obj_dice.readyflag == true {
			obj_dice.readyflag = false
			execute_venture(obj_game.venture_number)
		}
		break;
}