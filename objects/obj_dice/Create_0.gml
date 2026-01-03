//OBJ_DICE - Invisible (though shouldn't be), handles die-related logic
/////////////////////////////////////////////////////
//Initialize Variables

readyflag = false

global.die_sprites = [ spr_die_2 ]
global.die_sprite_max = spr_die_max

roll_min = 1
roll_max = 6

timer = 0
idle_timer = 20
spin_timer = 0

diceroll = 0
dice_rolls = [spr_die_1, spr_die_2, spr_die_3, spr_die_4, spr_die_5, spr_die_6, spr_die_7, spr_die_8, spr_die_9]

/////////////////////////////////////////////////////