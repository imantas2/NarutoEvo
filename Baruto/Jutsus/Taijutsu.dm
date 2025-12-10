mob/var/tmp/KOs
mob/var/tmp/
	ChakraJutsuState = 0
	ChakraJutsuIndex = 0
	ChakraJutsuSequence = list()
	ChakraJutsuTimer = 0
mob
	var/tmp/sheilded=0
	var/tmp/gates[5]
	var/tmp/guardians[1]
	var/tmp/mystical_palms=0//Probably should add a technique for this.
	proc
		guardianstop()
			if(src.guardians[1])src.guardians[1]=0
			src.icon_state=riconstate
			for(var/obj/O in LinkFollowers)if(O)del(O)
		gatestop()
			if(src.gates[5])src.gates[5]=0
			if(src.gates[4])src.gates[4]=0
			if(src.gates[3])src.gates[3]=0
			if(src.gates[2])src.gates[2]=0
			if(src.gates[1])src.gates[1]=0
			src.icon_state=riconstate
			for(var/obj/O in LinkFollowers)if(O)del(O)
		CSstop()
			src.CS=0
			src.icon_state=riconstate
			for(var/obj/O in LinkFollowers)if(O)del(O)
		Gate_1()
			if(move&&src.gates[1])
				src.gatestop()
				return
			if(ChakraCheck(50)) return
			if(move&&!src.gates[1])
				var/colour = colour2html("red")
				F_damage(src,health/10,colour)
				health-=health/10
				src.gates[1]=1
				var/obj/O2 = new/obj
				O2.loc=src.loc
				O2.icon = 'Dust.dmi'
				O2.layer=MOB_LAYER+1
				O2.pixel_x=-34
				O2.icon_state="smoke"
				spawn(5)del(O2)
				spawn(300)if(src&&!src.gates[2])src.gatestop()
		Gate_2()
			if(move&&src.gates[2])
				src.gatestop()
				return
			if(ChakraCheck(50)) return
			if(src.move==1)
				if(!src.gates[2] && src.gates[1])
					var/colour = colour2html("red")
					F_damage(src,health/10,colour)
					health-=health/10
					src.gates[2]=1
					var/obj/O = new/obj
					O.loc=loc
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.loc=loc
					O2.icon = 'Dust.dmi'
					O2.pixel_x=-34
					O2.layer=MOB_LAYER+1
					O2.icon_state="smoke2"
					spawn(5)if(O2)del(O2)
					spawn(300)
						if(!src.gates[3])
							if(O)del(O)
							if(src)src.gatestop()
		Gate_3()
			if(move&&src.gates[3])
				src.gatestop()
				return
			if(ChakraCheck(50)) return
			if(src.move==1)
				if(!src.gates[3] && src.gates[2])
					var/colour = colour2html("red")
					F_damage(src,health/10,colour)
					health-=health/10
					src.gates[3]=1
					var/k = src.icon
					src.icon = 'Gate Base.dmi'
					var/obj/O2 = new/obj
					O2.loc=loc
					O2.layer=MOB_LAYER+1
					O2.pixel_x=-34
					O2.icon = 'Dust.dmi'
					O2.icon_state="smoke3"
					spawn(5)if(O2)del(O2)
					spawn(300)if(src)
						src.icon = k
						if(!src.gates[4])
							src.gatestop()
		Gate_4()
			if(move&&src.gates[4])
				src.gatestop()
				return
			if(ChakraCheck(50)) return
			if(src.move==1)
				if(!src.gates[4] && src.gates[3])
					var/colour = colour2html("red")
					F_damage(src,health/10,colour)
					health-=health/10
					src.gates[4]=1
					var/obj/O = new/obj
					O.layer=MOB_LAYER-1
					O.icon = 'gate green aura.dmi'
					O.loc=loc
					O.pixel_x=-16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.layer=MOB_LAYER+1
					O2.pixel_x=-34
					O2.loc=loc
					O2.icon_state="smoke3"
					spawn(5)if(O2)del(O2)
					spawn(300)
						if(!src.gates[5])
							if(O)del(O)
							if(src)src.gatestop()
		Gate_5()
			if(move&&src.gates[5])
				src.gatestop()
				return
			if(ChakraCheck(50)) return
			if(src.move==1)
				if(!src.gates[5] && src.gates[4])
					var/colour = colour2html("red")
					F_damage(src,health/10,colour)
					health-=health/10
					src.gates[5]=1
					var/obj/O = new/obj
					O.layer=MOB_LAYER+1
					O.icon = 'gate 3 effect.dmi'
					O.loc=loc
					O.pixel_x=-16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.pixel_x=-34
					O2.layer=MOB_LAYER+1
					O2.loc=loc
					O2.icon_state="smokemax"
					spawn(5)if(O2)del(O2)
					spawn(300)
						if(O)del(O)
						if(src)src.gatestop()
		Bubble_Guardian()
			if(move&&src.guardians[1])
				src.guardianstop()
				return
			if(ChakraCheck(50)) return
			if(move&&!src.guardians[1])
				src.guardians[1]=1
				var/obj/O = new/obj
				O.layer=MOB_LAYER+1
				O.icon = 'bubble guardian.dmi'
				O.loc=loc
				O.pixel_x=-16
				O.linkfollow(src)
				var/obj/O2 = new/obj
				O2.icon = 'Dust.dmi'
				O2.pixel_x=-34
				O2.layer=MOB_LAYER+1
				O2.loc=loc
				O2.icon_state="smokemax"
				spawn(5)if(O2)del(O2)
				spawn(300)
					if(O)del(O)
					if(src)src.guardianstop()
		CS()
			if(move&&src.CS)
				src.CSstop()
				return
			if(ChakraCheck(100)) return
			if(src.move==1)
				if(!src.CS)
					health-=health/2
					src.CS=1
					var/obj/O = new/obj
					O.layer=MOB_LAYER+1
					O.icon = 'CS Aura.dmi'
					O.loc=loc
					O.pixel_x=-16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.pixel_x=-34
					O2.layer=MOB_LAYER+1
					O2.loc=loc
					O2.icon_state="smokemax"
					spawn(5)if(O2)del(O2)
					spawn(200)
						if(O)del(O)
						if(src)src.CS()
		ScreenShake(var/Times)
			if(!src.screen_moved)
				if(src.client&&src.client.eye==src)
					//if(Times) src.screen_moved=Times
					//if(src.screen_moved>=5) src.screen_moved=null
					while(Times)
						Times--
					//	if(src.screen_moved)
						src.client.eye=locate(src.x+rand(-1,1),src.y+rand(-1,1),src.z)
						sleep(2)
					//	if(src){src.client.eye=src;src.screen_moved--}
						continue
					src.client.eye=src
		PunchFlick(var/PTimes,var/obj/Jutsu)
			if(src.client)
				while(src)
					sleep(1)
					if(PTimes)
						var/obj/A = new/obj/MiscEffects/Morning_Peacock(src.loc)
						A.Owner=src
						A.damage=Jutsu.damage
						A.dir=src.dir
						if(prob(50))
							if(src.dir==NORTH)
							//	var/list/dir_list=list(NORTH,EAST,WEST,NORTHEAST,NORTHWEST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.x+=pick(dir_list)
								else A.x-=pick(dir_list)
							if(src.dir==SOUTH)
							//	var/list/dir_list=list(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.x+=pick(dir_list)
								else A.x-=pick(dir_list)
							if(src.dir==WEST)
							//	var/list/dir_list=list(SOUTH,NORTH,WEST,NORTHWEST,SOUTHWEST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.y+=pick(dir_list)
								else A.y-=pick(dir_list)
							if(src.dir==EAST)
							//	var/list/dir_list=list(SOUTH,NORTH,EAST,NORTHEAST,SOUTHEAST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.y+=pick(dir_list)
								else A.y-=pick(dir_list)
						step(A,src.dir)
						A.pixel_y=rand(1,5)
						A.pixel_x=rand(1,5)
						if(prob(35))step(A,src.dir)
						else
							if(prob(35))step(A,src.dir)
							else ..()
						flick("punchl",src)
						view(src) << sound('Sounds/Skill_BigRoketFire.wav',0,0,0,50)
						sleep(2)
						var/obj/B = new/obj/MiscEffects/Morning_Peacock(src.loc)
						B.Owner=src
						B.damage=Jutsu.damage
						B.dir=src.dir
						if(prob(50))
							if(src.dir==NORTH)
								//var/list/dir_list=list(NORTH,EAST,WEST,NORTHEAST,NORTHWEST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.x+=pick(dir_list)
								else B.x-=pick(dir_list)
							if(src.dir==SOUTH)
								//var/list/dir_list=list(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.x+=pick(dir_list)
								else B.x-=pick(dir_list)
							if(src.dir==WEST)
								//var/list/dir_list=list(SOUTH,NORTH,WEST,NORTHWEST,SOUTHWEST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.y+=pick(dir_list)
								else B.y-=pick(dir_list)
							if(src.dir==EAST)
								//var/list/dir_list=list(SOUTH,NORTH,EAST,NORTHEAST,SOUTHEAST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.y+=pick(dir_list)
								else B.y-=pick(dir_list)
						step(B,src.dir)
						B.pixel_y=rand(1,5)
						B.pixel_x=rand(1,5)
						if(prob(35))step(B,src.dir)
						else return
						flick("punchr",src)
						view(src) << sound('Sounds/Skill_BigRoketFire.wav',0,0,0,50)
						PTimes--
						sleep(2)
						continue
					else break
