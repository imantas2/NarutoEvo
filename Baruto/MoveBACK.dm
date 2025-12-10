mob
	var/tmp/Sleeping=0
	var/tmp/JashinConnector
	proc/Bleed()
		var/obj/O = new/obj/bloodeffectz
		O.Owner=src
		O.loc = src.loc
		O.pixel_x=-16
		O.icon =  'blood effects.dmi'
		var/bl = rand(1,7)
		O.icon_state = "l[bl]"
		var/bf = rand(1,7)
		flick("fl[bf]",O)
		walk_to(O,src)
		spawn(3)walk_to(O,0)
obj
	bloodeffectz
		New()
			..()
			spawn(100)if(src)del(src)
	InvisOverlay
		LArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9999
			dir=WEST
			pixel_x=-64
			//New()
			//	screen_loc = "17,16"
		RArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9999
			dir=EAST
			pixel_x=64
		UArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9999
			dir=NORTH
			pixel_y=64
		DArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9999
			dir=SOUTH
			pixel_y=-64
	Blood
		FootstepL
		FootstepR
		Drag
obj
	proc
		objburn()
			spawn(1)
				var/turf/T = src.loc
				for(var/mob/M in T)
					if(!M.burn)
						if(!M.injutsu)
							M.injutsu=1
							spawn(3)if(M)M.injutsu=0
						if(M)
							for(var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J in src.owner.JutsusLearnt)
								M.burn=(J.level*3)+src.owner.ninjutsu
								M.BurnEffect(src.owner)
				src.pixel_x=-21
				src.objburn()
mob
	proc
		ChidoriUp()Effects["Chidori"]++
		RasenganUp()Effects["Rasengan"]++
		NinTrainingUp()Effects["Nin Training"]++
		do8palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(1)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					if(M.chakra<>0)M.chakra-= 250
					M.move=0
					M.injutsu=1
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					var/colour = colour2html("aliceblue")
					F_damage(M,2+(src.strength/20),colour)
					M.health-=2+(src.strength/20)
					if(loc.loc:Safe!=1)src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					spawn(3)if(M) M.injutsu=0
					M.move=1
					M.Death(src)
			src.icon_state = ""
		do16palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(1)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					if(M.chakra<>0)M.chakra-=350
					M.move=0
					M.injutsu=1
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					var/colour = colour2html("lightblue")
					F_damage(M,3+(src.strength/20),colour)
					M.health-=3+(src.strength/20)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					spawn(3) if(M) M.injutsu=0
					M.move=1
					M.chakra=0
					M.Death(src)
			src.icon_state = ""
		do32palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(1)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					if(M.chakra<>0)M.chakra-= 450
					M.move=0
					M.injutsu=1
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					var/colour = colour2html("blue")
					F_damage(M,4+(src.strength/20),colour)
					M.health-=4+(src.strength/20)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					spawn(4) if(M) M.injutsu=0
					M.move=1
					M.chakra=0
					M.Death(src)
			src.icon_state = ""
		do64palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(1)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					if(M.chakra<>0)M.chakra -= 550
					M.injutsu=1
					M.move=0
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					var/colour = colour2html("darkblue")
					F_damage(M,5+(src.strength/20),colour)
					M.health-=5+(src.strength/20)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					spawn(5)if(M)M.injutsu=0
					M.move=1
					M.Death(src)
			src.icon_state = ""
		ashbomb()
			src.copy = "waiting"
			for(var/obj/O in view())
				if(O.owner == src && O.icon == 'Smoke.dmi' && O.icon_state == "still")
					O.icon = 'FireBallA.dmi'
					O.icon_state = "dir"
					O.objburn()
					O.pixel_x=-16
					O.pixel_y-=16
					spawn(50)if(O)del(O)
			for(var/obj/A in get_step(src,src.dir))A.layer=OBJ_LAYER
		HealUp()
			var/colour = colour2html("white")
			F_damage(src,"+25",colour)
			src.health += 25
			if(health>maxhealth) health=maxhealth
		DoMirrors(obj/Os)
			if(Os)
				var/obj/O = new/obj
				O.loc = Os.loc
				O.dir = Os.dir
				O.icon = 'Shuriken.dmi'
				O.icon_state = "needle"
				O.pixel_y=16
				O.layer=200
				spawn(1)
					step(O,O.dir)
					for(var/mob/M in O.loc)
						if(M<>src)
							M.injutsu=1
							var/random=rand(1,4)
							if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
							if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
							if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
							if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
							var/colour = colour2html("lightblue")
							F_damage(M,src.ninjutsu/10,colour)
							M.health-=src.ninjutsu/10
							if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
							src.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							spawn(2) M.injutsu=0
							M.Death(src)
					spawn(1)
						step(O,O.dir)
						for(var/mob/M in O.loc)
							if(M<>src)
								M.injutsu=1
								var/random=rand(1,4)
								if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
								if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
								if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
								if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
								var/colour = colour2html("lightblue")
								F_damage(M,src.ninjutsu/10,colour)
								M.health-=src.ninjutsu/10
								if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
								src.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								spawn(2) M.injutsu=0
								M.Death(src)
						spawn(1)
							step(O,O.dir)
							for(var/mob/M in O.loc)
								if(M<>src)
									M.injutsu=1
									var/random=rand(1,4)
									if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
									if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
									if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
									if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
									var/colour = colour2html("lightblue")
									F_damage(M,src.ninjutsu/10,colour)
									M.health-=src.ninjutsu/10
									if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
									src.Levelup()
									if(M.henge==4||M.henge==5)M.HengeUndo()
									spawn(2) M.injutsu=0
									M.Death(src)
									walk_to(O,M)
									O.icon_state = "nhit"
									O.pixel_x+=rand(1,5)
									O.pixel_y+=rand(1,5)
							spawn(15)if(O)del(O)
