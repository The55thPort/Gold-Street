//OBJ_DICE - Invisible (though shouldn't be), handles die-related logic
/////////////////////////////////////////////////////
//Initialize Variables

readyflag = false

global.die_sprites = [ spr_die_1 ]
global.die_sprite_max = spr_die_max

roll_min = 1
roll_max = 6

timer = 0
idle_timer = 20
spin_timer = 0

diceroll = 0

/////////////////////////////////////////////////////