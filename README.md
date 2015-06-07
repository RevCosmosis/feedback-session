# feedback-session
Sourcemod plugin for TF2 that gives everyone godmode, noclip, and disables the game timer. This would be used to let everyone have a discussion about the map over chat (text, voice, whatever).

An outline for what this sourcemod will hopefully do when it is complete:

-When turned on, things will not activate until the round is over. There will be a command to force it on in the middle of the round as well.
-Once it activates, everyone gets godmode and noclip and the round time is disabled (optional). Anyone who joins the game or respawns will be automatically godded and noclipped.
-This state will last indefinitely.
-Deactivating it will set everything back to normal.

So, as an actual outline of functions:

---

	!fs on next

Feedback session will begin on the next round.

	!fs on soft

Feedback session begins right now without resetting anything.
	
	!fs on hard

Feedback session will begin right now by resetting the round.

	!fs off soft

Feedback session ends right now without resetting anything.
	
	!fs off hard

Feedback session ends right now by resetting the round.

----	

	!fs timer on/off

The game timer will/will not continue during the feedback session.
	
	!fs win on/off

Teams can/cannot win during the feedback session.

	!fs end on/off

Feedback session will/will not begin when the map timer is over.
	
---

If I'm lazy, the plugin will be much simpler, and simply be an on/off that handles godding/noclipping people who spawn after the thing starts. I'm probably going to be lazy.