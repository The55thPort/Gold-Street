switch state {
	
	case "arrow":
		var spr = spr_arrow_e
		var col = global.player.color
		if blinking == true {col = c_grey}
		
		//+23, -22
		if dir <= 23 or dir >= 338 {spr = spr_arrow_e}
		if dir <= 68 and dir >= 23 {spr = spr_arrow_ne}
		if dir <= 113 and dir >= 68 {spr = spr_arrow_n}
		if dir <= 158 and dir >= 113 {spr = spr_arrow_nw}
		if dir <= 203 and dir >= 158 {spr = spr_arrow_w}
		if dir <= 248 and dir >= 203 {spr = spr_arrow_sw}
		if dir <= 293 and dir >= 248 {spr = spr_arrow_s}
		if dir <= 338 and dir >= 293 {spr = spr_arrow_se}
		
		draw_sprite_ext(spr,0,x,y,1,1,0,col,1)
	break;
	
	default:
		draw_self()
	break;
	
}