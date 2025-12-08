obj
	proc
		Levelup()
			if(src.exp>=src.maxexp&&src.level<4)
				if(!src.owner) return
				var/mob/Owner=getOwner(src.owner)
				Owner<<sound('level.wav',0,0)
				Owner<<output("<font color= #dda0dd>Your [src] skill has advanced a level</Font>.","actionoutput")
				src.level++
				src.exp=0
				src.maxexp+=30
				if(src.name=="Clone Jutsu")
					if(src.level==2)Owner.maxbunshin=2
					if(src.level==3)Owner.maxbunshin=3
					if(src.level==4)Owner.maxbunshin=4
					Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to produce [Owner.maxbunshin] clones</Font>.","actionoutput")
				if(src.name=="Fire Release: Fire Ball")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","actionoutput")
				if(src.name=="Meteor Punch")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage and knockback power has increased</Font>.","actionoutput")
				if(src.name=="Fire Release: Phoenix Immortal Fire Technique")
					if(src.level==2)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 3 projectiles</Font>.","actionoutput")
						Owner.katon=3
					if(src.level==3)
						Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","actionoutput")
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 4 projectiles</Font>.","actionoutput")
						Owner.katon=4
					if(src.level==4)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 5 projectiles</Font>.","actionoutput")
						Owner.katon=5
				if(src.name=="Body Replacement Jutsu")
					if(src.level==4)
						var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
						if(!J) return
						if(J.type in Owner.JutsusLearnt)del(J)
						else
							if(!J) return
							Owner<<output("<font color= #bc8f8f>You learned [J.name]</Font>.","actionoutput")
							Owner.JutsusLearnt.Add(J)
							Owner.JutsusLearnt.Add(J.type)
							J.Owner=Owner
				if(src.name=="Transformation Jutsu")
					if(src.level==2)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into objects</Font>!","actionoutput")
					if(src.level==3)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into almost anything</Font>!","actionoutput")