obj
	Drag
		icon='GRND.dmi'
		Dirt
			icon_state="dirtdrag"
			New()
				..()
				spawn(100)if(src)del(src)
	MiscEffects
		RisingTwinDragons
			icon='RisingTwinDragon.dmi'
			icon_state="dragon"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-33
			pixel_y=-5
			New()
				..()
				flick("RisingTwinDragon",src)
				spawn(8)if(src)del(src)
		WaterRing
			icon='GRND.dmi'
			icon_state="watering"
			density=0
			//pixel_x=-100
			pixel_y=5
		SmokeBomb
			icon='SmokeBomb.dmi'
			icon_state="fuzz"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-100
			pixel_y=-50
			New()
				flick("start",src)
				spawn(50)
					flick("disperse",src)
					spawn(5)if(src)del(src)
				..()
		Smoke
			icon='Smoke.dmi'
			icon_state="smoke"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-10
			New()
				..()
				flick("smoke",src)
				spawn(12)if(src)del(src)
		Chakra
			icon='Chakra.dmi'
			icon_state="chakra"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-33
			pixel_y=-5
			New()
				..()
				flick("chakra",src)
				spawn(8)if(src)del(src)
		Palms68
			icon='50Palms.dmi'
			icon_state="done"
			New()
				..()
				flick("start",src)
				spawn(200)
					flick("start",src)
					view(src)<<sound('charge.wav',0,0)
					spawn(100)
						flick("over",src)
						spawn(7)if(src)del(src)
		MeteorDust
			icon='MeteorPunch.dmi'
			icon_state="max"
			density=0
			layer=MOB_LAYER+1
			//pixel_x=-10
			New()
				if(src.level==1)src.icon_state="0"
				if(src.level==2)src.icon_state="1"
				if(src.level==3)src.icon_state="2"
				if(src.level==4)src.icon_state="3"
				flick("[src.icon_state]",src)
				spawn(5)if(src)del(src)
				..()
		Morning_Peacock
			icon='MorningPeacock.dmi'
			icon_state=""
			density=0
			layer=MOB_LAYER+1
			pixel_x=-28
			pixel_y=-10
			New()
				flick("[src.icon_state]",src)
				spawn(1)AI()
				spawn(7)
					if(!src.Hit)if(src)del(src)
					else src.loc=null
				..()
			proc/AI()
				var/mob/Owner=src.Owner
				while(src)
					sleep(1)
					if(!src.Hit)
						for(var/mob/c_target in range(src,1))
							if(c_target<>Owner)
								if(c_target.dead==0)
									if(c_target.fightlayer==src.fightlayer)
										src.Hit=1
										//if(prob(35))
										//	if(istype(c_target,/mob/NPC))
										//		..()
										//	else
										//		c_target.Linkage=src
										//		c_target.overlays+=/obj/Projectiles/Effects/OnFire
										//		c_target.burn=3
										//		spawn(50)
										//			if(c_target)
										//				c_target.BurnEffect(Owner)
										var/undefendedhit=round(((src.damage+Owner.strength+Owner.strength)/3.5)-(c_target.defence/10))
										if(undefendedhit<0)undefendedhit=1
										c_target.health-=undefendedhit
										var/colour = colour2html("white")
										F_damage(c_target,undefendedhit,colour)
										c_target.injutsu=1
										c_target.canattack=0
										c_target.firing=1
										if(c_target.client)spawn(1)c_target.ScreenShake(1)
										if(c_target.health<=0)
											c_target.Death(Owner)
											if(src)del(src)
										else
											spawn(11)
												if(c_target)
													c_target.injutsu=0
													c_target.canattack=1
													c_target.firing=0
												if(src)del(src)
										break
						for(var/obj/Training/T in range(src,1))
							if(T.health>=1)
								src.Hit=1
								var/undefendedhit=round((src.damage+Owner.strength+Owner.strength)/3.5)
								T.health-=undefendedhit
							//	if(prob(50))
								//	var/colour = colour2html("white")
								//	F_damage(T,undefendedhit,colour)
								//Owner.strengthexp++
								//Owner.strengthexp++
								spawn()Owner.Levelup()
								//view(src) << sound('Sounds/Skill_MashHit.wav',0,0,0,10)
								T.Break(Owner)
								break
						sleep(2)
						continue
					else break
		LeafWhirl
			icon='LeafWhirlwind.dmi'
			icon_state=""
			density=0
			layer=MOB_LAYER+1
			pixel_x=-40
			//pixel_y=-10
			New()
				flick("[src.icon_state]",src)
				spawn(10)if(src)del(src)
				..()
		LogT
			icon='MiscEffects.dmi'
			icon_state="logt"
			layer=MOB_LAYER+2
			pixel_y=32
		LogB
			icon='MiscEffects.dmi'
			icon_state="logb"
			density=1
			New()
				..()
				src.overlays+=/obj/MiscEffects/LogT/
				spawn(80)if(src)del(src)
