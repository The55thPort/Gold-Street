Hi Goodsir, and welcome to Gold Street!! <3

It's a little cluttered around here, sorry. I never anticipated anyone but me to
look at the underlying code of this project, but that being said, I still tried
to keep it pretty clean and organized! Still though, you're bound to find little
"band-aid" solutions around from place to place, so if you have any questions
or if something doesn't make sense, lemme know on Discord!! :]

1. Getting Started
2. Game Controls & Settings
3. A Note on Creating Boards & Characters

---------------------------------------------------------------
1. GETTING STARTED
---------------------------------------------------------------

When you first launch the game, you'll be greeted by a plain blue background with
seemingly nothing to do. To fix it, go to your LocalAppData folder and look for the
"Gold Street" folder, and inside it should be three folders called "Boards",
"Players", and "Themes" (These folders will only appear if you've launched the game
at least one time.). Open the Boards folder, copy "Mario Stadium" and "Lucky Zone"
from the zip folder I sent, and paste them into the Boards folder.

The boards are now in the correct file locations, but the game itself doesn't 
actually know they exist yet! To fix this, open the "select.txt" file inside
the Boards folder and replace "board1" with "Lucky Zone", and "board2" with
"Mario Stadium" (Don't forget the quotation marks!). Save the file, then 
relaunch the game.

You should see your boards on the menu now! Navigate the menu using "WASD", select
your board with "F", or go back a page with "Q". Once you've picked a board, press
"New Game", and...!!

...it crashed. Whoops- @~@

We still have to add in the characters, so we'll repeat a similar process we did for
the boards with the characters now. I haven't made it so the characters also load in
from a "select.txt" file yet, so for now, the game will only recognize "Niko" and
"Niko_P2" (though you can change it by code, I'll touch on that later). Copy those
two characters from the zip folder, paste them into "Players", and now you can
start a genuine game!

I recommend starting on Lucky Zone between the two boards because Mario Stadium was
my testing board. While you *can* play a game on it perfectly fine, the background
doesn't look as good as Lucky Zone's and isn't the board I'd like your first
impression to be. Also, one more tip: I mentioned in DMs that Venture Cards DO work,
but if you want to see what effect you actually got, you have to look at the output
terminal in GameMaker. Like I said, Venture Cards are DEFINITELY still in their
infancy.

---------------------------------------------------------------
2. GAME CONTROLS & SETTINGS
---------------------------------------------------------------

WASD - Move
F - Select
Q - Back
Tab - Toggle Stats (Dynamic (unfinished) --> Full --> Hidden)
Shift (hold) - Slow Camera Speed (only when viewing the board)

These controls can be changed in the Create event of "obj_persistent".

To change the player count, go to the Create event of "obj_persistent" and look for
the "players" variable, then add or subtract players from the array. I added the
maximum of eight to start, but you can even have as little as one lonely player.

To change the player *characters*, look just underneath the "players" variable and
you should see eight variables that all start with "player" and end with a number.
Just change the string to the folder name of the character you'd like to play as.
I included Marie in the zip file so you could test this out, but she's incredibly
unfinished and her sprites default to Niko's very often.

To change the music/sfx volumes, go to the Create event of "obj_audio" and change
the "music_volume" and "sfx_volume" variables. I think GameMaker MAY allow you to
set it higher than 1, but if memory serves, I think 1 is the maximum.

This SHOULD cover all the game settings. For anything board/character specific or
anything else I didn't cover, lemme know on Discord and I'll answer it!

---------------------------------------------------------------
3. A NOTE ON CREATING BOARDS & CHARACTERS
---------------------------------------------------------------
Boards in this game are NOT meant to be created by just typing them. My hope is
to incorporate a visual editor that allows you to create boards without ever
having to even *glance at* the text document itself, but for now, creating boards
in Notepad is the only way. It took me 6-7 hours to create Lucky Zone from scratch,
and that was when I knew what I was doing *and* just copying someone else's
existing board *and* using copy/paste everywhere I could. It would be drastically
shorter with a visual editor.

The same goes for characters as well, because while the information currently needed
for characters is significantly smaller than the boards, the spritework that goes
into them tends to make that process take longer than you'd think. If memory serves,
it took me an extra 2-4 hours total to create Niko.

If you REALLY wanna create your own custom board or character, I'll write a little
tutorial that explains how to do it. While it *is* a bit tedious, the end result is
super cool and incredibly fun. But I have to emphasize: It *will* be a bit tedious.
;^;

---------------------------------------------------------------