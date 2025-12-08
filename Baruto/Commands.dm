mob/verb
	Rules()
		set hidden=1
		var/text = {"
		<html>
		<head>
		<title>Rules</title>
			<style>
				body {
					background-color: '#000000';
					color: '#ffffff'
				}
			</style>
		</head>
		<body>
		<center>
		<p>All Rules will be listed here!</p>
		<hr>
		<h3>Rules</h3>
		<hr>
<br><br>
These rules need to be followed in-game, on the HUB, and on the forums. Be sure to use common sense!
<br><br><br>
+No killing in safe areas.
<br>
[][]-30 Min Jail.
<br>
[][]-1 Day Ban.
<br>
[][]-1 Week Ban.
<br><br>
+No blocking doorways.
<br>
[][]-Boot.
<br>
[][]-30 Min Jail.
<br>
[][]-1 Day Ban.
<br><br>
+No spam killing. {more than 3 kills without provoke within 10minutes}
<br>
[][]-1 Day Ban.
<br>
[][]-3 Day Ban.
<br>
[][]-1 Week Ban
<br><br>
+No spawn killing.
<br>
[][]-2 Day Ban.
<br>
[][]-4 Day Ban.
<br>
[][]-2 Week Ban.
<br><br>
+No disrespectful and profanity in world chat.
<br>
[][]-10 Minute Mute.
<br>
[][]-30 Minute Mute.
<br>
[][]-1 Hour Mute.
<br><br>
+No killing newbies. {Under level 5}
<br>
[][]-1 Hour Jail.
<br>
[][]-1 Day Ban.
<br>
[][]-1 Week Ban.
<br><br>
+No death/respawn avoiding.
<br>
[][]-20 Min Jail.
<br>
[][]-45 Min Jail.
<br>
[][]-1 Day Ban.
<br><br>
+Accidental bug abuse.
<br>
[][]-Warning.
<br>
[][]-No Longer Accidental.
<br><br>
+No bug abuse.
<br>
[][]-1 Hour Jail
<br>
[][]-1 Day Ban.
<br>
[][]-3 Day Ban.
<br><br>
+No taking an Admins name upon wipe.
<br>
[][]-1 Week Ban and account removed.
<br><br>
+No Tai training on puppets.
<br>
[][]-1 Hour Jail.
<br>
[][]-Tai Nerf and 1 Day Ban.
<br>
[][]-Character delete and 3 Day Ban.
<br><br>
+No multikeying.
<br>
[][]-Accounts deleted
<br><br>
+No being disrespectful to admins.
<br>
[][]-Up to 20min Mute.
<br>
[][]-1 Hour Mute.
<br>
[][]-1 Day Ban.
<br><br>
+No afk training.
<br>
[][]-Stat nerf and 1 Day Ban.
<br>
[][]-Stat nerf and 3 Day Ban.
<br>
[][]-Character removed and 3 Day Ban.
<br><br>
+No afk training others. {Multi-shadow-clone training others}
<br>
[][]-1 Hour active Jail.
<br>
[][]-1 Day Ban.
<br>
[][]-5 Day Ban.
<br><br>
+No bugging Chuunin Exams.
<br>
[][]-1 Hour Jail.
<br>
[][]-3 Hour Jail.
<br>
[][]-1 Day Ban.
<br><br>
+No pulling out of binds.
<br>
[][]-20 Min Jail.
<br>
[][]-1 Hour Jail.
<br>
[][]-1 Day Ban.
<br><br>
+No Training on Clients or Unkillable clones.
<br>
[][]-Stat nerf and 1 Hour Jail.
<br>
[][]-Stat nerf and 1 Day Ban.
<br>
[][]-Character removed and 1 Day Ban.
<br><br>
+No pushing/pulling through multi-hit jutsus.
<br>
[][]-30 Minute Jail.
<br>
[][]-1 Hour Jail.
<br>
[][]-1-3Day Ban.
<br><br><br>
*Anything past the 3rd offense is up to the admin dealing the punishment and could result in a permanent ban.
<br>
**All Punishments are flexible at admins expense.
<br>
**Admin Abuse is not tolerable. Loss of position if Admin is caught abusing.
<br>
***Rules are subject to change without warning.
<br>
		</center>
		<font size="2" color="red">
		<div style="text-align:right;">
		Credit goes to our amazing developers.
		</div>
		</font>
		</body>
		</html>
  	  "}
		src << browse(text, "window=Updates;size=500x400")

/*mob/verb/IconChoice()
	set hidden = 1
	switch(input(src,"Which Skilcolor would you like?","Select",)in list("Dark","White"))
		if("Dark")
			src.icon='Black MaleBase.dmi'
			return
		if("White")
			src.icon='MaleBase.dmi'
			return
			*/