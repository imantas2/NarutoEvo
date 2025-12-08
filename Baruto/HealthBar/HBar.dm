mob
	var/tmp/list/hbar = newlist()
obj/Screen/healthbar
	name=""
	icon='HBar.dmi'
	icon_state="100"
	layer=99
	pixel_y=75
	pixel_x=15
obj/Screen/manabar
	name=""
	icon='MBar.dmi'
	icon_state="100"
	layer=99
	pixel_y=65
	pixel_x=15
obj/Screen/Bar
	name=""
	icon='Bar.dmi'
	//icon_state="100"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/LeafSymbol
	name=""
	icon='Bar.dmi'
	icon_state="leaf"
	layer=99999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/SandSymbol
	name=""
	icon='Bar.dmi'
	icon_state="sand"
	layer=99999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/WeaponSelect
	name=""
	icon='Bar.dmi'
	icon_state="blank"
	layer=99999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/Health
	name=""
	icon='Health.dmi'
	icon_state="100"
	layer=9998
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/Chakra
	name=""
	icon='ChakraB.dmi'
	icon_state="100"
	layer=9998
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/EXP
	name=""
	icon='EXPB.dmi'
	icon_state="100"
	layer=9998
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
mob
	proc
		UpdateBars()
			spawn()
				while(src)
					var/timeoff=rand(10,16)
					sleep(timeoff)
					if(src.client)
						if(LastMissionTime)LastMissionTime-=timeoff
						if(src.RestOverlays&&!rest) RestUp()
						if((src.client.inactivity/10)>=120) continue
						if(!src.key)del(src)
						if(gates[1])
							var/colour = colour2html("red")
							F_damage(src,src.health/20+1,colour)
							health-=src.health/20+1
							src.Death(src)
						for(var/obj/Screen/H in src.client.screen)
							if(istype(H, /obj/Screen/Health/)) H.icon_state="[round(src.health/src.maxhealth*100,10)]"
							if(istype(H, /obj/Screen/Chakra/)) H.icon_state="[round(src.chakra/src.maxchakra*100,10)]"
							if(istype(H, /obj/Screen/EXP/)) H.icon_state="[round(src.exp/src.maxexp*100,10)]"
		UpdateHMB()
			spawn(rand(1,10)) src.MenuUpdate()
			if(!src.henge)
				for(var/obj/Screen/O in src.hbar)
					if(istype(O,/obj/Screen/healthbar))
						src.overlays-=O
						if(health>0) O.icon_state="[round(src.health/src.maxhealth*100,10)]"
						src.overlays+=O
					if(istype(O,/obj/Screen/manabar))
						src.overlays-=O
						if(chakra>0) O.icon_state="[round(src.chakra/src.maxchakra*100,10)]"
						src.overlays+=O



