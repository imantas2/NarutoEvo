mob/var/tmp/list/Killed=list()
mob/var/tmp/Mission
mob/var/tmp/list/RecentVerbs=list()
mob/var/LastMissionTime=0
mob/proc/RecentVerbsCheck(var/verbs, var/timer, var/spam = 0)
	if(src.RecentVerbs[verbs])
		if(world.timeofday-RecentVerbs["[verbs]"] < timer)
			if(spam) src << output("You must wait before using this again.","actionoutput")
			return 1
	return 0
mob/proc/MissionCheck()
	if(src.LastMissionTime>0)
		src << output("You must wait [round(LastMissionTime/600)] minutes before taking another mission.","actionoutput")
		return 1
	return 0
obj/MissionType
	byakuview=1
	icon='Flowers.dmi'
	layer=TURF_LAYER+3
	Entered(var/mob/player/M)
		if(istype(M,/mob/player))
			if(M.foot=="Left")
				view(M,13) << sound('Sounds/Walk/man_fs_l_mt_drt.ogg',0,0,0,25)
				M.foot="Right"
			else
				view(M,13) << sound('Sounds/Walk/man_fs_r_mt_drt.ogg',0,0,0,25)
				M.foot="Left"
	VesaiRoot
		name="Vesai Root"
		icon_state="vesai"
		New()
			src.pixel_x+=rand(3,30)
			src.pixel_x-=rand(3,30)
			src.pixel_y+=rand(1,5)
			..()
	Opal
		icon='GRND.dmi'
		icon_state="opal"
		New()
			..()
	Del()
		var/Location=src.loc
		src.loc=locate(0,0,0)
		spawn(300)
		src.loc=Location
	DblClick()
		if(src in usr) return
		if(get_dist(src,usr)>1) return
		if(!src) return
		var/mob/player/M=usr
		if(!findtext(M.Mission,"[src.name]"))
			M<<output("You shouldn't pick this up.","actionoutput")
			return
		if(M.dead) return
		hearers()<<output("[M] picks up [src].","actionoutput")
		Move(M)
		M.IncreaseExp()
		M.Killed["[src.name]"]++
		if(M.Mission=="Collect [M.Killed["[src.name]"]] [src.name]")
			M.Killed["[src.name]"]=null
			M.Mission=null
			M<<output("You've completed your mission.","actionoutput")
			var/MissionRyo=40
			var/MissionExp=5+WORLDXP
			for(var/obj/MissionType/O in M)
				M.itemDelete(O)
			for(var/obj/MissionType/O in M)
				del(O)
			if(usr.Squad)
				M = getOwner(usr.Squad.Leader)
				M.Ryo += (MissionRyo + 1)
				M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","actionoutput")
				M.exp+=MissionExp
				for(var/i=0,i<MissionExp,i++)
					var/GAIN = rand(1,3)
					switch(GAIN)
						if(1)
							M.LevelStat("Ninjutsu",rand(60,100),1)
							M.Levelup()
						if(2)
							M.LevelStat("strength",rand(60,100),1)
							M.Levelup()
						if(3)
							M.LevelStat("Genjutsu",rand(60,100),1)
							M.Levelup()
				for(var/i in usr.Squad.Members)
					if(getOwner(i))
						M = getOwner(i)
						if((M.client.inactivity/10)>=120) continue
						M.Ryo += MissionRyo + 1
						M.exp+=MissionExp
						for(var/i2=0,i2<MissionExp,i2++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",rand(60,100),1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",rand(60,100),1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",rand(60,100),1)
									M.Levelup()
						M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
						//M.Mission=null
						for(var/obj/MissionType/O in M)
							M.itemDelete(O)
			else
				usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","actionoutput")
				usr.Ryo+=MissionRyo
				usr.exp+=MissionExp
				var/mob/player/M2 = usr
				for(var/i=0,i<MissionExp,i++)
					var/GAIN = rand(1,3)
					switch(GAIN)
						if(1)
							M2.LevelStat("Ninjutsu",rand(60,100),1)
							M2.Levelup()
						if(2)
							M2.LevelStat("strength",rand(60,100),1)
							M2.Levelup()
						if(3)
							M2.LevelStat("Genjutsu",rand(60,100),1)
							M2.Levelup()
			usr.Levelup()
			return
var/list/namesavaliable=list("Akirya","Obei","Tsunai","Amatsi","Ayumi","Emiraya","Aiko","Nevira","Onomari")
mob/NPC
	move=0
	Move()return
	Death(killer)return
	MissionGuy
		density=0
		icon='MaleBase.dmi'
		health=500
		maxhealth=500
		Death()
			if(src.health<=0&&!dead)
				src.dead=1
				src.density=0
				src.icon_state="dead"
				spawn(600*5)
					src.health=maxhealth
					src.dead=0
					density=1
					src.icon_state=""
			..()
		NewStuff()
			if(!namesavaliable.len) del(src)
			name=pick(namesavaliable)
			namesavaliable-=name
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays += 'Shade.dmi'
			src.overlays+='Shirt.dmi'
		//	src.overlays+='Chunin Vest.dmi'
			src.overlays+='Sandals.dmi'
			src.Name(name)
			spawn() src.Stuff()
	DblClick()
		if(usr.dead) return
		if(get_dist(src,usr)>2) return
		if(usr.Mission=="Talk with [src.name]")
			usr.Mission=null
			usr.skalert("[src] says, Oh hello [usr.name].<br>You and [src] have a long talk, after it is over they hand you your reward. You have completed your mission!","[src]")
			//usr.Ryo+=30
			var/MissionRyo=150
			var/MissionExp=8+WORLDXP
			usr.IncreaseExp()
			if(usr.Squad)
				var/mob/M
				M = getOwner(usr.Squad.Leader)
				M.Ryo += (MissionRyo + 1)
				M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","actionoutput")
				M.exp+=MissionExp
				for(var/i=0,i<MissionExp,i++)
					var/GAIN = rand(1,3)
					switch(GAIN)
						if(1)
							M.LevelStat("Ninjutsu",rand(20,35),1)
							M.Levelup()
						if(2)
							M.LevelStat("strength",rand(20,35),1)
							M.Levelup()
						if(3)
							M.LevelStat("Genjutsu",rand(20,35),1)
							M.Levelup()
				for(var/i in usr.Squad.Members)
					if(getOwner(i))
						M = getOwner(i)
						if((M.client.inactivity/10)>=120) continue
						M.Ryo += MissionRyo + 1
						M.exp+=MissionExp
						for(var/i2=0,i2<MissionExp,i2++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",rand(20,35),1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",rand(20,35),1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",rand(20,35),1)
									M.Levelup()
						M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
						//M.Mission=null
						M.Levelup()
			else
				usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
				usr.Ryo+=MissionRyo
				usr.exp+=MissionExp
				var/mob/M = usr
				for(var/i=0,i<MissionExp,i++)
					var/GAIN = rand(1,3)
					switch(GAIN)
						if(1)
							M.LevelStat("Ninjutsu",rand(20,35),1)
							M.Levelup()
						if(2)
							M.LevelStat("strength",rand(20,35),1)
							M.Levelup()
						if(3)
							M.LevelStat("Genjutsu",rand(20,35),1)
							M.Levelup()
			usr.Levelup()
			return
obj/Pests/Weeds
	byakuview=1
	icon='Flowers.dmi'
	icon_state="2"
	New()
		..()
	Del()
		var/Location=src.loc
		src.loc=locate(0,0,0)
		spawn(300)
		src.loc=Location
	DblClick()
		if(get_dist(src,usr)>1) return
		if(findtext(usr.Mission,"Weeding"))
			usr<<output("You pick the weed, and crumple it up in your hand.","actionoutput")
			usr.Killed["Weeds"]++
			if(usr.Killed["Weeds"]==6)
				usr.Killed["Weeds"]=null
				usr.Mission=null
				var/MissionRyo=120
				var/MissionExp=8+WORLDXP
				usr.IncreaseExp()
				if(usr.Squad)
					var/mob/M
					M = getOwner(usr.Squad.Leader)
					M.Ryo += (MissionRyo + 1)
					M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","actionoutput")
					M.exp+=MissionExp
					for(var/i=0,i<MissionExp,i++)
						var/GAIN = rand(1,3)
						switch(GAIN)
							if(1)
								M.LevelStat("Ninjutsu",rand(85,105),1)
								M.Levelup()
							if(2)
								M.LevelStat("strength",rand(85,105),1)
								M.Levelup()
							if(3)
								M.LevelStat("Genjutsu",rand(85,105),1)
								M.Levelup()
					for(var/i in usr.Squad.Members)
						if(getOwner(i))
							M = getOwner(i)
							if((M.client.inactivity/10)>=120) continue
							M.Ryo += MissionRyo + 1
							M.exp+=MissionExp
							for(var/i2=0,i2<MissionExp,i2++)
								var/GAIN = rand(1,3)
								switch(GAIN)
									if(1)
										M.LevelStat("Ninjutsu",rand(85,105),1)
										M.Levelup()
									if(2)
										M.LevelStat("strength",rand(85,105),1)
										M.Levelup()
									if(3)
										M.LevelStat("Genjutsu",rand(85,105),1)
										M.Levelup()
							M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
							//M.Mission=null
							M.Levelup()
				else
					usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
					usr.Ryo+=MissionRyo
					usr.exp+=MissionExp
					var/mob/M = usr
					for(var/i=0,i<MissionExp,i++)
						var/GAIN = rand(1,3)
						switch(GAIN)
							if(1)
								M.LevelStat("Ninjutsu",rand(25,45),1)
								M.Levelup()
							if(2)
								M.LevelStat("strength",rand(25,45),1)
								M.Levelup()
							if(3)
								M.LevelStat("Genjutsu",rand(25,45),1)
								M.Levelup()
				usr.Levelup()
			del(src)//wait ill check on forums what i wrote lol
mob/NPC/Mission_Lady
	name = "Hokage's Secretary"
	icon='MaleBase.dmi'
	pixel_x=-15
	village="Hidden Leaf"
	density=0
	Move()return
	Death()return
	NewStuff()
		src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
		src.overlays += 'Shade.dmi'
		src.overlays+='Shirt.dmi'
		src.overlays+='Chunin Vest.dmi'
		src.overlays+='Sandals.dmi'
		src.Name(name)
		OriginalOverlays=overlays.Copy()
		spawn() src.Stuff()
	DblClick()
		if(usr.dead) return
		if(get_dist(src,usr)>2) return
		if(usr.Mission) return
		if(usr.village!=src.village)
			src<<"You must be from the [village] to talk to this NPC."
			return
		if(usr.MissionCheck()) return
		var/obj/missiontype=usr.CustomInput("Hello there. What mission would you like?","Mission",list("D","C","B","A"))
		if(!usr) return
		if(!missiontype) return
		if(!istype(missiontype)) return
		switch(missiontype.name)
			if("D")
				var/list/choices=list("Weeding","Talk with Mission")
				var/choice=pick(choices)
				var/text
				switch(choice)
					if("Weeding")
						var/obj/Pests/Weeds/W=new
						usr << browse_rsc(icon(W.icon,W.icon_state), "Weed.png")
						text="to get rid of those pesky weeds around the village, they're getting annoying. They look like this: \icon[W] Do you accept this mission?"
						del(W)
					if("Talk with Mission")
						var/MissionGuys
						for(var/mob/NPC/MissionGuy/M in world)
							if(prob(30)) MissionGuys=M
						if(!MissionGuys)
							for(var/mob/NPC/MissionGuy/M in world)
								MissionGuys=M
						choice="Talk with [MissionGuys]"
						text="to talk with [MissionGuys], he has some information that could benefit the village.He should be around the village somewhere. Do you accept this mission?"
				if(usr.skalert("Great! Your mission is [text]","Mission",list("Accept","Decline"))=="Decline") return
				if(!usr) return
				usr.Mission=choice
				if(usr.Mission=="Weeding")
					usr<<browse({"<head>
<title>Extra Mission Info</title>
<FONT SIZE="7"><center><font color=white><b><u>Extra Mission Info</u></b></FONT>
<BODY BGCOLOR="#000000"><hr><br>
<font color=white>You are looking for this plant:<br><img src="Weed.png">"})
					winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
				usr.LastMissionTime=(600*7)
				return
			if("C")
				if(usr.rank=="Academy Student")
					usr.skalert("Sorry, you're too young to do this mission. Come back when you're a Genin and at least level 13.","Mission")
					return
				if(usr.rank=="Genin"&&usr.level<13)
					usr.skalert("Sorry, you're too young to do this mission. Come back when you're a Genin and at least level 13.","Mission")
					return
				var/list/choices=list(/obj/MissionType/VesaiRoot/,/obj/MissionType/Opal/*,"K.O a bandit"*/)
				var/choice=pick(choices)
				if(choice=="K.O a bandit")
					if(usr.skalert("Your mission is to knock out a troublesome bandit and teach him a lesson not to mess with local folks! Do you accept this mission?","Mission",list("Accept","Decline"))=="Decline") return
					if(!usr) return
					usr.Mission="K.O a bandit"
					goto skip
				var/obj/I=new choice
				usr << browse_rsc(icon(I.icon,I.icon_state), "[I].png")
				var/amount=rand(5,10)
				if(usr.skalert("Your mission is to collect [amount] [I](s) for our research. You can find them throughout the world. Do you accept this mission?","Mission",list("Accept","Decline"))=="Decline") return
				if(!usr) return
				usr.Mission="Collect [amount] [I]"
				usr<<browse({"<head>
<title>Extra Mission Info</title>
<FONT SIZE="7"><center><font color=white><b><u>Extra Mission Info</u></b></FONT>
<BODY BGCOLOR="#000000"><hr><br>
<font color=white>You are looking for this object:<br><img src=[I].png>"})
				winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
				skip
				usr.LastMissionTime=(600*7)
				return
			if("B")
				var/mob/choice
				if(usr.rank=="Genin"||usr.rank=="Academy Student")
					usr.skalert("Sorry, you're too young to do this mission. Come back when you're a Chuunin.","Mission")
					if(!usr) return
					return
				for(var/mob/player/M in world)
					if(M&&M.rank=="Missing-Nin"&&M.village=="Missing-Nin"&&usr!=M)
						choice=M
						break
				if(!choice)
					usr.skalert("Sorry, we don't have a mission for you yet.","Mission")
					if(!usr) return
					return
				if(usr.skalert("Your mission is a special one, you are to hunt down and kill the Missing-Nin, [choice]. His last known location was at [choice.x],[choice.y],[choice.z]. Do you accept?","Mission",list("Accept","Decline"))=="Decline") return
				if(!usr) return
				usr.Mission="Kill [choice] ([choice.ckey])"
				usr.LastMissionTime=(600*7)
				return
			if("A")
				var/mob/choice
				if(usr.rank=="Genin"||usr.rank=="Academy Student"||usr.rank=="Chuunin")
					usr.skalert("Sorry, you're too young to do this mission. Come back when you're a Jounin.","Mission")
					if(!usr) return
					return
				for(var/mob/player/M in world)
					if(M&&M.rank=="Missing-Nin"&&M.village=="Missing-Nin"&&usr!=M)
						choice=M
						break
					if(M&&VillageAttackers.Find(src.village)&&VillageDefenders.Find(M.village))
						choice=M
						break
					if(M&&VillageDefenders.Find(src.village)&&VillageAttackers.Find(M.village))
						choice=M
						break
				if(!choice)
					usr.skalert("Sorry, we don't have a mission for you yet.","Mission")
					if(!usr) return
					return
				if(usr.skalert("Greetings [usr.name]. Your mission today is that you are to hunt down and kill the [choice.rank] Ninja ([choice.village ? "[choice.village]" : ""]), [choice]. His last known location was at [choice.x],[choice.y],[choice.z]. Do you accept?","Mission",list("Accept","Decline"))=="Decline") return
				if(!usr) return
				usr.Mission="Jounin Kill [choice] ([choice.ckey])"
				usr.LastMissionTime=(600*7)
				return
mob
	Missions
		Bandit
			icon='MaleBase.dmi'
			Name="Dangerous Bandit"
			village="Missing Nin"
			health=1500
			maxhealth=1500
			chakra=1500
			maxchakra=1500
			strength=80
			ninjutsu=80
			genjutsu=80
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		OneTails
			icon='Ichibi.dmi'
			Name="One Tails"
			village="Missing Nin"
			health=70000
			maxhealth=70000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		TwoTails
			icon='Nibi.dmi'
			Name="Two Tails"
			village="Missing Nin"
			health=70000
			maxhealth=70000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		ThreeTails
			icon='Sanbi.dmi'
			Name="Three Tails"
			village="Missing Nin"
			health=70000
			maxhealth=70000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		FourTails
			icon='Yonbi.dmi'
			Name="Four Tails"
			village="Missing Nin"
			health=80000
			maxhealth=80000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		FiveTails
			icon='Gobi.dmi'
			Name="Five Tails"
			village="Missing Nin"
			health=80000
			maxhealth=80000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		SixTails
			icon='Rokubi.dmi'
			Name="Six Tails"
			village="Missing Nin"
			health=90000
			maxhealth=90000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		SevenTails
			icon='Shichibi.dmi'
			Name="Seven Tails"
			village="Missing Nin"
			health=90000
			maxhealth=90000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		EightTails
			icon='Gyuki.dmi'
			Name="Eight Tails"
			village="Missing Nin"
			health=100000
			maxhealth=100000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
		NineTails
			icon='Kyuubi.dmi'
			Name="Nine Tails"
			village="Missing Nin"
			health=100000
			maxhealth=100000
			chakra=100000
			maxchakra=100000
			strength=500
			ninjutsu=500
			genjutsu=500
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(3,6)-M.defence*2
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
				/*	if(src.health<=0)
						src.dead = 1
						Death(src)*/
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for it!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)


mob/Missions/Bandit/New()
	src.health=src.maxhealth
	src.chakra=src.maxchakra
	src.icon_state=""
	var/s=rand(1,3)
	if(s==1)
		src.overlays+='Deidara.dmi'
	if(s==2)
		src.overlays+='Long.dmi'
	if(s==3)
		src.overlays+='Short.dmi'
	src.overlays+='Sandals.dmi'
	src.overlays+='Shirt.dmi'
	src.overlays+='Pants.dmi'
	src.overlays+='Gloves.dmi'
	src.locc=src.loc
	src.Combat()
	Name(src.name)
mob/Missions/Bandit/Del()
	src.loc=null
	spawn(600*4)
		view()<<"\yellow[src] says, \white'Fear me! I have returned to kill you all !!!'"
		src.icon_state=""
		src.health=src.maxhealth
		src.chakra=src.maxchakra
		src.loc=src.locc
		src.dead=0
		src.move=0