client
	var
		tmp
			injutsu=0
			likeaclone
			copy
			cranks
			arrow
			ArrowTasked
	North()
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						flick("climb",src.mob)
						if(mob.loc.loc:Safe!=1) src.mob.LevelStat("Strength",rand(1,4))
						src.mob.Levelup()
						..()
						//step(src,NORTH)
						//return
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Nin Training") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.NinTrainingUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						src.mob.cranks++
						if(src.mob.cranks==3)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="2"
								AP.level++
						if(src.mob.cranks==6)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="3"
								AP.level++
						if(src.mob.cranks==9)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="4"
								AP.level++
						if(src.mob.cranks==12)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="5"
								AP.level++
						if(src.mob.cranks==15)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="6"
								AP.level++
						if(src.mob.cranks==18)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="7"
								AP.level++
						if(src.mob.cranks==21)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="8"
								AP.level++
					return
		else return ..()
	South()
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				flick("climb",src.mob)
				//src.Move(dir=SOUTH)
				..()
				//return
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Nin Training") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.NinTrainingUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			if(src.mob.copy == "Ashes" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ashbomb()
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="D")
					spawn()
						var/obj/EArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						EArrow.pixel_x=64
						EArrow.dir=EAST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=EArrow
						src<<EArrow
						src.mob.arrow="R"
					return
		else
			return ..()
	West()
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						flick("climb",src.mob)
						src.mob.LevelStat("Strength",rand(1,2))
						src.mob.Levelup()
						..()
				if(src.mob.arrow=="L")
					spawn()
						var/obj/EArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						EArrow.pixel_x=64
						EArrow.dir=EAST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=EArrow
						src<<EArrow
						src.mob.arrow="R"
						return
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Nin Training") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.NinTrainingUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="L")
					spawn()
						var/obj/SArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						SArrow.pixel_y=-64
						SArrow.dir=SOUTH
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=SArrow
						src<<SArrow
						src.mob.arrow="D"
					return
		else
			return ..()
	East()
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						flick("climb",src.mob)
						src.mob.LevelStat("Strength",rand(1,2))
						src.mob.Levelup()
						..()
				if(src.mob.arrow=="R")
					spawn()
						var/obj/UArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						UArrow.pixel_y=64
						UArrow.dir=NORTH
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=UArrow
						src<<UArrow
						src.mob.arrow="U"
						return
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Nin Training") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.NinTrainingUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="R")
					spawn()
						//for(var/obj/Screen/Arrow/A in src.screen)
						//	A.dir=NORTH
						var/obj/NArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=9999)
						NArrow.pixel_y=64
						NArrow.dir=NORTH
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=NArrow
						src<<NArrow
						src.mob.arrow="U"
					return
		else return ..()
	Northwest()return
	Northeast()return
	Southwest()return
	Southeast()return
