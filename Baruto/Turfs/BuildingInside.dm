mob/var/tmp/lastloc
var/list/maps = list("Hidden Leaf"=list(),"Hidden Sand"=list())
var/capmaps = list()
var/warmaps = list()
var/sandpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)
var/leafpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)

world
	proc/Capdo(LevelTo,villagea)
		sleep(6000)
		if(LevelTo in global.capmaps)
			global.capmaps -= LevelTo
			if(villagea == "Hidden Sand")
				global.maps["Hidden Sand"]+=LevelTo
				world << output("<b>The Hidden Sand has captured an area!","actionoutput")
				for(var/mob/M in world)
					if(M.client && M.village == "Hidden Sand" && M.z == LevelTo)
						M.Ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 3 EXP from the capture!","actionoutput")
						M.exp+=3
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",0.2,1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",0.2,1)
									M.Levelup()
			else
				global.maps["Hidden Leaf"]+=LevelTo
				world << output("<b>The Hidden Leaf has captured an area!","actionoutput")
				for(var/mob/M in world)
					if(M.client && M.village == "Hidden Leaf" && M.z == LevelTo)
						M.Ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 3 EXP from the capture!","actionoutput")
						M.exp+=3
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",0.2,1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",0.2,1)
									M.Levelup()
	proc/Wardo(LevelTo)
		sleep(6000)
		if(LevelTo in global.warmaps)
			global.warmaps -= LevelTo
			world << output("<center><font size=2><b>After-battle report:<br><br>Leaf points: [global.leafpoints["[LevelTo]"]]<br>Sand points: [global.sandpoints["[LevelTo]"]]","actionoutput")
			if(global.sandpoints["[LevelTo]"] >= global.leafpoints["[LevelTo]"])
				global.maps["Hidden Sand"]+=LevelTo
				world << output("<b>The Hidden Sand has won the battle!","actionoutput")
				global.sandpoints["[LevelTo]"]=0
				global.leafpoints["[LevelTo]"]=0
				for(var/mob/M in world)
					if(M.client && M.village == "Hidden Sand" && M.z == LevelTo)
						M.Ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 6 EXP from the battle!","actionoutput")
						M.exp+=6
						for(var/i=0,i<5,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",0.2,1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",0.2,1)
									M.Levelup()
			else
				global.maps["Hidden Leaf"]+=LevelTo
				world << output("<b>The Hidden Leaf has won the battle!","actionoutput")
				global.sandpoints["[LevelTo]"]=0
				global.leafpoints["[LevelTo]"]=0
				for(var/mob/M in world)
					if(M.client && M.village == "Hidden Leaf" && M.z == LevelTo)
						M.Ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 6 EXP from the battle!","actionoutput")
						M.exp+=6
						for(var/i=0,i<5,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",0.2,1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",0.2,1)
									M.Levelup()