mob
	proc
		MenuUpdate()
			if(src.statbox==1)
				winset(src, null, {"
					Status.Name.text      = "[src.name]";
					Status.Level.text      = "[src.level]";
					Status.EXP.text      = "[src.exp]/[src.maxexp]";
					Status.Tai.text      = "\[See strength]";
					Status.Nin.text      = "[src.ninjutsu]([src.ninexp]/[src.maxninexp])";
					Status.Gen.text      = "[src.genjutsu]([src.genexp]/[src.maxgenexp])";
					Status.Str.text      = "[src.strength]([src.strengthexp]/[src.maxstrengthexp])";
					Status.Def.text      = "[src.defence]([src.defexp]/[src.maxdefexp])";
					Status.Agi.text      = "[src.agility]([src.agilityexp]/[src.maxagilityexp])";
					Status.Health.text      = "([src.health]/[src.maxhealth])";
					Status.Chakra.text      = "([src.chakra]/[src.maxchakra])";
					Status.statpoints.text      = "[src.statpoints]";
				"})
mob
	proc
		LevelStat(stat,howmuch,mission)
			var/area/A=loc.loc
			if(!A) return
			if(A.Safe&&!mission) return
			if(Tutorial!=6) return
			if(src.ExpLock)
				src<<output("<font color=red><small><small>You're currently exp locked! Use the Remove Exp Lock button under the options pane!</small></Font>","actionoutput")
				return
			switch(stat)
				if("Defence")defexp+=howmuch
				if("Strength")strengthexp+=howmuch
				if("Ninjutsu")ninexp+=howmuch
				if("Genjutsu")genexp+=howmuch
				if("Agility")agilityexp+=howmuch
			Levelup()
		Levelup()
			if(src.exp>=src.maxexp)
				var/obj/O = new/obj
				O.icon = 'ChakraCharge.dmi'
				O.icon_state = "3x"
				O.layer=200
				src.overlays+=O
				src<<sound('levelup.wav',0,0)
				src<<output("<font color= #bc8f8f>You leveled up!</Font>.","actionoutput")
				src.level+=1
				src.exp=0
				src.maxexp+=3
				src.statpoints+=3
				src.skillpoints++
				src.maxchakra+=5
			//	src.maxchakra+=round(src.ninjutsu/5+src.genjutsu/5)
				src.maxhealth+=10
			//	src.maxhealth+=round(src.strength/5+src.defence/5)
				src.Levelup()
				spawn(15)
					src.overlays-=O
					del(O)
			if(src.strengthexp>=src.maxstrengthexp)
				src<<sound('level.wav',0,0)
				src<<output("<font color=yellow>You leveled up Strength</Font>.","actionoutput")
				src.exp+=1
				src.strength+=1
				src.strengthexp=0
				src.maxstrengthexp+=10+round(src.strength/2)
				src.Levelup()

			if(src.ninexp>=src.maxninexp)
				src<<sound('level.wav',0,0)
				src<<output("<font color=green>You leveled up Ninjutsu</Font>.","actionoutput")
				src.exp+=1
				src.ninjutsu+=1
				src.ninexp=0
				src.maxninexp+=15+round(src.ninjutsu/2)
				src.Levelup()
			if(src.genexp>=src.maxgenexp)
				src<<sound('level.wav',0,0)
				src<<output("<font color=silver>You leveled up Genjutsu</Font>.","actionoutput")
				src.exp+=1
				src.genjutsu+=1
				src.genexp=0
				src.maxgenexp+=10+round(src.genjutsu/2)
				src.Levelup()
			if(src.defexp>=src.maxdefexp)
				src<<sound('level.wav',0,0)
				src<<output("<font color=maroon>You leveled up Defence</Font>.","actionoutput")
				src.exp+=1
				src.defence++
				src.defexp=0
				src.maxdefexp+=10+round(src.defence/2)
				src.Levelup()
			if(src.agilityexp>=src.maxagilityexp)
				src<<sound('level.wav',0,0)
				src<<output("<font color=blue>You leveled up Agility</Font>.","actionoutput")
				src.exp+=1
				src.agility++
				src.agilityexp=0
				src.maxagilityexp+=10+round(src.agility/2)
				src.Levelup()
				if(src.agility==10)src.attkspeed=7
				if(src.agility==20)src.attkspeed=6
				if(src.agility==30)src.attkspeed=5
				if(src.agility==50)src.attkspeed=4
				if(src.agility==70)src.attkspeed=3
				if(src.agility==80)src.attkspeed=2
				if(src.agility==90)src.attkspeed=1
			if(!src.client)src.UpdateHMB()
			else if(!src.likeaclone)src.UpdateHMB()
			if(src.client)src.MenuUpdate()
			if(level>=25&&!Element2)
				var/Elements=list("Fire","Water","Earth","Lightning","Wind")
				src.Element2=src.CustomInput("Element Options","What secondary element would you like?.",Elements-src.Element)
				if(src.Element2) src.Element2=src.Element2:name
				if(src.Element=="Water"|src.Element2=="Wind")
					if(src.Element=="Wind"|src.Element2=="Water")
						src.Kekkai = "Ice"
obj
	Overlays
		Death
			DeadRight
				icon='MaleBase.dmi'
				icon_state="deadright"
				//pixel_x=32
mob/var/tmp/hit
mob/var/tmp/KillCombo=0
mob/var/tmp/Attacked
mob/var/tmp/levelrate=0
mob/var
	undlvlatck=0
	overlvl=0
mob
	proc
		Death(mob/X,JashinFix)
			if(!X.key)
				goto trol
			if(!src.key)
				goto trol
			if(src.level<=4)
				src.health=src.maxhealth
				return
			if(X.level<=4)
				X.health=X.maxhealth
				return
			if(X.jailed==1)
				X.health=X.maxhealth
				return
			if(src.jailed==1)
				src.health=src.maxhealth
				return
			trol
			src.UpdateHMB()
			var/area/A=loc.loc
			hit=1
			spawn(100)hit=0
			src.HengeUndo()
			if(immortal)
				src.health=1
				UpdateHMB()
				return
			if(AdminShield)
				src.health=maxhealth
				UpdateHMB()
				return
			if(Tutorial&&Tutorial!=6)
				src.health=maxhealth
				UpdateHMB()
				return
			if(JashinFix)if(prob(50))return
			for(var/obj/JashinSymbol/O in src.loc)
				sleep(1)
				if(O&&O.Owner==src&&O.JashinConnected)
					var/mob/HitMe=O.JashinConnected
					if(!HitMe||!ismob(HitMe)) continue
					HitMe.health-= src.strength*2
					F_damage(HitMe,src.strength*2)
					HitMe.Bleed()
					src.Bleed()
					HitMe.UpdateHMB()
					view() << sound('knife_hit1.wav')
					src.UpdateHMB()
					HitMe.Death(src)
			if(ismob(X))
				if(istype(X,/mob/Karasu))X=X.Owner
				if(icon_state=="push"&&X==src)
					var/area/AK=X.loc.loc
					if(A.Safe==1||AK.Safe==1)
						src.health=src.maxhealth
						src.UpdateHMB()
						return
				if(src.key&&X&&X!=src&&X.key&&!dueling)
					var/area/AK=X.loc.loc
					X.Attacked=src
					spawn(200) if(X) X.Attacked=null
					if(A.Safe==1||AK.Safe==1)
						src.health=src.maxhealth
						src.UpdateHMB()
						return
			if(src.health<=0&&src.dead==0)
				if(istype(src,/mob/player))
					if(ismob(X))
						X.IncreaseExp()
						if(X.needkill==1)X.needkill=2
					src.KillCombo=0
					Effects["Rasengan"]=null
					Effects["Chidori"]=null
					if(src.gates[2])
						src.health=0
						return
					gatestop()
					if(src.Susanoo)
						src.health=0
						return
					if(src.client)src.client.eye=src
					src.screen_moved=0
					for(var/obj/Projectiles/Effects/AlmightyPush/JP in range(src,0))del(JP)
					if(src.client)
						src.client.images=0
						src.Target_ReAdd()
						src.client:perspective = EDGE_PERSPECTIVE
					src.likeaclone=null
					if(src.client)src.client.eye=src
					src.arrow=null
					src.cranks=null
					src.copy=null
					src.ArrowTasked=null
					for(var/mob/Clones/C in world)
						if(C.Owner==src)
							C.health=0
							C.Death(src)
					src.bunshin=0
					src.sbunshin=0
					src.msbunshin=0
					src.mizubunshin=0
					if(istype(A,/area/Dojo))
						if(ismob(X))
							if(src==X)
								src<<output("You've just self-killed.'No exp from that...","actionoutput")
								goto skip
							X.levelrate+=1
							if(X.levelrate>=1) X.levelrate=1
						var/area/Dojo/D=A
						skip
						src.health=maxhealth/2
						src.chakra=src.maxchakra/2
						view(src)<<output("[src] has been KO'd and removed from the Dojo.","actionoutput")
						if(istype(locate(D.DojoX,D.DojoY,D.DojoZ),/turf/))src.loc=locate(D.DojoX,D.DojoY,D.DojoZ)
						else src.loc=MapLoadSpawn()
						UpdateHMB()
						if(ismob(X)&&src != X)
							X.exp+=((0.1*X.KillCombo)+0.1)
						if(X&&src != X&&ismob(X)&&X.KillCombo<5+round(X.agility/5))
							X.KillCombo++
							if(global.Expboosts==X.village)X.KillCombo++
						return
					if(dueling)
						world << output("[opponent] has defeated [src] in an arena battle.","actionoutput")
						src.loc=locate(110,90,3)
						src.health=src.maxhealth
						var/mob/i=opponent
						i.loc=locate(110,90,3)
						arenaprogress=0
						opponent.dueling=0
						src.dueling=0
						return
					if(ChuuninOpponentOne==src&&ChuuninOpponentTwo==X)
						ChuuninDuelLoser=src
						ChuuninDuelWinner=X
						src.health=maxhealth
						return
					if(ChuuninOpponentTwo==src&&ChuuninOpponentOne==X)
						ChuuninDuelLoser=src
						ChuuninDuelWinner=X
						src.health=maxhealth
						return
					var/DeadLocation=src.loc
					src.health=0
					src.chakra=0
					src.move=0
					src.dead=1
					src.canattack=0
					src.firing=1
					src.density=0
					src.dodge=0
					src.Sleeping=0
					src.levelrate=0
					src.injutsu=1
					src.icon_state="dead"
					for(var/obj/ChuuninExam/Scrolls/S in src)S.Move(src.loc)
					spawn()
						while(dead)
							loc=DeadLocation
							icon_state="dead"
							move=0
							injutsu=1
							canattack=0
							sleep(1)
					src.wait=0
					src.rest=0
					src.overlays=0
					src.RestoreOverlays()
					src.UpdateHMB()
					if(ismob(X)) if(X&&X.key&&src!=X)
						if(X&&ismob(X)&&X.KillCombo<5+round(X.agility/5))
							X.KillCombo++
							if(global.Expboosts==X.village)X.KillCombo++
						if(X.village==src.village&&X.village!="Missing-Nin"&&src.village!="Missing-Nin")
							world<<output("[src] was knocked out by [X], and they were both from the [src.village]!","actionoutput")
							X.exp-=(X.exp/10)
							if(X.exp<=0) X.exp=0
							X<<output("You have lost 10% of your EXP for killing a fellow villager.","actionoutput")
							X.KillCombo=0
						else world<<output("[src] was knocked out by [X]!","actionoutput")
						src<<output("You were knocked out by [X].","actionoutput")
						X.levelrate+=2
						X.exp+=rand(3,(X.levelrate))
						if(X.levelrate>=5) X.levelrate=5
						X.Ryo+=src.Ryo
						X<<output("You have looted [src.Ryo] Ryo from [src].","actionoutput")
						X.kills++
						//X.Multikill++
						if(X.joinedwar==1)
							world<<"<font color = #C0C0C0>[src],[src.village] shinobi was knocked out by [X]...[X.village] gets 1 point!"
							if(X.village=="Hidden Sand")
								sandwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Mist")
								mistwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Leaf")
								leafwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Sound")
								soundwarpoints++
								X.exp+=rand(3,5)
						if(joinedakatshinobiw==1)
							if(src.village==X.village)
								world<<"<font color = #C0C0C0>[src],[src.village] ninja was knocked out by [X]...[X.village] LOOSES 1 point in war!"
								if(X.village=="Akatsuki")
									akatpoints--
									goto rofl
								else
									sforcepoints--
									goto rofl
							world<<"<font color = #C0C0C0>[src],[src.village] ninja was knocked out by [X]...[X] gets 1 PvP point."
							X.exp+=rand(5,10)
							X.pvppoints++
							if(X.village=="Akatsuki")
								world<<"Akatsuki gets 1 point in war!"
								akatpoints++
							else
								world<<"Shinobi Force gets a point!"
								sforcepoints++
						rofl
						//spawn() X.MedalCheck()
						//spawn(70) X.Multikill=0

						if(VillageAttackers.Find(src.village)&&VillageDefenders.Find(X.village))
							X<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!","actionoutput")
							X.Ryo+=10
						if(VillageDefenders.Find(src.village)&&VillageAttackers.Find(X.village))
							X<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!","actionoutput")
							X.Ryo+=10
						if(src.Bounty)
							X<<output("You have claimed the $[src.Bounty] bounty on [src.name]'s head.","actionoutput")
							X.Ryo+=src.Bounty
							src.Bounty=0
						else X.Bounty+=rand(5,10)
						if(X.Mission=="Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","actionoutput")
							var/MissionRyo=300
							var/MissionExp=10 + WORLDXP
							if(X.Squad)
								var/mob/player/M = getOwner(X.Squad.Leader)
								M.Ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","actionoutput")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(5,10)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(50,75),1)
											M.Levelup()
										if(2)
											M.LevelStat("strength",rand(50,75),1)
											M.Levelup()
										if(3)
											M.LevelStat("Genjutsu",rand(50,75),1)
											M.Levelup()
								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.Ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(5,10)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(50,75),1)
													M.Levelup()
												if(2)
													M.LevelStat("strength",rand(50,75),1)
													M.Levelup()
												if(3)
													M.LevelStat("Genjutsu",rand(50,75),1)
													M.Levelup()
										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
										M.Mission=null
										for(var/obj/MissionType/O in M)M.itemDelete(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","actionoutput")
								X.Ryo+=MissionRyo
								var/mob/player/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(5,10)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(50,75),1)
											M2.Levelup()
										if(2)
											M2.LevelStat("strength",rand(50,75),1)
											M2.Levelup()
										if(3)
											M2.LevelStat("Genjutsu",rand(50,75),1)
											M2.Levelup()
							X.Levelup()
						if(X.Mission=="Jounin Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","actionoutput")
							var/MissionRyo=600
							var/MissionExp=10 + WORLDXP
							if(X.Squad)
								var/mob/player/M = getOwner(X.Squad.Leader)
								M.Ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","actionoutput")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(5,10)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(75,100),1)
											M.Levelup()
										if(2)
											M.LevelStat("strength",rand(75,100),1)
											M.Levelup()
										if(3)
											M.LevelStat("Genjutsu",rand(75,100),1)
											M.Levelup()
								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.Ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(5,10)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(75,100),1)
													M.Levelup()
												if(2)
													M.LevelStat("strength",rand(75,100),1)
													M.Levelup()
												if(3)
													M.LevelStat("Genjutsu",rand(75,100),1)
													M.Levelup()
										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
										M.Mission=null
										for(var/obj/MissionType/O in M)M.itemDelete(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","actionoutput")
								X.Ryo+=MissionRyo
								var/mob/player/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(5,10)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(75,100),1)
											M2.Levelup()
										if(2)
											M2.LevelStat("strength",rand(75,100),1)
											M2.Levelup()
										if(3)
											M2.LevelStat("Genjutsu",rand(75,100),1)
											M2.Levelup()

					src.Ryo=0
					spawn(300)
						if(!revived)
							KOs++
							src.dead=0
							if(KOs>=2&&!Chuunins.Find(src))
								if(X&&X.key&&src!=X)
									if(X.z in global.warmaps && src.z in global.warmaps)
										if(X.village == "Hidden Sand")
											global.sandpoints["[X.z]"]+=src.level
										if(X.village == "Hidden Leaf")
											global.leafpoints["[X.z]"]+=src.level
								if(src.revived==0)
									var/list/Spawns=RespawnSpawn()
									if(!Spawns.len) src.loc=locate(1,1,4)
									else src.loc=pick(src.RespawnSpawn())
								else src.revived=0
								KOs=0
							if(KOs>=2)KOs=0
							src.density=1
							src.health=src.maxhealth
							src.chakra=src.maxchakra
							src.injutsu=0
							src.canattack=1
							src.firing=0
							src.icon_state=""
							src.wait=0
							src.rest=0
							src.dodge=0
							src.move=1
							src.joinedwar=0
							src.joinedakatshinobiw=0
							src.swimming=0
							src.overlays=0
							src.RestoreOverlays()
							src.UpdateHMB()
							spawn(1)src.Run()
						revived=0
				if(istype(src,/mob/Clones))
					var/mob/O=src.Owner
					if(O.likeaclone)
						O.client:perspective = EDGE_PERSPECTIVE
						O.client.eye=O
					if(istype(src,/mob/Clones/Bunshin))O.bunshin--
					if(istype(src,/mob/Clones/Shadow))O.sbunshin=0
					if(istype(src,/mob/Clones/MShadow))	O.msbunshin--
					if(istype(src,/mob/Clones/MizuBunshin))
						O.mizubunshin--
						view(src)<<sound('sg_explode.wav',0,0)
						icon='Water Bunshin.dmi'
						flick("form",src)
						del(src)
					view(src)<<sound('sg_explode.wav',0,0)
					var/obj/S = new/obj/MiscEffects/Smoke(src.loc)
					S.loc=src.loc
					del(src)
				if(istype(src,/mob/C2))
					flick("destroy",src)
					spawn(3)del(src)
				/*if(istype(src,/mob/Missions/Bandit))
					if(findtext(X.Mission,"K.O a bandit"))
						X<<output("\yellow You've finished your mission. Congratulations, the bandit is down!.","actionoutput")
						X.Mission=null
						var/MissionRyo=100
						var/MissionExp=12+WORLDXP
						X.IncreaseExp()
						if(usr.Squad)
							var/mob/M
							M = getOwner(usr.Squad.Leader)
							M.Ryo += (MissionRyo + 1)
							M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","actionoutput")
							M.exp+=MissionExp
							for(var/i in usr.Squad.Members)
								if(getOwner(i))
									M = getOwner(i)
									if((M.client.inactivity/10)>=120) continue
									M.Ryo += MissionRyo + 1
									M.exp+=MissionExp
									M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
									if(M.Mission=="K.O a bandit")
										M.Mission=null
									M.Levelup()
									Del(src)
						else
							usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","actionoutput")
							usr.Ryo+=MissionRyo
							usr.exp+=MissionExp
							usr.Levelup()
							Del(src)
						X.Levelup()*/