mob
	proc
		Run()
			while(src)
				sleep(1)
				if(!src.dead)
					if(src.speeding>=1&&src.speeding<=20)src.speeding-=2
					else
						if(src.speeding>=20&&src.speeding<=50)src.speeding-=3
						else
							if(src.speeding>=50&&src.speeding<=100)src.speeding-=4
							else
								if(src.speeding>=100)src.speeding-=6
					if(src.speeding<= 40)
						if(!src.swimming)
							if(src.health<=src.maxhealth/4)src.speeddelay=4
							if(src.health<=src.maxhealth/3&&src.health>src.maxhealth/4)src.speeddelay=3
							if(src.health<=src.maxhealth/2&&src.health>src.maxhealth/3)src.speeddelay=2
							if(src.health>src.maxhealth/2)src.speeddelay=1.5
						else
							if(src.swimming)
								if(src.health<=src.maxhealth/3)src.speeddelay=6
								if(src.health>src.maxhealth/3)src.speeddelay=4
					else
						if(src.speeding>= 16&&src.health>=src.maxhealth/2)
							if(!src.swimming)src.speeddelay=1//.5
							else
								if(src.swimming)src.speeddelay=4
					sleep(10)
					continue
				else
					if(src.dead)break
mob
	proc
		AgilityBoost()
			if(src.agility>=1&&src.agility<25)step(src,src.dir)
//	Move()
//		..()
//		if(src.Owner)
//			var/mob/O=src.Owner
//			if(src.stepped==0)
//				if(O.strength>=1&&O.strength<25)
//					step(src,src.dir)
//					src.stepped=1
	player
		icon='MaleBase.dmi'
		//	statpanel("Inventory")
		//	stat("Ryo: ","[src.Ryo]")
		//	stat("Items: ","[src.items]/[src.maxitems]")
		//	stat(src.contents)
			//statpanel("Clothing")
			//stat("Items: ","[src.items]/[src.maxitems]")
			//stat(src.Clothes)
		//	statpanel("Jutsus")
		//	stat(src.JutsusLearnt)
			//statpanel("Clothing Collection", src.storage)
			//statpanel("Quest Items", src.QuestItems)
		pixel_x=-15
		New()
			..()
			src.overlays+=/obj/MaleParts/UnderShade
		Bump(atom/O)
			..()
			if(istype(O,/mob))
				var/mob/M=O
				if(M.fightlayer==src.fightlayer)
					if(src.henge==4||src.henge==5)src.HengeUndo()
					if(M.henge==4||M.henge==5)M.HengeUndo()
				else src.loc=M.loc
				if(Effects["Rasengan"])
					var/damage=Effects["Rasengan"]
					Effects["Rasengan"]=null
					flick("punchr",src)
					overlays-=image('Rasengan.dmi',"spin")
					overlays+=image('Rasengan.dmi',"explode")
					spawn(3) overlays-=image('Rasengan.dmi',"explode")
					M.health-=damage
					var/colour = colour2html("white")
					F_damage(M,damage,colour)
					if(M.client)spawn() M.ScreenShake(10)
					M.UpdateHMB()
					M.Death(src)
				if(Effects["Nin Training"])
					Effects["Rasengan"]=null
					flick("punchr",src)
					overlays-=image('chakra.dmi')
					overlays+=image('chakra.dmi')
					spawn(3) overlays-=image('chakra.dmi')
					var/colour = colour2html("white")
					M.UpdateHMB()
				if(Effects["Chidori"])
					var/damage=Effects["Chidori"]
					Effects["Chidori"]=null
					flick("punchr",src)
					overlays-=image('Chidori.dmi',"charge")
					overlays+=image('Chidori.dmi',"explode")
					spawn(3) overlays-=image('Chidori.dmi',"explode")
					M.health-=damage
					var/colour = colour2html("white")
					F_damage(M,damage,colour)
					if(M.client)spawn() M.ScreenShake(10)
					M.UpdateHMB()
					M.Death(src)
			if(istype(O,/obj))
				//var/obj/Obj=O
				if(src.henge==4||src.henge==5)src.HengeUndo()
			if(istype(O,/turf))
				var/turf/T=O
				src.HengeUndo()
				if(O.density&&src.icon_state=="push")
				//	O.overlays+=image('Misc Effects.dmi',O,"crack[number]")
					var/damage=rand(10,15)
					src.health-=damage
					var/colour = colour2html("white")
					F_damage(src,damage,colour)
					if(src.client)spawn() src.ScreenShake(10)
					UpdateHMB()
					Death(src)
					src.icon_state=""
				if(istype(O,/turf/Ground/Cliff/Edges/Bottom)||istype(O,/turf/Ground/Cliff))
					if(!src.copy&&O:Climbable)
						if(src.dashable==2)
							if(src.mountainkit)
								src.loc=locate(T.x,T.y,T.z)
								src.canattack=0
								src.firing=1
								src.icon_state="climbS"
								src.copy="Climb"
								src.arrow="L"
								var/obj/WArrow = image('Misc Effects.dmi',src,icon_state="arrow",layer=9999)
								WArrow.pixel_x=-64
								WArrow.dir=WEST
								src.ArrowTasked=WArrow
								src<<WArrow
							else
								if(mountainwalk)src.loc=locate(T.x,T.y,T.z)
								else ..()
					else if(src.copy=="Climb")src.loc=locate(T.x,T.y,T.z)
				else ..()
