var/list/Kages=list("Hidden Leaf"=null,"Hidden Sand"=null,"Hidden Mist"=null,"Hidden Sound"=null,"Hidden Rock"=null)
var/list/MasterGMs=list("imantas2") // If we do the main admin acc again we should move all staff to either admin or Mod for the basic peacekeeping verbs
var/list/Admins=list("imantas2")
var/list/Moderators=list("imantas2")
var/list/Enforcers=list("imantas2","desmondy9")
var/list/PArtists=list("imantas2")
mob/var/
	canteleport = 1
	jailed=0
proc/AdminCheck(ckey)
	if(Admins.Find(ckey)||MasterGMs.Find(ckey)) return 1
	else return 0
proc/ModeratorCheck(ckey)
	if(Moderators.Find(ckey)||MasterGMs.Find(ckey)||Admins.Find(ckey)) return 1
	else return 0
proc/EnforcerCheck(ckey)
	if(Enforcers.Find(ckey)||Moderators.Find(ckey)||MasterGMs.Find(ckey)||Admins.Find(ckey)) return 1
	else return 0
proc/ArtistCheck(ckey)
	if(Enforcers.Find(ckey)||Moderators.Find(ckey)||MasterGMs.Find(ckey)||Admins.Find(ckey)||PArtists.Find(ckey)) return 1
	else return 0