mob/player
	verb
		Attack()
			set hidden=1
			if(src.sheilded==1)
				if(src.Clan == "Sand"&&canattack)
					canattack=0
					spawn(15) canattack=1
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Sand Sheild.dmi'
					O.icon_state = "spike"
					O.pixel_x=-32
					O.layer=12
					O.layer=MOB_LAYER+100
					var/PL = list()
					for(var/mob/PO in orange(1))PL+=PO
					if(length(PL)<>0)
						var/mob/W = pick(PL)
						src.Target_Atom(W)
						src.dir = get_dir(src,W)
					step(O,src.dir)
					if(O.dir == NORTH)O.layer = OBJ_LAYER
					spawn(2)if(O)del(O)
					for(var/mob/M in orange(1,O))
						if(M <> src)
							F_damage(M,src.ninjutsu/2)
							M.health-=src.ninjutsu/2
							M.Levelup()
							M.Death(src)
				return
			if(src.incalorie==1&&usr.Clan=="Akimichi")
				src.Meteor_Punch()
			if(ChakraCheck(0)) return
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(SC.canattack==1)
					SC.canattack=0
					if(SC.icon_state<>"blank")
						if(SC.Hand=="Left")
							flick("punchl",SC)
							SC.Hand="Right"
						else
							if(SC.Hand=="Right")
								flick("punchr",SC)
								SC.Hand="Kick"
							else
								if(SC.Hand=="Kick")
									flick("kick",SC)
									SC.Hand="Left"
					view(SC,10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					spawn(2)
						for(var/mob/C in orange(SC,1))
							SC.dir = get_dir(SC,C)
							for(var/mob/c_target in get_step(SC,SC.dir))
								if(c_target in get_step(SC,SC.dir))
									if(c_target.dead==0&&!istype(c_target,/mob/NPC/)&&c_target!=SC.Owner)
										if(c_target.fightlayer==SC.fightlayer)
											if(c_target.client)spawn()c_target.ScreenShake(1)
											if(c_target.dodge==0)
												var/undefendedhit=round((2.5+(SC.strength/10))-(c_target.defence/10)+(rand(10)/10))
												if(undefendedhit<0)undefendedhit=1
												c_target.health-=undefendedhit
												var/colour = colour2html("white")
												F_damage(c_target,undefendedhit,colour)
												if(SC.loc.loc:Safe!=1) LevelStat("Strength",rand(1,3))
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												c_target.Levelup()
												src.Levelup()
												if(SC.Hand=="Left")view(SC,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(SC.Hand=="Right")view(SC,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
												c_target.Death(src)

											else
												if(SC.agility>=c_target.agility)
													var/defendedhit=SC.strength-c_target.defence
													if(defendedhit<0)defendedhit=1

													src.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
													if(defence<SC.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,SC.dir)
														c_target.dir = get_dir(c_target,SC)
														step_to(SC,c_target,1)
													var/colour = colour2html("white")
													F_damage(c_target,defendedhit,colour)
													c_target.health-=defendedhit
													c_target.Levelup()
													flick("defendhit",c_target)
													view(SC,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
													c_target.Death(src)

												else
													flick("dodge",c_target)
													var/colour = colour2html("white")
													F_damage(c_target,0,colour)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
													c_target.Levelup()
							break
						for(var/obj/Training/T in get_step(SC,SC.dir))
							if(T.health>=1)
								var/undefendedhit=round(SC.strength)//-T.defence/4)
								T.health-=undefendedhit
							//	var/colour = colour2html("white")
							//	F_damage(T,undefendedhit,colour)
								if(T) if(T.Good) LevelStat("Strength",rand(2,4))
								else LevelStat("Strength",rand(0.4,1))
								src.Levelup()
								if(SC.Hand=="Left")view(SC,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
								if(SC.Hand=="Right")view(SC,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
								T.Break(src)
					spawn(src.attkspeed)
						//src.move=1
						if(SC)SC.canattack=1
			if(src.canattack==1&&!src.likeaclone&&!dead&&!rest)
				var/mob/c_target2=src.Target_Get(TARGET_MOB)
				if(c_target2)src.dir = get_dir(src,c_target2)
				else
					src.Target_A_Mob()
					var/mob/c_target23=src.Target_Get(TARGET_MOB)
					if(c_target23)src.dir = get_dir(src,c_target23)
				var/mob/M  = src.puppets[1]
				if(M)
					M.loc = src.loc
					M.dir = src.dir
					step(M,src.dir)
					spawn(1)
						step(M,src.dir)
						spawn(1)step(M,src.dir)
					var/obj/A = new/obj/MiscEffects/Smoke(M.loc)
					A.loc=M.loc
				src.canattack=0
				if(src.icon_state<>"blank")
					if(src.byakugan==1)
						var/PL = list()
						for(var/mob/PO in orange(1))PL+=PO
						if(length(PL)<>0)
							var/mob/W = pick(PL)
							src.Target_Atom(W)
							src.dir = get_dir(src,W)
					if(src.gates[4])
						var/mob/W=src.Target_Get(TARGET_MOB)
						if(W)
							src.dir = get_dir(src,W)
							src.loc = W.loc
							step(src,W.dir)
							src.dir = get_dir(src,W)
							var/obj/SH = new/obj
							SH.loc = src.loc
							SH.icon = 'Shunshin.dmi'
							flick("fl",SH)
							spawn(3)if(SH)del(SH)
					if(src.Hand=="Left")
						if(Specialist=="strength"||Specialist2=="strength")combo++
						if(src.Clan <> "Sand")
							flick("punchl",src)
							if(src.bugpass)
								var/obj/O = new/obj
								O.loc = src.loc
								O.icon = 'Insect Cocoon.dmi'
								O.pixel_x=-16
								O.icon_state = ""
								O.dir = src.dir
								O.layer = MOB_LAYER+1
								flick("punchl",O)
								var/obj/O2 = new/obj
								O2.loc =src.loc
								step(O2,src.dir)
								for(var/mob/Mv in orange(O2))if(Mv <> src)step_to(Mv,O2)
								spawn(5)
									if(O)del(O)
									if(O2)del(O2)
						src.Hand="Right"
						if(src.Clan == "Sand")
							var/obj/SAND = new/obj
							SAND.loc = src.loc
							SAND.layer = src.layer+1
							SAND.dir = src.dir
							SAND.pixel_x=-16
							flick('Sand Attack 1.dmi',SAND)
							spawn(4)if(SAND)del(SAND)
						for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("punchl",C)
					else
						if(src.Hand=="Right")
							if(src.Clan <> "Sand")
								flick("punchr",src)
								if(src.bugpass)
									var/obj/O = new/obj
									O.loc = src.loc
									O.icon = 'Insect Cocoon.dmi'
									O.pixel_x=-16
									O.icon_state = ""
									O.dir = src.dir
									O.layer = MOB_LAYER+1
									flick("punchr",O)
									var/obj/O2 = new/obj
									O2.loc =src.loc
									step(O2,src.dir)
									for(var/mob/Mv in orange(O2))if(Mv <> src)step_to(Mv,O2)
									spawn(5)
										if(O)del(O)
										if(O2)del(O2)
							if(Specialist=="strength"||Specialist2=="strength")
								src.Hand="Kick"
								combo++
							else src.Hand="Left"
							if(src.Clan == "Sand")
								var/obj/SAND = new/obj
								SAND.loc = src.loc
								SAND.layer = src.layer-1
								SAND.dir = src.dir
								SAND.pixel_x=-16
								flick('Sand Attack 2.dmi',SAND)
								spawn(4)if(SAND)del(SAND)
							if(src.byakugan==1)
								var/obj/GF = new/obj
								GF.loc = src.loc
								GF.layer=200
								GF.dir = src.dir
								GF.icon = 'PressurePoint.dmi'
								for(var/obj/Jutsus/Byakugan/J in src.JutsusLearnt)
									if(J.level == 4)flick('GentleFist.dmi',GF)
									else flick("[J.level]",GF)
								switch(src.dir)
									if(WEST) GF.pixel_x=-16
								spawn(4)if(GF)del(GF)
							if(src.mystical_palms==1)
								var/obj/GF = new/obj
								GF.loc = src.loc
								GF.layer=200
								GF.dir = src.dir
								GF.icon = 'PressurePoint.dmi'
								flick('GentleFist.dmi',GF)
								switch(src.dir)if(WEST) GF.pixel_x=-16
								spawn(4)if(GF)del(GF)
							for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("punchr",C)
						else
							if(src.Hand=="Kick")
								if(Specialist=="strength"||Specialist2=="strength")combo++
								flick("kick",src)
								src.Hand="Left"
								for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("kick",C)
				view(src,10) << sound('Sounds/Swing5.ogg',0,0,0,100)
				if(src.agility<50)
					spawn(2)
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
									var/canhityou=1
									if(c_target.Clan == "Sand")
										var/blockchance = rand(1,3)
										if(c_target.dir == get_dir(c_target,src))blockchance = rand(1,2)
										if(blockchance==1)
											var/obj/AW = new/obj
											AW.loc = c_target.loc
											AW.dir = c_target.dir
											AW.pixel_x=-16
											AW.layer = MOB_LAYER+1
											var/obj/AW2 = new/obj
											AW2.loc = c_target.loc
											AW2.dir = c_target.dir
											AW2.pixel_x=-16
											AW2.layer = MOB_LAYER-1
											AW.icon = 'sand block.dmi'
											AW2.icon = 'sand block.dmi'
											flick("over player",AW)
											flick("under player",AW2)
											canhityou=0
											spawn(3)
												if(AW)del(AW)
												if(AW2)del(AW2)
									if(c_target.fightlayer==src.fightlayer && canhityou==1)
										if(c_target.client)	spawn()c_target.ScreenShake(1)
										if(c_target.dodge==0)
											var/bonus=0
											if(src.gates[1])bonus=10
											if(src.gates[2])
												bonus=15
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "0"
											if(src.gates[3])
												bonus=20
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "1"
											if(src.gates[4])
												bonus=25
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "2"
											if(src.gates[5])
												bonus=30
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "max"
											if(bugpass)bonus+=3
											if(Sharingan)bonus+=Sharingan
											if(src.mystical_palms)bonus+=5
											bonus+=src.bonesword
											var/undefendedhit=(2.5+(src.strength/10))-(c_target.defence/10)+(rand(10)/10)+bonus
											if(undefendedhit<0)undefendedhit=1
											if(c_target.Sharingan)
												if(prob((c_target.agility*2)-(undefendedhit)+(c_target.Sharingan*5)))
													undefendedhit=1
													flick("dodge",c_target)
												else
													undefendedhit-=(c_target.Sharingan+c_target.agility)
													if(undefendedhit<0) undefendedhit=1
													flick("defend",c_target)
											c_target.health-=undefendedhit
											var/colour = colour2html("white")
											F_damage(c_target,undefendedhit,colour)
											if(src.loc.loc:Safe!=1) LevelStat("Strength",rand(1,3))
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											c_target.Levelup()
											src.Levelup()
											if(src.Hand=="Right")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Kick")
												bonus+=2
												spawn(1)
													if(!c_target) return
													if(c_target.chakra<>0 && src.byakugan==1)
														for(var/obj/Jutsus/Byakugan/J in src.JutsusLearnt)
															c_target.chakra-=J.level*5+round(src.ninjutsu/2)
															var/colourz = colour2html("aliceblue")
															F_damage(c_target,J.level*5+round(src.ninjutsu/2),colourz)
												view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											if(src.Hand=="Left")view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
											if(src.gates[5]&&move&&!injutsu)
												c_target.icon_state="push"
												c_target.injutsu=1
												c_target.canattack=0
												c_target.firing=1
												step_away(c_target,src)
												walk(c_target,c_target.dir)
												if(c_target.client)spawn() c_target.ScreenShake(3)
												spawn(3)
													if(c_target)
														walk(c_target,0)
														c_target.injutsu=0
														if(!c_target.swimming)c_target.icon_state=""
														c_target.canattack=1
														c_target.firing=0
														c_target.Death(src)
											if(bonesword)
												if(c_target.icon_state == "")
													c_target.move=0
													spawn(bonesword)if(c_target)c_target.move=1
											c_target.Death(src)
										else
											if(src.agility>=c_target.agility || src.gates[3])
												var/bonus=0
												if(src.gates[1])bonus=2
												if(src.gates[2])bonus=4
												if(src.gates[3])bonus=6
												if(src.gates[4])bonus=8
												if(src.gates[5])bonus=10
												if(src.mystical_palms)bonus+=5
												if(bugpass)bonus+=3
												bonus+=src.bonesword
												var/defendedhit=(1+(src.strength/10))-(c_target.defence/10)+(rand(10)/10)+bonus
												if(defendedhit<0)defendedhit=1
												// WHY WHY WHY ? if(src.loc.loc:Safe!=1) src.strength++
												src.Levelup()
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												var/colour = colour2html("white")
												F_damage(c_target,defendedhit,colour)
												c_target.health-=defendedhit
												if(bonesword)
													if(c_target.icon_state == "")
														c_target.move=0
														spawn(bonesword)if(c_target)c_target.move=1
												c_target.Levelup()
												flick("defendhit",c_target)
												view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
												c_target.Death(src)
											else
												flick("dodge",c_target)
												var/colour = colour2html("white")
												F_damage(c_target,0,colour)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
												c_target.Levelup()
						for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(src.strength)//-T.defence/4)
								T.health-=undefendedhit
							//	var/colour = colour2html("white")
							//	F_damage(T,undefendedhit,colour)
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								src.Levelup()
								if(src.Hand=="Right")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Kick")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
								if(src.Hand=="Left")view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
								T.Break(src)
				else
					if(src.agility>=50)
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
									var/canhityou=1
									if(c_target.Clan == "Sand")
										var/blockchance = rand(1,2)
										if(c_target.dir == get_dir(c_target,src))blockchance = 1
										if(blockchance==1)
											var/obj/AW = new/obj
											AW.loc = c_target.loc
											AW.dir = c_target.dir
											AW.layer = MOB_LAYER+1
											AW.pixel_x=-16
											var/obj/AW2 = new/obj
											AW2.loc = c_target.loc
											AW2.pixel_x=-16
											AW2.dir = c_target.dir
											AW2.layer = MOB_LAYER-1
											AW.icon = 'sand block.dmi'
											AW2.icon = 'sand block.dmi'
											flick("over player",AW)
											flick("under player",AW2)
											canhityou=0
											spawn(3)
												if(AW)del(AW)
												if(AW2)del(AW2)
									if(c_target.fightlayer==src.fightlayer && canhityou==1)
										if(c_target.client)spawn()c_target.ScreenShake(1)
										if(c_target.dodge==0)
											var/bonus=0
											if(src.gates[1])bonus=2
											if(src.gates[2])
												bonus=4
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "0"
											if(src.gates[3])
												bonus=6
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "1"
											if(src.gates[4])
												bonus=8
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "2"
											if(src.gates[5])
												bonus=10
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "max"
											bonus+=src.bonesword
											if(bugpass)bonus+=3
											if(Sharingan)bonus+=Sharingan
											if(src.mystical_palms)bonus+=5
											if(src.Hand=="Kick")bonus+=2
											var/undefendedhit=(2.5+(src.strength/10))-(c_target.defence/10)+(rand(10)/10)+bonus
											if(undefendedhit<0)undefendedhit=1
											if(c_target.Sharingan)
												if(prob((c_target.agility)-(undefendedhit)+(c_target.Sharingan*5)))
													undefendedhit=1
													flick("dodge",c_target)
												else
													undefendedhit-=(c_target.Sharingan+round(c_target.agility/2))
													if(undefendedhit<0) undefendedhit=1
													flick("defend",c_target)
											c_target.health-=undefendedhit
											var/colour = colour2html("white")
											F_damage(c_target,undefendedhit,colour)
											if(src.loc.loc:Safe!=1) LevelStat("Strength",rand(2,3))
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											c_target.Levelup()
											src.Levelup()
											if(src.Hand=="Right")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Kick")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											if(src.Hand=="Left")view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
											if(src.gates[5]&&move&&!injutsu)
												c_target.icon_state="push"
												c_target.injutsu=1
												c_target.canattack=0
												c_target.firing=1
												step_away(c_target,src)
												walk(c_target,c_target.dir)
												if(c_target.client)spawn() c_target.ScreenShake(3)
												spawn(3)
													if(c_target)
														walk(c_target,0)
														c_target.injutsu=0
														if(!c_target.swimming)c_target.icon_state=""
														c_target.canattack=1
														c_target.firing=0
														c_target.Death(src)
											if(bonesword)
												if(c_target.icon_state == "")
													c_target.move=0
													spawn(bonesword)if(c_target)c_target.move=1
											c_target.Death(src)
										else
											if(src.agility>=c_target.agility || src.gates[3])
												var/bonus=0
												if(src.gates[1])bonus=2
												if(src.gates[2])bonus=4
												if(src.gates[3])bonus=6
												if(src.gates[4])bonus=8
												if(src.gates[5])bonus=10
												if(src.mystical_palms)bonus+=5
												if(bugpass)bonus+=3
												bonus+=src.bonesword
												var/defendedhit=(1+(src.strength/10))-(c_target.defence/10)+(rand(10)/10)+bonus
												if(defendedhit<0)defendedhit=1
												//if(src.loc.loc:Safe!=1) src.strength++
												src.Levelup()
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												var/colour = colour2html("white")
												F_damage(c_target,defendedhit,colour)
												c_target.health-=defendedhit
												c_target.Levelup()
												flick("defendhit",c_target)
												view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
												if(bonesword)
													if(c_target.icon_state == "")
														c_target.move=0
														spawn(bonesword)if(c_target)c_target.move=1
												c_target.Death(src)
											else
												flick("dodge",c_target)
												var/colour = colour2html("white")
												F_damage(c_target,0,colour)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
												c_target.Levelup()
						for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(src.strength)//-T.defence/4)
								T.health-=undefendedhit
							//	var/colour = colour2html("white")
							//	F_damage(T,undefendedhit,colour)
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								src.Levelup()
								if(src.Hand=="Right")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Kick")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
								if(src.Hand=="Left")view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
								T.Break(src)
				if(Specialist=="strength"||Specialist2=="strength")
					if(src.combo==3)
						src.combo=0
						spawn(src.attkspeed)if(src)src.canattack=1
					else
						var/wait=src.attkspeed-5
						if(wait<=0)wait=2
						spawn(wait)if(src)src.canattack=1
				else spawn(src.attkspeed)if(src)src.canattack=1
mob
	proc
		Eight_Trigrams_Empty_Palm()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.firing==0&&!src.likeaclone)
					for(var/obj/Jutsus/Eight_Trigrams_Empty_Palm/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=20)
								J.Excluded=1
								if(loc.loc:Safe!=1) src.LevelStat("strength",rand(2,5))
								src.Levelup()
								src.UpdateHMB()
								J.uses++
								var/damage
								var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
								A.pixel_x=-30
								A.pixel_y=-10
								A.dir=src.dir
								if(J.level==1)
									damage=10
									A.icon_state="0"
								if(J.level==2)
									damage=15
									A.icon_state="1"
								if(J.level==3)
									damage=20
									A.icon_state="2"
								if(J.level==4)
									damage=30
									A.icon_state="max"
								if(J.level<4)
									if(loc.loc:Safe!=1) J.exp+=rand(2,5)
									J.Levelup()
								if(prob(50))flick("punchl",src)
								else flick("punchr",src)
								//src.firing=1
								view(src,10) << sound('Sounds/Skill_BigRoketFire.wav',0,0,0,100)
								var/obj/O = new/obj
								O.loc = src.loc
								O.dir = src.dir
								O.icon = 'Eight Trigrams Empty Palm.dmi'
								O.icon_state = "head"
								O.animate_movement = SYNC_STEPS
								for(var/i=1,i<4,i++)
									sleep(1)
									if(O.loc<>src.loc)
										var/obj/K = new/obj
										K.loc = O.loc
										K.dir = O.dir
										K.icon = 'Eight Trigrams Empty Palm.dmi'
										K.icon_state = "tail"
										K.animate_movement = SYNC_STEPS
										spawn(4)if(K)del(K)
									step(O,O.dir)
									for(var/mob/c_target in view(O,0))
										src.dir = get_dir(src,c_target)
										src.Target_Atom(c_target)
										if(c_target in view(O,0))
											if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
												if(c_target.fightlayer==src.fightlayer)
													if(c_target.dodge==0)
														var/undefendedhit=round(((damage+src.strength+src.strength)/3)-(c_target.defence/10))
														if(undefendedhit<0)undefendedhit=1
														c_target.health-=undefendedhit
														var/colour = colour2html("white")
														F_damage(c_target,undefendedhit,colour)
														if(loc.loc:Safe!=1) LevelStat("Strength",rand(3,9))
														if(loc.loc:Safe!=1) src.LevelStat("strength",rand(3,9))
														if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
														c_target.Levelup()
														src.Levelup()
														if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
														if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
														c_target.icon_state="push"
														c_target.injutsu=1
														c_target.canattack=0
														c_target.firing=1
														walk(c_target,src.dir)
														if(c_target.client)spawn()c_target.ScreenShake(damage)
														spawn(round(damage/2))
															if(c_target)
																walk(c_target,0)
																c_target.injutsu=0
																if(!c_target.swimming)c_target.icon_state=""
																c_target.canattack=1
																c_target.firing=0
																c_target.Death(src)
													else
														if(src.agility>=c_target.agility)
															var/defendedhit=round(((damage+src.strength+src.strength)/4))
															if(defendedhit<0)
																defendedhit=1
															//if(loc.loc:Safe!=1)src.strength++
															if(loc.loc:Safe!=1)src.LevelStat("strength",1)
															src.Levelup()
															if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
															if(defence<src.strength/3)
																var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
																Drag.dir=c_target.dir
																step(c_target,src.dir)
																c_target.dir = get_dir(c_target,src)
																step_to(src,c_target,1)
															var/colour = colour2html("white")
															F_damage(c_target,defendedhit,colour)
															c_target.health-=defendedhit
															c_target.Levelup()
															flick("defendhit",c_target)
															view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
															c_target.Death(src)
														else
															flick("dodge",c_target)
															var/colour = colour2html("white")
															F_damage(c_target,0,colour)
															if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
															if(c_target.loc.loc:Safe!=1) c_target.Levelup()
									for(var/obj/Training/T in view(O,0))
										if(T.health>=1)
											var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
											T.health-=undefendedhit
										//	var/colour = colour2html("white")
										//	F_damage(T,undefendedhit,colour)
											if(T) if(T.Good) LevelStat("Strength",rand(1,2))
											else LevelStat("Strength",rand(0.2,1))
											if(T) if(T.Good) src.LevelStat("strength",1)
											else src.LevelStat("strength",0.2)
											src.Levelup()
											if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											T.Break(src)
								del(O)
								src.JutsuCoolSlot(J)
								//spawn(5)src.firing=0
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(20).</Font>","actionoutput")
		Meteor_Punch()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.firing==0&&!src.likeaclone)
					for(var/obj/Jutsus/Meteor_Punch/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=20)
								J.Excluded=1
								if(loc.loc:Safe!=1) src.LevelStat("strength",rand(2,5))
								src.Levelup()
								src.chakra-=rand(8,20)
								src.UpdateHMB()
								var/damage
								var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
								A.pixel_x=-30
								A.pixel_y=-10
								A.dir=src.dir
								if(J.level==1)
									damage=10
									A.icon_state="0"
								if(J.level==2)
									damage=15
									A.icon_state="1"
								if(J.level==3)
									damage=20
									A.icon_state="2"
								if(J.level==4)
									damage=30
									A.icon_state="max"
								if(J.level<4)
									if(loc.loc:Safe!=1) J.exp+=rand(2,5)
									J.Levelup()
								if(prob(50))flick("punchl",src)
								else flick("punchr",src)
								//src.firing=1
								view(src,10) << sound('Sounds/Skill_BigRoketFire.wav',0,0,0,100)
								for(var/mob/c_target in get_step(src,src.dir))
									src.dir = get_dir(src,c_target)
									src.Target_Atom(c_target)
									if(c_target in get_step(src,src.dir))
										if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
											if(c_target.fightlayer==src.fightlayer)
												if(c_target.dodge==0)
													var/undefendedhit=round(((damage+src.strength+src.strength)/3)-(c_target.defence/10))
													if(undefendedhit<0)undefendedhit=1
													c_target.health-=undefendedhit
													var/colour = colour2html("white")
													F_damage(c_target,undefendedhit,colour)
													if(loc.loc:Safe!=1) LevelStat("Strength",rand(3,9))
													if(loc.loc:Safe!=1) src.LevelStat("strength",rand(3,9))
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
													c_target.Levelup()
													src.Levelup()
													if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
													if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
													c_target.icon_state="push"
													c_target.injutsu=1
													c_target.canattack=0
													c_target.firing=1
													walk(c_target,src.dir)
													if(c_target.client)spawn()c_target.ScreenShake(damage)
													spawn(damage)
														if(c_target)
															walk(c_target,0)
															c_target.injutsu=0
															if(!c_target.swimming)c_target.icon_state=""
															c_target.canattack=1
															c_target.firing=0
															c_target.Death(src)
												else
													if(src.agility>=c_target.agility)
														var/defendedhit=round(((damage+src.strength+src.strength)/4))
														if(defendedhit<0)defendedhit=1
														//if(loc.loc:Safe!=1)src.strength++
														if(loc.loc:Safe!=1)src.LevelStat("strength",1)
														src.Levelup()
														if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
														if(defence<src.strength/3)
															var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
															Drag.dir=c_target.dir
															step(c_target,src.dir)
															c_target.dir = get_dir(c_target,src)
															step_to(src,c_target,1)
														var/colour = colour2html("white")
														F_damage(c_target,defendedhit,colour)
														c_target.health-=defendedhit
														c_target.Levelup()
														flick("defendhit",c_target)
														view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
														c_target.Death(src)
													else
														flick("dodge",c_target)
														var/colour = colour2html("white")
														F_damage(c_target,0,colour)
														if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
														if(c_target.loc.loc:Safe!=1) c_target.Levelup()
								for(var/obj/Training/T in get_step(src,src.dir))
									if(T.health>=1)
										var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
										T.health-=undefendedhit
									//	var/colour = colour2html("white")
									//	F_damage(T,undefendedhit,colour)
										if(T) if(T.Good) LevelStat("Strength",rand(1,2))
										else LevelStat("Strength",rand(0.2,1))
										if(T) if(T.Good) src.LevelStat("strength",1)
										else src.LevelStat("strength",0.2)
										src.Levelup()
										if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
										if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
										T.Break(src)
								src.JutsuCoolSlot(J)
								//spawn(5)src.firing=0
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(20).</Font>","actionoutput")
		Leaf_Whirlwind()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.firing==0&&!src.likeaclone)
					for(var/obj/Jutsus/Leaf_Whirlwind/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=20)
								J.Excluded=1
								if(loc.loc:Safe!=1)src.LevelStat("strength",rand(2,5))
								src.Levelup()
								src.chakra-=rand(8,20)
								src.UpdateHMB()
								var/damage
								if(J.level==3)
									var/obj/A = new/obj/MiscEffects/LeafWhirl(src.loc)
									A.dir=src.dir
								if(J.level==1)damage=10
								if(J.level==2)damage=15
								if(J.level==3)damage=20
								if(J.level<3)
									if(loc.loc:Safe!=1) J.exp+=rand(2,5)
									J.Levelup()
								src.injutsu=1
								src.firing=1
								flick("spinkick",src)
								if(J.level==3)view(src) << sound('Sounds/wirlwind.wav',0,0,0,100)
								else view(src) << sound('Sounds/Spin.ogg',0,0,0,100)
								for(var/mob/c_target in orange(src,J.level))
									if(c_target in orange(src,J.level))
										if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
											if(c_target.fightlayer==src.fightlayer)
												if(c_target.dodge==0)
													var/undefendedhit=round(((damage+src.strength+src.strength)/3)-(c_target.defence/10))
													if(undefendedhit<0)undefendedhit=1
													c_target.health-=undefendedhit
													var/colour = colour2html("white")
													F_damage(c_target,undefendedhit,colour)
													if(loc.loc:Safe!=1) LevelStat("Strength",rand(1,3))
													if(loc.loc:Safe!=1)src.LevelStat("strength",rand(1,3))
													if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(1,2))
													c_target.Levelup()
													src.Levelup()
													view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
													c_target.icon_state="push"
													c_target.injutsu=1
													c_target.canattack=0
													c_target.firing=1
													walk(c_target,src.dir)
													if(c_target.client)spawn()c_target.ScreenShake(damage)
													spawn(damage)
														if(c_target)
															walk(c_target,0)
															c_target.injutsu=0
															if(!c_target.swimming)c_target.icon_state=""
															c_target.canattack=1
															c_target.firing=0
															c_target.Death(src)
												else
													if(src.agility>=c_target.agility)
														var/defendedhit=round(((damage+src.strength+src.strength)/4))
														if(defendedhit<0)defendedhit=1
														//if(loc.loc:Safe!=1)src.
														if(loc.loc:Safe!=1)src.LevelStat("strength",1)
														src.Levelup()
														if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(1,2))
														if(defence<src.strength/3)
															var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
															Drag.dir=c_target.dir
															step(c_target,src.dir)
															c_target.dir = get_dir(c_target,src)
															step_to(src,c_target,1)
														var/colour = colour2html("white")
														F_damage(c_target,defendedhit,colour)
														c_target.health-=defendedhit
														c_target.Levelup()
														flick("defendhit",c_target)
														view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
														c_target.Death(src)
													else
														flick("dodge",c_target)
														var/colour = colour2html("white")
														F_damage(c_target,0,colour)
														if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Agility",rand(1,2))
														c_target.Levelup()
								for(var/obj/Training/T in orange(src,J.level))
									if(T.health>=1)
										var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
										T.health-=undefendedhit
									//	var/colour = colour2html("white")
									//	F_damage(T,undefendedhit,colour)
										if(T) if(T.Good) LevelStat("Strength",rand(1,2))
										else LevelStat("Strength",rand(0.2,1))
										if(T) if(T.Good) src.LevelStat("strength",1)
										else src.LevelStat("strength",0.2)
										src.Levelup()
										view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
										T.Break(src)
								src.JutsuCoolSlot(J)
								spawn(5)if(src)src.firing=0
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(20).</Font>","actionoutput")
							spawn(10)src.injutsu=0
		Morning_Peacock()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.firing==0&&!src.likeaclone)
					for(var/obj/Jutsus/Morning_Peacock/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=20)
								J.Excluded=1
								if(loc.loc:Safe!=1)src.LevelStat("strength",rand(2,5))
								src.Levelup()
								src.chakra-=rand(8,20)
								src.UpdateHMB()
								var/damage
								if(J.level==1)damage=5
								if(J.level==2)damage=8
								if(J.level==3)damage=12
								if(J.level<3)
									if(loc.loc:Safe!=1) J.exp+=rand(2,5)
									J.Levelup()
								src.injutsu=1
								src.firing=1
								for(var/mob/c_target in get_step(src,src.dir))
									src.dir = get_dir(src,c_target)
									src.Target_Atom(c_target)
									if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												c_target.dir = get_dir(c_target,src)
												c_target.Step_Back()
												if(prob(35))
													//c_target.Linkage=src
													c_target.overlays+=/obj/Projectiles/Effects/OnFire
													c_target.burn=3
													spawn(50)if(c_target)c_target.BurnEffect(src)
												var/undefendedhit=round(((damage+src.strength+src.strength)/6.5)-(c_target.defence/10))
												if(undefendedhit<0)undefendedhit=1
												c_target.health-=undefendedhit
												var/colour = colour2html("white")
												F_damage(c_target,undefendedhit,colour)
												if(loc.loc:Safe!=1)LevelStat("Strength",rand(1,4))
												if(loc.loc:Safe!=1)src.LevelStat("strength",rand(1,3))
												if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(1,2))
												c_target.Levelup()
												src.Levelup()
												view(src) << sound('Sounds/Skill_MashHit.wav',0,0,0,50)
												c_target.injutsu=1
												c_target.canattack=0
												c_target.firing=1
												if(c_target.client)spawn()c_target.ScreenShake(1)
												spawn(11)
													if(c_target)
														c_target.injutsu=0
														c_target.canattack=1
														c_target.firing=0
														c_target.Death(src)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=round(((damage+src.strength+src.strength)/8.5))
													if(defendedhit<0)defendedhit=1
													//if(loc.loc:Safe!=1)src.strength++
													if(loc.loc:Safe!=1)src.LevelStat("strength",1)
													src.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
													if(defence<src.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													var/colour = colour2html("white")
													F_damage(c_target,defendedhit,colour)
													c_target.health-=defendedhit
													c_target.Levelup()
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
													c_target.Death(src)
												else
													flick("dodge",c_target)
													var/colour = colour2html("white")
													F_damage(c_target,0,colour)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
													c_target.Levelup()
								for(var/obj/Training/T in get_step(src,src.dir))
									if(T.health>=1)
										var/undefendedhit=round(((damage+src.strength+src.strength)/2.5))//-c_target.defence/4)
										T.health-=undefendedhit
									//	var/colour = colour2html("white")
									//	F_damage(T,undefendedhit,colour)
										if(T) if(T.Good) LevelStat("Strength",rand(1,2))
										else LevelStat("Strength",rand(0.2,1))
										if(T) if(T.Good) src.LevelStat("strength",3)
										else LevelStat("strength",0.5)
										src.Levelup()
										view(src) << sound('Sounds/Skill_MashHit.wav',0,0,0,50)
										T.Break(src)
								spawn()PunchFlick(damage,J)
								src.JutsuCoolSlot(J)
								var/wait=damage*4
								spawn(wait)if(src)
									src.firing=0
									src.injutsu=0
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(50).</Font>","actionoutput")
mob/player
	verb
		ThrowMob()
			set hidden=1
			if(ChakraCheck(0)) return
			src.HengeUndo()
			if(src.level<=4)
				src<<"Get past level 4 to use this. -This is due to some complains with underlevel'ed system."
				return
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(SC.ThrowingMob)
					if(SC.canattack==1&&SC.firing==0)
						if(SC.dead==0&&SC.dodge==0&&SC.canattack==1)
							var/mob/M=ThrowingMob
							if(!M.key)
								//src<<"You can't push non player mobs."
								return
							if(get_dist(SC,M)>1) return
							if(!M||M.dead||M.swimming) return
							flick("2fist",SC)
							view(SC) << sound('dash.wav',0,0,0,100)
							SC.ThrowingMob=null
							M.BeingThrown=null
							M.icon_state="push"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							walk(M,SC.dir)
							spawn(4)
								if(M)
									M.icon_state=""
									M.injutsu=0
									M.canattack=1
									M.firing=0
									walk(M,0)
							return
				if(SC.canattack==1&&SC.firing==0)
					if(SC.dead==0&&SC.dodge==0&&SC.canattack==1)
						for(var/mob/M in get_step(SC,SC.dir))
							if(M.dead||M.swimming) continue
							flick("punchrS",SC)
							SC.ThrowingMob=M
							M.BeingThrown=1
			else
				if(ThrowingMob)
					if(src.canattack==1&&src.firing==0)
						if(src.dead==0&&src.dodge==0&&src.canattack==1)
							var/mob/M=ThrowingMob
							if(!M.key)
								//src<<"You can't push non player mobs."
								return
							if(!M.move)
								src<<"You can not push a player while they are bound!. Fixed that you bug abusing bitches."
								return
							if(get_dist(src,M)>1) return
							if(!M||M.dead||M.swimming) return
							flick("2fist",src)
							view(src) << sound('dash.wav',0,0,0,100)
							ThrowingMob=null
							M.BeingThrown=null
							M.icon_state="push"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							walk(M,src.dir)
							spawn(4)
								if(M)
									M.icon_state=""
									M.injutsu=0
									M.canattack=1
									M.firing=0
									walk(M,0)
							return
				if(src.canattack==1&&src.firing==0)
					if(src.dead==0&&src.dodge==0&&src.canattack==1)
						for(var/mob/M in get_step(src,src.dir))
							if(M.dead||M.swimming) continue
							flick("punchrS",src)
							src.ThrowingMob=M
							M.BeingThrown=1
		Dodge()
			set hidden=1
			src.HengeUndo()
			if(src.kawarmi)
				if(usr.mark.z == usr.z)
					ChakraCheck(0)
					if(usr.dead==1) return
					if(get_dist(usr,usr.mark)>18)
						usr<<"\red <b>Your substitution was set too far away. Jutsu failed!"
						usr.mark=null
						usr.kawarmi=0
						return
					for(var/mob/M in oview(usr,13))M.Target_Remove()
					view(usr)<<sound('flashbang_explode1.wav',0,0)
					usr.mark2=usr.loc
					usr.loc=usr.mark
					usr.move=1
					usr.injutsu=0
					usr.canattack=1
					usr.Sleeping=0
					usr.kawarmi=0
					var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
					A.loc=usr.mark2
					sleep(8)
					if(src)
						var/obj/B = new/obj/MiscEffects/LogB(usr.loc)
						B.loc=usr.mark2
				else
					usr.mark=null
					usr.kawarmi=0
			if(ChakraCheck(0)) return
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(SC.canattack==1&&SC.firing==0)
					if(SC.dead==0&&SC.dodge==0&&SC.canattack==1&&SC.dashable==1&&SC.health>SC.maxhealth/3)
						view(SC) << sound('dash.wav',0,0,0,100)
						if(SC.icon_state<>"blank")flick("dash",SC)
						SC.move=1
						SC.dashable=2
						step(SC,SC.dir)
						spawn(1)if(SC)step(SC,SC.dir)
						spawn(2)if(SC)step(SC,SC.dir)
						spawn(2)if(SC)SC.dashable=0
						return
					if(SC.dodge==0&&SC.dashable==0)
						for(var/mob/C in orange(SC,1))
							SC.dir = get_dir(SC,C)
							break
						view(SC) << sound('Swing4.ogg',0,0,0,50)
						if(SC.icon_state<>"blank")SC.icon_state="defend"
						SC.dodge=1
						sleep(5)
						if(SC.dead==0)
							if(SC.icon_state<>"blank")SC.icon_state=""
							SC.dodge=0
			if(src.canattack==1&&src.firing==0&&!src.likeaclone&&!Effects["Rasengan"]&&!Effects["Chidori"]&&!Effects["Nin Training"])
				if(src.explosivetag)
					src.explosivetag=0
					for(var/obj/Projectiles/Weaponry/ExplosiveTag/ET in view(src,50))
						if(ET.damage&&ET.Owner==src)
							var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(ET.loc)
							BURN.loc=ET.loc
							var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(ET.loc)
							EXPLODE.loc=ET.loc
							var/damage=ET.damage
							view(ET)<<sound('Explo_StoneMed2.ogg',0,0)
							for(var/mob/M in view(ET,3))
								if(M.dead==0)
									var/colour = colour2html("white")
									F_damage(M,damage,colour)
									M.health-=damage
									if(istype(M,/mob/NPC))..()
									else
										M.icon_state="push"
										M.injutsu=1
										walk_away(M,ET,5,0)
										spawn(10)
											if(M)
												walk(M,0)
												M.injutsu=0
												if(M.dead==0&&!M.swimming)
													M.icon_state=""
												M.Death(src)
							ET.damage=null
							ET.icon_state="blank"
							spawn(50)if(ET)del(ET)
				if(src.kawarmi==0 && src.C3bombz==0)
					if(src.dead==0&&src.dodge==0&&src.canattack==1&&src.dashable==1&&src.health>src.maxhealth/3)
						view(src) << sound('dash.wav',0,0,0,100)
						if(src.icon_state<>"blank")flick("dash",src)
						src.dashable=2
						step(src,src.dir)
						spawn(1)if(src)step(src,usr.dir)
						spawn(2)
							if(src)step(usr,usr.dir)
							if(usr)usr.dashable=0
						//return
					if(usr.dodge==0&&usr.dashable==0)
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						if(c_target)
							usr.dir = get_dir(usr,c_target)
							usr.Target_Atom(c_target)
						view(usr) << sound('Swing4.ogg',0,0,0,50)
						if(usr.icon_state<>"blank")
							usr.icon_state="defend"
						usr.dodge=1
						for(var/mob/Clones/C in world)if(C.Owner==src)C.icon_state="defend"
						sleep(5)
						for(var/mob/Clones/C in world)if(C.Owner==src)C.icon_state=""
						if(usr.dead==0)
							if(usr.icon_state<>"blank")usr.icon_state=""
							usr.dodge=0
				else
					if(src.C3bombz)
						var/obj/O = src.C3bombz
						O.Boomz(src)
						src.C3bombz=null
mob/proc/
	Rasenshuriken()
		for(var/obj/Jutsus/Rasenshuriken/J in src.JutsusLearnt) if(J.Excluded==0)
			if(Effects["Rasengan"])
				Effects["Rasengan"]=null
				src.overlays-=image('Rasengan.dmi',"spin")
				return
			if(ChakraCheck(240)) return
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			src.icon_state="punchrS"
			var/obj/I = new/obj
			I.IsJutsuEffect=src
			if(dir!=SOUTH) I.layer=MOB_LAYER-1
			I.loc = src.loc
			I.icon = 'Rasenshuriken.dmi'
			I.pixel_y=-32
			I.pixel_x=-32
			switch(src.dir)
				if(SOUTH)
					I.pixel_y=-8
					I.layer = MOB_LAYER+1
				if(NORTH)
					I.pixel_y=5
					I.pixel_x=-12
				if(EAST)I.pixel_x=-13
				if(WEST)I.pixel_x=-11
			flick("form",I)
			spawn(3)if(I)I.icon_state = "spin"
			var/timer=0
			var/list/DIRS=list(NORTH,EAST,SOUTH,WEST)
			while(DIRS.len&&timer<15&&Effects["Rasengan"]!=4&&!Prisoned)
				timer++
				src.copy = "Rasengan"
				var/obj/A = new/obj
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.pixel_x=15
				A.pixel_y=7
				A.dir = DIRS[1]
				DIRS-=DIRS[1]
				A.layer=9999
				src.ArrowTasked = A
				sleep(17)
				if(A)del(A)
			src.icon_state=""
			I.icon_state = "form"
			I.pixel_x=0
			walk_to(I,src)
			src.move=1
			src.injutsu=0
			src.canattack=1
			src.firing=0
			if(Effects["Rasengan"]<4||Prisoned)
				del(I)
				src.copy=null
				Effects["Rasengan"]=null
				ArrowTasked=null
			else
				ArrowTasked=null
				src.copy=null
				var/rashit=0
				var/rcount=0
				while(rashit==0 && rcount <> 15)
					move=1
					rcount+=1
					if(c_target)step_towards(src,c_target)
					else step(src,src.dir)
					move=0
					var/obj/Drag/Dirt/D=new(src.loc)
					D.dir=src.dir
					for(var/mob/M in get_step(src,src.dir))
						if(M)
							flick("punchr",src)
							rashit=1
							del(I)
							M.icon_state="push"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							walk(M,src.dir)
							if(M.client)spawn(1)if(M)M.ScreenShake(10)
							spawn(10)
								if(M)
									walk(M,0)
									M.injutsu=0
									if(!M.swimming)M.icon_state=""
									M.canattack=1
									M.firing=0
									var/obj/Ex = new/obj
									Ex.icon = 'Rasenshuriken Explode.dmi'
									Ex.icon_state = "wtf"
									Ex.layer=MOB_LAYER+2
									Ex.pixel_x=-112
									Ex.loc = M.loc
									spawn(20)if(Ex)del(Ex)
									M.health-=(70*J.level)+(src.ninjutsu*5+src.strength*10)
									F_damage(M,(70*J.level)+(src.ninjutsu*5+src.strength*10))
									M.Death(src)
					sleep(1)
				if(I)del(I)
			move=1
			Effects["Rasengan"]=null
			J.Excluded=1
			J.uses++
			J.maxcooltime = 200
			src.JutsuCoolSlot(J)
			spawn()
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)
			sleep(2)
	Lariat()
		for(var/obj/Jutsus/Lariat/J in src.JutsusLearnt) if(J.Excluded==0)
			if(Effects["Chidori"])
				Effects["Chidori"]=null
				src.overlays-=image('Lariat.dmi',"hold")
				return
			if(ChakraCheck(250)) return
			if(loc.loc:Safe!=1) src.LevelStat("Taijutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			view(src) << output("<b><font color = #C0C0C0>[usr] says: L-LARIAT!!!","actionoutput")
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			src.icon_state="groundjutsuse"
			var/obj/I = new/obj
			I.IsJutsuEffect=src
			I.loc = src.loc
			I.icon = 'Lariat.dmi'
			I.icon_state = "charge"
			I.pixel_y-=32
			I.pixel_x-=16
			if(dir!=SOUTH) I.layer=MOB_LAYER+1
			var/timer
			while(timer<20&&Effects["Chidori"]<5&&!Prisoned)
				timer++
				src.copy = "Chidori"
				var/obj/A = new/obj
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.pixel_x=15
				A.pixel_y=7
				A.dir = SOUTH
				A.layer=9999
				src.ArrowTasked = A
				sleep(5)
				if(A)del(A)
			if(Effects["Chidori"]<5||Prisoned)
				del(I)
				src.copy=null
				Effects["Chidori"]=null
				ArrowTasked=null
				src.move=1
				src.injutsu=0
				src.canattack=1
				src.firing=0
				return
			ArrowTasked=null
			src.copy=null
			src.icon_state=""
			src.move=1
			src.injutsu=0
			src.canattack=1
			src.firing=0
			Effects["Chidori"]=round(J.level*8)
			src.overlays+=image('Lariat.dmi',"hold")
			J.Excluded=1
			J.uses++
			J.maxcooltime=120
			src.JutsuCoolSlot(J)
			src.move=0
			if(I)del(I)
			spawn()
				if(src)
					timer=15
					src.icon_state = "run"
					var/rashit=0
					var/rcount=0
					while(rashit==0 && rcount <> 15)
						move=1
						rcount+=1
						if(c_target)step_towards(src,c_target)
						else step(src,src.dir)
						move=0
						var/obj/Drag/Dirt/D=new(src.loc)
						D.dir=src.dir
						for(var/mob/M in get_step(src,src.dir))
							if(M)
								flick("punchr",src)
								rashit=1
								step(src,src.dir)
								if(M)
									M.health-=(85*J.level)+src.agility
									F_damage(M,(85*J.level)+src.agility)
									if(M)M.Bleed()
									if(M)M.Death(src)
						sleep(1)
					if(src)
						Effects["Chidori"]=null
						src.overlays-=image('Lariat.dmi',"hold")
						src.move=1
						src.icon_state = ""
			spawn()
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)
	Rasengan()
		for(var/obj/Jutsus/Rasengan/J in src.JutsusLearnt) if(J.Excluded==0)
			if(Effects["Rasengan"])
				Effects["Rasengan"]=null
				src.overlays-=image('Rasengan.dmi',"spin")
				return
			if(ChakraCheck(180)) return
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			src.icon_state="punchrS"
			var/obj/I = new/obj
			I.IsJutsuEffect=src
			if(dir!=SOUTH) I.layer=MOB_LAYER-1
			I.loc = src.loc
			I.icon = 'Rasengan.dmi'
			switch(src.dir)
				if(SOUTH)
					I.pixel_y=-8
					I.layer = MOB_LAYER+1
				if(NORTH)
					I.pixel_y=5
					I.pixel_x=-12
				if(EAST)I.pixel_x=-13
				if(WEST)I.pixel_x=-11
			flick("form",I)
			spawn(3)
				I.icon_state = "spin"
			var/timer=0
			var/list/DIRS=list(NORTH,EAST,SOUTH,WEST)
			while(DIRS.len&&timer<10&&Effects["Rasengan"]!=4&&!Prisoned)
				timer++
				src.copy = "Rasengan"
				var/obj/A = new/obj
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.pixel_x=15
				A.pixel_y=7
				A.dir = DIRS[1]
				DIRS-=DIRS[1]
				A.layer=9999
				src.ArrowTasked = A
				sleep(17)
				if(A)del(A)
			src.icon_state=""
			I.icon_state = "form"
			I.pixel_x=0
			walk_to(I,src)
			src.move=1
			src.injutsu=0
			src.canattack=1
			src.firing=0
			if(Effects["Rasengan"]<4||Prisoned)
				if(I)del(I)
				src.copy=null
				Effects["Rasengan"]=null
				ArrowTasked=null
			else
				ArrowTasked=null
				src.copy=null
				var/rashit=0
				var/rcount=0
				while(rashit==0 && rcount <> 15)
					move=1
					rcount+=1
					if(c_target)step_towards(src,c_target)
					else step(src,src.dir)
					move=0
					var/obj/Drag/Dirt/D=new(src.loc)
					D.dir=src.dir
					for(var/mob/M in get_step(src,src.dir))
						if(M)
							flick("punchr",src)
							rashit=1
							I.loc = M.loc
							I.icon_state = "explode"
							I.pixel_x=-16
							walk_to(I,0)
							walk_to(I,I.loc)
							var/colour = colour2html("aliceblue")
							M.health-=(40*J.level)+src.ninjutsu*10
							F_damage(M,(40*J.level)+src.ninjutsu*10,colour)
							M.Death(src)
					sleep(1)
				del(I)
			move=1
			Effects["Rasengan"]=null
			J.Excluded=1
			J.uses++
			J.maxcooltime=120
			src.JutsuCoolSlot(J)
			spawn()
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)
	Nin_Training()
		for(var/obj/Jutsus/Nin_Training/J in src.JutsusLearnt) if(J.Excluded==0)
			if(Effects["Nin Training"])
				Effects["Nin Training"]=null
				src.overlays-=image('jutsus/chakra.dmi',"chakra")  // Optional visual
				return
			if(ChakraCheck(50)) return
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			var/list/DIRS=list(NORTH,SOUTH,EAST,WEST)
			var/streak=0
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			src.overlays+=image('jutsus/chakra.dmi',"chakra")  // chakracharge
			src.icon_state="hands"
			src.copy="Nin Training"
			while(streak < 50 && !Prisoned)  // Max 20 arrows
				if(!ChakraCheck(50))
					src << "<span class='warning'>No chakra! Training ends (streak: [streak])</span>"
					src.firing=0
					break
				src.chakra -= 50  // Consume per arrow
				DIRS = list(NORTH,SOUTH,EAST,WEST)
				DIRS = rand(DIRS)
				var/obj/A = new/obj()
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.pixel_x=15
				A.pixel_y=7
				A.dir = pick(list(NORTH,SOUTH,EAST,WEST))
				A.layer=9999
				src.ArrowTasked = A
				spawn(25)  // 1.7s limit
					while(src.ArrowTasked == A)
						streak++
						src << "<span class='boldnotice'>Success! Streak: [streak]</span>"
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu", rand(5,15))
						del(A)
						src.ArrowTasked = null
						break
						sleep(1)  // Tick for press
				spawn(17)
					if(src.ArrowTasked -= A)  // "Press" = face arrow dir
						src << "<span class='warning'>Timeout! Streak: [streak]</span>"
						del(A)
						src.ArrowTasked = null
				sleep(20)
			src.copy = null
			src.icon_state=""
			src.overlays-=image('jutsus/chakra.dmi',"chakra")
			src.move=1
			src.injutsu=0
			src.canattack=1
			src.firing=0
			src << "<span class='notice'>Training done! Ninjutsu gained: [streak]</span>"
			src.ArrowTasked=null
			Effects["Nin Training"]=null
			J.Excluded = 1
			J.uses++
			J.maxcooltime = 60
			src.JutsuCoolSlot(J)
			spawn()
				J.cooltimer = J.maxcooltime
				J.JutsuCoolDown(src)
	Chidori()
		for(var/obj/Jutsus/Chidori/J in src.JutsusLearnt) if(J.Excluded==0)
			if(Effects["Chidori"])
				Effects["Chidori"]=null
				src.overlays-=image('Chidori.dmi',"hold")
				return
			if(ChakraCheck(180)) return
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			src.icon_state="groundjutsuse"
			var/obj/I = new/obj
			I.IsJutsuEffect=src
			I.loc = src.loc
			I.icon = 'Chidori.dmi'
			I.icon_state = "charge"
			I.pixel_y-=32
			I.pixel_x-=16
			if(dir!=SOUTH) I.layer=MOB_LAYER+1
			var/timer
			while(timer<20&&Effects["Chidori"]<5&&!Prisoned)
				timer++
				src.copy = "Chidori"
				var/obj/A = new/obj
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.pixel_x=15
				A.pixel_y=7
				A.dir = SOUTH
				A.layer=1000000000000000
				src.ArrowTasked = A
				sleep(5)
				if(A)del(A)
			if(Effects["Chidori"]<5||Prisoned)
				del(I)
				src.copy=null
				Effects["Chidori"]=null
				ArrowTasked=null
				src.move=1
				src.injutsu=0
				src.canattack=1
				src.firing=0
				return
			ArrowTasked=null
			src.copy=null
			src.icon_state=""
			src.move=1
			src.injutsu=0
			src.canattack=1
			src.firing=0
			Effects["Chidori"]=round(J.level*8)
			src.overlays+=image('Chidori.dmi',"hold")
			J.Excluded=1
			J.uses++
			J.maxcooltime=120
			src.JutsuCoolSlot(J)
			src.move=0
			if(I)del(I)
			spawn()
				if(src)
					timer=15
					src.icon_state = "run"
					var/rashit=0
					var/rcount=0
					while(rashit==0 && rcount <> 15)
						move=1
						rcount+=1
						if(c_target)step_towards(src,c_target)
						else step(src,src.dir)
						move=0
						var/obj/Drag/Dirt/D=new(src.loc)
						D.dir=src.dir
						for(var/mob/M in get_step(src,src.dir))
							if(M)
								flick("punchr",src)
								rashit=1
								step(src,src.dir)
								if(M)
									M.health-=(20*J.level)+src.agility*10
									F_damage(M,(20*J.level)+src.agility*10)
									if(M)M.Bleed()
									if(M)M.Death(src)
						sleep(1)
					if(src)
						Effects["Chidori"]=null
						src.overlays-=image('Chidori.dmi',"hold")
						src.move=1
						src.icon_state = ""
			spawn()
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)
	Raikiri()
		for(var/obj/Jutsus/Raikiri/J in src.JutsusLearnt) if(J.Excluded==0)
			if(Effects["Chidori"])
				Effects["Chidori"]=null
				src.overlays-=image('Chidori.dmi',"hold")
				return
			if(ChakraCheck(300)) return
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			src.icon_state="groundjutsuse"
			var/obj/I = new/obj
			I.IsJutsuEffect=src
			I.loc = src.loc
			I.icon = 'Chidori.dmi'
			I.icon_state = "charge"
			I.pixel_y-=32
			I.pixel_x-=16
			if(dir!=SOUTH) I.layer=MOB_LAYER+1
			var/timer
			while(timer<30&&Effects["Chidori"]<7&&!Prisoned)
				timer++
				src.copy = "Chidori"
				var/obj/A = new/obj
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.pixel_x=15
				A.pixel_y=7
				A.dir = SOUTH
				A.layer=9999
				src.ArrowTasked = A
				sleep(5)
				if(A)del(A)
			if(Effects["Chidori"]<7||Prisoned)
				if(I)del(I)
				src.copy=null
				Effects["Chidori"]=null
				ArrowTasked=null
				src.move=1
				src.injutsu=0
				src.canattack=1
				src.firing=0
				return
			ArrowTasked=null
			src.copy=null
			src.icon_state=""
			src.move=1
			src.injutsu=0
			src.canattack=1
			src.firing=0
			Effects["Chidori"]=round(J.level*15)
			src.overlays+=image('Chidori.dmi',"hold")
			J.Excluded=1
			J.uses++
			J.maxcooltime=120
			src.JutsuCoolSlot(J)
			src.move=0
			del(I)
			spawn()
				if(src)
					timer=15
					src.icon_state = "run"
					var/rashit=0
					var/rcount=0
					while(rashit==0 && rcount <> 15)
						move=1
						rcount+=1
						if(c_target)step_towards(src,c_target)
						else step(src,src.dir)
						move=0
						var/obj/Drag/Dirt/D=new(src.loc)
						D.dir=src.dir
						for(var/mob/M in get_step(src,src.dir))
							if(M)
								flick("punchr",src)
								rashit=1
								step(src,src.dir)
								if(M)
									M.health-=(30*J.level)+src.agility*12
									F_damage(M,(30*J.level)+src.agility*12)
									if(M)M.Bleed()
									if(M)M.Death(src)
						sleep(1)
					if(src)
						Effects["Chidori"]=null
						src.overlays-=image('Chidori.dmi',"hold")
						src.move=1
						src.icon_state = ""
			spawn()
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)
	ShishiRendan()
		for(var/obj/Jutsus/Shishi/J in src.JutsusLearnt) if(J.Excluded==0)
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(!c_target){src<<output("<font color=yellow>You need to have a Target to perform ShiShi Rendan","actionoutput");return}
			if(ChakraCheck(100)) return
			if(loc.loc:Safe!=1) src.LevelStat("Taijutsu",rand(4,8))
			src.Levelup()
			if(J.level<4)
				if(loc.loc:Safe!=1) J.exp+=rand(2,5)
				J.Levelup()
			view(src) << output("<b><font color = #C0C0C0>[usr] says: Shishi Rendan!!!","actionoutput")
			src.move=0
			src.injutsu=1
			src.canattack=0
			src.firing=1
			if(get_dist(src,c_target)>4){src<<"[c_target] need to be closer to you for that move to work!";src.move=1;return}
			src.loc=locate(c_target.x-1,c_target.y,c_target.z)
			flick("spinkick",src)
			sleep(1)
			c_target.move=0
			step(c_target,NORTH)
			spawn(2)
				if(c_target)
					step(c_target,NORTH)
					spawn(2)
						if(src)
							spawn(2)
								if(src)
									src.loc=locate(c_target.x+1,c_target.y,c_target.z)
									flick("spinkick",src)
									spawn(2)
										if(src)
											step(c_target,SOUTH)
											spawn(2)
												if(src)
													step(c_target,SOUTH)
													src.move=1
													src.firing=0
													src.injutsu=0
													src.canattack=1
													c_target.move=1
													c_target.health-=(18*J.level)+src.agility
													F_damage(c_target,(18*J.level)+src.agility)
													if(c_target)c_target.Bleed()
													if(c_target)c_target.Death(src)
													src.move=1
			spawn()
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)