client
	Move(Loc)
		if(!mob.likeaclone)
			if(!mob.injutsu&&!mob.rest&&!mob.dead&&!mob.sheilded&&!mob.Sleeping)
				if(mob.dashable<>2)
					if(mob.move==1)
						if(mob.ThrowingMob)
							for(var/mob/player/M in world)if(M==mob.ThrowingMob)step_to(M,mob,0)
						if(mob.BeingThrown)
							for(var/mob/player/M in world)if(M.ThrowingMob==mob) M.ThrowingMob=null; mob.BeingThrown=0
						if(mob.bunshin)
							for(var/mob/Clones/C2 in world)
								if(C2.Owner==mob&&!C2.target_mob)
									step(C2,mob.dir)
									if(C2)	C2.icon_state="[mob.icon_state]"
						if(!mob.dashable)mob.dashable=1
						mob.speeding += 1
						//mob.move=0
						if(mob.swimming)
							mob.LevelStat("Strength",rand(0.1,0.2))
							mob.Levelup()
						if(mob.speeding<0)mob.speeding=0
						if(mob.speeding<=40)
							if(mob.dead==0&&mob.icon_state<>"blank"&&mob.icon_state<>"swim"&&mob.icon_state<>"climbS"&&mob.henge==0&&mob.dodge==0&&mob.rest==0)
								mob.icon_state=""
						if(mob.speeding>= 41&&mob.health>=mob.maxhealth/3)
							if(mob.dead==0&&mob.icon_state<>"blank"&&mob.icon_state<>"swim"&&mob.icon_state<>"climbS"&&mob.dodge==0)
								mob.icon_state="run"
								//mob.layer=MOB_LAYER
								var/turf/T = mob.loc
								spawn(10)
									if(mob.loc == T)
										mob.speeding=0
										mob.icon_state = ""
						mob.lastloc=mob.loc
						..()
						spawn(2)if(mob.dashable<>2)mob.dashable=0
						/*sleep(mob.speeddelay)
						if(!mob.move)mob.move=1
						switch(mob.dir)
							if(NORTH) mob.pixel_move(0,7)
							if(SOUTH) mob.pixel_move(0,-7)
							if(EAST) mob.pixel_move(7,0)
							if(WEST) mob.pixel_move(-7,0)
							if(NORTHEAST) mob.pixel_move(7,7)
							if(NORTHWEST) mob.pixel_move(-7,7)
							if(SOUTHEAST) mob.pixel_move(7,-7)
							if(SOUTHWEST) mob.pixel_move(-7,-7)*/
					else if(!mob.move)return
				else return
			else return
		else
			var/mob/Clones/SC=src.mob.likeaclone
			if(SC.ThrowingMob)for(var/mob/player/M in world) if(M==SC.ThrowingMob)step_to(M,SC,0)
			if(SC.BeingThrown)for(var/mob/player/M in world)if(M.ThrowingMob==SC) M.ThrowingMob=null; SC.BeingThrown=0
			var/Dir = get_dir(mob,Loc)
			if(!SC.dashable)SC.dashable=1
			step(SC,Dir)
			spawn(2)if(SC)if(SC.dashable<>2)SC.dashable=0
obj
	var/tmp/stepped=0
mob
	proc
		HengeUndo()
			if(src.henge)
				view(src)<<sound('flashbang_explode1.wav',0,0)
				var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
				A.loc=src.loc
				src.overlays=0
				src.henge=0
				src.UpdateHMB()
				src.Name(src.name)
				src.icon='MaleBase.dmi'
				src.icon_state=""
				src.RestoreOverlays()
				if(!jutsuaffect)src.move=1