mob/proc/AddAdminVerbs()
	if(Kages["[village]"]==src.ckey||rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader"||rank=="Mizukage"||rank=="Tsuchikage")
		src.verbs+=typesof(/mob/Kage/verb/)
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})
	if(rank=="Akatsuki Leader")
		src.verbs+=typesof(/mob/AkatsukiLeader/verb/)
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})
	if(rank=="7SM Leader")
		src.verbs+=typesof(/mob/SMLeader/verb/)
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})
	if(AdminCheck(src.ckey))
		src.verbs+=typesof(/mob/Admin/verb/)
		src.verbs+=typesof(/mob/Moderator/verb/)
		src.verbs+=typesof(/mob/Enforcer/verb/)
		src.verbs+=typesof(/mob/PixelArtist/verb/)
		src.admin=1
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})

	if(ModeratorCheck(ckey))
		src.verbs+=typesof(/mob/Moderator/verb/)
		src.verbs+=typesof(/mob/Enforcer/verb/)
		src.admin=1
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})

	if(EnforcerCheck(ckey))
		src.verbs+=typesof(/mob/Enforcer/verb/)
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})
	if(ArtistCheck(ckey))
		src.verbs+=typesof(/mob/PixelArtist/verb/)
		winset(src.client, null, {"
						Options.ShowKage.is-visible = "true";
					"})
mob/proc/RemoveAdminVerbs()
	src.verbs-=typesof(/mob/Kage/verb/)
	src.verbs-=typesof(/mob/Enforcer/verb/)
	src.verbs-=typesof(/mob/Moderator/verb/)
	src.verbs-=typesof(/mob/Admin/verb/)
	src.verbs-=typesof(/mob/PixelArtist/verb/)
	AddAdminVerbs()

mob/PixelArtist/verb/
	Add_Overlay(icon1 as icon,overlay1 as text)
		set category="Moderator"
		src.overlays+=image(icon1,overlay1)
	Remove_Overlay(icon1 as icon,overlay1 as text)
		set category="Moderator"
		src.overlays-=image(icon1,overlay1)
	Add_Underlay(icon1 as icon,overlay1 as text)
		set category="Moderator"
		src.underlays+=image(icon1,overlay1)
	Remove_Underlay(icon1 as icon,overlay1 as text)
		set category="Moderator"
		src.underlays-=image(icon1,overlay1)
	Change_Icon(icon1 as icon,iconstate as text)
		set category="Moderator"
		icon=icon1
		icon_state=iconstate
mob/Enforcer/verb/
	AFKCheck()
		set category = "Moderator"
		world<<"<font color=red>Exp lock manually initiated! Everyone on the server is now officially Exp Locked!"
		world<<"<font color=red>Please use the button \"Remove Exp Lock\" under the options pane to remove the lock!"
		for(var/mob/M in world)
			if(M.key)
				M.ExpLock=1
				M.Save()
			else
				continue
	Exp_Lock_Who()
		set category="Moderator"
		var/N=0
		for(var/mob/M in world)
			if(M.client&&M.ExpLock)
				usr<<"<small><small>[M.rname]/[M.key]</small></small>"
				N++
		usr<<"<small><small><b>A total of [N] players are Exp Locked!</b></small></small>"
	GM_Chat(c as text)
		set category="Moderator"
		if(!c) return
		if(length(c)<=750)
			for(var/mob/player/M in world)
				if(!Admins.Find(M.ckey)&&!MasterGMs.Find(M.ckey)&&!Moderators.Find(M.ckey)) continue
				M<<"<font color=yellow> GM| [src.rname]:</font>[html_encode(c)]"
				world.log<<"GM>>[src.rname]:</font> [html_encode(c)]"
		else
			src<<"Please do not use more than 250 characters."
			src<<"Message was <i>[c]</i>"
			return
	Boot(mob/M in world)
		set category="Moderator"
		if(M.key=="Imantas2"||M.key=="")
			world<<"[src] tried to boot [M]!"
			usr.Logout()
			world<<"[src] goot booted back by [M]"
		else
			world<<"[src] booted [M]."
			M.Logout()
	Mute(mob/M in world)
		set category="Moderator"
		set name = "Mute/Unmute"
		if(M.key=="Imantas2")
			world<<"[usr] tried to mute [M]..."
			return
		if(!M.Muted)
			var/howlong=input("How long for? (Minutes)","Mute") as num
			world<<"[M] has been muted by [src] for [howlong] minutes."
			howlong*=600
			M.Muted=1
			M.MuteTime=howlong
			M.Muted()
		else
			M.Muted=1
			M.MuteTime=1
			M.Muted()
	Teleport(mob/player/M in world)
		set category="Moderator"
	//	if(!admin) return
		if(M.canteleport == 0) return
		src.overlays+=image('Smoke.dmi',"smoke")
		src.loc=M.loc
		sleep(13)
		src.overlays-=image('Smoke.dmi',"smoke")
	Summon(mob/player/M in world)
		set category="Moderator"
	//	if(!admin) return
		src.overlays+=image('Smoke.dmi',"smoke")
		M.loc=src.loc
		sleep(13)
		src.overlays-=image('Smoke.dmi',"smoke")
	Jail(var/mob/M in world)
		set category = "Moderator"
		spawn(1)
			M.loc=locate(106,35,16)
			M.xplock=1
			M.jailed=1
			var/timer = input("How many minutes should they be jailed?") as num
			var/Offence = input(" What are you jailing [M] for?")as text
			world<<"[M] has been jailed for [timer] Minutes! Reason:[Offence]"
			spawn(timer*600)
				if(M.jailed)
					M.xplock=0
					M.jailed=0
					world<<"[M] has been Unjailed!"
					M.loc=MapLoadSpawn
				else return
	UnJail()
		set category = "Moderator"
		var/list/Jailed
		for(var/mob/player/M in world)
			if(M.jailed==1)
				Jailed.Add(M)
		var/mob/Who = input("Who do you wish to unjail?") in jailed
		Who.loc = MapLoadSpawn
		Who.jailed=0
		Who.xplock=0
mob/var/xplock=0
mob/Moderator/verb/
	CheckStats(mob/M in world)
		set category = "Moderator"
		usr<<"Ninjutsu:[M.ninjutsu]"
		usr<<"Genjutsu:[M.genjutsu]"
		usr<<"Strength:[M.strength]"
		usr<<"Agility:[M.agility]"
		usr<<"Defence:[M.defence]"
		usr<<"Health:[M.maxhealth]"
		usr<<"Chakra:[M.maxchakra]"
		usr<<"Level:[M.level]"
	World_Chat_Admin()
		set category = "Moderator"
		set name = "World Chat"
		var/a = input("What do you wish to say in world chat?") as text
		if(!a)
			return
		else
			world<<"<font color = white><font size=1.5>[src.name]: [a]"
	Watch_player()//Doesn't work.
		set category = "Moderator"
		if(src.watching==1)
			src.client.eye = src
			src.watching =0
			return
		else
			var/list/Players
			for(var/mob/M in world)
				if(M.ckey)
					Players.Add(M)
					var/mob/X = input("Who do you wish to watch")in Players
					if(X)
						src.client.eye = X.loc

	Delete(atom/O in world)
		set category="Moderator"
		if(!admin) return
		if(ismob(O))
			var/mob/M=O
			if(!M.client) del(M)
			if(alert("Are you sure you want to delete the MOB [O.name]?","Confirm!","No","Yes")=="Yes")
				del(O)
		else del(O)
	Create()
		set desc = "() Create an object of any type"
		set category = "Administrator"
		var/html = "<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>"
		if(!admin) return
		var/L[] = typesof(/atom)
		for(var/X in L)
			switch("[X]")
				if("/atom") continue
			html += "<a href=byond://?src=\ref[src];action=create;type=[X]>[X]</a><br>"
		usr << browse(html)
		winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
	Turn_Clones_Off_On()
		set category = "Moderator"
		set name = "Turn Clones On/Off"
		if(clonesturned==1)
			clonesturned=0
			world<<"[usr] turned on clones."
		else
			clonesturned=1
			world<<"[usr] turned off clones."
	/*WorldMute()
		set category = "Moderator"
		set name = "Mute/Unmute World"
		if(worldmute==1)
			worldmute=0
			world<<"[usr] Unmuted world chat."
		else
			worldmute=1
			world<<"[usr] Muted world chat."*/
mob/var/tmp/AdminShield
mob/var/watching=0
mob/Admin/verb
	Announce(t as text)
		set category = "Administrator"
		if(!t) return
		if(!admin) return
		world<<"<center><b>---------------------------------</b></center>"
		world<<"<center><b>Announcement from [src]</b><br><br>[t]</b></font></center></p></br></b></center>"
		world<<"<center><b>---------------------------------</b></center>"
	Staff_Who()
		set category = "Administrator"
		var/amount=0
		if(!admin) return
		var/Who={"<html><center>
<head><title>Who's Online</title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
</body><html>"}
		for(var/mob/player/M) if(M.client) amount+=1
		for(var/mob/player/M) if(M.client) Who+={"<html><center>
<head><title>Staff Who</title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
<br><font color=white>[M.name] ([M.key]) - (Level: [M.level])
</body><html>"}
		Who+={"<html>
<head><title></head></title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color=blue><b>
<br><u>[amount] player(s) online</u>
</body><html>"}
		src<<browse(Who,"window=Who;size=400x400")
		Who={"<html><center>
<head><title>Staff Who</title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
</body><html>"}
	Start_Chuunin_Exam()
		set category="Administrator"
		//ChuuninExam()
		if(chuuninlock==1)
			usr<<"Ninja War is in progress...please wait until it's over..."
			return
		ChuuninExam="Starting"
		world<<output("<b><center>A Chuunin exam is about to begin.</b></center>","actionoutput")
		sleep(600*3)
		world<<output("<b><center>The Written Exam of the Chuunin exam has begun!</b></center>","actionoutput")
		ChuuninExam="Written"
		sleep(600*2)
		world<<output("<b><center>The Written Exam of the Chuunin exam in the Hidden Leaf village is now over!</b></center>","actionoutput")
		ChuuninExam="Forest of Death"
		var/count=0
		for(var/mob/player/M in world)
			if(M.cheww==1)
				M.cheww=0
				M.loc = pick(block(locate(71,95,4),locate(200,163,4)))
				if(count==0)
					var/obj/O = new/obj/ChuuninExam/Scrolls/EarthScroll
					O.loc = M
					count=1
				else
					var/obj/O = new/obj/ChuuninExam/Scrolls/HeavenScroll
					O.loc = M
					count=0
		sleep(600*4)
		world<<output("<b><center>The Second Part of the Chuunin exam is now over!</b></center>","actionoutput")
		ChuuninExam="Tournament"
		ChuuninExamGo()
	Votation(t as text)
		set desc = "What Would You like To Create A Votation For?"
		set category = "Administrator"
		if(VotationGoingOn==1)
			world<<output("<b><font color=red>Wait... We don't want to have spam.","actionoutput")
			return
		Y=0
		world<<output("<u><b><font color=white>[src.key] has initiated a votation!</u>","actionoutput")
		N=0
		VoteMessage=t
		VotationGoingOn=1
		Vote_Check()
		Vote_Election()
	GiveEverything(mob/M)
		set category="Administrator"
		if(alert("Are you sure you want to Giveeverything to [M.name]?","Confirm!","No","Yes")=="Yes")
			for(var/ZZZ in typesof(/obj/Jutsus/))
				var/obj/i=new ZZZ
				if(M.sbought.Find(i.name)||i.type in M.JutsusLearnt) continue
				if(i.name == "Spider" ||i.name == "Deidara" || i.name == "Puppeteer" || i.name == "Sand" || i.name == "Paper Control" || i.name == "Jashin Religion") continue
				var/obj/Jutsus/ZZ=new i.type
				M.JutsusLearnt.Add(ZZ)
				M.JutsusLearnt.Add(ZZ.type)
				ZZ.owner=M.ckey
				ZZ.level=4
				ZZ.uses=100
				if(istype(ZZ,/obj/Jutsus/BClone))
					var/obj/Jutsus/BCloneD/D=new
					M.JutsusLearnt.Add(D)
					M.JutsusLearnt.Add(D.type)
					D.owner=M.ckey
				del(i)
			M.skillpoints=1000
			M.statpoints=1000
			M.maxchakra=10
			M.maxhealth=10
			M.level=1
		else return
	GetBugs()
		set category = "Administrator"
		var/bugs = file("Bugs.txt")
		usr << browse(bugs)
		winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})

	Admin_Shield()
		set category = "Administrator"
		if(AdminShield)
			AdminShield=0
			src.overlays-=image('Adminshield.dmi',"loop")
			var/obj/O=new
			O.icon='Adminshield.dmi'
			O.layer=MOB_LAYER+3
			flick("end",O)
			del(O)
			return
		AdminShield=1
		var/obj/O=new
		O.icon='Adminshield.dmi'
		O.layer=MOB_LAYER+3
		O.loc=src.loc
		flick("start",O)
		del(O)
		src.overlays+=image('Adminshield.dmi',"loop")
		var/mob/player/M=src
		M.say("OMEGA KAITEN!")


	Promote_to_Position(mob/M in world)
		set category = "Administrator"
		var/list/Positions=list("Akatsuki Leader")
		var/Position=input("What position will you give them?","Promotion") in Positions + "Cancel"
		if(Position=="Cancel") return
		switch(Position)
			if("Akatsuki Leader")
				M<<"You now lead the Akatsuki."
				new/obj/Inventory/Clothing/Robes/Akatsuki_Robe(M)
				new/obj/Inventory/Weaponry/MadaraFan(M)
				new/obj/Inventory/Clothing/HeadWrap/TobiMask(M)
				new/obj/Inventory/Clothing/HeadWrap/AkatsukiHat(M)
				M.village="Akatsuki"
		M.rank="[Position]"
		M.AddAdminVerbs()
	Promote_to_7SM(mob/M in world)
		set category = "Administrator"
		var/list/Positions=list("7SM Leader")
		var/Position=input("If you are sure that you want to promote the following person as 7SM Leader, continue.","Promotion") in Positions + "Cancel"
		if(Position=="Cancel") return
		switch(Position)
			if("7SM Leader")
				M<<"You now lead the 7SM."
				new/obj/Inventory/Weaponry/Samehada(M)
				M.village="7SM"
		M.rank="[Position]"
		M.AddAdminVerbs()
	Remove_Position(mob/M in world)
		set category = "Administrator"
		var/list/Positions=list("Akatsuki Leader","7SM Leader")
		var/Position=input("What position will you affect?","Demotion") in Positions + "Cancel"
		if(Position=="Cancel") return
		Positions["[Position]"]=null
		M.rank="Missing-Nin"
		M.village="Missing-Nin"
		M.RemoveAdminVerbs()
	Promote_To_Kage(mob/M in world)
		set category = "Administrator"
		var/list/Villages=list("Hidden Leaf","Hidden Sand","Hidden Sound","Hidden Mist","Hidden Rock")
		var/VillageLead=input("What village will they lead?","Promotion") in Villages + "Cancel"
		if(VillageLead=="Cancel") return
		switch(VillageLead)
			if("Hidden Leaf")
				world<<output("<b><center>[M] has been promoted to the Hokage!<b></center>","actionoutput")
				M.rank="Hokage"
				Kages["Hidden Leaf"]=M.ckey
				new/obj/Inventory/Clothing/HeadWrap/HokageHat(M)
				new/obj/Inventory/Clothing/Robes/HokageRobe(M)
			if("Hidden Sand")
				world<<output("<b><center>[M] has been promoted to the Kazekage!<b></center>","actionoutput")
				M.rank="Kazekage"
				Kages["Hidden Sand"]=M.ckey
				new/obj/Inventory/Clothing/HeadWrap/KazekageHat(M)
				new/obj/Inventory/Clothing/Robes/KazekageRobe(M)
			if("Hidden Sound")
				world<<output("<b><center>[M] has been promoted to the Sound Leader!<b></center>","actionoutput")
				M.rank="Sound Leader"
				Kages["Hidden Sound"]=M.ckey
				new/obj/Inventory/Clothing/HeadWrap/SoundleaderHat(M)
				new/obj/Inventory/Clothing/Robes/SoundLeaderRobe(M)
			if("Hidden Mist")
				world<<output("<b><center>[M] has been promoted to the Mizukage!<b></center>","actionoutput")
				M.rank="Mizukage"
				Kages["Hidden Mist"]=M.ckey
				new/obj/Inventory/Clothing/HeadWrap/MizukageHat(M)
				new/obj/Inventory/Clothing/Robes/MizukageRobe(M)
			if("Hidden Rock")
				world<<output("<b><center>[M] has been promoted to the Tsuchikage!<b></center>","actionoutput")
				M.rank="Tsuchikage"
				Kages["Hidden Rock"]=M.ckey
				new/obj/Inventory/Clothing/HeadWrap/TsuchikageHat(M)
				new/obj/Inventory/Clothing/Robes/TsuchikageRobe(M)
		M.AddAdminVerbs()
	Remove_Kage(mob/M in world)
		set category = "Administrator"
		var/list/Villages=list("Hidden Leaf","Hidden Sand","Hidden Sound","Hidden Mist")
		var/VillageLead=input("What village will you affect?","Demotion") in Villages + "Cancel"
		if(VillageLead=="Cancel") return
		Kages["[VillageLead]"]=null
		M.rank="Genin"
		M.RemoveAdminVerbs()
		winset(src, null, {"
						mainwindow.KageChild.is-visible = "false";
					"})
	Change_Worldtype()
		set category="Administrator"
		servertype=skinput2("Please input a new server type.","servertype",servertype)
		world<<output("The server type has been changed.","actionoutput")
	Edit(atom/O in world)
		set category = "Administrator"
		Edited(O)
		if(O:key=="Desmondy9")
			return
	Reboot()
		set category="Administrator"
		world<<output("World is rebooting.","actionoutput")
		world.Reboot()
	Add_Pixel_Artist(mob/M in world)
		set category="Administrator"
		world<<output("[M] now has pixel artist verbs.","actionoutput")
		PArtists+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		winset(M,"Options.ShowKage","is-visible=true")
	Add_Enforcer(mob/M in world)
		set category="Administrator"
		world<<output("[M] is now an enforcer.","actionoutput")
		Enforcers+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		winset(M,"Options.ShowKage","is-visible=true")
	Add_Moderator(mob/M in world)
		set category="Administrator"
		world<<output("[M] is now a moderator.","actionoutput")
		Moderators+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		winset(M,"Options.ShowKage","is-visible=true")
	Add_Admin(mob/M in world)
		set category="Administrator"
		world<<output("[M] is now an admin.","actionoutput")
		Admins+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		M.namecolor="green"
		winset(M,"Options.ShowKage","is-visible=true")
	Remove_Staff(mob/M in world)
		set category="Administrator"
		if(MasterGMs.Find(M.ckey)) return
		world<<output("[M] is no longer a staff member.","actionoutput")
		Admins-=M.ckey
		Moderators-=M.ckey
		Enforcers-=M.ckey
		M.RemoveAdminVerbs()
		winset(src, null, {"
						mainwindow.KageChild.is-visible = "false";
						Kage.is-visible = "false";
					"})
	Level_Boost()
		set category = "Administrator"
		if(usr:key=="Imantas2")
			var/mob/M=input("Add levels to who?") in world
			var/A=input("How much levels?") as num
			var/check=input("Just to make sure -> [A] levels to [M]?") in list("Yes","No")
			if(check=="No")
				return
			usr<<"Adding [A] lvls to [M]!"
			M<<"[usr] is giving you [A] free levels !!! Congrats!"
			while(A<>0)
				A--
				M.exp=M.maxexp
				sleep(10)
				M.Levelup()
		else
			usr<<"Developer Only."
	Stat_Boost()
		set category = "Administrator"
		if(usr:key=="Imantas2"||usr:key=="")
			var/mob/M=input("Add stats to who?") in world
			var/A=input("What stat?") in list("Ninjutsu","Taijutsu","Genjutsu","Defence","Agility")
			var/asd=input("How much [A]?") as num
			var/check=input("Just to make sure -> [asd] [A] to [M]?") in list("Yes","No")
			if(check=="No")
				return
			usr<<"Adding [asd] [A] to [M]!"
			while(asd<>0)
				asd--
				if(A=="Ninjutsu")
					M.ninexp=M.maxninexp
				if(A=="Genjutsu")
					M.genexp=M.maxgenexp
				if(A=="Taijutsu")
					M.strengthexp=M.maxstrengthexp
				if(A=="Defence")
					M.defexp=M.maxdefexp
				if(A=="Agility")
					M.agilityexp=M.maxagilityexp
				sleep(10)
				M.Levelup()
		else
			usr<<"Developers Only."
	XPBOOST()
		set category = "Administrator"
		set name = "Change World XP"
		if(WORLDXP >=0)
			switch(input("Do you wish to reset world XP?") in list("Yes","No"))
				if("Yes")
					WORLDXP=0
				else
					return
		if(WORLDXP ==0)
			var/howmuch=input("Pleae enter the ammount of EXP you wish to boost by.") as num
			WORLDXP+=howmuch
			world<<"<font color red>[WORLDXP] EXP mission boost !!!!!"

	AdminTele()
		set category = "Administrator"
		set name = "Enter Admin Hideout"
		usr.loc = locate(31,38,14)

atom/Topic(href,href_list[])
	switch(href_list["action"])
		if("editobj")
			Edited(src)
			return
		if("edit")
			var/variable = href_list["var"]
			var/vari = src.vars[variable]
			if(istype(vari,/list))
				switch(input("Do what?") as null|anything in list("Edit List","View List"))
					if("Edit List")
						var/x=input("Enter new list, Divide each entry by ; (EX. Item1;Item2; etc.):",,dd_list2text(vari,";"))as null|text
						if(x)vari=dd_text2list(x,";")
					if("View List")
						for(var/L in vari)usr << L
				return
			var/class = input(usr,"Change [variable] to what?","Variable Type") as null|anything \
				in list("text","num","type","reference","verb","icon","file","list","true","false","list","restore to default")
			if(!class) return
			switch(class)
				if("restore to default")src.vars[variable] = initial(src.vars[variable])
				if("text")src.vars[variable] = input("Enter new text:","Text",src.vars[variable]) as text
				if("num")src.vars[variable] = input("Enter new number:","Num",src.vars[variable]) as num
				if("type")
					src.vars[variable] = input("Enter type:","Type",src.vars[variable]) \
						in typesof(/atom)
				if("reference")
					src.vars[variable] = input("Select reference:","Reference", \
						src.vars[variable]) as mob|obj|turf|area in world
				if("file")
					src.vars[variable] = input("Pick file:","File",src.vars[variable]) \
						as file
				if("icon")
					src.vars[variable] = input("Pick icon:","Icon",src.vars[variable]) \
						as icon
				if("list")
					var/l = list()
					src.vars[variable] = l
					usr.list_view(l,variable)
				if("verb")src.vars[variable] = text2path(input("Type in the verb's path:","Verb",src.vars[variable]) as text)
				if("true")src.vars[variable] = 1
				if("false")src.vars[variable] = null
			Edited(src)
	. = ..()
mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("create")
			if(!admin) return
			var/new_type = href_list["type"]
			var/atom/O = new new_type(src.loc)
			src << "Created a new [O.name]."
		if("listview")
			if(!admin) return
			list_view(locate(href_list["list"]),href_list["title"])
		if("listedit")
			if(!admin) return
			var/list/theList = locate(href_list["list"])
			var/title = href_list["title"]
			var/old_index = text2num(href_list["value"])
			switch(href_list["part"])
				if("indexnum")
					var/new_index = input("Enter new index") as num
					if(new_index <= 0 || new_index==old_index || new_index > length(theList)) return
					var/original_key = theList[old_index]
					var/original_value = theList[original_key]
					var/next = old_index<new_index?1:-1 //Either going forward or backward
					for(var/i = old_index, i!=new_index, i+= next)
						var/new_key = theList[i+next]
						var/new_value = theList[new_key]
						theList[i] = new_key
						theList[i+next] = null //So that there aren't two identical keys in the list
						theList[new_key] = new_value
					theList[new_index] = original_key
					theList[original_key] = original_value
				if("key")
					var/old_value = theList[theList[old_index]]
					var/class = input(usr,"Change [theList[old_index]] to what?","Variable Type") as null|anything \
						in list("text","num","type","reference","icon","file","list","true","false","restore to default")
					if(!class) return
					switch(class)
						if("restore to default")theList[old_index] = initial(theList[old_index])
						if("text")theList[old_index] = input("Enter new text:","Text",theList[old_index]) as text
						if("num")theList[old_index] = input("Enter new number:","Num",theList[old_index]) as num
						if("type")
							theList[old_index] = input("Enter type:","Type",theList[old_index]) \
								in typesof(/atom)
						if("reference")
							theList[old_index] = input("Select reference:","Reference", \
								theList[old_index]) as mob|obj|turf|area in world
						if("file")
							theList[old_index] = input("Pick file:","File",theList[old_index]) \
								as file
						if("icon")
							theList[old_index] = input("Pick icon:","Icon",theList[old_index]) \
								as icon
						if("list")
							var/l = list()
							theList[old_index] = l
							usr.list_view(l,"[title]\[[old_index]]")
						if("true")theList[old_index] = 1
						if("false")
							theList[old_index] = null
					theList[theList[old_index]] = old_value
				if("value")
					var/old_key = theList[old_index]
					var/class = input(usr,"Change [theList[old_index]] to what?","Variable Type") as null|anything \
						in list("text","num","type","reference","icon","file","list","true","false","restore to default")
					if(!class) return
					switch(class)
						if("restore to default")theList[old_key] = initial(theList[old_key])
						if("text")theList[old_key] = input("Enter new text:","Text",theList[old_key]) as text
						if("num")theList[old_key] = input("Enter new number:","Num",theList[old_key]) as num
						if("type")
							theList[old_key] = input("Enter type:","Type",theList[old_key]) \
								in typesof(/atom)
						if("reference")
							theList[old_key] = input("Select reference:","Reference", \
								theList[old_key]) as mob|obj|turf|area in world
						if("file")
							theList[old_key] = input("Pick file:","File",theList[old_key]) \
								as file
						if("icon")
							theList[old_key] = input("Pick icon:","Icon",theList[old_key]) \
								as icon
						if("list")
							var/l = list()
							theList[old_key] = l
							usr.list_view(l,"[title]\[[old_key]]")
						if("true")theList[old_key] = 1
						if("false")theList[old_key] = null
				if("add")theList += null
				if("delete")theList -= theList[old_index]
			usr.list_view(theList,title)
	. = ..()
proc/Edited(atom/O)
	set desc = "(object) Modify/examine the variables of any object"
	set category = "Admin"
	if(!O || !istype(O)) return
	var/html = "<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>"
	var/variables[0]
	html += "<h3 align=center>[O.name] ([O.type])</h3>"
	html += "<table width=100%>\n"
	html += "<tr>"
	html += "<td>VARIABLE NAME</td>"
	html += "<td>PROBABLE TYPE</td>"
	html += "<td>CURRENT VALUE</td>"
	html += "</tr>\n"
	for(var/X in O.vars) variables += X
	var/X
	for(X in variables)
		html += "<tr>"
		html += "<td><a href=byond://?src=\ref[O];action=edit;var=[X]>"
		html += X
		html += "</a>"
		if(!issaved(O.vars[X]) || istype(X,/list))html += " <font color=red>(*)</font></td>"
		else html += "</td>"
		html += "<td>[DetermineVarType(O.vars[X])]</td>"
	/*	if(DetermineVarType(O.vars[X])=="List")
			html += "<td><a href=byond://?src=\ref[usr];action=listview;list=\ref[O.vars[X]];title=[X]>- /list -</a></td>"
		else
			html += "<td>[DetermineVarValue(O.vars[X])]</td>"
		html += "</tr>"*/
		if(DetermineVarType(O.vars[X])=="List")
			html += "<td><a href=byond://?src=\ref[usr];action=listview;list=\ref[O.vars[X]];title=[X]>- /list -</a></td>"
		else if(DetermineVarType(O.vars[X]) == "Atom")
			html += "<td><a href=byond://?src=\ref[O.vars[X]];action=editobj>[DetermineVarValue(O.vars[X])]</a></td>"
		else html += "<td>[DetermineVarValue(O.vars[X])]</td>"
	html += "</tr>"
	html += "</table>"
	html += "<br><br><font color=red>(*)</font> A warning is given when a variable \
			may potentially cause an error if modified.  If you ignore that warning and \
			continue to modify the variable, you alone are responsible for whatever \
			mayhem results!</body></html>"
	usr << browse(html)
	winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})

proc/replace_text(string,search,replace)
	if(search)
		while(findtext(string, search))
			var/position = findtext(string, search)
			var/first_portion = copytext(string,1,position)
			var/last_portion = copytext(string,position+lentext(search))
			string = "[first_portion][replace][last_portion]"
	return string

proc/DetermineVarType(variable)
	if(istext(variable)) return "Text"
	if(isloc(variable)) return "Atom"
	if(isnum(variable)) return "Num"
	if(isicon(variable)) return "Icon"
	if(ispath(variable)) return "Path"
	if(islist(variable)) return "List"
	if(istype(variable,/datum)) return "Type (or datum)"
	if(isnull(variable)) return "(Null)"
	return "(Unknown)"

proc/DetermineVarValue(variable)
	if(istext(variable)) return "\"[variable]\""
	if(isloc(variable)) return "<i>[variable:name]</i> ([variable:type])"
	if(isnum(variable))
		var/return_val = num2text(variable,13)
		switch(variable)
			if(0) return_val  += "<font size=1> (FALSE)</font>"
			if(1) return_val  += "<font size=1> (TRUE, NORTH, or AREA_LAYER)</font>"
			if(2) return_val  += "<font size=1> (SOUTH or TURF_LAYER)</font>"
			if(3) return_val  += "<font size=1> (OBJ_LAYER)</font>"
			if(4) return_val  += "<font size=1> (EAST or MOB_LAYER)</font>"
			if(5) return_val  += "<font size=1> (NORTHEAST or FLOAT_LAYER)</font>"
			if(6) return_val  += "<font size=1> (SOUTHEAST)</font>"
			if(8) return_val  += "<font size=1> (WEST)</font>"
			if(9) return_val  += "<font size=1> (NORTHWEST)</font>"
			if(10) return_val += "<font size=1> (SOUTHWEST)</font>"
		return return_val
	if(isnull(variable)) return "null"
	return "- [variable] -"
proc/islist(var/list/s)   return istype(s)
mob/proc/list_view(aList,title)
	if(!aList || !islist(aList)) CRASH("List null or incorrect type")
	var/html = {"<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>
	[title]
	<table><tr><td><u>Index #</u></td><td><u>Index</u></td><td><u>Value</u></td><td><u>Delete</u></td></tr>"}
	for(var/i=1,i<=length(aList),i++)
		#define LISTEDIT_LINK "href=byond://?src=\ref[src];title=[title];action=listedit;list=\ref[aList]"
		html += "<tr><td><a [LISTEDIT_LINK];part=indexnum;value=[i]>[i]</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=key;value=[i]>[aList[i]]([DetermineVarType(aList[i])][AddListLink(aList[i],title,i)])</td>"
		html += "<td><a [LISTEDIT_LINK];part=value;value=[i]>[aList[aList[i]]]([DetermineVarType(aList[aList[i]])][AddListLink(aList[aList[i]],title,i)])</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=delete;value=[i]><font color=red>X</font></a></td></tr>"
	html += "</table><br><br><a [LISTEDIT_LINK];part=add>\[Add]</a></body></html>"
	if(title)src << browse(html,"window=[title]")
	else src << browse(html)
mob/proc/AddListLink(variable,listname,index)
	if(islist(variable))
		return "<a href=byond://?src=\ref[src];action=listview;list=\ref[variable];title=[listname]\[[index]]><font color=red>(V)</font></a>"
proc
	dd_text2list(text, separator)
		var/textlength      = lentext(text)
		var/separatorlength = lentext(separator)
		var/list/textList   = new /list()
		var/searchPosition  = 1
		var/findPosition    = 1
		var/buggyText
		while (1)															// Loop forever.
			findPosition = findtext(text, separator, searchPosition, 0)
			buggyText = copytext(text, searchPosition, findPosition)		// Everything from searchPosition to findPosition goes into a list element.
			textList += "[buggyText]"										// Working around weird problem where "text" != "text" after this copytext().
			searchPosition = findPosition + separatorlength					// Skip over separator.
			if (findPosition == 0)											// Didn't find anything at end of string so stop here.
				return textList
			else
				if (searchPosition > textlength)							// Found separator at very end of string.
					textList += ""											// So add empty element.
					return textList
	dd_list2text(list/the_list, separator)
		var/total = the_list.len
		if(!total)return														// Nothing to work with.
		var/newText = "[the_list[1]]"										// Treats any object/number as text also.
		var/count
		for (count = 2, count <= total, count++)
			if (separator) newText += separator
			newText += "[the_list[count]]"
		return newText

obj
	test
		kpuppet
			icon='Kazekage Puppet.dmi'
			icon_state="Kazekage Puppet"
			density=1


obj/Special/Squigspaper
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	Click()
		if(get_dist(src,usr)>1) return
		usr<<"This is Yaku's paperwork. He must be very busy."