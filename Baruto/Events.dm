mob/verb
	Updates()
		set hidden=1
		var/text = {"
		<html>
		<head>
		<title>Updates</title>
			<style>
				body {
					background-color: '#000000';
					color: '#ffffff'
				}
			</style>
		</head>
		<body>
		<center>
		<p>All new updates will be listed here.</p>
		<hr>
		<h3>1.3.7-Minor Patch</h3>
		<br>
		-Boosted the cooldown of Advanced Substitution Jutsu.
		<br>
		-Boosted the cooldown of Puppet Shoot.
		<br>
		-Added the cooldown to Paper Chakram... It practicly had none.
		<br>
		-Nerfed Tsukiyomi by a slight amount. It seems someone boosted it recently so I changed it back to the way it was before, which was good since Genjutsu is actually easier to train than the rest of the stats now (lol it was never like that).
		<br>
		<h3>1.3.7</h3>
		<br>
		-Fixed some bugs where your Sage / Curse Seal / Weapons overlay would dissapear after you use any jutsu which removes overlays.
		<br>
		-Disabled all currently added Events until everything is tested and fixed.
		<br>
		-Reworked Paper entirely. It's now made of Paper Chakram, Shikigami Dance, Shikigami Spear and Angel Wings which add a special effect to each Paper jutsu.
		<br>
		-Fixed a LOT of jutsus which drained chakra before they were supposed to.
		<br>
		-Fixed (hopefully, didn't test) and re-added K.O a Bandit mission.
		<br>
		-Nerfed certain Clans by a small amount, nothing major worth mentioning.
		<br>
		-Mud Riven cannot be used while Earth Cage is active as of now.
		<br>
		-Fixed Root Strangle due to it not having an icon, and also nerfed Daijurin no jutsu a little bit. Just a little.
		<br>
		-Changed the EXP gain from dodging and punching, therefore making Strength and Agility quite harder to train.
		<br>
		-Nerfed Lightning Element by quite a good amount. Reason? Completely dominates other elements.
		<br>
		-Nerfed Nara clan. Shadow Punch and Shadow Stab damage mostly.
		<br>
		-Maximum level up EXP has been boosted. Don't worry though, Events compensate for this, maybe even more than they should!
		<br>
		-Changed the amount of EXP gained through Weaponist jutsus.
		<br>
		-Changed the amount of EXP gained through Gravity jutsus by approx. 50% or so.
		<br>
		<h3>1.3.6 - Minor patch</h3>
		-Balanced and upadated some of the Rinnegan jutsus. Adding in Chibaku Tensei aswell.
		<br>
		-Reduced the bind time of Lightning Pillars by 50% approx.
		<br>
		-Reduced the amount of experience gained by punching players as it was too high and easy trained compared to Ninjutsu.
		<br>
		-Reduced the amount of experience gained by outdoor killing from 10-15 to 5-10 xp per kill.
		<br>
		<h3>1.3.6</h3>
		<hr>
		-Many bug fixes.
		<br>
		-Re-added a part to the Rules list that was removed accidently awhile ago.
		<br>
		-Centered Doton Doryuusou.
		<br>
		-Removed the skin tone change from the interface.
		<br>
		-Fixed Immortal jutsu.
		<br>
		-Arranged admin verbs allitle.
		<br>
		-Included skin tone in the creation(currently unavailable).
		<br>
		-Fixed the bug with losing chakra while on cooldown for lightning pillars and earth boulder.
		<br>
		-Fixed the handsigns shown for Doton Doryuusou no jutsu.
		<br>
		-Re-added Suijinheki. No one told me it's a defencive jutsu.
		<br>
		-Fixed Eight Gates Assault's cooldown.
		<br>
		-Fixed Reaper Death Seal's cooldown.
		<br>
		-Changed Reaper Death Seal's way of damage.
		<br>
		-Fixed Reaper Death Seal's ninjutsu exp gain.
		<br>
		-Increased Susanoo's cooldown
		<br>
		-Nerf'd Mokuton - Daijurin no Jutsu
		<br>
		-Suiton Teppoudama, Doton Doryo Dango, and Doryuusou was boosted.
		<br>
		-Fixed the Jutsu cost of Suiton Tepp, Doton Doryo, and Doryuusou.
		<br>
		-Nerf'd flying thunder god's movement distance(A lot).
		<br>
		-Made it so you can no longer challenge yourself.
		<br>
		-Removed a few broken jutsus.
		<br>
		-Added in Player watch for Moderators.
		<br>
		-Made the admin's world chat text normal size.
		<br>
		-Blocked clients again.
		<br>
		<h3>1.3.5</h3>
		<br>
		-Added an Admin hideout/meeting room.
		<br>
		-Fixed a couple Genin/Chuunin questions.
		<br>
		-Hopefully fixed the clients again.
		<br>
		-Fixed Arena bugs.
		<br>
		-Puppets can now be killed.
		<br>
		-Made things hengable again.
		<br>
		-Blocked clients.
		<br>
		-Added f9-f10 for other villages.
		<br>
		-Fixed invisibility henge bug when Resting.
		<br>
		-Change some Administrative related material.
		<br>
		-Warp Rasengan is added
		<br>
		-Ink jutsu are added
		<br>
		-Added Sage Release: Giant Rasengan
		<br>
		-Changed the World XP verb for Admins.
		<br>
		-Updated the update box.
		<br>
		-Fixed Mizu retire text.
		<br>
		-Included all villages in the War event.
		<br
		-Fixed Deidara hair's Death icon.
		<br>
		-Any un-used doors have been removed.
		<br>
		-Swapped Mist and Sound Chuunin Vests.
		<br>
		-Changed New Sound Vest(old mist vest) to a new color.
		<br>
		-Updated Skill tree interface icons.
		<br>
		-Organized Skill trees.
		<br>
		-Completely new Village Symbols(Credit to Yaku).
		<br>
		-Admin Shield re-implimented into game.
		<br>
		-Curse seal aura  no longer bugs when you logout with it on.
		<br>
		-Lavitiz SoulBan has been re-added.
		<br>
		-Rock Kage losing commands when logging out has been fixed.
		<br>
		-Moved Sand Banker into a reachable position.
		<br>
		-Fixed Demote Jounin verb for kage.
		<br>
		-Fixed Demote Anbu verb for kage.
		<br>
		-Fixed Demote Sage verb for kage.
		<br>
		-Mud River Cooldown increased.
		<br>
		-Removed Bandits
		<br>
		-Nerfed Eight Gates Assault Chakra drain
		<br>
		-Increased Eight Gates Assault Damage.
		<br>
		-Nerfed 64 Palms chakra drain.
		<br>
		-Added Kazekage Puppet summoning back.
		<br>
		-Nerfed Kazekage Puppet damage.
		<br>
		-Uchiha Mangekyou Sharingan Takes 15% of Users Health.
		<br>
		-Uchiha Eternal Mangekyou Sharingan takes none of its users health.
		<br>
		-All Jutsu now give increased EXP.
		<br>
		-Tsukiyomi, Temple of Nirvana, Tree Binding, and Bringer of Darkness all now gives Genjutsu Exp.
		<br>
		-Shadow Clones now do not take health, and they take less chakra.
		<br>
		-Removed Hotel system, may turn this into something different.
		<br>
		-Sand has a New Entrance.
		<br>
		-Added Kamui.
		<br>
		-Changed the the order Uchiha gain jutsu.
		<br>
		-Nerfed Amaterasu.
		<br>
		-Added the EXP Lock System.
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
mob
	White_Zettsu
		icon='zettsu.dmi'
		Name="White Zettsu"
		health=800
		maxhealth=800
		var/killed=0
		var/oloc
		var/hited=0
		move=0
		Bump(mob/M)
			var/ppunch="left"
			if(src.hited==1) return
			if(istype(M,/mob/White_Zettsu/))
				return
			if(istype(M,/mob/player/))
				if(ppunch=="left")
					ppunch="right"
					flick("punchl",src)
				if(ppunch=="right")
					ppunch="left"
					flick("punchr",src)
				M.health-=100
				M.UpdateHMB()
				M.Death(src)
				src.hited=1
				sleep(10)
				src.hited=0
		Move()
			if(src.move==1)
				return
			else
				..()
mob/White_Zettsu/New()
	if(src.killed==1)
		src.loc=null
		spawn(600)
		src.loc=src.oloc
		src.killed=0
	else
		src.health=src.maxhealth
		src.oloc=src.loc
		spawn(1)   src.CombatAI()
		return ..()
mob/White_Zettsu/proc/CombatAI()
	while(src)
		if(src.health<=0)
			src.killed=1
			src.New()
			return
		src.Move()
		for(var/mob/M in oview())
			if(istype(M,/mob/White_Zettsu/))
				continue
			if(M.village=="Akatsuki")
				continue
			if(M.dead==1)
				continue
			else
				step_towards(src,M)
				if(get_dist(src,M)<=1)
					Bump(M)
		sleep(4)

obj
	zettsuspawn
		var/filled=0

var
	lock=1
	chuuninlock=0
	wartype=null
	akatpoints=0
	sforcepoints=0
mob
	var
		joinedwar=0
		joinedakatshinobiw=0
		pvppoints=0
	Admin
		verb
			Host_Great_Ninja_War_Event()
				set category = "Administrator"
				src<<"Disabled this until I fix it fully.  ~Vik"
				return
				if(chuuninlock==1)
					return
				world<<"<font size = 2><font color=white>[usr] started Great Ninja War Event !!! Join !!!"
				lock=0
				chuuninlock=1
				wartype="NINJA WAR"
			Host_Allied_Shinobi_War()
				set category = "Administrator"
				src<<"Disabled this until I fix it fully.  ~Vik"
				return
				if(chuuninlock==1)
					return
				world<<"<font size = 2><font color=red>Akatsuki and Allied Shinobi Forces have as of now started a war!!! All persons above level 30 will enter the war regardless of their will!!!!!"
				for(var/mob/M in world)
					if(M.village=="Akatsuki")
						M.joinedakatshinobiw=1
						world<<"[M] joined to fight for Akatsuki against Allied Shinobi Force!!!"
						M.loc=locate(92,22,19)//akatsuki side location
					else
						if(M.level>=30)
							M.joinedakatshinobiw=1
							world<<"[M] joined to fight for Allied Shinobi Force against Akatsuki!!!"
							M.loc=locate(41,81,19)//allied shinobi side

				for(var/obj/zettsuspawn/A in world)
					if(A:filled==0)
						var/mob/White_Zettsu/B=new/mob/White_Zettsu
						B.loc=A:loc
						A:filled=1
				//var/M=new/mob/White_Zettsu()
				/*for(var/l=1,l<15,l++)
					M:loc=locate(3,3,3)//zettsu spawning point
					step_rand(M)*/
				chuuninlock=1
				wartype="AKATSUKI WAR"
			Close_Great_Ninja_War_Event()
				set category = "Administrator"
				lock=1
				chuuninlock=0
				world<<"[src] closes down Great Ninja War event, all of those who joined it will be teleported back to their own villages."
				world<<"Last results are : Sand Village:[sandwarpoints],Mist Village:[mistwarpoints],Sound Village:[soundwarpoints],Leaf Village:[leafwarpoints],Rock Village:[rockwarpoints],Missing Ninjas:[missingwarpoints],Akatsuki:[akatwarpoints]!!!."
				CheckWarWinner()
				for(var/mob/M in world)
					if(M.village=="Hidden Sound"&&M.joinedwar==1)
						M.loc = locate(157,28,6)
					if(M.village=="Hidden Leaf"&&M.joinedwar==1)
						M.loc = locate(116,127,1)
					if(M.village=="Hidden Sand"&&M.joinedwar==1)
						M.loc = locate(91,132,10)
					if(M.village=="Hidden Mist"&&M.joinedwar==1)
						M.loc = locate(130,87,8)
					if(M.village=="Hidden Rock"&&M.joinedwar==1)
						M.loc = locate(126,35,15)
					if(M.village=="Akatsuki"&&M.joinedwar==1)
						M.loc = locate(100,101,17)

					M.joinedwar=0
					sandwarpoints=0
					mistwarpoints=0
					leafwarpoints=0
					soundwarpoints=0
					rockwarpoints=0
					missingwarpoints=0
					akatwarpoints=0
				chuuninlock=0
				wartype=null
			Close_Allied_Shinobi_War()
				set category = "Administrator"
				chuuninlock=0
				wartype=null
				for(var/mob/M in world)
					if(M.joinedakatshinobiw==1)
						M.joinedakatshinobiw=0
						if(M.village=="Akatsuki")
							M.loc=locate(100,101,17)//akathideout
						if(M.village=="Hidden Sound")
							M.loc = locate(157,28,6)
						if(M.village=="Hidden Leaf")
							M.loc = locate(116,127,1)
						if(M.village=="Hidden Sand")
							M.loc = locate(91,132,10)
						if(M.village=="Hidden Mist")
							M.loc = locate(91,132,10)
						if(M.village=="Hidden Rock")
							M.loc = locate(126,35,15)
				if(akatpoints>sforcepoints)
					world<<"<font color=red><font size=3>Akatsuki are victorious! Each of them gets 10 additional PvP points!"
				if(akatpoints<sforcepoints)
					world<<"<font color=red><font size=3>Allied Shinobi Force is victorious! Each of them gets 10 additional PvP points!"
				for(var/obj/zettsuspawn/A in world)
					if(A:filled==1)
						var/mob/White_Zettsu/B
						if(B in A:loc)
							del(B)
							A:filled=0

	verb
		JoinWar()
			set hidden = 1
			if(usr.level<=5)
				usr<<"You are too low level to participate!"
				return
			if(wartype=="AKATSUKI WAR")
				goto akatwar
			if(wartype=="NINJA WAR")
				goto ninjawar
			if(wartype==null)
				usr<<"No war in progress... try again later."
				return
			ninjawar
			if(lock==0&&usr.joinedwar==0)
				if(!key) return
				if(!usr.village=="Hidden Sound"&&!usr.village=="Hidden Leaf"&&!usr.village=="Hidden Sand"&&!usr.village=="Hidden Mist"&&!usr.village=="Hidden Rock")
					src<<"You don't have a village...you can't join war."
					return
				usr.loc = pick(block(locate(71,95,4),locate(200,163,4)))
				world<<"[usr] joined war to fight for [village] side!"
				usr.joinedwar=1
			if(lock==1)
				usr<<"Great Ninja War hasn't started yet..."
			if(lock==0&&usr.joinedwar==1)
				usr<<"You already joined war!"
			if(lock==1&&usr.joinedwar==1)
				usr<<"Use '/stuck' to teleport out of Great Ninja War Event if you are stuck in it..."
			return
			akatwar
			if(usr.joinedakatshinobiw==1)
				usr<<"You already joined this war!"
			else
				if(usr.level<30)
					var/sure=CustomInput("Great War","Are you sure you want to join Akatsuki vs Shinobi Force War?",list("Yes","No"))
					if(sure=="Yes")
						usr.joinedakatshinobiw=1
						if(usr.village=="Akatsuki")
							world<<"[usr] joined to fight for [usr.village] in war against Allied Shinobi Force !!!"
							usr.loc=locate(92,2,19)//akatsuki side
						else
							world<<"[usr] joined to fight for [usr.village] in war against Akatsuki !!!"
							usr.loc=locate(41,81,19)//allied shinobi side
var
	sandwarpoints=0
	mistwarpoints=0
	leafwarpoints=0
	soundwarpoints=0
	missingwarpoints=0
	akatwarpoints=0
	rockwarpoints=0
proc
	CheckWarWinner()
		if(sandwarpoints>mistwarpoints&&sandwarpoints>leafwarpoints&&sandwarpoints>soundwarpoints&&sandwarpoints>missingwarpoints&&sandwarpoints>akatwarpoints&&sandwarpoints>rockwarpoints)
			world<<"<font size=4>Winner of this war is Sand Village !!!"
			return
		if(mistwarpoints>sandwarpoints&&mistwarpoints>leafwarpoints&&mistwarpoints>soundwarpoints&&mistwarpoints>missingwarpoints&&mistwarpoints>akatwarpoints&&mistwarpoints>rockwarpoints)
			world<<"<font size=4>Winner of this war is Mist Village !!!"
			return
		if(leafwarpoints>mistwarpoints&&leafwarpoints>sandwarpoints&&leafwarpoints>soundwarpoints&&leafwarpoints>missingwarpoints&&leafwarpoints>akatwarpoints&&leafwarpoints>rockwarpoints)
			world<<"<font size=4>Winner of this war is Leaf Village !!!"
			return
		if(soundwarpoints>mistwarpoints&&soundwarpoints>leafwarpoints&&soundwarpoints>sandwarpoints&&soundwarpoints>missingwarpoints&&soundwarpoints>akatwarpoints&&soundwarpoints>rockwarpoints)
			world<<"<font size=4>Winner of this war is Sound Village !!!"
			return
		if(missingwarpoints>mistwarpoints&&missingwarpoints>leafwarpoints&&missingwarpoints>sandwarpoints&&missingwarpoints>akatwarpoints&&missingwarpoints>rockwarpoints&&missingwarpoints>soundwarpoints)
			world<<"<font size=4>Winner of this war is Missing Ninjas !!!"
			return
		if(akatwarpoints>mistwarpoints&&akatwarpoints>leafwarpoints&&akatwarpoints>sandwarpoints&&akatwarpoints>rockwarpoints&&akatwarpoints>soundwarpoints&&akatwarpoints>missingwarpoints)
			world<<"<font size=4>Winner of this war is Akatsuki !!!"
			return
		if(rockwarpoints>mistwarpoints&&rockwarpoints>leafwarpoints&&rockwarpoints>sandwarpoints&&rockwarpoints>akatwarpoints&&rockwarpoints>soundwarpoints&&rockwarpoints>missingwarpoints)
			world<<"<font size=4>Winner of this war is Rock Village !!!"
			return

		else
			world<<"No war winner."
mob
	var
		numberwtf=1
	proc
		inputafkcheck(var/N)
			set hidden = 1
			var/checkafk=input("This is an AFK Check. Input the number you see in Chat!") as num
			spawn(100)
				if(checkafk==N)
					src<<"Grats, you've safely passed this AFK Check !"
				//	src.numberwtf=1
					return
				else
					usr<<"<font color = red> YOU ARE BEING BOOTED DUE TO BEING AFK!"
					world<<"[usr] was booted due to being AFK."
					del(usr)