turf
	MapWarps
		var/LevelTo
		Entered(mob/M)
			if(istype(M,/mob) && M.client)
				var/counts=0
				var/check=0
				if(M.z == 2 || M.z == 3 || M.z == 4 || M.z == 13 || M.z == 14)
					check=1
				else
					if(M.village == "Hidden Leaf" || M.village == "Hidden Sand")
						if(M.z in global.warmaps)
							check=0
							M << output("Nice try! You're not leaving this area while it's undergoing battle.","actionoutput")
						else
							if(LevelTo in global.maps["[M.village]"])
								check=1
							else
								if(LevelTo in global.warmaps)
									check=1
								else
									for(var/mob/M2 in world)
										if(M2.client && M2.village == M.village && M2.z == LevelTo)
											counts++
									if(counts >= 5)
										counts=0
										for(var/mob/M2 in world)
											if(M2.client && M2.village <> M.village && M2.z == LevelTo)
												counts++
										if(counts>=5)
											world << output("<b><font size=2>[M.village]'s capture has led to battle!","actionoutput")
											global.sandpoints["[LevelTo]"]=0
											global.leafpoints["[LevelTo]"]=0
											if(LevelTo in global.maps["Hidden Leaf"])
												global.maps["Hidden Leaf"]-=LevelTo
											if(LevelTo in global.maps["Hidden Sand"])
												global.maps["Hidden Sand"]-=LevelTo
											if(LevelTo in global.capmaps)
												global.capmaps-=LevelTo
											global.warmaps += LevelTo
											world.Wardo(LevelTo)
										else
											if(LevelTo in global.capmaps)
												check=1
											else
												world << output("<b><font size=2>[M.village] is capturing an area!","actionoutput")
												if(LevelTo in global.maps["Hidden Leaf"])
													global.maps["Hidden Leaf"]-=LevelTo
												if(LevelTo in global.maps["Hidden Sand"])
													global.maps["Hidden Sand"]-=LevelTo
												global.capmaps+=LevelTo
												world.Capdo(LevelTo,M.village)

									check=1
					else
						check=1
				if(check)
					if(M.x==world.maxx&&dir==SOUTH)
						M.x=world.maxx
						M.z=LevelTo
						counts++
					if(M.x==1&&M.dir==WEST)
						M.x=world.maxx
						M.z=LevelTo
						counts++
					if(M.x==world.maxx&&M.dir==EAST)
						M.x=1
						M.z=LevelTo
						counts++
					if(M.x==world.maxx&&M.dir==NORTH)
						M.x=1
						M.z=LevelTo
						counts++
					if(M.y==1&&M.dir==SOUTH)
						M.y=world.maxy
						M.z=LevelTo
						counts++
					if(M.y==1&&M.dir==NORTH)
						M.y=1
						M.z=LevelTo
						counts++
					if(M.y==world.maxy&&M.dir==SOUTH)
						M.y=world.maxy
						M.z=LevelTo
						counts++
					if(M.y==world.maxy&&M.dir==NORTH)
						M.y=1
						M.z=LevelTo
						counts++
					var/Owned=0
					var/list/LeafList=maps["Hidden Leaf"]
					var/list/SandList=maps["Hidden Sand"]
					if(LeafList.Find(LevelTo))
						M<<"This area is under control by the Hidden Leaf."
						Owned=1
					if(SandList.Find(LevelTo))
						M<<"This area is under control by the Hidden Sand."
						Owned=1
					if(!Owned)M<<"This area is not under control by any village."
	Warpz
		Special
			WarpToMapLoadSpawn
				Entered(mob/M)
					if(istype(M,/mob) && M.client)
						if(M.Tutorial!=5)
							M<<output("Hey, hold your horses! You haven't finished the tutorial yet. Make sure you speak with all the NPCs, and take down atleast one rogue shinobi.","actionoutput")
							if(M.lastloc)M.loc=M.lastloc
							return
						else M.Tutorial=6
						M.loc=M.MapLoadSpawn()
		layer=TURF_LAYER+1
		Senders
			var/turf/Warpz/Receivers/ToWhere
			New()
				..()
				for(var/turf/Warpz/Receivers/T in world)if(T.name == src.name) ToWhere=T
		//	icon='uparrow.dmi'
			Entered(mob/M)
				if(istype(M,/mob) && M.client && ToWhere)
					if(M.Attacked)
						M<<"You were recently in combat. Please wait to do this."
						if(M.lastloc) M.loc=M.lastloc
						return
					usr.loc = ToWhere
					step(usr,NORTH)
			T1
			T2
			T3
			T4
			T5
			T6
			T7
			T8
			T9
			T10
			Forest1
			T11
			T12
			T13
			T14
			T15
			T16
			T17
			T18
			T19
			T20
			T21
			T22
			T23
			T24
			T25
			T26
			T27
			T28
			T29
			T30
			T31
			//MIST SENDERS
			T32
			T33
			T34
			T35
			T36
			T37
			T38
			T39
			T40
			T41
			T42
			T45
			T46
			T47
			T48
			//kage senders
			//leaf
			T60
				Entered(mob/M)
					if(!M.village=="Hidden Leaf"||!M.rank=="Hokage"||!M.rank=="ANBU")
						return
			//sand
			T61
				Entered(mob/M)
					if(M.rank=="Kazekage"||M.rank=="ANBU")
						..()
					else
						return
			//mist
			T62
				Entered(mob/M)
					if(M.rank=="Mizukage"||M.rank=="ANBU")
						..()
					else
						return
			//sound
			T63
				Entered(mob/M)
					if(M.rank=="Sound Leader"||M.rank=="ANBU")
						..()
					else
						return
			T100
				Entered(mob/M)
					if(M.village != "Akatsuki")
						return
					else
						..()
		Receivers
		//	icon = 'downarrow.dmi'
			var/turf/Warpz/Receivers/ToWhere
			New()
				..()
				for(var/turf/Warpz/Senders/T in world)
					if(T.name == src.name) ToWhere=T
			Entered(mob/M)
				if(istype(M,/mob) && M.client && ToWhere)
					if(M.Attacked)
						M<<"You were recently in combat. Please wait to do this."
						if(M.lastloc) M.loc=M.lastloc
						return
					usr.loc = ToWhere
					step(usr,SOUTH)
			T1
			T2
			T3
			T4
			T5
			T6
			T7
			T8
			T9
			T10
			Forest1
			T11
			T12
			T13
			T14
			T15
			T16
			T17
			T18
			T19
			T20
			T21
			T22
			T23
			T24
			T25
			T26
			T27
			T28
			T29
			T30
			T31
			//MIST RECEIVERS
			T32
			T33
			T34
			T35
			T36
			T37
			T38
			T39
			T40
			T41
			T42
			T45
			T46
			T47
			T48
			//
			T60
			T61
			T62
			T63
			T100
	Outsides
		Fence
			icon='Fence.dmi'
			density=1
			bottom1
				icon_state="bottom1"
			bottom2
				icon_state="bottom2"
			top1
				icon_state="top1"
				layer=MOB_LAYER+1
				density=0
			top2
				icon_state="top2"
				layer=MOB_LAYER+1
				density=0
			side1
				icon_state="side1"
				layer=MOB_LAYER+1
			side2
				icon_state="side2"
				layer=MOB_LAYER+1
			side3
				icon_state="side3"
				layer=MOB_LAYER+1
			side4
				icon_state="side4"
				layer=MOB_LAYER+1
			endline1
				icon_state="endline1"
				layer=MOB_LAYER
			endline2
				icon_state="endline2"
				layer=MOB_LAYER
			endline3
				icon_state="endline3"
				layer=MOB_LAYER
			endline4
				icon_state="endline4"
				layer=MOB_LAYER
	BuildingInsides
		icon='building insides.dmi'
		door
			doortop
				icon_state = "doortop"
			doorbottom
				icon_state = "doorbottom"
		Wall
			density=1
			name="Wall"
			Wall
				icon_state="wallbottom"
			Walltop
				icon_state="walltop"
			Walltop1
				icon_state="walltop1"
			Walltop2
				icon_state="walltop2"
			Wallbottom1
				icon_state="wallbottom1"
			Wallbottom2
				icon_state="wallbottom2"
		WallSides
			density=1
			name="Wall"
			WallSide1
				icon_state="wallside1"
			TopCorner1
				icon_state="topcorner1"
			WallBorderTop
				icon_state="wallbordertop"
			Wall2BorderTop
				icon_state="wallbordertop2"
			TopCorner2
				icon_state="topcorner2"
			TopCorner3
				icon_state="topcorner3"
			TopCorner4
				icon_state="topcorner4"
			WallSide2
				icon_state="wallside2"
			SideBottom1
				icon_state="sidebottom1"
			SideBottom2
				icon_state="sidebottom2"
			Top2Corner1
				icon_state="2topcorner1"
			Top2Corner2
				icon_state="2topcorner2"
			Top2Corner3
				icon_state="2topcorner3"
			Top2Corner4
				icon_state="2topcorner4"
		Floors
			name="Floor"
			Floor
				icon_state="floor"
			Floor2
				icon_state="floor2"
			ChuuninTile
				icon='GRND.dmi'
				icon_state="Chewnin exam tile"
		Desk
			layer=MOB_LAYER-1
			density=1
			Desk1
				icon_state="desk1"
			Desk2
				icon_state="desk2"
			Desk3
				icon_state="desk3"
		Doors
			Doortop
				icon_state="doortop"
			Doorbottom
				icon_state="doorbottom"
		Bed
			icon='HouseObjs.dmi'
			Bottom
				icon_state="Bed1B"
			Top
				icon_state="Bed1T"
				density=1
			Sheet
				icon_state="Bed1Sheet"
				layer=MOB_LAYER+5
