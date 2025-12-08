// Craignimer@live.com
mob/proc/ChakraCheck(var/CHAKRA)
	var/area/T=loc.loc
	src.HengeUndo()
	if(Sleeping) return 1
	if(T)
		if(T.Safe)
			src<<output("You're indoors, you shouldn't be doing this.","actionoutput")
			return 1
	if(Disabled)
		src<<output("Your jutsus have been disabled right now.","actionoutput")
		return 1
	if(istype(loc,/turf/Arena)&&!opponent)
		src<<output("Your jutsus have been disabled right now.","actionoutput")
		return 1
	if(Chuunins.Find(src)&&ChuuninOpponentOne!=src&&ChuuninOpponentTwo!=src)
		src<<output("You r jutsus have been disabled right now.","actionoutput")
		return
	if(!NaraTarget)
		if(src.firing==1) return 1
		if(src.canattack==0) return 1
	if(dead) return 1
	if(CHAKRA > src.chakra)
		src<<output("<Font color=Aqua>You Need More Chakra([CHAKRA]).</Font>","actionoutput")
		return 1
	if(src.CS==0)
		chakra-=CHAKRA
mob/var/tmp/C3bombz=0
mob/var/tmp/CS=0
mob/var/tmp/nagashi=0
mob
	var
		Mcontrolled=0
		tmp
			needkill=0
			immortal=0
			sbugged=0
			bugpass=0
			revived=0
			pois=0
			Rinnegan=0
mob
	proc/poisoned(mob/M)
		if(src.pois<=0) return
		src.pois-=1
		if(!M)return
		if(src.pois>0)
			src.health -= M.ninjutsu/8
			F_damage(src,M.ninjutsu/8)
			src.Death(M)
			spawn(50)src.poisoned(M)
obj
	PoisonMist
		icon = 'Poison Gas Cloud.dmi'
		pixel_x=-32
		pixel_y=-32
		var/candoit=0
		var/mob/Ownzorz
		New(mob/M)
			loc = M.loc
			dir = M.dir
			step(src,src.dir)
			step(src,src.dir)
			candoit=1
			walk(src,src.dir,2)
			Ownzorz=M
			spawn(5)if(src)del(src)
		Del()
			flick("delete",src)
			spawn(4)
				..()
		Move()
			..()
			if(candoit)
				for(var/mob/M in orange(1,src))
					if(Ownzorz)
						if(M) M.health -= Ownzorz.ninjutsu/4
						if(M) F_damage(M,Ownzorz.ninjutsu/4)
						if(M) M.Death(Ownzorz)
						if(M) M.pois=5
						if(M) M.poisoned(Ownzorz)
	ESDS
		icon = 'earth style dark swamp.dmi'
		icon_state = "center"
		New(turf/T)
			..()
			overlays+=image('earth style dark swamp.dmi',icon_state = "top",pixel_y=32)
			overlays+=image('earth style dark swamp.dmi',icon_state = "bottom",pixel_y=-32)
			overlays+=image('earth style dark swamp.dmi',icon_state = "left",pixel_x=-32)
			overlays+=image('earth style dark swamp.dmi',icon_state = "right",pixel_x=32)
			if(src)
				src.invisibility=0
				for(var/mob/M in src.loc)
					if(M.move)
						M.move=0
						spawn(10)if(M)M.move=1
				spawn(rand(10,20))if(src)del(src)
	C3bomb
		layer = MOB_LAYER
		New(mob/M)
			..()
			if(!M)del(src)
			src.loc = M.loc
			step(src,M.dir)
			src.dir = SOUTH
			pixel_x=-16
			src.icon = 'C3_small.dmi'
			spawn(2)
				if(src)
					pixel_x=-136
					src.icon = 'C3.dmi'
					src.icon_state = "arms out"
					flick("create",src)
			spawn(600)if(src)del(src)
	proc/Boomz(mob/M)
		layer = MOB_LAYER+10
		src.icon = 'Epic Explosion.dmi'
		pixel_x=-175
		orange(10,src) << sound('Exp_Dirt_01.wav')
		orange(10,src) << sound('Exp_Dirt_01.wav')
		orange(10,src) << sound('Exp_Dirt_01.wav')
		for(var/mob/M2 in orange(5,src))
			M2.health -= 100+M.ninjutsu*4
			F_damage(M2,100+M.ninjutsu*4)
			M2.Death(M)
		spawn(10)if(src)del(src)
	SmokeBOOM
		pixel_x=-134
		pixel_y=-16
		New(mob/M)
			loc = M.loc
			icon = 'Dusty Explosion.dmi'
			flick("matt lauer can suck it",src)
			spawn(54)if(src)del(src)
	New()
		..()
		spawn(600)if(name=="Wave")if(src)del(src)
atom/movable/var/byakuview=0
mob
	byakuview=1
mob/var/tmp/Susanoo=0
mob/var/tmp/bonesword=0
mob/var/tmp/jutsucopy=0
turf/var/tmp/iswater=0
mob/var/tmp/LinkFollowers=list()
mob/var/tmp/Sharingan=0
mob/var/tmp/puppets[2]//DONT TOUCH THIS OR YOULL MESS UP WHAT TOOK HOURS TO MAKE
mob/var/tmp/pdash=0
mob/var/tmp/pshoot=0
mob/var/tmp/pgrab=0
obj/var/IsJutsuEffect
obj/proc/lf2(mob/M)
	if(M)spawn(1) src.lf2(M)
	else if(src)del(src)
mob/verb
	puppetgrab1()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M && src.pgrab)
			src.pgrab=0
			for(var/mob/K in get_step(M,M.dir))
				if(K <> src && K.move==1 && K.firing==0 && K.canattack==1)
					M.loc = K.loc
					M.dir=SOUTH
					if(!M.henged) M.icon = 'Karasu.dmi'
					if(!M.henged) M.overlays=null
					if(!M.henged) M.icon_state = "Grab bottom"
					M.layer = MOB_LAYER-1
					var/obj/O
					if(!M.henged)
						O = new/obj
						O.icon_state = "Grab top"
						O.IsJutsuEffect=src
						O.layer = MOB_LAYER+1
					K.move=0
					K.canattack=0
					K.firing=1
					var/counter=50+src.ninjutsu
					while(counter && M && src)
						counter-=1
						sleep(1)
					if(!M.henged)if(O)del(O)
					M.layer = MOB_LAYER
					K.move=1
					K.canattack=1
					K.firing=0
					if(!M.henged)M.icon_state = "Idle"
	puppetgrab2()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M && src.pgrab)
			src.pgrab=0
			for(var/mob/K in get_step(M,M.dir))
				if(K <> src && K.move==1 && K.firing==0 && K.canattack==1)
					M.loc = K.loc
					M.dir=SOUTH
					if(!M.henged) M.icon = 'Karasu.dmi'
					if(!M.henged) M.overlays=null
					if(!M.henged) M.icon_state = "Grab bottom"
					M.layer = MOB_LAYER-1
					var/obj/O
					if(!M.henged)
						O = new/obj
						O.IsJutsuEffect=src
						O.icon_state = "Grab top"
						O.layer = MOB_LAYER+1
					K.move=0
					K.canattack=0
					K.firing=1
					var/counter=50+src.ninjutsu
					while(counter && M && src)
						counter-=1
						sleep(1)
					if(!M.henged)if(O)del(O)
					M.layer = MOB_LAYER
					K.move=1
					K.canattack=1
					K.firing=0
					if(!M.henged) M.icon_state = "Idle"
	puppetshoot1()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M && src.pshoot)
			src.pshoot=0
			if(!M.henged) M.icon = 'Karasu.dmi'
			if(!M.henged) M.overlays=null
			if(!M.henged) M.icon_state = "arm shooters"
			var/obj/O = new/obj/Projectiles/Effects/Puppetknife
			O.IsJutsuEffect=src
			O.loc = M.loc
			O.dir = M.dir
			O.Owner = src
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(c_target)
				walk_towards(O,c_target)
				spawn(5)if(src)
					walk_towards(O,0)
					walk(O,O.dir)
			else walk(O,M.dir)
			if(!M.henged) M.icon_state = "Idle"
	puppetshoot2()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M && src.pshoot)
			src.pshoot=0
			if(!M.henged) M.icon = 'Karasu.dmi'
			if(!M.henged) M.overlays=null
			if(!M.henged) M.icon_state = "arm shooters"
			var/obj/O = new/obj/Projectiles/Effects/Puppetknife
			O.IsJutsuEffect=src
			O.loc = M.loc
			O.dir = M.dir
			O.Owner = src
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(c_target)
				walk_towards(O,c_target)
				spawn(5)if(src)
					walk_towards(O,0)
					walk(O,O.dir)
			else walk(O,M.dir)
			if(!M.henged) M.icon_state = "Idle"
	puppetdash1()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M && src.pdash)
			if(!M.henged) M.icon_state = "dash"
			for(var/i=0,i<3+1,i++)
				step(M,M.dir)
				sleep(1)
			if(!M.henged) M.icon_state = "Idle"
	puppetdash2()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M && src.pdash)
			if(!M.henged) M.icon_state = "dash"
			for(var/i=0,i<3+1,i++)
				step(M,M.dir)
				sleep(1)
			if(!M.henged) M.icon_state = "Idle"
	puppet1north()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,NORTH)
	puppet2north()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,NORTH)
	puppet1south()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,SOUTH)
	puppet2south()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,SOUTH)
	puppet1east()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,EAST)
	puppet2east()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,EAST)
	puppet1west()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,WEST)
	puppet2west()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,WEST)
mob/var/henged
turf
	Click()
		..()
		if(usr.byakugan && src.density==0)
			if(usr.client.eye<>usr)
				usr.client.eye=usr
				usr.client:perspective = EDGE_PERSPECTIVE
				return
			usr.client.eye=src
			usr.client:perspective = EYE_PERSPECTIVE
mob/Karasu
	icon = 'Karasu.dmi'
	icon_state = "Idle"
	health=250
	pixel_x=-16
	var/OriginalIcon='Karasu.dmi'
	var/OriginalIconState="Idle"
	byakuview=0
	Move()
		..()
		if(!henged)
			icon=OriginalIcon
			icon_state=OriginalIconState
	Bump(mob/c_target)
		if(!ismob(c_target)) return
		if(src.canattack==1)
			src.canattack=0
			view(src,10) << sound('Sounds/Swing5.ogg',0,0,0,100)
			spawn(2)
				src.dir = get_dir(src,c_target)
				if(c_target.dead==0&&!istype(c_target,/mob/NPC/)&&c_target!=src.Owner)
					flick("arm shooters",src)
					if(c_target.client)spawn()c_target.ScreenShake(1)
					var/undefendedhit=round((5+(strength*1.6))-(c_target.defence/10)+(rand(10)/10))
					if(undefendedhit<0)
						undefendedhit=1
					c_target.health-=undefendedhit
					F_damage(c_target,undefendedhit)
					c_target.Death(src)
			spawn(src.attkspeed)if(src)src.canattack=1
	Click()
		if(usr.puppets[1]==src||usr.puppets[2]==src)
			if(usr.client.eye==src)
				usr.client.eye=usr
				usr.client:perspective = EDGE_PERSPECTIVE
				return
			usr.client.eye=src
			usr.client:perspective = EYE_PERSPECTIVE
		..()
	Death(mob/killer)
		if(health<=0)
			for(var/mob/M in world)
				if(!M.client) continue
				if(M.client.eye==src) M.client.eye=M
				if(M.puppets[1]==src||M.puppets[2]==src)
					if(istype(killer,/mob/NPCs/Shinobi))
						var/mob/NPCs/Shinobi/X=killer
						X.target=M
						X.Target_Atom(M)
			if(src)del(src)
	Del()
		for(var/mob/player/M in world)
			if(!M.client) continue
			if(M.client.eye==src) M.client.eye=M
		..()
mob/Susanoo
	icon = 'Susanoo Official.dmi'
	icon_state = "Idle"
	pixel_y=-200
	pixel_x=-380
	health=20
	var/mob/Ownzeez
	New(mob/M)
		..()
		src.Ownzeez=M
		src.loc = M.loc
		step(src,NORTH)
		src.dir=SOUTH
		src.health = 20
		flick("create",src)
		spawn(3)
			pixel_y=-200
			pixel_x=-380
			src.bec2()
		spawn(200)spawn(3)if(src)del(src)
	proc/tailswing()
		src.icon_state = "Idle"
		flick("Attack",src)
		view(src)<<sound('wirlwind.wav',0,0,volume=100)
		for(var/mob/M in orange(5))
			if(M.dead || M.swimming || M.key==src.name) continue
			M.injutsu=1
			var/random=rand(1,4)
			if(random==1)view(src)<<sound('Skill_BigRoketFire.wav',0,0,volume=100)
			if(random==2)view(src)<<sound('Skill_BigRoketFire.wav',0,0,volume=100)
			if(random==3)view(src)<<sound('Skill_BigRoketFire.wav',0,0,volume=100)
			if(random==4)view(src)<<sound('Skill_BigRoketFire.wav',0,0,volume=100)
			var/colour = colour2html("white")
			F_damage(M,15+Ownzeez.strength/2+Ownzeez.ninjutsu/2,colour)
			M.health-=15+Ownzeez.strength/2+Ownzeez.ninjutsu/2
			M.Bleed(M)
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(10,15))
			src.Levelup()
			if(M.henge==4||M.henge==5)M.HengeUndo()
			M.icon_state="push"
			M.injutsu=1
			M.canattack=0
			M.firing=1
			walk(M,pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST))
			if(M.client)spawn() M.ScreenShake(10)
			walk(M,0)
			M.injutsu=0
			if(!M.swimming)M.icon_state=""
			M.canattack=1
			M.firing=0
			M.Death(src)
	proc/bec2()
		while(src)
			sleep(25)
			src.icon_state = "Idle"
			var/Mobs
			for(var/mob/player/M in oview(5))if(M.key!=src.name)Mobs=1
			if(Mobs) src.tailswing()
mob/C2
	icon = 'C2.dmi'
	icon_state = "Idle"
	pixel_y=-425
	health=20
	var/mob/Ownzeez
	New(mob/M)
		..()
		src.Ownzeez=M
		src.loc = M.loc
		step(src,NORTH)
		src.dir=SOUTH
		pixel_y+=188
		pixel_x-=188
		src.health = 20
		flick("create",src)
		for(var/i=1,i<10,i++)
			var/obj/O = new/obj
			O.IsJutsuEffect=src
			O.density=1
			O.x+=i
			O.lf2(src)
		spawn(3)if(src)src.bec2()
		spawn(600)if(src)
			flick("destroy",src)
			spawn(3)if(src)del(src)
	proc/tailswing()
		src.icon_state = "Idle"
		flick("tail swing",src)
		if(!Ownzeez) return
		for(var/mob/M in orange(4))
			if(M.dead || M.swimming || M.key==src.name) continue
			M.injutsu=1
			var/random=rand(1,4)
			if(random==1)view(src)<<sound('KickHit.ogg',0,0,volume=100)
			if(random==2)view(src)<<sound('KickHit.ogg',0,0,volume=100)
			if(random==3)view(src)<<sound('KickHit.ogg',0,0,volume=100)
			if(random==4)view(src)<<sound('KickHit.ogg',0,0,volume=100)
			var/colour = colour2html("white")
			F_damage(M,10+src.Ownzeez.strength,colour)
			M.health-=10+src.Ownzeez.strength
			if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(10,15))
			src.Levelup()
			if(M.henge==4||M.henge==5)M.HengeUndo()
			M.icon_state="push"
			M.injutsu=1
			M.canattack=0
			M.firing=1
			walk(M,pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST))
			if(M.client)spawn() M.ScreenShake(5)
			spawn(4)
				if(M)
					walk(M,0)
					M.injutsu=0
					if(!M.swimming)M.icon_state=""
					M.canattack=1
					M.firing=0
					M.Death(src)
	proc/landminemake()
		var/obj/O = new/obj/Projectiles/Effects/ClayBird
		O.icon = 'C2_landmines.dmi'
		O.loc = src.loc
		O.Owner=src.Ownzeez
		O.pixel_x-=96+rand(-5,5)
		O.pixel_y-=48+rand(-5,5)
		O.name = src.name
		spawn(2)
			O.pixel_x+=20
			spawn(2)
				O.pixel_x+=20
				spawn(2)
					O.pixel_x=0
					O.pixel_y=0
					O.y-=1
					walk(O,pick(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST))
					spawn(7)
						walk(O,0)
						spawn(3)if(O)del(O)
	proc/birdmake()
		var/obj/O = new/obj/Projectiles/Effects/ClayBird(src.loc)
		O.Owner=src.Ownzeez
		O.dir = pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST)
		O.name = src.name
		O.Owner = src
		var/check=0
		for(var/mob/M in orange(10))
			if(M.key <> src.name)
				walk_towards(O,M.loc)
				check=1
		if(check==0) walk(O,O.dir)
		spawn(10)if(O)walk(O,O.dir)
	proc/createbirds()
		src.icon_state = "mouth open"
		for(var/i=1,i<5,i++)
			spawn(i)if(src)src.birdmake()
	proc/createlandmines()
		src.icon_state = "mouth open"
		for(var/i=1,i<10,i++)
			spawn(i)if(src)src.landminemake()
	proc/bec2()
		if(src)
			src.icon_state = "Idle"
			var/k = rand(1,5)
			if(k==1)src.createlandmines()
			if(k==2)src.createbirds()
			if(k==3)src.tailswing()
			if(k==4)src.tailswing()
			if(k==5)src.tailswing()
			spawn(20)if(src)src.bec2()
obj
	proc/linkfollow(mob/M)
		if(M && src)
			M.LinkFollowers+=src
			src.loc = M.loc
			spawn(1) src.linkfollow(M)
		else if(src)del(src)
	var
		tmp
			cooled=0
			hitstate
			hitsound
	watercreate
		icon = 'GRND.dmi'
		icon_state = "water"
		New()
			spawn(4)
				var/turf/T = get_step(src,NORTH)
				var/check1=0
				var/check14=0
				var/check12=0
				var/check13=0
				for(var/obj/watercreate/O in T)check1=1
				var/turf/T2 = get_step(src,SOUTH)
				for(var/obj/watercreate/O2 in T2)check12=1
				var/turf/T3 = get_step(src,EAST)
				for(var/obj/watercreate/O3 in T3)check13=1
				var/turf/T4 = get_step(src,WEST)
				for(var/obj/watercreate/O4 in T4)check14=1
				if(check14==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeR")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeL",pixel_x=-32)
				if(check13==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeL")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeR",pixel_x=32)
				if(check12==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeT")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeB",pixel_y=-32)
				if(check1==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeB")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeT",pixel_y=32)
				var/turf/Td = src.loc
				if(Td) Td.iswater=1
				spawn(200)
					if(Td)Td.iswater=0
					if(src)del(src)
	Projectiles
		New()
			..()
			spawn(76) del(src)
		icon='Jutsus.dmi'
		density=1
		Effects
			InkLions
				name="Ink Lions"
				icon='hm.dmi'
				icon_state="lion"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						src.pixel_x=-16
						src.pixel_y=-16
						flick("blow",src)
						src.Hit=1
						for(var/mob/player/M in oview(2,src))
							if(M.dead||!M) continue
							var/colour = colour2html("red")
							F_damage(M,src.damage+(Owner.ninjutsu/1),colour)
							M.health-=src.damage+(Owner.ninjutsu/1)
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(4,6))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.Death(Owner)
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,src.damage/1.3,colour)
								M.health-=src.damage/1.3
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			RTD
				name="RTD"
				icon='Shuriken.dmi'
				icon_state="RTD"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			BubbleBarrage
				name="Bubble Barrage"
				icon='Bubble Barrage.dmi'
				icon_state="bubble"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						src.pixel_x=-16
						src.pixel_y=-16
						flick("blow",src)
						src.Hit=1
						for(var/mob/player/M in oview(2,src))
							if(M.dead||!M) continue
							var/colour = colour2html("red")
							F_damage(M,src.damage+(Owner.ninjutsu/1),colour)
							M.health-=src.damage+(Owner.ninjutsu/1)
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(1,2))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.Death(Owner)
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,src.damage/1.3,colour)
								M.health-=src.damage/1.3
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			Puppetknife
				name="Knife"
				icon='Puppet Projectiles.dmi'
				icon_state="Arm knife"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					src.damage = 20
					spawn(50)if(src)del(src)
				Bump(atom/O)
					src.damage = 20
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('knife_hit1.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon_state = "NUUUUU"
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,50+Owner.ninjutsu*5,colour)
								M.health-=50+Owner.ninjutsu*5
								spawn() M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,10))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						else src.invisibility=1
						spawn(5) src.loc=locate(0,0,0)
			Balvan
				name="Balvan"
				icon='Senjuu.dmi'
				icon_state="woodbalvan"
				density=1
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 20
					spawn(50)if(src)del(src)
				Bump(atom/O)
					src.damage = 20
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M)
								src.density=0
								view(src)<<sound('knife_hit1.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,50+Owner.ninjutsu*1.5,colour)
								M.health-=50+Owner.ninjutsu*1.5
								spawn() M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						else src.invisibility=1
						spawn(5) src.loc=locate(0,0,0)
			ChakraManiper
				name="Kunai"
				icon='Multiple Chakra Kunai.dmi'
				icon_state="kunai"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			Windmill
				name="windmill"
				icon='Shuriken.dmi'
				icon_state="windmill"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			Shukakku_Spear
				name="Shukkaku Spear"
				icon='Shukakku Spear.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_y=-69
					pixel_x=-69
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 20
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7)if(O)del(O)
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								var/mob/Owner=src.Owner
								if(M.dead || M.swimming || M.key == src.name) return
								if(M.fightlayer==src.fightlayer)
									view(src)<<sound('knife_hit1.wav',0,0,volume=50)
									src.layer=MOB_LAYER+1
									if(M)
										src.loc = M.loc
										var/colour = colour2html("red")
										F_damage(M,50+src.damage+Owner.ninjutsu*6,colour)
										M.health-=50+src.damage+Owner.ninjutsu*6
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
										Owner.Levelup()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										M.Death(Owner)
			Sand_Shuriken
				name="Sand Shuriken"
				icon='Sand Shuriken.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_x=-16
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								var/mob/Owner=src.Owner
								if(M.dead || M.swimming || M.key == src.name) return
								if(M.fightlayer==src.fightlayer)
									view(src)<<sound('knife_hit1.wav',0,0,volume=50)
									src.layer=MOB_LAYER+1
									if(M)
										src.loc = M.loc
										var/colour = colour2html("red")
										if(!Owner) return
										F_damage(M,2+src.damage+Owner.ninjutsu*0.8,colour)
										M.health-=2+src.damage+Owner.ninjutsu*0.8
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,9))
										Owner.Levelup()
										if(M.henge==4||M.henge==5)M.HengeUndo()
										M.Death(Owner)
			Maniper
				name="Kunai"
				icon='Shuriken.dmi'
				icon_state="kunai"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,4))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
			SnakeC1
				name="C1 Snake"
				icon='C1Snake.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						flick("blow",src)
						src.Hit=1
						for(var/mob/player/M in oview(2,src))
							if(M.dead||!M) continue
							var/colour = colour2html("red")
							F_damage(M,src.damage+Owner.ninjutsu*2,colour)
							M.health-=src.damage+Owner.ninjutsu*2
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(8,10))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.Death(Owner)
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,src.damage+Owner.ninjutsu,colour)
								M.health-=src.damage+Owner.ninjutsu*2
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			CrystalShards
				name="Crystal Shards"
				icon='CrystalIcons.dmi'
				icon_state="shards"
				density=1
				pixel_x=-16
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(6,10))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			CrystalNeedles
				name="Crystal Needles"
				icon='CrystalIcons.dmi'
				icon_state="needles"
				density=1
				pixel_x=-16
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			lightningmask
				icon='KakuzuPuppets.dmi'
				icon_state="Lightning"
				density=1
			firemask
				icon='KakuzuPuppets.dmi'
				icon_state="Fire"
				density=1
			windmask
				icon='KakuzuPuppets.dmi'
				icon_state="Wind"
				density=1
			earthmask
				icon='KakuzuPuppets.dmi'
				icon_state="Earth"
				density=1
			mudwall
				icon='Mud Wall.dmi'
				layer=MOB_LAYER+1
				density=1
				pixel_x=-34
				pixel_y=-5
				New()
					spawn(15)
						src.icon_state="idle"
						spawn(85)
							del(src)
			shinratensei
				icon='Jutsus/shinratensei.dmi'
				layer=MOB_LAYER+10
				density=1
				pixel_x=-310
				pixel_y=-242
				New()
					spawn(20)
						del(src)
					..()
			Maniper2
				name="Shuriken"
				icon='Shuriken.dmi'
				icon_state="shuri"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(2,4))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			Maniper3
				name="Needle "
				icon='Shuriken.dmi'
				icon_state="needle"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										view(src)<<sound('knife_hit1.wav',0,0,volume=50)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,4))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
			Paper_Chakram
				name="Paper Chakram"
				icon='Paper Chakram.dmi'
				icon_state=""
				density=1
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 1
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'paperb.dmi'
					O.pixel_y=32
					O.pixel_x=-16
					step_rand(O)
					spawn(2)if(O)del(O)
					spawn(10)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								view(src)<<sound('SharpHit_Short2.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								var/colour = colour2html("red")
								F_damage(M,src.damage+Owner.strength*0.1,colour)
								if(Owner.inAngel==1)
									M.health-=src.damage+Owner.strength*0.1+Owner.strength*0.1
								else
									M.health-=src.damage+Owner.strength*0.1
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",0.2)
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
			Bug_Swarm
				name="Bug Swarm"
				icon='Bug Swarm.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_x=-16
					pixel_y=8
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(10)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								view(src)<<sound('LPunchHIt.ogg',0,0,volume=50)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								var/colour = colour2html("red")
								F_damage(M,1.5+src.damage+round(Owner.ninjutsu*1),colour)
								M.health-=1.5+src.damage+round(Owner.ninjutsu*1)
								step(M,src.dir)
								M.dir = get_dir(M,src)
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
			HunterScarab
				name="Hunter Scarab"
				icon='Destruction Bug Hunter Scarabs.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_x=-16
					pixel_y=8
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								view(src)<<sound('LPunchHIt.ogg',0,0,volume=50)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								var/colour = colour2html("red")
								F_damage(M,2+src.damage+(Owner.ninjutsu/10),colour)
								M.health-=2+src.damage+(Owner.ninjutsu/10)
								step(M,src.dir)
								M.dir = get_dir(M,src)
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
			BugTornado
				name="Bug Tornado"
				icon='AburameUltimate.dmi'
				density=1
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								view(src)<<sound('LPunchHIt.ogg',0,0,volume=50)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								var/colour = colour2html("red")
								F_damage(M,2+src.damage+(Owner.ninjutsu*2),colour)
								M.health-=2+src.damage+(Owner.ninjutsu*2)
								step(M,src.dir)
								M.dir = get_dir(M,src)
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)

			WaterShark
				name="Water Shark"
				icon='Water Shark.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					src.damage = src.level*5
					spawn(50)if(src)del(src)
				Bump(atom/O)
					src.damage = src.level*5
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('man_fs_r_mt_wat.ogg',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,src.damage+(Owner.strength*0.9)+(Owner.ninjutsu*2.5),colour)
								M.health-=src.damage+(Owner.strength*0.9)+(Owner.ninjutsu*2.5)
								M.UpdateHMB()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="push"
								M.injutsu=1
								M.canattack=0
								M.firing=1
								walk(M,pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST))
								if(M.client)spawn() M.ScreenShake(10)
								spawn(10)
									walk(M,0)
									M.injutsu=0
									if(!M.swimming)M.icon_state=""
									M.canattack=1
									M.firing=0
									M.Death(Owner)
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
				Move()
					..()
					var/obj/Projectiles/Effects/WaterDash/D=new(src.loc)
					D.dir=src.dir
			WaterDash
				name="Water Dash"
				icon='Water Dash.dmi'
				icon_state="water top"
				density=1
				New()
					..()
					overlays+=image('Water Dash.dmi',"water bottom")
					spawn(10)if(src)del(src)
			ClayBird
				name="Clay Bird"
				icon='C1.dmi'
				icon_state="Bird"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						src.pixel_x=-16
						src.pixel_y=-16
						flick("blow",src)
						src.Hit=1
						for(var/mob/player/M in oview(2,src))
							if(M.dead||!M) continue
							var/colour = colour2html("red")
							F_damage(M,src.damage+(Owner.ninjutsu/1),colour)
							M.health-=src.damage+(Owner.ninjutsu/1)
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(6,8))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.Death(Owner)
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								var/colour = colour2html("red")
								F_damage(M,src.damage/1.3,colour)
								M.health-=src.damage/1.3
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			JinraiHead
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="heady"
				density=1
				var/obj/Projectiles/Effects/JinraiCore/link
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+1
					//src.damage = src.level*3
					spawn(20)
						for(var/obj/Projectiles/Effects/JinraiCore/K in world)if(K.link == src)del K
						if(src)del(src)
				Bump(atom/O)
					//src.damage = src.level*5
					if(!src.Hit)
						for(var/obj/Projectiles/Effects/JinraiCore/K in world) if(K.link == src) K.loc=locate(0,0,0)
						for(var/obj/Projectiles/Effects/JinraiBack/K in world) if(K.link == src.link) K.loc=locate(0,0,0)
						spawn(100) for(var/obj/Projectiles/Effects/JinraiCore/K in world) if(K.link == src) del K
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.swimming) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("[src.hitstate]",src)
								src.Hit=1
								var/colour = colour2html("aliceblue")
								F_damage(M,src.damage+(Owner.ninjutsu*1.5),colour)
								M.health-=src.damage+(Owner.ninjutsu*1.5)
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
						src.loc=locate(0,0,0)
				Move()
					var/K = new/obj/Projectiles/Effects/JinraiCore(src.loc)
					K:icon = src.icon
					K:link = src
					K:dir = src.dir
					K:pixel_x = src.pixel_x
					K:pixel_y = src.pixel_y
					..()
			JinraiCore
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="beamy"
				density=1
				var/obj/Projectiles/Effects/JinraiBack/link
				Del()
					..()
					for(var/obj/Projectiles/Effects/JinraiBack/K in world) if(K.link == src) del(K)
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)if(src)del(src)
				Move()
					var/K = new/obj/Projectiles/Effects/JinraiBack(src.loc)
					K:icon = src.icon
					K:link = src
					K:dir = src.dir
					K:pixel_x = src.pixel_x
					K:pixel_y = src.pixel_y
					..()
			JinraiBack
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="flashy"
				density=1
				var/link
				pixel_y=32
				layer = MOB_LAYER+1
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+1
					spawn(20) del(src)
			AlmightyPush
				icon='APush.dmi'
				icon_state="1"
				pixel_x=-310
				pixel_y=-242
				density=0
			BoneSenHit
				icon='Jutsus.dmi'
				icon_state="bonesen"
				layer=MOB_LAYER+1
				New()
					..()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
					if(prob(50))src.pixel_y+=rand(3,5)
					else src.pixel_y-=rand(1,5)
					if(prob(50))src.pixel_x+=rand(3,6)
					else src.pixel_x-=rand(1,6)
			BoneHit
				icon='BoneYard.dmi'
				icon_state="1T"
				layer=MOB_LAYER+1
			BoneYard
				icon='BoneYard.dmi'
				icon_state="1"
				density=0
				New()
					..()
					var/list/dir_list=list(NORTH,EAST,WEST,SOUTH)
					var/list/icon_list=list("1","2","3")
					src.dir=pick(dir_list)
					src.icon_state=pick(icon_list)
					flick("[src.icon_state]R",src)
					var/obj/Top=new/obj/Projectiles/Effects/BoneHit
					Top.IsJutsuEffect=src
					Top.icon_state="[src.icon_state]T"
					Top.dir=src.dir
					src.overlays+=Top
					for(var/mob/M in view(src,0))
						if(M.client)M.injutsu=1
						else M.move=0
					spawn(2)
						var/time=text2num(src.level*10)
						src.density=1
						spawn(time)
							src.overlays=0
							del(Top)
							spawn(1)flick("[src.icon_state]S",src)
							for(var/mob/M in view(src,0))
								if(M.client)M.injutsu=0
								else M.move=1
							spawn(3)if(src)del(src)
			OnFire
				icon_state="onfire"
				pixel_y=15
				layer=MOB_LAYER+1
				luminosity=2
				pixel_x=16
			BurntSpot
				icon_state="burnt"
				density=0
				New(loc)
					..()
					var/list/dir_list=list(NORTH,EAST,WEST,SOUTH)
					src.dir=pick(dir_list)
					spawn(600)
						flick("burntfade",src)
						spawn(3)if(src)del(src)
			MediumBurntSpot
				icon='SmallExplode.dmi'
				icon_state="burnt"
				density=0
				New(loc)
					..()
					var/list/dir_list=list(NORTH,EAST,WEST,SOUTH)
					src.dir=pick(dir_list)
					spawn(600)
						flick("burntfade",src)
						spawn(3)if(src)del(src)
			SmallExplosion
				icon='SmallExplode.dmi'
				icon_state="blow"
				density=0
				layer=MOB_LAYER+2
				luminosity=3
				//pixel_x=-10
				New()
					..()
					flick("blow",src)
					spawn(6)if(src)del(src)
			Fire
				name=""
				icon_state="firesmall"
				density=0
				layer=OBJ_LAYER+1
				luminosity=2
				New(loc)
					..()
					src.overlays+=/obj/Projectiles/Effects/Fire
					src.pixel_x+=rand(1,20)
					src.pixel_x-=rand(1,20)
					src.pixel_y+=rand(1,20)
					src.pixel_y-=rand(1,20)
					spawn(rand(50,100))
						if(src.Linkage)
							var/mob/Link=src.Linkage
							Link.injutsu=0
							flick("firesmall",src)
							sleep(5)
							Link.injutsu=0
							del(src)
						else
							flick("firesmall",src)
							sleep(5)
							del(src)
					spawn()
						AI()
						AIBurn()
				proc/AI()
					if(prob(50))src.icon_state="fire"
					else src.icon_state="firesmall"
					if(prob(50))step_rand(src)
					else ..()
					if(prob(50))step_rand(src)
					else ..()
					var/obj/FB=new/obj/Projectiles/Effects/BurntSpot
					FB.IsJutsuEffect=src
					FB.loc=src.loc
					FB.pixel_x=src.pixel_x
					FB.pixel_y=src.pixel_y
				proc/AIBurn()
					while(src)
						if(src)
							var/mob/Owner=src.Owner
							if(!Owner) break
							for(var/mob/U in view(src,0))
								if(U.dead || U.swimming) continue
								if(U.dead==0)
									var/colour = colour2html("orange")
									var/damage=10+round(Owner.ninjutsu/4)
									F_damage(U,damage,colour)
									U.health-=damage
									U.UpdateHMB()
									if(U.henge==4||U.henge==5)
										U.HengeUndo()
									src.Linkage=U
									U.injutsu=1
									spawn(2)
										if(U)U.injutsu=0
										if(src)src.Linkage=0
									U.Death(Owner)
							sleep(5)
							continue
						else break
			MasterFire
				name=""
				icon_state="fire"
				density=0
				layer=OBJ_LAYER+1
				luminosity=2
				New(loc)
					..()
					src.pixel_x+=rand(1,20)
					src.pixel_x-=rand(1,20)
					src.pixel_y+=rand(1,20)
					src.pixel_y-=rand(1,20)
					src.overlays+=/obj/Projectiles/Effects/Fire
					src.overlays+=/obj/Projectiles/Effects/Fire
					var/obj/FB=new/obj/Projectiles/Effects/BurntSpot
					FB.IsJutsuEffect=src
					FB.loc=src.loc
					FB.pixel_x=src.pixel_x
					FB.pixel_y=src.pixel_y
					spawn(rand(150,250))
						flick("firesmall",src)
						sleep(5)
						del(src)
					spawn()AI()
				proc/AI()
					view(src,19) << sound('Sounds/fire/fire_small1.ogg',0,0,0,100)
					if(src.cooled<=14)
						var/obj/fire=new/obj/Projectiles/Effects/Fire(src.loc)
						var/mob/CP=src.Owner
						fire.Owner=CP
						fire.IsJutsuEffect=src
						src.cooled++
					sleep(43)
					if(src)src.AI()
			MasterFireNoSound
				name=""
				icon_state="fire"
				density=0
				layer=OBJ_LAYER+1
				luminosity=2
				New(loc)
					..()
					src.pixel_x+=rand(1,20)
					src.pixel_x-=rand(1,20)
					src.pixel_y+=rand(1,20)
					src.pixel_y-=rand(1,20)
					src.overlays+=/obj/Projectiles/Effects/Fire
					src.overlays+=/obj/Projectiles/Effects/Fire
					var/obj/FB=new/obj/Projectiles/Effects/BurntSpot
					FB.IsJutsuEffect=src
					FB.loc=src.loc
					FB.pixel_x=src.pixel_x
					FB.pixel_y=src.pixel_y
					spawn(rand(150,250))
						flick("firesmall",src)
						sleep(5)
						if(src)del(src)
					spawn()AI()
				proc/AI()
					if(src.cooled<=14)
						var/obj/fire=new/obj/Projectiles/Effects/Fire(src.loc)
						fire.IsJutsuEffect=src
						var/mob/CP=src.Owner
						fire.Owner=CP
						src.cooled++
					sleep(33)
					if(src)src.AI()
		AFireBall
			icon='FireBallA.dmi'
			icon_state="dir"
			pixel_x=-30
			hitstate="hit"
			hitsound='Exp_Dirt_01.wav'
			luminosity=5
			New()
				flick("dir",src)
				spawn(30)if(src)if(!src.Hit)del(src)
				spawn()AI()
				..()
			proc/AI()
				var/mob/Owner=src.Owner
				while(src)
					if(!src.Hit)
						for(var/mob/M in range(src,1))
							if(M<>Owner)
								if(M.dead||M.swimming||M.Owner==src.Owner)continue
								if(M.fightlayer==src.fightlayer||M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									src.Hit=1
									src.icon='FireBallAHit.dmi'
									src.pixel_x=-50
									src.density=0
									view(src)<<sound(src.hitsound,0,0,volume=50)
									src.layer=MOB_LAYER+1
									walk(src,0)
									flick("hit",src)
									var/colour = colour2html("orange")
									F_damage(M,src.damage+(Owner.ninjutsu),colour)
									M.health-=src.damage+(Owner.ninjutsu)
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,9))
									Owner.Levelup()
									if(M.henge==4||M.henge==5)M.HengeUndo()
									var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
									F1.loc=src.loc
									F1.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
									F2.loc=src.loc
									F2.x+=1
									F2.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
									F3.loc=src.loc
									F3.x-=1
									F3.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
									F4.loc=src.loc
									F4.y-=1
									F4.Owner=Owner
									M.Death(Owner)
									spawn(7)if(src)del(src)
						sleep(2)
						continue
					else break
			Bump(atom/O)
				if(!src.Hit)
					src.icon='FireBallAHit.dmi'
					src.pixel_x=-50
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead||M.swimming||M.Owner==src.Owner)if(src)del(src)
						if(M.fightlayer==src.fightlayer)
							src.density=0
							view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
							src.layer=MOB_LAYER+1
							walk(src,0)
							src.loc=O.loc
							flick("[src.hitstate]",src)
							src.Hit=1
							var/colour = colour2html("orange")
							F_damage(M,src.damage,colour)
							M.health-=src.damage
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,9))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
							F1.loc=src.loc
							F1.Owner=Owner
							var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
							F2.loc=src.loc
							F2.x+=1
							F2.Owner=Owner
							var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
							F3.loc=src.loc
							F3.x-=1
							F3.Owner=Owner
							var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
							F4.loc=src.loc
							F4.y-=1
							F4.Owner=Owner
							M.Death(Owner)
							spawn(7)if(src)del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("[src.hitstate]",src)
								src.Hit=1
								var/colour = colour2html("orange")
								F_damage(M,src.damage,colour)
								M.health-=src.damage
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,9))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
								F1.loc=src.loc
								F1.Owner=Owner
								var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
								F2.loc=src.loc
								F2.x+=1
								F2.Owner=Owner
								var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
								F3.loc=src.loc
								F3.x-=1
								F3.Owner=Owner
								var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
								F4.loc=src.loc
								F4.y-=1
								F4.Owner=Owner
								M.Death(Owner)
								spawn(7)if(src)del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj/Projectiles)&&!istype(O,/obj/Projectiles/Weaponry))
							var/obj/Projectiles/OBJ=O
							if(OBJ.fightlayer==src.fightlayer)
								src.Hit=1
								if(src.damage>OBJ.damage)
									OBJ.density=0
									view(OBJ)<<sound(OBJ.hitsound,0,0)
									walk(OBJ,0)
									flick("[OBJ.hitstate]",OBJ)
									spawn(7)if(OBJ)del(OBJ)
								else
									if(src.damage<OBJ.damage)
										src.density=0
										src.icon='FireBallAHit.dmi'
										src.pixel_x=-50
										view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
										walk(src,0)
										flick("[src.hitstate]",src)
										var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
										F1.loc=src.loc
										F1.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
										F2.loc=src.loc
										F2.x+=1
										F2.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
										F3.loc=src.loc
										F3.x-=1
										F3.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
										F4.loc=src.loc
										F4.y-=1
										F4.Owner=Owner
										spawn(7)if(src)del(src)
									else
										if(src.damage==OBJ.damage)
											src.density=0
											OBJ.density=0
											src.icon='FireBallAHit.dmi'
											src.pixel_x=-50
											view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
											walk(src,0)
											walk(OBJ,0)
											flick("[src.hitstate]",src)
											flick("[OBJ.hitstate]",OBJ)
											var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
											F1.loc=src.loc
											F1.Owner=Owner
											var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
											F2.loc=src.loc
											F2.x+=1
											F2.Owner=Owner
											var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
											F3.loc=src.loc
											F3.x-=1
											F3.Owner=Owner
											var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
											F4.loc=src.loc
											F4.y-=1
											F4.Owner=Owner
											spawn(7)
												if(OBJ)del(OBJ)
												if(src)del(src)
						else
							if(istype(O,/obj))
								var/obj/OBJ=O
								if(OBJ.fightlayer==src.fightlayer)
									src.density=0
									view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
									walk(src,0)
									flick("hit",src)
									var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
									F1.loc=src.loc
									F1.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
									F2.loc=src.loc
									F2.x+=1
									F2.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
									F3.loc=src.loc
									F3.x-=1
									F3.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
									F4.loc=src.loc
									F4.y-=1
									F4.Owner=Owner
									spawn(7)if(src)del(src)
								else
									if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")
										src.density=0
										view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
										walk(src,0)
										flick("hit",src)
										var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
										F1.loc=src.loc
										F1.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
										F2.loc=src.loc
										F2.x+=1
										F2.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
										F3.loc=src.loc
										F3.x-=1
										F3.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
										F4.loc=src.loc
										F4.y-=1
										F4.Owner=Owner
										spawn(7)if(src)del(src)
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer==src.fightlayer)
										src.density=0
										view(src)<<sound('Exp_Dirt_01.wav',0,0,volume=50)
										walk(src,0)
										flick("hit",src)
										var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
										F1.loc=src.loc
										F1.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
										F2.loc=src.loc
										F2.x+=1
										F2.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
										F3.loc=src.loc
										F3.x-=1
										F3.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
										F4.loc=src.loc
										F4.y-=1
										F4.Owner=Owner
										spawn(7)if(src)del(src)
									else
										if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
										else if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
		FireBall
			icon_state="fireball"
			hitstate="fireballhit"
			hitsound='boom.wav'
			luminosity=3
			New()
				flick("fireball",src)
				spawn(30)
					if(!src.Hit)
						flick("fireballhit",src)
						spawn(7)if(src)del(src)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming) return
						if(M.fightlayer==src.fightlayer)
							src.density=0
							view(src)<<sound('boom.wav',0,0)
							src.layer=MOB_LAYER+1
							walk(src,0)
							src.loc=O.loc
							flick("[src.hitstate]",src)
							src.Hit=1
							var/colour = colour2html("orange")
							F_damage(M,src.damage+(Owner.ninjutsu*0.5),colour)
							M.health-=src.damage+(Owner.ninjutsu*0.5)
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,9))
							Owner.Levelup()
							if(prob(50))
								M.Linkage=src
								M.overlays+=/obj/Projectiles/Effects/OnFire
								if(src.level==1)
									M.burn=3
									spawn(50)if(M)M.BurnEffect(Owner)
								if(src.level==2)
									M.burn=6
									spawn(50)if(M)M.BurnEffect(Owner)
								if(src.level==3)
									M.burn=9
									spawn(50)if(M)M.BurnEffect(Owner)
								if(src.level==4)
									M.burn=11
									spawn(50)if(M)M.BurnEffect(Owner)
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.Death(Owner)
							spawn(7)if(src)src.loc=locate(0,0,0)
							//del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								view(src)<<sound('boom.wav',0,0)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("fireballhit",src)
								src.Hit=1
								var/colour = colour2html("orange")
								F_damage(M,src.damage+(Owner.ninjutsu*0.5),colour)
								M.health-=src.damage+(Owner.ninjutsu*0.5)
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(7,9))
								Owner.Levelup()
								if(prob(50))
									M.Linkage=src
									M.overlays+=/obj/Projectiles/Effects/OnFire
									if(src.level==1)
										M.burn=3
										spawn(50)if(M)M.BurnEffect(Owner)
									if(src.level==2)
										M.burn=6
										spawn(50)if(M)M.BurnEffect(Owner)
									if(src.level==3)
										M.burn=9
										spawn(50)if(M)M.BurnEffect(Owner)
									if(src.level==4)
										M.burn=11
										spawn(50)if(M)M.BurnEffect(Owner)
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.Death(Owner)
								spawn(7)if(src)src.loc=locate(0,0,0)
								//del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj/Projectiles)&&!istype(O,/obj/Projectiles/Weaponry))
							var/obj/Projectiles/OBJ=O
							if(OBJ.fightlayer==src.fightlayer)
								src.Hit=1
								if(src.damage>OBJ.damage)
									OBJ.density=0
									view(OBJ)<<sound(OBJ.hitsound,0,0)
									walk(OBJ,0)
									flick("[OBJ.hitstate]",OBJ)
									spawn(7)if(OBJ)del(OBJ)
								else
									if(src.damage<OBJ.damage)
										src.density=0
										view(src)<<sound(src.hitsound,0,0)
										walk(src,0)
										flick("[src.hitstate]",src)
										spawn(7)if(src)del(src)
									else
										if(src.damage==OBJ.damage)
											src.density=0
											OBJ.density=0
											view(src)<<sound(src.hitsound,0,0)
											walk(src,0)
											walk(OBJ,0)
											flick("[src.hitstate]",src)
											flick("[OBJ.hitstate]",OBJ)
											spawn(7)
												if(OBJ)del(OBJ)
												if(src)del(src)
							else
								if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									src.Hit=1
									src.density=0
									view(src)<<sound('boom.wav',0,0)
									walk(src,0)
									flick("[src.hitstate]",src)
									spawn(7)if(src)del(src)
						else
							if(istype(O,/obj))
								var/obj/OBJ=O
								if(OBJ.fightlayer==src.fightlayer)
									src.Hit=1
									src.loc=O.loc
									src.density=0
									view(src)<<sound('boom.wav',0,0)
									walk(src,0)
									flick("[src.hitstate]",src)
									spawn(7)if(src)del(src)
								else
									if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")
										src.Hit=1
										src.density=0
										view(src)<<sound('boom.wav',0,0)
										walk(src,0)
										flick("[src.hitstate]",src)
										spawn(7)if(src)del(src)
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer==src.fightlayer)
										src.Hit=1
										src.loc=locate(T.x,T.y,T.z)
										src.density=0
										view(src)<<sound('boom.wav',0,0)
										walk(src,0)
										flick("fireballhit",src)
										spawn(7)if(src)del(src)
									else
										if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
										else
											if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
		Pull
			icon_state="pull"
			New()
				flick("pull",src)
				spawn(30)if(src)if(!src.Hit)del(src)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming || !M.key) del(src)
						if(M.fightlayer==src.fightlayer)
							src.density=0
							view(src)<<sound('Beam.ogg',0,0)
							walk(src,0)
							src.loc=locate(0,0,0)
							src.Hit=1
							if(Owner.loc.loc:Safe!=1)Owner.LevelStat("Ninjutsu",rand(5,7))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.icon_state="pull"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							if(!M.key) goto lol
							walk_towards(M,Owner)
							lol
							src.loc=locate(0,0,0)
							spawn(src.damage)
								if(M)
									if(M.dead==0)
										M.icon_state=""
										M.injutsu=0
									M.canattack=1
									M.firing=0
									walk(M,0)
								if(src)del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								view(src)<<sound('Beam.ogg',0,0)
								walk(src,0)
								src.loc=locate(0,0,0)
								src.Hit=1
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="pull"
								M.injutsu=1
								walk_towards(M,Owner)
								src.loc=locate(0,0,0)
								spawn(src.damage)
									if(M)
										if(M.dead==0)
											M.icon_state=""
											M.injutsu=0
										walk(M,0)
									if(src)del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj))
							var/obj/OBJ=O
							if(OBJ.fightlayer==src.fightlayer)if(src)del(src)
							else
								if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")if(src)del(src)
						else
							if(istype(O,/turf))
								var/turf/T=O
								if(T.fightlayer==src.fightlayer)if(src)del(src)
								else
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")if(src)src.loc=locate(T.x,T.y,T.z)
									else
										if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")if(src)src.loc=locate(T.x,T.y,T.z)
			Move()
				..()
				return step(src,src.dir)
		Push
			icon_state="pull"
			hitstate="0"
			New()
				flick("pull",src)
				spawn(30)if(src)if(!src.Hit)del(src)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming || !M.key) del(src)
						if(M.fightlayer==src.fightlayer)
							src.density=0
							var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
							A.IsJutsuEffect=src
							A.pixel_x=-30
							A.pixel_y=-10
							A.dir=src.dir
							view(src)<<sound('Beam.ogg',0,0)
							walk(src,0)
							src.loc=locate(0,0,0)
							src.Hit=1
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.icon_state="push"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							if(!M.key) goto lol
							walk(M,Owner.dir)
							lol
							src.loc=locate(0,0,0)
							spawn(src.damage)
								if(M)
									if(M.dead==0&&!M.swimming)M.icon_state=""
									if(M.dead==0)M.injutsu=0
									walk(M,0)
									M.canattack=1
									M.firing=0
								if(src)del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
								A.IsJutsuEffect=src
								A.pixel_x=-30
								A.pixel_y=-10
								A.dir=src.dir
								view(src)<<sound('Beam.ogg',0,0)
								walk(src,0)
								src.loc=locate(0,0,0)
								src.Hit=1
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="push"
								M.injutsu=1
								walk(M,Owner.dir)
								src.loc=locate(0,0,0)
								spawn(src.damage)
									if(M)
										if(M.dead==0&&!M.swimming)M.icon_state=""
										if(M.dead==0)M.injutsu=0
										walk(M,0)
									if(src)del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj/Projectiles)&&!istype(O,/obj/Projectiles/Weaponry))
							..()
						else
							if(istype(O,/obj/Projectiles/Weaponry))
								var/obj/OBJ=O
								if(OBJ.fightlayer==src.fightlayer)walk(O,src.dir)
								else
									if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")walk(O,src.dir)
							else
								if(istype(O,/obj))
									var/obj/OBJ=O
									if(OBJ.fightlayer==src.fightlayer)if(src)del(src)
									else
										if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")if(src)del(src)
								else
									if(istype(O,/turf))
										var/turf/T=O
										if(T.fightlayer==src.fightlayer)if(src)del(src)
										else
											if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
											else
												if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
						if(src)del(src)
			Move()
				..()
				return step(src,src.dir)
mob
	proc
		BurnEffect(mob/X)
			if(src.burn>0&&src.health>0&&X)
				burn--
				var/colour = colour2html("orange")
				var/damage=3+round(X.ninjutsu/10)
				F_damage(src,damage,colour)
				src.health-=damage
				view(src)<<sound('boom.wav',0,0)
				src.UpdateHMB()
				src.Death(X)
				spawn(10)if(src)src.BurnEffect(X)
			else
				src.overlays=0
				src.RestoreOverlays()
				if(src.Linkage)
					var/obj/OBJ=src.Linkage
					if(OBJ)del(OBJ)
					src.Linkage=null
mob
	proc
		Step_Back()
			var/direct=src.dir
			if(src.dir==NORTH)
				step(src,SOUTH)
				src.dir=direct
				return
			if(src.dir==NORTHEAST)
				step(src,SOUTHWEST)
				src.dir=direct
				return
			if(src.dir==NORTHWEST)
				step(src,SOUTHEAST)
				src.dir=direct
				return
			if(src.dir==SOUTH)
				step(src,NORTH)
				src.dir=direct
				return
			if(src.dir==SOUTHEAST)
				step(src,NORTHWEST)
				src.dir=direct
				return
			if(src.dir==SOUTHWEST)
				step(src,NORTHEAST)
				src.dir=direct
				return
			if(src.dir==EAST)
				step(src,WEST)
				src.dir=direct
				return
			if(src.dir==WEST)
				step(src,EAST)
				src.dir=direct
				return
mob/proc/Follow(var/mob/M)
	if(M && src)
		M.LinkFollowers+=src
		src.loc = M.loc
		spawn(1)if(src)src.Follow(M)
	else if(src)del(src)
obj/Projectiles/Effects
	WaterPrison
		icon='Water Prison.dmi'
		icon_state="stay"
		pixel_y=-5
		mouse_opacity=0
		New()
			..()
			flick("create",src)
obj/Projectiles/Effects
	Nara
		layer=MOB_LAYER-1
		ShadowBase
			icon='Shadow_Bind.dmi'
			icon_state="base"
			pixel_y=-12
			pixel_x=-2
			New()
				..()
				spawn(20000)if(src)del(src)
		ShadowTrail
			icon='Shadow_Bind.dmi'
			icon_state="trail"
			pixel_y=-12
			pixel_x=-2
			New()
				..()
				spawn(20000)if(src)del(src)
				spawn(1)
					switch(src.dir)
						if(NORTHEAST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=16,pixel_y=16)
						if(NORTHWEST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=-16,pixel_y=16)
						if(SOUTHEAST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=16,pixel_y=-16)
						if(SOUTHWEST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=-16,pixel_y=-16)
		ShadowExtension
			icon='Shadow_Bind.dmi'
			icon_state="head"
			pixel_y=-12
			pixel_x=-2
			var/list/Stuffz=list()
			var/bumped
			New()
				..()
				spawn(1200)if(src)del(src)
			Move()
				..()
				if(bumped) return
				var/obj/Projectiles/Effects/Nara/ShadowTrail/T=new(src.loc)
				T.IsJutsuEffect=src
				Stuffz.Add(T)
				T.dir=src.dir
			Del()
				for(var/obj/O in Stuffz) del(O)
				for(var/mob/Who in src.loc)
					if(!Who.dead)
						Who.move=1
						Who.injutsu=0
						Who.canattack=1
						Who.NaraTarget=null
						Who.icon_state=""
						Who.firing=0
				..()
mob/var/tmp/mob/NaraTarget
mob/proc/CreateTrailNara(mob/Who,Timer)
	if(!Who)return
	//if(!Who in oview()) return
	icon_state="jutsuse"
	move=0
	injutsu=1
	canattack=0
	firing=1
	Timer = Timer*10
	if(Timer>=50)Timer=50
	var/obj/Projectiles/Effects/Nara/ShadowBase/B=new(src.loc)
	B.IsJutsuEffect=src
	B.dir=src.dir
	var/obj/Projectiles/Effects/Nara/ShadowExtension/E=new(src.loc)
	E.IsJutsuEffect=src
	E.dir=src.dir
	E.Owner=src
	B.Owner=src
	var/turf/T=Who.loc
	spawn((Timer)+10)
		if(src)
			move=1
			injutsu=0
			canattack=1
			icon_state=""
			firing=0
			/*for(var/obj/Jutsus/Shadow_Extension/J in src.JutsusLearnt)
				src.JutsuCoolSlot(J)
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)*/
		if(Who)
			Who.injutsu=0
			Who.move=1
			Who.canattack=1
			Who.icon_state = ""
			Who.firing=0
			NaraTarget=null
			Who=null
		if(E)del(E)
		if(B)del(B)
	while(E.loc!=T&&!E.bumped&&Who)
		sleep(1)
		if(src)
			T=Who.loc
			if(!E) continue
			for(var/atom/D in get_step(E,E.dir))
				if(D.density&&!ismob(D))
					if(isturf(D)||isobj(D))
						if(E)E.bumped=1
			E.density=0
			step_to(E,T,0)
	T = Who.loc
	if(Who&&T)
		if(Who.loc==T&&E.loc==T)
			Who.move=0
			Who.injutsu=1
			Who.canattack=0
			NaraTarget=Who
			while(Timer && Who && src)
				Timer--
				NaraTarget=Who
				sleep(10)
			if(E)del(E)
			if(B)del(B)
			if(Who)
				if(!Who.dead)
					Who.move=1
					Who.injutsu=0
					Who.canattack=1

			if(src)
				if(!src.dead)
					src.move=1
					src.injutsu=0
					src.canattack=1
					src.NaraTarget=null
					/*for(var/obj/Jutsus/Shadow_Extension/J in src.JutsusLearnt)
						src.JutsuCoolSlot(J)
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)*/
	if(E)del(E)
	if(B)del(B)
	if(src)
		if(!src.dead)
			move=1
			injutsu=0
			canattack=1
			NaraTarget=null
			icon_state=""
			firing=0
			/*for(var/obj/Jutsus/Shadow_Extension/J in src.JutsusLearnt)
				src.JutsuCoolSlot(J)
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)*/
	if(Who)
		if(!Who.dead)
			Who.move=1
			Who.injutsu=0
			Who.canattack=1
			Who.NaraTarget=null
			Who.icon_state=""
			Who.firing=0
mob
	proc
		Gedo_Revival()
			for(var/obj/Jutsus/Gedo_Revival/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(10))return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				src.Levelup()
				J.Excluded=1
				J.uses++
				src.move=0
				src.canattack=0
				src.injutsu=1
				src.firing=1
				flick("groundjutsu",src)
				src.icon_state = "groundjutsuse"
				for(var/mob/M in src.loc)
					if(M.icon_state == "dead" && M.client && M.dead)
						M.revived=1
						M.dead=0
						M.KOs=0
						M.density=1
						M.health=M.maxhealth
						M.chakra=M.maxchakra
						M.injutsu=0
						M.canattack=1
						M.firing=0
						M.icon_state=""
						M.wait=0
						M.rest=0
						M.dodge=0
						M.move=1
						M.swimming=0
						M.overlays=0
						M.RestoreOverlays()
						M.UpdateHMB()
						spawn(1)M.Run()
						src.health=health/2
						src.Death()
						spawn(600)if(M)if(M.revived)M.revived=0
				spawn(5)if(src)
					src.icon_state = ""
					src.move=1
					src.canattack=1
					src.injutsu=0
					src.firing=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Shinra_Tensei()
			for(var/obj/Jutsus/Shinra_Tensei/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(240)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
				view(src)<<sound('Powerup.ogg',0,0)
				spawn(7)
					view(src)<<sound('Powerup.ogg',0,0)
					spawn(7)if(src)view(src)<<sound('Powerup.ogg',0,0)
				var/obj/O = new/obj
				O.IsJutsuEffect=src
				O.loc = src.loc
				O.icon = 'Shinra.dmi'
				O.icon_state = ""
				O.layer=200
				src.injutsu=1
				src.dir = SOUTH
				flick("jutsuse",src)
				spawn(1) src.dir=EAST; spawn(1) src.dir = NORTH; spawn(1) src.dir = WEST; spawn(1) src.dir = SOUTH
				src.icon_state = "jutsuse"
				flick("start",O)
				sleep(7)
				O.icon_state = "Loop"
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=20
				if(J.level==2) J.damage=40
				if(J.level==3) J.damage=60
				if(J.level==4) J.damage=80
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				if(J.level==4)
					for(var/mob/M in range(15))
						if(!istype(M,/mob/NPC) && M.injutsu==0 && !M.dead && !M.swimming)
							var/ki = get_dist(M,src)
							for(var/i=0,i<ki,i++) spawn() step_away(M,src); sleep(1.5)
				for(var/i=0,i<J.level*12,i++)
					for(var/obj/Projectiles/Weaponry/Ok in orange(J.level))
						walk_to(Ok,0)
						step_away(Ok,src)
						walk(Ok,Ok.dir)
					for(var/obj/Projectiles/Ok in orange(J.level))
						walk_to(Ok,0)
						step_away(Ok,src)
						walk(Ok,Ok.dir)
					for(var/mob/M in orange(1))
						if(M.dead || M.swimming) continue
						if(!istype(M,/mob/NPC))
							M.icon_state="push"
							M.injutsu=1
							M.health-=J.damage+src.ninjutsu*2
							var/IA = rand(1,2)
							if(IA==1)step_away(M,src)
							var/colour = colour2html("white")
							F_damage(M,J.damage+src.ninjutsu*2,colour)
							if(M.client)spawn() M.ScreenShake(20)
							if(M)
								walk(M,0)
								M.injutsu=0
								if(!M.swimming&&!M.dead)M.icon_state=""
								M.Death(src)
					sleep(1)
				O.icon_state = ""
				O.pixel_x-=32
				O.pixel_x-=16
				O.pixel_x-=8
				flick("end",O)
				sleep(5)
				if(O)del(O)
				src.copy = "Cant move"
				src.icon_state = ""
				spawn(3)if(src)
					src.firing=0
					src.injutsu=0
					src.copy=null
					src.canattack=1
					src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Flying_Thunder_God()
			for(var/obj/Jutsus/Flying_Thunder_God/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(!move) return
				if(injutsu) return
				if(copy=="Climb") return
				if(ChakraCheck(15)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				src.move=0
				J.uses++
				if(J.level==1) J.damage=2
				if(J.level==2) J.damage=4
				if(J.level==3) J.damage=6
				if(J.level==4) J.damage=8
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				if(c_target)
					if(c_target.opponent) return
					flick('Flyingthunder.dmi',src)
					spawn(1)
						src.loc = c_target.loc
						step(src,c_target.dir)
						src.dir = get_dir(src,c_target)
				else
					flick('Flyingthunder.dmi',src)
					spawn(1)for(var/i=0,i<J.damage*3+1,i++)step(src,src.dir)
				src.move=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				spawn(8)if(src)
					src.firing=0
					src.move=1
					src.canattack=1
		Warp_Rasengan()
			for(var/obj/Jutsus/Warp_Rasengan/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.move=0
				src.injutsu=1
				src.firing=1
				src.canattack=0
				src.Levelup()
				src.icon_state = "jutsuse"
				sleep(5)
				//view(src) << output("<b>One-thousand years of death!","actionoutput")
				if(c_target)
					c_target.dir = get_dir(c_target,src)
					flick('Flyingthunder.dmi',src)
					loc = c_target.loc
					step(src,c_target.dir)
					dir = get_dir(src,c_target)
					sleep(2)
				flick("2fist",src)
				for(var/mob/M in get_step(src,src.dir))
					for(var/i=0,i<4,i++)
						var/obj/O = new/obj
						O.loc = M.loc
						O.icon = 'Rasenshuriken Explode.dmi'
						flick("wtf",O)
						spawn(7)if(O)del(O)
						if(M) step(M,src.dir)
						if(M) M.dir = get_dir(M,src)
						if(M) M.health -= 100+round(src.agility/15)
						F_damage(M,100+round(src.agility/15))
						sleep(1)
				src.icon_state = ""
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				src.move=1
				src.injutsu=0
				src.firing=0
				src.canattack=1
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Snake_Release_Jutsu()
			for(var/obj/Jutsus/Snake_Release_Jutsu/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(150)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*55
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Snake_Release_Jutsu.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Snake_Release_Jutsu.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*3)+round(src.ninjutsu*6)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Snake_Skin_Replacement_Jutsu()
			for(var/obj/Jutsus/Snake_Skin_Replacement_Jutsu/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(25)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				src.Levelup()
				var/turf/T=src.loc
				J.Excluded=1
				J.uses++
				src<<output("You will be sent to this location the next time your character accumulates damage.","actionoutput")
				var/X = src.health
				while(src.health == X)sleep(1)
				for(var/i=0,i<8,i++)
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Snake_Skin_Replacement_Jutsu.dmi'
					O.pixel_x=-16
					spawn(1) step_rand(O)
					spawn(10)if(O)del(O)
				src.loc = T
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Demon_Wind_Shuriken()
			for(var/obj/Jutsus/Demon_Wind_Shuriken/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100))return
				if(J.Excluded)return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				J.Excluded=1
				J.uses++
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=6
				if(J.level==3) J.damage=7
				if(J.level==4) J.damage=9
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=round(J.level*1.5)
				if(c_target)
					while(num)
						sleep(1)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/Windmill(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1)if(A)A.density=1
						walk_towards(A,c_target,0)
						spawn(7)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(1)
						num--
						var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/Windmill(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1) if(A) A.density=1
						walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Multiple_Chakra_Kunai()
			for(var/obj/Jutsus/Multiple_Chakra_Kunai/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100))return
				if(J.Excluded)return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				J.Excluded=1
				J.uses++
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=6
				if(J.level==3) J.damage=7
				if(J.level==4) J.damage=10
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=round(J.level*1.5)
				if(c_target)
					while(num)
						sleep(1)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/ChakraManiper/A = new/obj/Projectiles/Effects/ChakraManiper(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1)if(A)A.density=1
						walk_towards(A,c_target,0)
						spawn(7)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(1)
						num--
						var/obj/Projectiles/Effects/ChakraManiper/A = new/obj/Projectiles/Effects/ChakraManiper(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1) if(A) A.density=1
						walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Magma_Crush()
			for(var/obj/Jutsus/Magma_Crush/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(65))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1)J.damage=3
				if(J.level==2)J.damage=5
				if(J.level==3)J.damage=6
				if(J.level==4)J.damage=7
				if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
				if(c_target)
					flick("groundjutsu",src)
					sleep(4)
					src.icon_state="groundjutsuse"
					src.move=0
					spawn(3)if(src)
						src.firing=0
						src.canattack=1
						src.move=1
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/A = new(c_target.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.density=1
						A.layer=MOB_LAYER+1
						var/I=J.damage*7
						A.icon='Magma_Crush.dmi'
						A.icon_state="stay"
						A.pixel_x=-48
						A.pixel_y=-16
						flick("create",A)
						I = I+round(src.ninjutsu/16)
						var/oldhealth=c_target.health
						var/I2=1
						while(I)
							I--
							I2+=1
							sleep(1)
							for(var/mob/F in A.loc)
								F.health=oldhealth
								F.move=0
								F.injutsu=1
								F.canattack=0
								if(src)Prisoner=F
								spawn(2)
									if(F)
										F.move=1
										F.injutsu=0
										F.canattack=1
								if(I2==8)
									I2=0
									if(F)
										F.health-=J.damage
										oldhealth=(oldhealth-J.damage)
										F.health=oldhealth
										var/colour = colour2html("white")
										F_damage(F,J.damage,colour)
										F.Death(src)
							sleep(1)
						if(src)
							flick("delete",A)
							sleep(4)
							del(A)
						if(c_target)
							c_target.move=1
							c_target.injutsu=0
							c_target.canattack=1
						if(src)
							Prisoner=null
							src.icon_state=""
				//	A.pixel_y+=rand(10,15)
				//	spawn(4) if(A) walk(A,A.dir)
				else src<<output("This technique requires a target.","actionoutput")
				if(src)
					src.firing=0
					src.canattack=1
					src.move=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Magma_Needles()
			for(var/obj/Jutsus/Magma_Needles/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(150)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('046.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=40
				if(J.level==2) J.damage=60
				if(J.level==3) J.damage=80
				if(J.level==4) J.damage=100
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=5
				if(c_target)
					while(num)
						sleep(1)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Weaponry/Magma_Needles/A = new/obj/Projectiles/Weaponry/Magma_Needles(src.loc)
						A.IsJutsuEffect=src
						A.density=0
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.5+src.strength*0.3)
						var/turf/Tg
						Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
						var/k = rand(1,5)
						spawn() switch(k)
							if(1)
								spawn(1) A.density=1
								walk_towards(A,c_target.loc,0)
							else
								spawn(1) A.density=1
								walk_towards(A,Tg,0)
						spawn(4)
							spawn(1) if(A) A.density=1
							if(A) walk(A,A.dir)
						num--
				else
					while(num)
						num--
						sleep(1)
						var/obj/Projectiles/Weaponry/Magma_Needles/A = new/obj/Projectiles/Weaponry/Magma_Needles(src.loc)
						A.IsJutsuEffect=src
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						step(A,A.dir)
						if(A)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu*1.5+src.strength*0.8)
						spawn() walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Wind_Sheild()//
			for(var/obj/Jutsus/Wind_Sheild/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(src.ChakraCheck(20)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.firing=1
				src.canattack=0
				src.move=0
				flick("jutsuse",src)
				view(src)<<sound('wirlwind.wav',0,0)
				J.Excluded=1
				J.uses++
				var/obj/O=new
				O.IsJutsuEffect=src
				O.icon='Tornado.dmi'
				O.loc=src.loc
				O.layer=20000000000000000000000000000000000000000000000000000000000000000000000000
				O.pixel_x=-78
				for(var/mob/M in orange(2))
					if(!M) continue
					M.health-=J.damage+src.strength*0.7+src.ninjutsu*0.7
					var/colour = colour2html("white")
					F_damage(M,J.damage+src.strength*0.7+src.ninjutsu*0.7,colour)
					if(M) M.Bleed()
					M.icon_state="push"
					M.injutsu=1
					M.canattack=0
					M.firing=1
					step_away(M,src)
					walk(M,M.dir)
					if(M.client)spawn()M.ScreenShake(6)
					spawn(round(6))
						if(M)
							walk(M,0)
							M.injutsu=0
							if(!M.swimming)M.icon_state=""
							M.canattack=1
							M.firing=0
							if(M) M.Bleed()
				spawn(5)
					del(O)
					src.firing=0
					src.canattack=1
					src.move=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sage_Style_Giant_Rasengan()
			for(var/obj/Jutsus/Sage_Style_Giant_Rasengan/J in src.JutsusLearnt) if(J.Excluded==0)
				if(Effects["Rasengan"])
					Effects["Rasengan"]=null
					src.overlays-=image('Rasengan.dmi',"spin")
					return
				if(ChakraCheck(500)) return
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
				src.icon_state="jutsuse"
				view(src) << output("<b><font color = gold>[usr]says: Sage Style...GIANT RASENGAN!","actionoutput")
				var/obj/I = new/obj
				I.IsJutsuEffect=src
				if(dir!=SOUTH) I.layer=MOB_LAYER-1
				I.loc = src.loc
				I.icon = 'Sage Style Giant Rasengan.dmi'
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
				flick("Form",I)
				spawn(3)if(I)I.icon_state = "Spin"
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
					A.layer=1000000000000000
					src.ArrowTasked = A
					sleep(17)
					if(A)del(A)
				src.icon_state=""
				I.icon_state = "Form"
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
										Ex.icon = 'Sage Style Giant Rasengan Explode.dmi'
										Ex.icon_state = "ow"
										Ex.layer=MOB_LAYER+2
										Ex.pixel_x=-112
										Ex.loc = M.loc
										spawn(20)if(Ex)del(Ex)
										M.health-=(45*J.level)+(src.strength*12)
										F_damage(M,(45*J.level)+(src.strength*12))
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
		Shadow_Stab()
			for(var/obj/Jutsus/Shadow_Stab/J in src.JutsusLearnt)
				if(!NaraTarget)
					src<<output("You must first trap someone using Shadow Extension jutsu.","actionoutput")
					return
				if(J.Excluded) return
				if(src.ChakraCheck(200)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				src.Levelup()
				src.UpdateHMB()
				if(J.level==1) J.damage=15
				if(J.level==2) J.damage=25
				if(J.level==3) J.damage=35
				if(J.level==4) J.damage=45
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				J.Excluded=1
				J.uses++
				var/mob/M=NaraTarget
				var/obj/O=new
				O.IsJutsuEffect=src
				O.icon='Multiple SHadow Stab.dmi'
				O.loc=M.loc
				O.layer=MOB_LAYER+1
				O.pixel_x=-16
				J.damage = J.damage+round((src.ninjutsu*3))
				flick("stab",O)
				M.health-=J.damage
				var/colour = colour2html("white")
				F_damage(M,J.damage,colour)
				if(!M) M.Bleed()
				M.Death(src)
				spawn(5)if(O)del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Shadow_Choke()
			for(var/obj/Jutsus/Shadow_Choke/J in src.JutsusLearnt)
				if(!NaraTarget)
					src<<output("You must first trap someone using Shadow Extension jutsu.","actionoutput")
					return
				if(J.Excluded) return
				if(src.ChakraCheck(150)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=15
				if(J.level==3) J.damage=20
				if(J.level==4) J.damage=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/Timer=J.level
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				J.Excluded=1
				J.uses++
				var/mob/M=NaraTarget
				var/obj/O=new
				O.IsJutsuEffect=src
				O.icon='Shadowneckbind.dmi'
				O.loc=M.loc
				O.pixel_x=-16
				O.layer=MOB_LAYER+1
				flick("grab",O)
				J.damage = J.damage+src.ninjutsu*1.4
				while(Timer&&NaraTarget&&M)
					Timer--
					sleep(4)
					O.icon_state = "choke"
					M.health-=J.damage
					var/colour = colour2html("white")
					F_damage(M,J.damage,colour)
					M.Death(src)
				del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Shadow_Extension()
			for(var/obj/Jutsus/Shadow_Extension/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(275))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<8)
					if(loc.loc:Safe!=1)
						J.exp+=rand(2,5)
						J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				J.uses++
				J.Excluded=1
				spawn(80)if(src)J.Excluded=0
				if(c_target)
					dir = get_dir(src,c_target)
					CreateTrailNara(c_target,J.level*3)
				else
					Target_A_Mob()
					c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						dir = get_dir(src,c_target)
						CreateTrailNara(c_target,J.level*2)
				spawn()
					src.JutsuCoolSlot(J)
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Camellia_Dance()
			for(var/obj/Jutsus/Camellia_Dance/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(50))return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,11))
				if(J.level<5)
					if(loc.loc:Safe!=1)
						J.exp+=rand(2,5)
						J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsu",src)
				J.uses++
				if(src.bonesword==0)
					src.bonesword = J.level
					src.overlays+='Camellia.dmi'
					src.overlays+=image('CamB.dmi',pixel_y=-32)
					src.overlays+=image('CamL.dmi',pixel_x=-32)
					src.overlays+=image('CamR.dmi',pixel_x=32)
					src.overlays+=image('CamT.dmi',pixel_y=32)
					while(src.bonesword)
						src.chakra-=5
						if(src.chakra<0)
							src.chakra=0
							src.bonesword=0
							src.overlays-='Camellia.dmi'
							src.overlays-=image('CamB.dmi',pixel_y=-32)
							src.overlays-=image('CamL.dmi',pixel_x=-32)
							src.overlays-=image('CamR.dmi',pixel_x=32)
							src.overlays-=image('CamT.dmi',pixel_y=32)
						sleep(10)
				else
					src.bonesword=0
					src.overlays-='Camellia.dmi'
					src.overlays-=image('CamB.dmi',pixel_y=-32)
					src.overlays-=image('CamL.dmi',pixel_x=-32)
					src.overlays-=image('CamR.dmi',pixel_x=32)
					src.overlays-=image('CamT.dmi',pixel_y=32)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sand_Funeral()
			for(var/obj/Jutsus/Sand_Funeral/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(300)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target.","actionoutput")
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(8,12))
				if(J.level<4)
					if(loc.loc:Safe!=1)
						J.exp+=rand(2,5)
						J.Levelup()
				J.Excluded=1
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("groundjutsu",src)
				J.uses++
				if(c_target)
					for(var/obj/Jutsus/Effects/desertcoffin/O in c_target.loc)
						view(src)<<sound('knife_hit3.wav',0,0)
						O.icon = 'Sand Funeral.dmi'
						flick("stab",O)
						O.icon_state = "blood"
						c_target.health-=((J.level*10)+src.ninjutsu*5)
						F_damage(c_target,((J.level*10)+src.ninjutsu*5))
						c_target.Death(src)
				src.JutsuCoolSlot(J)
				spawn()
					J.maxcooltime=100
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Bug_Neurotoxin()
			for(var/obj/Jutsus/Bug_Neurotoxin/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(40))return
				if(src.firing)return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target || c_target.sbugged==0)
					src << output("This jutsu requires a target that is under the effect of stealth bug.","actionoutput")
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				if(J.level<4)
					if(loc.loc:Safe!=1)
						J.exp+=rand(2,5)
						J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("groundjutsu",src)
				J.uses++
				J.Excluded=1
				if(c_target)
					if(c_target.sbugged)
						var/obj/O = new/obj
						O.loc = c_target.loc
						view(src)<<sound('bugs.wav',0,0)
						O.icon = 'Neurotoxin Bug.dmi'
						O.pixel_x=-48
						O.pixel_y=-32
						flick("grab",O)
						O.icon_state = "grabbed"
						c_target.move=0
						c_target.injutsu=1
						c_target.canattack=0
						spawn(25+(J.level*3))
							if(c_target)
								c_target.move=1
								c_target.injutsu=0
								c_target.canattack=1
							if(O)del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sand_Sheild()
			for(var/obj/Jutsus/Sand_Sheild/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(75)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				if(J.level<4)
					if(loc.loc:Safe!=1)
						J.exp+=rand(2,5)
						J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				J.uses++
				src.sheilded=1
				src.firing=1
				src.move=0
				src.injutsu=1
				var/obj/O = new/obj
				O.loc = src.loc
				O.icon = 'Sand Sheild.dmi'
				O.icon_state = "stay"
				O.pixel_x=-32
				O.pixel_y=-8
				O.layer=10
				flick("form",O)
				var/X = J.level*100
				var/Z = src.health
				while(X && src)
					sleep(1)
					src.health = Z
					src.sheilded=1
					X--
				if(src)
					if(O)del(O)
					src.firing=0
					src.move=1
					src.injutsu=0
					src.sheilded=0
				else if(O)del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		WaterPrison()
			for(var/obj/Jutsus/WaterPrison/J in src.JutsusLearnt)
				if(!has_water())
					src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","actionoutput")
					return
				if(J.Excluded)
					sleep(120)
					if(J)if(J.Excluded)J.Excluded=0
					return
				if(ChakraCheck(75)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.uses++
				J.Excluded=1
				var/Timer
				if(J.level==1) Timer=20
				if(J.level==2) Timer=40
				if(J.level==3) Timer=60
				if(J.level==4) Timer=80
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/obj/PrisonOb
				var/turf/T
				for(var/mob/M in get_step(src,src.dir))
					if(istype(M)&&!M.dead)
						Prisoner=M
						M.move=0
						M.canattack=0
						M.injutsu=1
						M.Prisoned=1
						firing=1
						canattack=0
						var/obj/Projectiles/Effects/WaterPrison/W=new
						W.IsJutsuEffect=src
						W.pixel_x-=45
						W.loc=M.loc
						W.layer=M.layer+2
						icon_state="punchrS"
						PrisonOb=W
						T=src.loc
					while(Timer&&T==src.loc&&M)
						Timer--
						M.move=0
						M.canattack=0
						M.injutsu=1
						M.Prisoned=1
						sleep(10)
					M.move=1
					M.canattack=1
					M.injutsu=0
					M.Prisoned=0
					icon_state=""
					if(PrisonOb)del(PrisonOb)
				firing=0
				canattack=1
				Prisoner=null
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		WaterShark()
			for(var/obj/Jutsus/WaterShark/J in src.JutsusLearnt)
				if(!has_water())
					src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","actionoutput")
					return
				if(J.Excluded)
					sleep(200)
					if(J)if(J.Excluded)J.Excluded=0
					return
				if(ChakraCheck(75)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("groundjutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=30
				if(J.level==2) J.damage=40
				if(J.level==3) J.damage=45
				if(J.level==4) J.damage=50
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=3
				if(c_target)
					while(num)
						num--
						sleep(2)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/WaterShark/A = new/obj/Projectiles/Effects/WaterShark(src.loc)
						A.IsJutsuEffect=src
						A.pixel_x-=44
						A.dir = src.dir
						if(num==1)
							if(dir==NORTH||dir==SOUTH)A.x--
							A.y--
						if(num==2)
							if(dir==NORTH||dir==SOUTH)A.x++
							A.y++
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*2+src.strength*0.8)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						num--
						sleep(2)
						var/obj/Projectiles/Effects/WaterShark/A = new/obj/Projectiles/Effects/WaterShark(src.loc)
						A.IsJutsuEffect=src
						A.pixel_x-=44
						A.dir  = src.dir
						if(num==1)
							if(dir==NORTH||dir==SOUTH)A.x--
							A.y--
						if(num==2)
							if(dir==NORTH||dir==SOUTH)A.x++
							A.y++
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/2+src.strength/10)
						walk(A,src.dir)
				spawn(5)if(src)src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Mystical_Palms()
			for(var/obj/Jutsus/Mystical_Palms/J in src.JutsusLearnt) if(J.Excluded==0)
				if(mystical_palms)
					src<<output("You deactivate your mystical palms.","actionoutput")
					src.mystical_palms=0
					return
				if(ChakraCheck(50)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.mystical_palms=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				src<<output("You activate mystical palms.","actionoutput")
				while(mystical_palms&&chakra>0)
					chakra-=5
					sleep(10)
				src<<output("You deactivate your mystical palms.","actionoutput")
				src.mystical_palms=0
		Insect_Coccoon()
			for(var/obj/Jutsus/Insect_Coccoon/J in src.JutsusLearnt) if(J.Excluded==0)
				if(bugpass)
					src<<output("You shut down your insect coccoon.","actionoutput")
					src.bugpass=0
					return
				if(ChakraCheck(30)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.bugpass=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				src<<output("You turn on your insect coccoon.","actionoutput")
				while(bugpass&&chakra>0)
					chakra-=10
					sleep(10)
				src<<output("You shut down your insect coccoon.","actionoutput")
				src.bugpass=0
		Puppet_Dash()
			for(var/obj/Jutsus/Puppet_Dash/J in src.JutsusLearnt) if(J.Excluded==0)
				if(pdash)
					src<<output("You deactivate your puppet dashing.","actionoutput")
					src.pdash=0
					return
				if(ChakraCheck(30)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.pdash=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				src<<output("You activate puppet dashing. Press CTRL+D or ALT+D to dash.","actionoutput")
				while(pdash&&chakra>0)
					chakra-=4
					sleep(10)
				src<<output("You deactivate your puppet dashing.","actionoutput")
				src.pdash=0
		Puppet_Shoot()
			for(var/obj/Jutsus/Puppet_Shoot/J in src.JutsusLearnt) if(J.Excluded==0)
				if(pshoot)
					src<<output("You unload your puppet's knife.","actionoutput")
					src.pshoot=0
					return
				if(ChakraCheck(20)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=200
				src.pshoot=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				src<<output("Your puppet loads a knife into it's arms. Press CTRL+A or ALT+A to fire it.","actionoutput")
		Puppet_Grab()
			for(var/obj/Jutsus/Puppet_Grab/J in src.JutsusLearnt) if(J.Excluded==0)
				if(pgrab)
					src<<output("Your puppet's arms are unflexed.","actionoutput")
					src.pgrab=0
					return
				if(ChakraCheck(30)) return
				if(loc.loc:Safe!=2) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.pgrab=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				src<<output("Your puppet loosens it's joints, ready to grab a nearby foe. Press CTRL+S or ALT+S to grab a player.","actionoutput")
		Puppet_Transform()
			for(var/obj/Jutsus/Puppet_Transform/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(30)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				var/mob/K = src.puppets[1]
				if(K)
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = K.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7)if(O)del(O)
					K.icon = src.icon
					K.henged=1
					K.overlays = src.overlays
					K.icon_state = ""
				var/mob/K2 = src.puppets[2]
				if(K2)
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = K2.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7)if(O)del(O)
					K2.icon = src.icon
					K2.henged=1
					K2.overlays = src.overlays
					K2.icon_state = ""
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.pgrab=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Amaterasu()
			for(var/obj/Jutsus/Amaterasu/J in src.JutsusLearnt) if(J.Excluded==0)
				if(Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","actionoutput")
					return
				var/mob/player/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a targeted player to use this technique.","actionoutput")
					return
				if(ChakraCheck(450)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(60,70))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=230
				var/obj/O = new(c_target.loc)
				O.IsJutsuEffect=src
				O.icon='Amat.dmi'
				O.pixel_x=-15
				O.layer=MOB_LAYER+1
				O.name="AmaterasuFire"
				var/Timer=J.level*6
			//	src.health -= src.maxhealth/5
				spawn(10)if(O)
					if(O.loc==c_target.loc)
						O.linkfollow(c_target)
						while(Timer&&c_target&&!c_target.dead)
							Timer--
							var/area/A=c_target.loc.loc
							if(A.Safe) break
							c_target.health-=J.level+round(src.ninjutsu/2)
							var/colour = colour2html("red")
							F_damage(c_target,J.level+round(src.ninjutsu/2),colour)
							c_target.Death(src)
							sleep(2)
						if(O)del(O)
					else if(O)del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Stealth_Bug()
			for(var/obj/Jutsus/Stealth_Bug/J in src.JutsusLearnt) if(J.Excluded==0)
				var/mob/player/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You require a targeted player to use this technique.","actionoutput")
					return
				if(ChakraCheck(50)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				view()<<sound('bugs.wav')
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				var/obj/O = new(c_target.loc)
				O.IsJutsuEffect=src
				O.icon='stealth bug.dmi'
				O.layer=MOB_LAYER+1
				O.pixel_x=-16
				O.name="Stealth Bugs"
				var/Timer=J.level*10
				walk_to(O,c_target)
				while(Timer&&c_target&&!c_target.dead)
					Timer--
					var/area/A=c_target.loc.loc
					if(A.Safe) break
					c_target.sbugged=1
					c_target.health-=round(src.ninjutsu/13)
					var/colour = colour2html("red")
					F_damage(c_target,round(src.ninjutsu/13),colour)
					c_target.Death(src)
					sleep(2)
				del(O)
				if(c_target)c_target.sbugged=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		C2()
			for(var/obj/Jutsus/C2/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				var/mob/M = new/mob/C2(src)
				M.loc = get_step(src,NORTH)
				M.name = src.key
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Death_Ruling_Possesion_Blood()
			for(var/obj/Jutsus/Death_Ruling_Possesion_Blood/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(250)) return
				var/checks=0
				for(var/obj/O in src.loc)
					if(O.icon == 'blood effects.dmi'&&O.Owner)
						checks=O
						break
				if(checks==0)
					src << output("This jutsu requires you to be standing on blood.","actionoutput")
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				var/obj/JashinSymbol/O=new(src)
				O.Owner=src
				O.JashinConnected=checks:Owner
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Immortality()
			for(var/obj/Jutsus/Immortality/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100)) return
				if(src.needkill) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.needkill=1
				src << output("<b>Kill someone within twenty seconds and you will be awarded with immortality for a short amount of time.","actionoutput")
				spawn(200)
					if(src)
						if(src.needkill==2)
							view(src) << output("Sacrifice to Jashin!","actionoutput")
							src.immortal = 1
							src.JashinSacrifices++
							spawn(200*J.level)
								src.immortal=0
						src.needkill=0
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Immortal()
			for(var/obj/Jutsus/Immortal/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100)) return
				if(src.needkill)
					src << output("You are using Immortality already. This jutsu will only be avivable once Immortality wears off.","actionoutput")
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
				src.Levelup()
				J.Excluded=1
				if(src.JashinSacrifices>=150)
					src.immortal=1
					src << output("<b>Jashin is pleased with your Sacrifices ! You gain ten seconds of Immortality instantly.","actionoutput")
					spawn(100)
						src << output("<b>Immortality wears off.","actionoutput")
						src.immortal=0
				else
					src << output("<b>The Jashin god needs more Sacrifices. You currently have [JashinSacrifices] of them. Once you reach 200, the jutsu will become available.","actionoutput")
				J.maxcooltime=300
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		First_Puppet_Summoning()
			for(var/obj/Jutsus/First_Puppet_Summoning/J in src.JutsusLearnt) if(J.Excluded==0)
				if(src.puppets[1])
					var/mob/K = src.puppets[1]
					src.puppets[1]=null
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = K.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7) del(O)
					del(K)
					src << output("You un-summon your first puppet.","actionoutput")
					return
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				var/mob/M = new/mob/Karasu(get_step(src,src.dir))
				var/obj/O2 = new/obj
				O2.IsJutsuEffect=src
				O2.loc = M.loc
				O2.icon = 'Smoke.dmi'
				flick("smoke",O2)
				spawn(7) del(O2)
				M.health=J.level*150
				M.strength=J.level*20
				M.name = src.key
				M.Owner=src
				src.puppets[1] = M
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Second_Puppet_Summoning()
			for(var/obj/Jutsus/Second_Puppet_Summoning/J in src.JutsusLearnt) if(J.Excluded==0)
				if(src.puppets[2])
					var/mob/K = src.puppets[2]
					src.puppets[2]=null
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = K.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7) del(O)
					del(K)
					src << output("You un-summon your second puppet.","actionoutput")
					return
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				var/mob/M = new/mob/Karasu(get_step(src,src.dir))
				M.Owner=src
				M.health=J.level*200
				M.strength=J.level*22
				var/obj/O2 = new/obj
				O2.IsJutsuEffect=src
				O2.loc = M.loc
				O2.icon = 'Smoke.dmi'
				flick("smoke",O2)
				spawn(7) del(O2)
				M.name = src.key
				src.puppets[2] = M
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Susanoo()
			for(var/obj/Jutsus/Susanoo/J in src.JutsusLearnt) if(J.Excluded==0)
				if(Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","actionoutput")
					return
				if(ChakraCheck(225)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,11))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				var/mob/M = new/mob/Susanoo(src)
				M.Follow(src)
				M.name = src.key
				src.Susanoo=1
				spawn(200) src.Susanoo=0
				J.Excluded=1
				J.uses++
				J.maxcooltime=450
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		One_Thousand_Years_of_Death()
			for(var/obj/Jutsus/One_Thousand_Years_of_Death/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(10)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.move=0
				src.injutsu=1
				src.firing=1
				src.canattack=0
				src.Levelup()
				src.icon_state = "jutsuse"
				sleep(5)
				//view(src) << output("<b>One-thousand years of death!","actionoutput")
				if(c_target)
					c_target.dir = get_dir(c_target,src)
					flick('Shunshin.dmi',src)
					loc = c_target.loc
					step(src,c_target.dir)
					dir = get_dir(src,c_target)
					sleep(2)
				flick("2fist",src)
				for(var/mob/M in get_step(src,src.dir))
					for(var/i=0,i<4,i++)
						var/obj/O = new/obj
						O.loc = M.loc
						O.icon = 'Smoke.dmi'
						flick("smoke",O)
						spawn(7)if(O)del(O)
						if(M) step(M,src.dir)
						if(M) M.dir = get_dir(M,src)
						if(M) M.health -= 1+round(src.agility/15)
						F_damage(M,1+round(src.agility/15))
						sleep(1)
				src.icon_state = ""
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				src.move=1
				src.injutsu=0
				src.firing=0
				src.canattack=1
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Bone_Drill()
			for(var/obj/Jutsus/Bone_Drill/J in src.JutsusLearnt) if(!J.Excluded)
				if(ChakraCheck(25)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				src.Levelup()
				src.overlays+='BoneDrill.dmi'
				src.icon_state = "punchrS"
				flick("punchr",src)
				src.move=0
				src.injutsu=1
				src.firing=1
				src.canattack=0
				var/mob/Z
				for(var/mob/M in get_step(src,src.dir))
					M.move=0
					M.injutsu=1
					M.firing=1
					M.canattack=0
					Z = M
				if(Z)
					for(var/i=0,i<5,i++)
						step(Z,src.dir)
						Z.dir = get_dir(Z,src)
						step(src,src.dir)
						F_damage(Z,(src.strength*6)+(src.strength*6))
						Z.health-=round((src.strength*6)+(src.strength*6))
						sleep(1)
					if(Z)
						Z.icon_state = "push"
						var/I = J.level*2
						while(I)
							I--
							step(Z,src.dir)
							Z.dir = get_dir(Z,src)
							sleep(1)
						Z.UpdateHMB()
						Z.move=1
						Z.injutsu=0
						Z.firing=0
						Z.canattack=1
						Z.icon_state = ""
						Z.Death(src)
				src.overlays-='BoneDrill.dmi'
				src.icon_state = ""
				src.move=1
				src.injutsu=0
				src.firing=0
				src.canattack=1
				J.Excluded=1
				J.uses++
				J.maxcooltime=220
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Eight_Gates_Assault()
			for(var/obj/Jutsus/Eight_Gates_Assault/J in src.JutsusLearnt) if(!J.Excluded)
				if(src.byakugan==0)
					src << output("Byakugan must be active.","actionoutput")
					return
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.icon_state = "punchrS"
				src.move=0
				src.injutsu=1
				src.firing=1
				src.canattack=0
				var/mob/Z
				for(var/mob/M in get_step(src,src.dir))
					M.move=0
					M.injutsu=1
					M.firing=1
					M.canattack=0
					Z = M
				if(Z)
					for(var/i=0,i<5,i++)
						sleep(1)
						flick("punchr",src)
						sleep(1)
						flick("punchrS",src)
						var/obj/O = new/obj
						O.loc = Z.loc
						O.layer = 200
						O.pixel_y=-16
						O.pixel_x=-16
						O.pixel_y+=rand(-5,5)
						O.pixel_x+=rand(-5,5)
						flick('EightGatesAssault.dmi',O)
						spawn(4)if(O)del(O)
						Z.chakra -= (src.ninjutsu + 7)
						F_damage(Z,(src.strength/3)+(src.ninjutsu))
						Z.health-=(src.strength/3)+(src.ninjutsu)
					for(var/i=0,i<3,i++)
						step(src,src.dir)
						step(src,src.dir)
						sleep(2)
						flick("punchr",src)
						sleep(2)
						flick("punchrS",src)
						step(Z,src.dir)
						step(Z,src.dir)
						Z.dir = get_dir(Z,src)
						var/obj/O = new/obj
						O.loc = Z.loc
						O.layer = 200
						O.pixel_y=-16
						O.pixel_x=-16
						O.pixel_y+=rand(-5,5)
						O.pixel_x+=rand(-5,5)
						flick('EightGatesAssault.dmi',O)
						spawn(4)if(O)del(O)
						Z.chakra -= (src.ninjutsu + 7)
						F_damage(Z,(src.strength/3)+(src.ninjutsu))
						Z.health-=(src.strength/3)+(src.ninjutsu)
					if(Z)
						Z.UpdateHMB()
						Z.move=1
						Z.injutsu=0
						Z.firing=0
						Z.canattack=1
						Z.icon_state = ""
						Z.Death(src)
				src.icon_state = ""
				src.move=1
				src.injutsu=0
				src.firing=0
				src.canattack=1
				J.Excluded=1
				J.uses++
				J.maxcooltime=350
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Chakra_Leech()
			for(var/obj/Jutsus/Chakra_Leech/J in src.JutsusLearnt)
				if(ChakraCheck(10)) return
				if(J.Excluded) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.icon_state = "punchrS"
				src.move=0
				src.injutsu=1
				src.firing=1
				src.canattack=0
				var/mob/Z
				for(var/mob/M in get_step(src,src.dir))
					if(M.key)
						M.move=0
						M.injutsu=1
						M.firing=1
						M.canattack=0
						Z = M
				if(Z)
					var/obj/O = new/obj
					O.icon = 'ChakraCharge.dmi'
					O.loc = Z.loc
					O.icon_state = "3x"
					O.layer = 200
					O.pixel_x=-21
					while(Z && src && Z.chakra-J.level*5>0 && src.chakra<>src.maxchakra && Z.loc == get_step(src,src.dir))
						Z.chakra-=J.level*5
						src.chakra+=J.level*5
						Z.move=0
						Z.injutsu=1
						Z.firing=1
						Z.canattack=0
						if(src.chakra>src.maxchakra)src.chakra = src.maxchakra
						src.UpdateHMB()
						sleep(2)
					if(Z)
						Z.move=1
						Z.injutsu=0
						Z.firing=0
						Z.canattack=1
						Z.icon_state = ""
					del(O)
				src.icon_state = ""
				src.move=1
				src.injutsu=0
				src.firing=0
				src.canattack=1
				J.Excluded=1
				J.uses++
				J.maxcooltime=5
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sharingan_Copy()
			for(var/obj/Jutsus/Sharingan_Copy/J in src.JutsusLearnt)
				if(Sharingan<=3)
					src<<output("You need to have a three-tomoe Sharingan activated to use this.","actionoutput")
					return
				if(ChakraCheck(50)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,3))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				if(src.jutsucopy==0)
					src.jutsucopy=1
					src << output("You will soon copy the next jutsu used by another Shinobi.","actionoutput")
				else
					if(src.jutsucopy==1)src.jutsucopy=0
					else
						if(isobj(src.jutsucopy))
							var/obj/O = src.jutsucopy
							src.JutsusLearnt+=O
							src.doslot(O.name)
							spawn(1)src.JutsusLearnt-=O
				J.Excluded=1
				J.uses++
				J.maxcooltime=5
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sharingan()
			for(var/obj/Jutsus/Sharingan/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(30-(J.level*5))) return
				if(src.Sharingan)
					src.Sharingan=0
					if(src.jutsucopy)src.jutsucopy=0
					src << output("<font color=[colour2html("red")]><b>You deactivate your Sharingan.","actionoutput")
					return
				var/Text
				if(J.level==1)
					Text="a one tomoe"
					J.name="Sharingan One Tomoe"
					J.icon_state="Sharingan 1 tomoe"
				if(J.level==2)
					Text="a two tomoe"
					J.name="Sharingan Two Tomoe"
					J.icon_state="Sharingan 2 tomoe"
				if(J.level==3)
					Text="a three tomoe"
					J.name="Sharingan Three Tomoe"
					J.icon_state="Sharingan 3 tomoe"
				if(J.level==4)
					Text="the legendary Mangekyou"
					J.name="Mangekyou Sharingan"
					J.icon_state="Mangekyou Sharingan"
					src.health -= round(src.health/100*15)
					src.Death(src)
				if(J.level==5)
					Text="the almighty Eternal Mangekyou"
					J.name="Eternal Mangekyou Sharingan"
					J.icon_state="Eternal Mangekyou"
					src.health -= round(src.health/100*0)
					src.Death(src)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,12))
				src.Levelup()
				src.UpdateHMB()
			//	flick("jutsuse",src)
				view(src)<<output("<font color=[colour2html("red")]><b>[src] says: Sharingan!","actionoutput")
				view(src)<<output("<font color=[colour2html("red")]><b>[src]'s eyes swirl to form [Text] Sharingan.","actionoutput")
				src.firing=1
				src.canattack=0
				src.Sharingan=J.level
				J.Excluded=1
				src.copy = "Cant move"
				spawn(2)if(src)
					src.firing=0
					src.copy=null
					src.canattack=1
				spawn(500)if(src)
					src << output("<font color=[colour2html("red")]><b>You deactivate your Sharingan.","actionoutput")
					src.Sharingan=0
					if(src.jutsucopy)src.jutsucopy=0
				src.JutsuCoolSlot(J)
				spawn()
					J.maxcooltime = 500
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Mud_Dragon_Projectile()
			for(var/obj/Jutsus/Mud_Dragon_Projectile/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(200)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*50
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Mud Dragon Projectile.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Mud Dragon Projectile.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Water_Dragon_Projectile()
			for(var/obj/Jutsus/Water_Dragon_Projectile/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(!has_water())
					src << output("<Font color=Aqua>You need a nearby water source to use this.</Font>","actionoutput")
					return
				var/mob/c_target=src.Target_Get(TARGET_MOB)

				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*50
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Water Dragon Projectile.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Water Dragon Projectile.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.ninjutsu*1.5)+round(src.strength*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Fire_Dragon_Projectile()
			for(var/obj/Jutsus/Fire_Dragon_Projectile/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view()<<sound('fire.wav')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*50
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'FireBallA.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.pixel_y=16
				Aa.pixel_x=-16
				Aa.layer = src.layer+1
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'FireBallA.dmi'
				A.dir = src.dir
				A.Owner=src
				A.pixel_y=16
				A.pixel_x=-16
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.damage=J.damage+round(src.ninjutsu*1.5)+round(src.strength*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Eight_Trigrams_Mountain_Crusher()
			for(var/obj/Jutsus/Eight_Trigrams_Mountain_Crusher/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(50)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view()<<sound('Beam.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*30
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Mountain Crusher.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.pixel_y=32
				Aa.layer = src.layer+1
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Mountain Crusher.dmi'
				A.dir = src.dir
				A.Owner=src
				A.pixel_y=32
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.damage=J.damage+round(src.ninjutsu)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Chidori_Jinrai()
			for(var/obj/Jutsus/Jinrai/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(25)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,3))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				icon_state="jutsuuse"
				view()<<sound('Beam.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*10
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(src.loc)
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.pixel_y=32
				Aa.layer = src.layer+1
				var/obj/Projectiles/Effects/JinraiHead/A=new(src.loc)
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.damage=J.damage+round(src.ninjutsu*2)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Kirin()
			for(var/obj/Jutsus/Kirin/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You must have a target to use this technique.","actionoutput")
					return
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				icon_state="jutsuuse"
				view()<<sound('Sounds/Thunder.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=70
				if(J.level==2) J.damage=100
				if(J.level==3) J.damage=125
				if(J.level==4) J.damage=150
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/Jutsu=4
				J.damage+=round(src.ninjutsu*4)
				var/Damage=J.damage/Jutsu
				if(c_target)
					c_target.injutsu=1
					c_target.move=0
					if(J.level==4)
						var/obj/Z=new
						Z.IsJutsuEffect=src
						Z.layer=MOB_LAYER+101
						Z.loc=c_target.loc
						Z.icon='Lightning God.dmi'
						Z.pixel_x-=85
						Z.pixel_y+=170
						spawn(24) del(Z)
					var/obj/O=new
					O.IsJutsuEffect=src
					O.layer=MOB_LAYER+100
					O.loc=c_target.loc
					O.icon='Kirin.dmi'
					O.pixel_x-=85
					O.pixel_y+=80
					while(Jutsu&&c_target)
						Jutsu--
						c_target.health-=Damage
						var/colour = colour2html("white")
						F_damage(c_target,Damage,colour)
						c_target.Death(src)
						sleep(6)
					del(O)
					if(c_target) // Maybe they were a nub and logged off while it was being cast.
						c_target.move=1
						c_target.injutsu=0
					move=1
					canattack=1
					firing=0
				icon_state=""
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Chidori_Needles()
			for(var/obj/Jutsus/Chidori_Needles/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(75)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,4))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('046.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=6
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=30
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=5
				if(c_target)
					while(num)
						sleep(1)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Weaponry/ChidoriNeedle/A = new/obj/Projectiles/Weaponry/ChidoriNeedle(src.loc)
						A.IsJutsuEffect=src
						A.density=0
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.5+src.strength*0.3)
						var/turf/Tg
						Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
						var/k = rand(1,5)
						spawn() switch(k)
							if(1)
								spawn(1) A.density=1
								walk_towards(A,c_target.loc,0)
							else
								spawn(1) A.density=1
								walk_towards(A,Tg,0)
						spawn(4)
							spawn(1) if(A) A.density=1
							if(A) walk(A,A.dir)
						num--
				else
					while(num)
						num--
						sleep(1)
						var/obj/Projectiles/Weaponry/ChidoriNeedle/A = new/obj/Projectiles/Weaponry/ChidoriNeedle(src.loc)
						A.IsJutsuEffect=src
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						step(A,A.dir)
						if(A)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu*1.5+src.strength*0.8)
						spawn() walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sand_Shuriken()
			for(var/obj/Jutsus/Sand_Shuriken/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(30))return
				if(!canattack)return
				canattack=0
				J.Excluded=1
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,7))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("throw",src)
				view(src)<<sound('Skill_MashHit.wav',0,0)
				J.uses++
				if(J.level==1) J.damage=2
				if(J.level==2) J.damage=4
				if(J.level==3) J.damage=6
				if(J.level==4) J.damage=7
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=5
				if(c_target)
					while(num)
						sleep(1)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Sand_Shuriken/A = new/obj/Projectiles/Effects/Sand_Shuriken(src.loc)
						A.IsJutsuEffect=src
						A.density=0
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.2+src.strength*0.2)
						var/turf/Tg
						Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
						var/k = rand(1,5)
						spawn() switch(k)
							if(1)
								spawn(1) A.density=1
								walk_towards(A,c_target.loc,0)
							else
								spawn(1) A.density=1
								walk_towards(A,Tg,0)
						spawn(4)
							spawn(1) if(A) A.density=1
							if(A) walk(A,A.dir)
						num--
				else
					while(num)
						sleep(1)
						num--
						var/obj/Projectiles/Effects/Sand_Shuriken/A = new/obj/Projectiles/Effects/Sand_Shuriken(src.loc)
						A.IsJutsuEffect=src
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						step(A,A.dir)
						if(A)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu*0.8+src.strength*0.8)
						spawn() walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Hunter_Scarabs()
			for(var/obj/Jutsus/Hunter_Scarabs/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(25)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("throw",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=8
				if(J.level==3) J.damage=14
				if(J.level==4) J.damage=20
				if(J.level<6) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level*2+(round(src.strength/23)+round(src.ninjutsu/23))
				if(c_target)
					while(num)
						sleep(1)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/HunterScarab/A = new/obj/Projectiles/Effects/HunterScarab(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/10+src.strength/5)
						A.dir = get_dir(A,c_target)
						walk_towards(A,c_target.loc,5)
						spawn(25)if(A)walk(A,A.dir,5)
				else
					while(num)
						sleep(1)
						num--
						var/obj/Projectiles/Effects/HunterScarab/A = new/obj/Projectiles/Effects/HunterScarab(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/10+src.strength/5)
						A.dir = src.dir
						if(A)walk(A,A.dir,5)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		ClaySpiders()
			for(var/obj/Jutsus/C1_Spiders/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(25)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=8
				if(J.level==3) J.damage=14
				if(J.level==4) J.damage=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level+(round(src.ninjutsu/20))
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						A.icon_state = "Spider Swarm"
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/1.2+src.strength/4)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir,5)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.icon_state = "Spider Swarm"
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/1.2+src.strength/4)
						walk_away(A,src)
						spawn(4)if(A)walk(A,A.dir,5)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		ClayBirds()
			for(var/obj/Jutsus/C1_Birds/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(50)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=2
				if(J.level==2) J.damage=4
				if(J.level==3) J.damage=6
				if(J.level==4) J.damage=8
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level+(round(src.ninjutsu/13))
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.pixel_y+=rand(3,5)
						else A.pixel_y-=rand(1,5)
						if(prob(50))A.pixel_x+=rand(3,8)
						else A.pixel_x-=rand(1,8)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.8+src.strength/4)
						if(c_target) walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.9+src.strength/4)
						walk(A,src.dir)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sickle_Weasel_Technique()
			for(var/obj/Jutsus/Sickle_Weasel_Technique/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(50))return
				if(firing)return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('wirlwind.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=2
				if(J.level==2) J.damage=3
				if(J.level==3) J.damage=4
				if(J.level==4) J.damage=5
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level*2
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Weaponry/SickleSlash/A = new/obj/Projectiles/Weaponry/SickleSlash(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.pixel_y+=rand(3,5)
						else A.pixel_y-=rand(1,5)
						if(prob(50))A.pixel_x+=rand(3,8)
						else A.pixel_x-=rand(1,8)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/15)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Weaponry/SickleSlash/A = new/obj/Projectiles/Weaponry/SickleSlash(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						walk(A,src.dir)
				spawn(5)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Chakra_Control()
			for(var/obj/Jutsus/Chakra_Control/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(35)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				if(src.waterwalk)
					waterwalk=0
					src<<output("You stop converting chakra to your feet.","actionoutput")
					J.Excluded=1
					J.uses++
					J.maxcooltime=120
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
					return
				waterwalk=1
				src<<output("You start converting chakra to your feet.","actionoutput")
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Blade_of_Wind() // I'm not sure what this is, but it looks like a hastily made Jutsu. Perhaps we could brainstorm something else? - Zetaiva
			for(var/obj/Jutsus/Blade_of_Wind/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(50)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				src.Levelup()
				if(src.BOW<J.level*2)src.BOW++
				src<<output("You charge chakra to your fingertips, and now have stocked [src.BOW] Blades of Wind.","actionoutput")
				J.Excluded=1
				J.uses++
				J.maxcooltime=50
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		/*Raikiri() // This is not how Raikiri is. I removed it, and changed it with a altered version of Chidori. - Zetaiva
			for(var/obj/Jutsus/Raikiri/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				src.Levelup()
				if(src.LOW<J.level)
					src.LOW++
				src<<output("You charge chakra to your fingertips, and now have stocked [src.LOW] Lightning Blade strikes.","actionoutput")
				J.Excluded=1
				J.uses++
				J.maxcooltime=100
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)*/
		Cherry_Blossom_Impact()
			for(var/obj/Jutsus/Cherry_Blossom_Impact/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(100)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				src.Levelup()
				if(src.COW<J.level*3)src.COW++
				src<<output("You precisely charge chakra to your hands, and now have stocked [src.COW] punches.","actionoutput")
				J.Excluded=1
				J.uses++
				J.maxcooltime=100
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Body_Replacement_Technique()
			for(var/obj/Jutsus/BodyReplace/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(15)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,5))
				src.Levelup()
				src.UpdateHMB()
				view(src)<<sound('flashbang_explode1.wav',0,0)
				var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
				A.IsJutsuEffect=src
				A.loc=src.loc
				var/obj/B = new/obj/Training/BDLogB(src.loc)
				B.IsJutsuEffect=src
				B.loc=src.loc
				J.Excluded=1
				J.uses++
				for(var/mob/M in oview(src,13))M.Target_Remove()
				if(J.level<4)
					if(loc.loc:Safe!=1) J.exp=J.maxexp
					J.Levelup()
				if(J.level==1)
					src.Step_Back()
					J.maxcooltime=110
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
				if(J.level==2)
					src.injutsu=1
					src.Step_Back()
					src.Step_Back()
					src.injutsu=0
					J.maxcooltime=100
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
				if(J.level==3)
					src.overlays=0
					src.Name(src.name)
					src.RestoreOverlays()
					src.injutsu=1
					src.Step_Back()
					src.Step_Back()
					src.Step_Back()
					src.injutsu=0
					J.maxcooltime=90
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
						src.UpdateHMB()
						src.Name(src.name)
						src.icon_state=""
						src.RestoreOverlays()
				if(J.level>=4 || J.level==4)
					B.icon=src.icon
					B.icon_state=src.icon_state
					B.overlays=0
					B.overlays=src.overlays
					B.dir=src.dir
					src.overlays=0
					src.Name(src.name)
					src.RestoreOverlays()
					src.injutsu=1
					src.Step_Back()
					src.Step_Back()
					src.Step_Back()
					src.Step_Back()
					src.injutsu=0
					J.maxcooltime=80
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
						src.UpdateHMB()
						src.Name(src.name)
						src.icon_state=""
						src.RestoreOverlays()
		Shikigami_Dance()
			for(var/obj/Jutsus/Shikigami_Dance/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/player/c_target=usr.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You must have a target to use this technique.","actionoutput")
					return
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wirlwind.wav',0,0)
				J.Excluded=1
				J.uses++
				src.move=0
				src.canattack=0
				src.injutsu=1
				src.firing=1
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=15
				if(J.level==3) J.damage=20
				if(J.level==4) J.damage=30
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/Timer=J.level
				c_target.move=0
				c_target.canattack=0
				c_target.injutsu=1
				c_target.firing=1
				c_target.overlays+='Shikigami Dance.dmi'
				if(src.inAngel==1)
					Timer=J.level*2
				spawn(10)
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)

				while(Timer&&c_target)
					sleep(5)
					Timer--
					if(J.level==1)
						c_target.health-=round(src.ninjutsu*0.3)
					if(J.level==2)
						c_target.health-=round(src.ninjutsu*0.6)
					if(J.level==3)
						c_target.health-=round(src.ninjutsu*0.9)
					if(J.level==4)
						c_target.health-=round(src.ninjutsu*1.1)
					c_target.Death(src)
				spawn()
				if(c_target)
					c_target.move=1
					c_target.canattack=1
					c_target.injutsu=0
					c_target.firing=0
					c_target.overlays-='Shikigami Dance.dmi'
				src.move=1
				src.canattack=1
				src.injutsu=0
				src.firing=0
		Advanced_Body_Replacement_Technique()
			for(var/obj/Jutsus/AdvancedBodyReplace/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(50)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				src.Levelup()
				src.kawarmi=1
				src.mark=src.loc
				J.Excluded=1
				J.uses++
				src<<output("Now to activate use the defend verb.","actionoutput")
				J.maxcooltime=400
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Blade_Manipulation_Jutsu()
			for(var/obj/Jutsus/Blade_Manipulation_Jutsu/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(60))return
				if(J.Excluded)return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,4))
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				J.Excluded=1
				J.uses++
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=4
				if(J.level==2) J.damage=5
				if(J.level==3) J.damage=6
				if(J.level==4) J.damage=7
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=round(J.level*1.5)
				if(c_target)
					while(num)
						sleep(1)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Maniper/A = new/obj/Projectiles/Effects/Maniper(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1)if(A)A.density=1
						walk_towards(A,c_target,0)
						spawn(7)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(1)
						num--
						var/obj/Projectiles/Effects/Maniper/A = new/obj/Projectiles/Effects/Maniper(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1) if(A) A.density=1
						walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Ones_Own_Life_Reincarnation()
			for(var/obj/Jutsus/Ones_Own_Life_Reincarnation/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(10))return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				src.Levelup()
				J.Excluded=1
				J.uses++
				src.move=0
				src.canattack=0
				src.injutsu=1
				src.firing=1
				flick("groundjutsu",src)
				src.icon_state = "groundjutsuse"
				for(var/mob/M in src.loc)
					if(M.icon_state == "dead" && M.client && M.dead)
						M.revived=1
						M.dead=0
						M.KOs=0
						M.density=1
						M.health=M.maxhealth
						M.chakra=M.maxchakra
						M.injutsu=0
						M.canattack=1
						M.firing=0
						M.icon_state=""
						M.wait=0
						M.rest=0
						M.dodge=0
						M.move=1
						M.swimming=0
						M.overlays=0
						M.RestoreOverlays()
						M.UpdateHMB()
						spawn(1)M.Run()
						src.health=0-1
						src.Death(M)
						spawn(600)if(M)if(M.revived)M.revived=0
				spawn(5)if(src)
					src.icon_state = ""
					src.move=1
					src.canattack=1
					src.injutsu=0
					src.firing=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Earth_Style_Dark_Swamp()
			for(var/obj/Jutsus/Earth_Style_Dark_Swamp/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(50))return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				J.Excluded=1
				J.uses++
				src.move=0
				src.canattack=0
				src.injutsu=1
				src.firing=1
				flick("groundjutsu",src)
				src.icon_state = "groundjutsuse"
				var/mob/M
				if(c_target)M = c_target
				else M = src
				for(var/turf/T in view(0,M))new/obj/ESDS(T)
				spawn(1)
					for(var/turf/T in view(1,M))new/obj/ESDS(T)
					spawn(1)for(var/turf/T in view(2,M))new/obj/ESDS(T)
				spawn(5)
					src.icon_state = ""
					src.move=1
					src.canattack=1
					src.injutsu=0
					src.firing=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Paper_Chakram()
			for(var/obj/Jutsus/Paper_Chakram/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(300)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("throw",src)
				view(src)<<sound('083.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=1
				if(J.level==2) J.damage=3
				if(J.level==3) J.damage=7
				if(J.level==4) J.damage=10
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/Paper_Chakram/A = new/obj/Projectiles/Effects/Paper_Chakram(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					var/turf/TZ = c_target.loc
					walk_towards(A,TZ,0)
					spawn(7)if(A)walk(A,A.dir)
				else
					var/obj/Projectiles/Effects/Paper_Chakram/A = new/obj/Projectiles/Effects/Paper_Chakram(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk(A,src.dir)
				spawn(1)
					src.firing=0
					src.canattack=1
				J.maxcooltime=100
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Shikigami_Spear()
			for(var/obj/Jutsus/Shikigami_Spear/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				view(src)<<sound('wirlwind.wav',0,0)
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*50
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Shikigami Spear.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Shikigami Spear.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*1.1)+round(src.ninjutsu*4)
				A.level=J.level
				walk(A,dir,0)
				if(src.inAngel==1)
					src.firing=0
					src.canattack=1
					src.move=1
				else
					spawn(20)
						src.firing=0
						src.canattack=1
						src.move=1
				icon_state=""
				Aa.dir = src.dir
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Destruction_Bug_Swarm()
			for(var/obj/Jutsus/Destruction_Bug_Swarm/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(30)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('bugs.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=2
				if(J.level==2) J.damage=4
				if(J.level==3) J.damage=6
				if(J.level==4) J.damage=13
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/Bug_Swarm/A = new/obj/Projectiles/Effects/Bug_Swarm(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu/13)
					A.level=J.level
					walk_towards(A,c_target.loc,0)
					spawn(4)if(A)walk(A,A.dir)
				else
					var/obj/Projectiles/Effects/Bug_Swarm/A = new/obj/Projectiles/Effects/Bug_Swarm(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu/23)
					A.level=J.level
					walk(A,src.dir)
				spawn(20)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Shukakku_Spear()
			for(var/obj/Jutsus/Shukakku_Spear/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(90)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("punchl",src)
				view(src)<<sound('Skill_MashHit.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=15
				if(J.level==2) J.damage=20
				if(J.level==3) J.damage=25
				if(J.level==4) J.damage=30
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/Shukakku_Spear/A = new/obj/Projectiles/Effects/Shukakku_Spear(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu*2)
					A.level=J.level
					walk_towards(A,c_target.loc,0)
					spawn(4)
					if(A)  walk(A,A.dir)
				else
					var/obj/Projectiles/Effects/Shukakku_Spear/A = new/obj/Projectiles/Effects/Shukakku_Spear(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu*2)
					A.level=J.level
					walk(A,src.dir)
				spawn(20)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Fire_Ball()
			for(var/obj/Jutsus/FireBall/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(60)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,9))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('fire.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=20
				if(J.level==3) J.damage=30
				if(J.level==4) J.damage=40
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu/3)
					A.level=J.level
					walk_towards(A,c_target.loc,0)
					spawn(4)if(A)walk(A,A.dir)
				else
					var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu/3)
					A.level=J.level
					walk(A,src.dir)
				spawn(10)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Phoenix_Immortal_Fire_Technique()
			for(var/obj/Jutsus/PheonixFire/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(45))return
				if(firing)return
				src.firing=1
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.LevelStat("Ninjutsu",rand(5,8))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Phoenix Immortal Fire Technique"
				flick("jutsuse",src)
				view(src)<<sound('fire.wav',0,0)
				J.Excluded=1
				src.canattack=0
				J.uses++
				var/I=J.level*2
				if(J.level==1) J.damage=2
				if(J.level==2) J.damage=3
				if(J.level==3) J.damage=4
				if(J.level==4) J.damage=5
				if(J.level<4)
					J.exp+=rand(2,5)
					J.Levelup()
				spawn(10)
					while(I)
						I--
						sleep(2)
						if(c_target)
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.pixel_y+=rand(1,8)
							else A.pixel_y-=rand(1,8)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/7)
							A.level=J.level
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
						else
							var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.pixel_y+=rand(1,8)
							else A.pixel_y-=rand(1,8)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=src
							A.fightlayer=src.fightlayer
							A.layer=src.layer
							A.damage=J.damage+round(src.ninjutsu/7)
							A.level=J.level
							walk(A,src.dir)
				src.client.eye=src
				src.copy=null
				spawn(10)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		AFire_Ball()
			for(var/obj/Jutsus/AFireBall/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(170))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('fire.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=20
				if(J.level==2) J.damage=30
				if(J.level==3) J.damage=40
				if(J.level==4) J.damage=50
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/AFireBall/A = new/obj/Projectiles/AFireBall(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu*2)
					A.level=J.level
					walk_towards(A,c_target.loc,0)
					spawn(4)if(A)walk(A,A.dir)
				else
					var/obj/Projectiles/AFireBall/A = new/obj/Projectiles/AFireBall(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu*2)
					A.level=J.level
					walk(A,src.dir)
				spawn(10)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Eight_Trigrams_64_Palms()
			if(src.byakugan==0)
				src<<output("<font color=#C0C0C0>You must have Byakugan activated.</font>","actionoutput")
				return
			for(var/obj/Jutsus/Eight_Trigrams_64_Palms/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(350)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				var/obj/O = new/obj
				O.IsJutsuEffect=src
				O.loc = src.loc
				O.icon = '50Palms.dmi'
				O.icon_state = ""
				flick("start",O)
				O.pixel_y-=32
				O.pixel_x-=87
				spawn(100) if(O) del(O)
				spawn(7) O.icon_state = "done"
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=1
				if(J.level==2) J.damage=2
				if(J.level==3) J.damage=3
				if(J.level==4) J.damage=4
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15)
				J.Levelup()
				var/check=0
				if(c_target)
					src.loc = c_target.loc
					step_away(src,c_target)
					src.dir=get_dir(src,c_target)
				src.injutsu=1
				for(var/mob/m in get_step(src,src.dir))
					m.move=0
					Prisoner=m
					spawn(50)
						if(m)m.move=0
						if(src)Prisoner=null
				while(check<>1)
					sleep(1)
					src.copy = "Hakke"
					view() << output("<font color=#C0C0C0><b>[src] Says: 8 palms!","actionoutput")
					var/obj/A = new/obj
					A.IsJutsuEffect=src
					A.loc = src.loc
					A.icon = 'Misc Effects.dmi'
					A.icon_state = "arrow"
					A.y+=3
					A.dir = pick(EAST,WEST,NORTH,SOUTH)
					A.layer=1000000000000000
					src.ArrowTasked = A
					step(src,src.dir)
					if(c_target)step_towards(src,c_target)
					sleep(16)
					if(A) del(A)
					if(src.copy <> "Hakke" && J.level>=1 && J.level <> 1)
						src.copy = "Hakke2"
						view() << output("<font color=#C0C0C0><b>[src] Says: 16 palms!","actionoutput")
						var/obj/A2 = new/obj
						A2.IsJutsuEffect=src
						A2.loc = src.loc
						A2.icon = 'Misc Effects.dmi'
						A2.icon_state = "arrow"
						A2.y+=3
						A2.dir = pick(EAST,WEST,NORTH,SOUTH)
						A2.layer=1000000000000000
						src.ArrowTasked = A2
						step(src,src.dir)
						if(c_target)step_towards(src,c_target)
						sleep(25)
						if(A2)del(A2)
						if(src.copy <> "Hakke2" && J.level>=1 && J.level <> 1)
							src.copy = "Hakke3"
							view() << output("<font color=#C0C0C0><b>[src] Says: 32 palms!","actionoutput")
							var/obj/A3 = new/obj
							A3.IsJutsuEffect=src
							A3.loc = src.loc
							A3.icon = 'Misc Effects.dmi'
							A3.icon_state = "arrow"
							A3.y+=3
							A3.dir = pick(EAST,WEST,NORTH,SOUTH)
							A3.layer=1000000000000000
							src.ArrowTasked = A3
							step(src,src.dir)
							if(c_target)step_towards(src,c_target)
							sleep(25)
							if(A3) del(A3)
							if(src.copy <> "Hakke3" && J.level>=2 && J.level <> 2)
								src.copy = "Hakke4"
								view() << output("<font color=#C0C0C0><b>[src] Says: 64 PALMS!","actionoutput")
								check=1
								var/obj/A4 = new/obj
								A4.IsJutsuEffect=src
								A4.loc = src.loc
								A4.icon = 'Misc Effects.dmi'
								A4.icon_state = "arrow"
								A4.y+=3
								A4.dir = pick(EAST,WEST,NORTH,SOUTH)
								A4.layer=1000000000000000
								src.ArrowTasked = A4
								step(src,src.dir)
								if(c_target)step_towards(src,c_target)
								sleep(25)
								if(A4) del(A4)
							else check=1
						else check=1
					else check=1
					for(var/mob/m in get_step(src,src.dir))
						m.move=1
					Prisoner=null
					flick("over",O)
					spawn(7) del(O)
					src.copy = "Cant move"
					spawn(10)if(src)
						src.firing=0
						src.copy=null
						src.injutsu=0
						src.canattack=1
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
		Kaiten()
			for(var/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(70)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
				view(src)<<sound('Powerup.ogg',0,0)
				spawn(7)
					view(src)<<sound('Powerup.ogg',0,0)
					spawn(7)if(src)view(src)<<sound('Powerup.ogg',0,0)
				var/obj/O = new/obj
				O.IsJutsuEffect=src
				O.loc = src.loc
				O.pixel_x-=(3.5*32)
				O.pixel_y-=(1*32)
				O.icon = 'Kaiten.dmi'
				O.icon_state = ""
				O.layer=200
				src.injutsu=1
				src.dir = SOUTH
				flick("throw",src)
				spawn(1) src.dir=EAST; spawn(1) src.dir = NORTH; spawn(1) src.dir = WEST; spawn(1) src.dir = SOUTH
				src.icon_state = "jutsuse"
				flick("start",O)
				sleep(7)
				O.icon_state = "Loop"
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				if(J.level==4)
					for(var/mob/M in range(4))
						if(!istype(M,/mob/NPC) && M.injutsu==0 && !M.dead && !M.swimming)
							var/ki = get_dist(M,src)
							for(var/i=0,i<ki,i++) spawn() step_away(M,src); sleep(1.5)
				for(var/i=0,i<J.level*12,i++)
					for(var/obj/Projectiles/Weaponry/Ok in orange(J.level))
						walk_to(Ok,0)
						step_away(Ok,src)
						walk(Ok,Ok.dir)
					for(var/obj/Projectiles/Ok in orange(J.level))
						walk_to(Ok,0)
						step_away(Ok,src)
						walk(Ok,Ok.dir)
					for(var/mob/M in orange(1))
						if(M.dead || M.swimming) continue
						if(!istype(M,/mob/NPC))
							M.icon_state="push"
							M.injutsu=1
							M.health-=J.damage+src.ninjutsu*2
							var/IA = rand(1,2)
							if(IA==1)step_away(M,src)
							var/colour = colour2html("white")
							F_damage(M,J.damage+src.ninjutsu*2,colour)
							if(M.client)spawn() M.ScreenShake(20)
							if(M)
								walk(M,0)
								M.injutsu=0
								if(!M.swimming&&!M.dead)M.icon_state=""
								M.Death(src)
					sleep(1)
				O.icon_state = ""
				O.pixel_x-=32
				O.pixel_x-=16
				O.pixel_x-=8
				flick("end",O)
				sleep(5)
				if(O)del(O)
				src.copy = "Cant move"
				src.icon_state = ""
				spawn(3)if(src)
					src.firing=0
					src.injutsu=0
					src.copy=null
					src.canattack=1
					src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Rinnegan()
			for(var/obj/Jutsus/Rinnegan/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(30)) return
				if(src.Rinnegan==1)
					for(var/image/i in client.images)if(i.name=="RinneganCircle")del(i)
					src.Rinnegan=0
					src << output("<font color=#C0C0C0><b>You deactivate Rinnegan","actionoutput")
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
				src << output("<font color=#C0C0C0><b>[src] activates Rinnegan.","actionoutput")
				src.Levelup()
				src.UpdateHMB()
				src.Rinnegan=1
				J.Excluded=1
				J.uses++
				if(J.level<4)
					if(loc.loc:Safe!=1) J.exp+=rand(5,15)
					J.Levelup()
				spawn()
					while(src.Rinnegan)
						if(src)
							for(var/atom/movable/ZX in orange())
								var/minusx=-16
								if(ismob(ZX))minusx=0
								if(ZX.byakuview == 1)
									var/QWE = image('Rinneglow.dmi',layer=600,loc = ZX,pixel_x=minusx)
									if(istype(ZX,/mob/Clones/)) QWE+=rgb(255,0,0)
									src << QWE
									spawn(2)if(QWE)del(QWE)
						sleep(1)
				spawn(500)
					//if(O)
					if(src)
					//		del(O)
						src << output("<font color=#C0C0C0><b>You deactivate Rinnegan","actionoutput")
						src.Rinnegan=0
				if(src)
					src.JutsuCoolSlot(J)
					spawn()
						J.maxcooltime = 500
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Byakugan()
			for(var/obj/Jutsus/Byakugan/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(30)) return
				if(src.byakugan==1)
					for(var/image/i in client.images)if(i.name=="ByakuganCircle")del(i)
					src.byakugan=0
					src << output("<font color=#C0C0C0><b>You deactivate your Byakugan","actionoutput")
					src.client.eye=src
					src.client:perspective = EDGE_PERSPECTIVE
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
				view(src)<<output("<font color=#C0C0C0><b>[src] Says: Byakugan!","actionoutput")
				src.firing=1
				src.canattack=0
				src.byakugan=1
				J.Excluded=1
				J.uses++
				if(J.level<4)
					if(loc.loc:Safe!=1) J.exp+=rand(5,15)
					J.Levelup()
				src.copy = "Cant move"
				spawn(2)if(src)
					src.firing=0
					src.copy=null
					src.canattack=1
				spawn()
					while(src.byakugan)
						sleep(1)
						if(src)
							for(var/atom/movable/ZX in orange())
								if(!ZX) continue
								sleep(1)
								var/minusx=-16
								if(ismob(ZX))minusx=0
								if(ZX) if(ZX.byakuview == 1)
									var/QWE = image('byakuglow.dmi',layer=600,loc = ZX,pixel_x=minusx)
									if(istype(ZX,/mob/Clones/)) QWE+=rgb(255,0,0)
									src << QWE
									spawn(2)if(QWE)del(QWE)
				spawn(500)
					//if(O)
					if(src)
					//		del(O)
						src << output("<font color=#C0C0C0><b>You deactivate your Byakugan","actionoutput")
						src.client.eye=src
						src.client:perspective = EDGE_PERSPECTIVE
						src.byakugan=0
				if(src)
					src.JutsuCoolSlot(J)
					spawn()
						J.maxcooltime = 500
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Water_Release_Exploding_Water_Colliding_Wave()
			for(var/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(63)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('man_fs_r_mt_wat.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				spawn(10-(J.level*2))
					if(src)if(src)
						src.firing=0
						src.canattack=1
						src.copy = null
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=30
				J.damage+=round(src.ninjutsu/10)
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				var/obj/O = new/obj
				O.IsJutsuEffect=src
				O.loc = src.loc
				O.icon = 'Wave.dmi'
				O.icon_state = "mid"
				O.name="Wave"
				O.overlays+=image('Wave.dmi',icon_state = "top",pixel_y=32)
				O.overlays+=image('Wave.dmi',icon_state = "bottom",pixel_y=-32)
				O.overlays+=image('Wave.dmi',icon_state = "left",pixel_x=-32)
				O.overlays+=image('Wave.dmi',icon_state = "right",pixel_x=32)
				spawn(5)
					if(src)
						if(O)O.dir = src.dir
						var/moves=0
						while(moves<>(10+J.level))
							moves+=1
							sleep(1)
							if(O) step(O,O.dir)
							if(O)
								var/turf/T = O.loc
								if(T.density)moves=10
								else
									for(var/obj/Projectiles/Effects/OnFire/Fire in O.loc)del(Fire)
									for(var/obj/Projectiles/Effects/Fire/Fire in O.loc)	del(Fire)
									for(var/obj/Projectiles/Effects/MasterFireNoSound/Fire in O.loc)del(Fire)
									for(var/obj/Projectiles/Effects/MasterFire/Fire in O.loc)del(Fire)
									for(var/mob/M in O.loc)
										if(M.dead || M.swimming) continue
										if(M) M.icon_state = "push"
										if(M) step(M,O.dir)
										if(M) M.dir = get_dir(M,O)
										if(M) M.health-=J.damage
										if(M) M.Death(src)
										var/colour = colour2html("white")
										F_damage(M,J.damage,colour)
										spawn(1)if(M)M.icon_state = ""
									var/obj/W3 = new/obj/watercreate
									W3.IsJutsuEffect=src
									W3.loc=O.loc
									switch(O.dir)
										if(EAST)
											O.pixel_x=32
											var/obj/W = new/obj/watercreate
											W.IsJutsuEffect=src
											W.loc=O.loc
											W.y-=1
											var/obj/W2 = new/obj/watercreate
											W2.IsJutsuEffect=src
											W2.loc=O.loc
											W2.y+=1
										if(WEST)
											O.pixel_x=-32
											var/obj/W = new/obj/watercreate
											W.IsJutsuEffect=src
											W.loc=O.loc
											W.y-=1
											var/obj/W2 = new/obj/watercreate
											W2.IsJutsuEffect=src
											W2.loc=O.loc
											W2.y+=1
										if(NORTH)
											O.pixel_y=32
											var/obj/W = new/obj/watercreate
											W.IsJutsuEffect=src
											W.loc=O.loc
											W.x-=1
											var/obj/W2 = new/obj/watercreate
											W2.IsJutsuEffect=src
											W2.loc=O.loc
											W2.x+=1
										if(SOUTH)
											O.pixel_y=-32
											var/obj/W = new/obj/watercreate
											W.IsJutsuEffect=src
											W.loc=O.loc
											W.x-=1
											var/obj/W2 = new/obj/watercreate
											W2.IsJutsuEffect=src
											W2.loc=O.loc
											W2.x+=1
							sleep(1)
					if(O)del(O)
				src.copy = "Cant move"
				spawn(10-(J.level*2))
					if(src)
						src.firing=0
						src.copy=null
						src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Fire_Release_Ash_Pile_Burning()
			for(var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(150)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level<4)
					if(loc.loc:Safe!=1) J.exp+=rand(5,15)
					J.Levelup()
				src.injutsu=1
				src.icon_state = "jutsuse"
				var/obj/Z = new/obj
				Z.loc = src.loc
				Z.density=1
				var/R=5
				while(R)
					sleep(1)
					R--
					step(Z,src.dir)
				Z.density=0
				var/U = get_dist(Z,src)
				U-=1
				for(var/turf/T in orange(U,Z))
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.icon = 'Smoke.dmi'
					O.icon_state = "still"
					O.loc = T
					O.owner=src
					spawn(150) if(O) del(O)
				src.copy = "Ashes"
				var/obj/A = new/obj
				A.IsJutsuEffect=src
				A.loc = src.loc
				A.icon = 'Misc Effects.dmi'
				A.icon_state = "arrow"
				A.y+=3
				A.dir = SOUTH
				A.layer=1000000000000000
				src.ArrowTasked = A
				spawn(150)
					if(ArrowTasked==A) ArrowTasked=null; src.copy=null; del(A)
				src << output("<Font color=[colour2html("orange")]>Press down to ignite the ashes.</Font>","actionoutput")
				for(var/obj/As in get_step(src,src.dir))
					As.layer=OBJ_LAYER
				while(src.copy == "Ashes")
					sleep(1)
				src.copy = "Cant move"
				spawn(10-(J.level*2))
					src.firing=0
					src.copy=null
					src.injutsu=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
obj
	proc
		Dup(mob/M)
			var/obj/O8 = new/obj
			O8.IsJutsuEffect=M
			O8.icon = 'Smoke.dmi'
			O8.icon_state = "still"
			O8.loc = src.loc
			step(O8,src.dir)
			step_rand(O8)
			for(var/obj/O in O8.loc)if(O8 && O <> O8)del(O8)
			if(O8)
				var/turf/T = O8.loc
				if(T.density)if(O8)del(O8)
			if(O8)
				O8.owner = M
				spawn(2)if(M.copy == "Ashes" && src) O8.Dup(M)
				spawn(150)if(O8)del(O8)
mob
	proc
		Shunshin()
			for(var/obj/Jutsus/Body_Flicker/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(!move) return
				if(injutsu) return
				if(copy=="Climb") return
				if(ChakraCheck(15)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				src.move=0
				J.uses++
				if(J.level==1) J.damage=1
				if(J.level==2) J.damage=2
				if(J.level==3) J.damage=3
				if(J.level==4) J.damage=4
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				if(c_target)
					if(c_target.opponent) return
					flick('Shunshin.dmi',src)
					spawn(1)
						src.loc = c_target.loc
						step(src,c_target.dir)
						src.dir = get_dir(src,c_target)
				else
					flick('Shunshin.dmi',src)
					spawn(1)for(var/i=0,i<J.damage*3+1,i++)step(src,src.dir)
				src.move=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
				spawn(8)if(src)
					src.firing=0
					src.move=1
					src.canattack=1
		Demonic_Ice_Mirrors()
			for(var/obj/Jutsus/Demonic_Ice_Mirrors/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(100)) return
				if(!has_water())
					src << output("<Font color=Aqua>You need a nearby water source to use this.</Font>","actionoutput")
					return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(c_target)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					src.Levelup()
					src.UpdateHMB()
					//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
					flick("jutsuse",src)
					view(src)<<sound('man_fs_l_mt_wat.ogg',0,0)
					src.firing=1
					src.canattack=0
					J.Excluded=1
					src.pixel_x=4
					J.uses++
					c_target.move=0
					c_target.injutsu=1
					c_target.canattack=0
					c_target.firing=1
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=15
					if(J.level==3) J.damage=25
					if(J.level==4) J.damage=30
					J.damage=J.damage+(src.ninjutsu/2.5)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					for(var/i=1,i<8+1,i++)
						var/obj/O = new/obj
						O.IsJutsuEffect=src
						O.loc = c_target.loc
						O.icon = 'Ice Mirrors.dmi'
						O.icon_state = "rawr"
						O.density=1
						O.layer = MOB_LAYER
						O.owner=src
						switch(i)
							if(1) O.dir = NORTHEAST
							if(2) O.dir = NORTHWEST
							if(3) O.dir = SOUTHEAST
							if(4) O.dir = SOUTHWEST
							if(6) O.dir = EAST
							if(7) O.dir = SOUTH
							if(8) O.dir = WEST
							if(5)
								O.dir = NORTH
								src.loc = O.loc
								src.dir=SOUTH
								O.layer = OBJ_LAYER
								src.injutsu=1
						for(var/ifd=0,ifd<3,ifd++)
							var/IOU = O.dir
							switch(O.dir)
								if(EAST) step(O,WEST)
								if(WEST) step(O,EAST)
								if(SOUTH) step(O,NORTH)
								if(NORTH) step(O,SOUTH)
								if(NORTHEAST) step(O,SOUTHWEST)
								if(NORTHWEST) step(O,SOUTHEAST)
								if(SOUTHEAST) step(O,NORTHWEST)
								if(SOUTHWEST) step(O,NORTHEAST)
							O.dir = IOU
						O.damage = J.damage
						O.name = "[i]"
					src.invisibility=1
					src.injutsu=1
					src.loc = c_target.loc
					step(src,NORTH)
					step(src,NORTH)
					var/turf/NS = get_step(src,NORTH)
					for(var/obj/Ouu in NS)if(Ouu.owner == src)src.loc = NS
					src.dir=SOUTH
					for(var/ivc=0,ivc<33*J.level,ivc++)
						if(src.ArrowTasked==null)
							var/olist = list()
							for(var/obj/Osd in view())if(Osd.owner == src)olist+=Osd
							if(length(olist))
								var/obj/IC = pick(olist)
								src.copy = "Icemir [IC.name]"
								var/image/A3 = new/obj
								A3.loc = IC.loc
								A3.icon = 'Misc Effects.dmi'
								A3.icon_state = "arrow"
								A3.y+=3
								A3.dir = pick(EAST,NORTH,SOUTH,WEST)
								A3.layer=1000000000000000
								src.ArrowTasked = A3
								spawn(16)
									if(A3)
										var/obj/AT = src.ArrowTasked
										del(AT)
										src.ArrowTasked=null
						sleep(1)
					var/obj/AkT = src.ArrowTasked
					del(AkT)
					src.ArrowTasked=null
					for(var/obj/Ohh in view())
						if(Ohh.icon == 'Ice Mirrors.dmi' && Ohh.owner == src)
							Ohh.invisibility=1
							Ohh.density=0
							Ohh.owner=null
							spawn(20)if(Ohh)del(Ohh)
						if(Ohh)if(Ohh.name == "GUI [src.key]")	del(Ohh)
					src.pixel_x=-16
					src.copy = "Cant move"
					spawn(10-(J.level*2))if(src)
						src.invisibility=0
						src.copy = null
						src.firing=0
						src.injutsu=0
						src.copy=null
						src.canattack=1
					if(c_target)
						c_target.move=1
						c_target.injutsu=0
						c_target.canattack=1
						c_target.firing=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
				else src << output("<Font color=Aqua>You need a target to use this.</Font>","actionoutput")
		has_water()
			for(var/turf/T in view()) if(T.iswater==1) return T
			return null
		Sensatsu_Suisho()
			for(var/obj/Jutsus/Sensatsu_Suishou/J in src.JutsusLearnt)
				if(J.Excluded==0)
					if(ChakraCheck(45)) return
					if(!has_water())
						src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","actionoutput")
						return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("<Font color=Aqua>You need a target to use this.</Font>","actionoutput")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
					src.Levelup()
					src.UpdateHMB()
					//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
					flick("jutsuse",src)
					src.injutsu=1
					src.firing=1
					src.canattack=0
					J.Excluded=1
					J.uses++
					if(J.level==1) J.damage=30
					if(J.level==2) J.damage=40
					if(J.level==3) J.damage=50
					if(J.level==4) J.damage=60
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					if(c_target)
						sleep(3)
						view(src)<<sound('man_fs_r_mt_con.ogg',0,0)
						view(src)<<sound('man_fs_r_mt_con.ogg',0,0)
						view(src)<<sound('man_fs_r_mt_con.ogg',0,0)
						view(src)<<sound('man_fs_r_mt_con.ogg',0,0)
						sleep(7)
						if(c_target)
							view(src)<<sound('man_fs_r_mt_wat.ogg',0,0)
							for(var/i=1,i<8+1,i++)
								var/obj/O = new/obj
								O.IsJutsuEffect=src
								O.animate_movement = SYNC_STEPS
								O.icon = 'Sensastsu Suisho.dmi'
								O.loc = c_target.loc
								O.pixel_x=-32
								O.pixel_y=-32
								switch(i)
									if(1) O.dir = NORTHEAST
									if(2) O.dir = NORTHWEST
									if(3) O.dir = SOUTHEAST
									if(4) O.dir = SOUTHWEST
									if(5) O.dir = NORTH
									if(6) O.dir = EAST
									if(7) O.dir = SOUTH
									if(8) O.dir = WEST
								for(var/x=0,x<3,x++)step(O,O.dir)
								O.pixel_y=16
								O.layer=200
								O.icon_state = "live"
								O.dir = get_dir(O,c_target)
								spawn(10)
									step(O,O.dir)
									for(var/mob/M in O.loc)
										if(M.dead || M.swimming) continue
										M.injutsu=1
										var/random=rand(1,4)
										if(random==1) view(src)<<sound('knife_hit1.wav',0,0,volume=100)
										if(random==2) view(src)<<sound('knife_hit2.wav',0,0,volume=100)
										if(random==3) view(src)<<sound('knife_hit3.wav',0,0,volume=100)
										if(random==4) view(src)<<sound('knife_hit4.wav',0,0,volume=100)
										var/colour = colour2html("lightblue")
										F_damage(M,J.damage+src.ninjutsu/4,colour)
										M.health-=J.damage+src.ninjutsu/4
										if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
										src.Levelup()
										if(M.henge==4||M.henge==5) M.HengeUndo()
										M.Bleed(M)
										M.Death(src)
									spawn(1)
										step(O,O.dir)
										for(var/mob/M in O.loc)
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1) view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2) view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3) view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4) view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											var/colour = colour2html("lightblue")
											F_damage(M,J.damage+src.ninjutsu/4,colour)
											M.health-=J.damage+src.ninjutsu/4
											if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
											src.Levelup()
											if(M.henge==4||M.henge==5) M.HengeUndo()
											M.Bleed(M)
											M.Death(src)
										spawn(1)
											step(O,O.dir)
											for(var/mob/M in O.loc)
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1) view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2) view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3) view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4) view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("lightblue")
												F_damage(M,J.damage+src.ninjutsu/4,colour)
												M.health-=J.damage+src.ninjutsu/4
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
												src.Levelup()
												if(M.henge==4||M.henge==5) M.HengeUndo()
												M.Bleed(M)
												M.Death(src)
												walk_to(O,M)
												O.icon_state = "stuck"
											spawn(30)if(O)del(O)
						else


							src << output("<Font color=Aqua>You need a target to use this.</Font>","actionoutput")
							src.firing=0
							src.injutsu=0
							src.copy=null
							src.canattack=1
							src.move=1
							return
					else
						src << output("<Font color=Aqua>You need a target to use this.</Font>","actionoutput")
						src.firing=0
						src.injutsu=0
						src.copy=null
						src.canattack=1
						src.move=1
						return
					src.copy = "Cant move"
					spawn(10-(J.level*2))if(src)
						src.firing=0
						src.injutsu=0
						src.copy=null
						src.canattack=1
						src.move=1
					c_target.firing=0
					c_target.injutsu=0
					c_target.copy=null
					c_target.canattack=1
					c_target.move=1
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Induction()
			for(var/obj/Jutsus/Induction/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(15)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,4))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=15
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(7,9); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Pull/A = new/obj/Projectiles/Pull(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk_towards(A,c_target.loc,0)
					A.pixel_y+=rand(10,15)
					spawn(4) if(A) walk(A,A.dir)
				else
					var/obj/Projectiles/Pull/A = new/obj/Projectiles/Pull(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk(A,src.dir)
					A.pixel_y+=rand(10,15)
				spawn(7)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Repulsion()
			for(var/obj/Jutsus/Repulsion/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(15)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,4))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=15
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(7,9); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Push/A = new/obj/Projectiles/Push(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk_towards(A,c_target.loc,0)
					A.pixel_y+=rand(10,15)
					spawn(4) if(A) walk(A,A.dir)
				else
					var/obj/Projectiles/Push/A = new/obj/Projectiles/Push(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk(A,src.dir)
					A.pixel_y+=rand(10,15)
				spawn(5)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Earth_Release_Earth_Cage()
			for(var/obj/Jutsus/Earth_Release_Earth_Cage/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(65))return
				J.density = 1
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1)J.damage=2
				if(J.level==2)J.damage=4
				if(J.level==3)J.damage=5
				if(J.level==4)J.damage=6
				if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
				if(c_target)
					flick("groundjutsu",src)
					sleep(4)
					src.icon_state="groundjutsuse"
					src.move=0
					spawn(3)if(src)
						src.firing=0
						src.canattack=1
						src.move=1
					if(c_target)
						c_target.caged=1
						src.dir=get_dir(src,c_target)
						var/obj/A = new(c_target.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.density=1
						A.layer=MOB_LAYER+1
						var/I=J.damage*5
						A.icon='doton cage.dmi'
						A.icon_state="stay"
						A.pixel_x=-48
						A.pixel_y=-16
						flick("create",A)
						I = I+round(src.ninjutsu/16)
						var/oldhealth=c_target.health
						var/I2=1
						while(I)
							I--
							I2+=1
							sleep(1)
							for(var/mob/F in A.loc)
								F.health=oldhealth
								F.move=0
								F.injutsu=1
								F.canattack=0
								if(src)Prisoner=F
								spawn(2)
									if(F)
										F.move=1
										F.injutsu=0
										F.canattack=1
								if(I2==8)
									I2=0
									if(F)
										F.health-=J.damage
										oldhealth=(oldhealth-J.damage)
										F.health=oldhealth
										var/colour = colour2html("white")
										F_damage(F,J.damage,colour)
										F.Death(src)
							sleep(1)
						if(src)
							flick("delete",A)
							sleep(4)
							del(A)
						if(c_target)
							c_target.move=1
							c_target.injutsu=0
							c_target.caged=0
							c_target.canattack=1
						if(src)
							Prisoner=null
							src.icon_state=""
				//	A.pixel_y+=rand(10,15)
				//	spawn(4) if(A) walk(A,A.dir)
				else src<<output("This technique requires a target.","actionoutput")
				if(src)
					src.firing=0
					src.canattack=1
					src.move=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Tree_Summoning()
			for(var/obj/Jutsus/Tree_Summoning/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(120))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view(src) << output("<b><font color = brown>[usr] says: Tree Summoning!","actionoutput")
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1)J.damage=3
				if(J.level==2)J.damage=6
				if(J.level==3)J.damage=9
				if(J.level==4)J.damage=12
				if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
				if(c_target)
					flick("groundjutsu",src)
					sleep(4)
					src.icon_state="groundjutsuse"
					src.move=0
					spawn(3)if(src)
						src.firing=0
						src.canattack=1
						src.move=1
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/A = new(c_target.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.density=1
						A.layer=MOB_LAYER+1
						var/I=J.damage*7
						A.icon='Treee Summoning.dmi'
						A.icon_state="stay"
						A.pixel_x=-48
						A.pixel_y=-16
						flick("create",A)
						I = I+round(src.ninjutsu/16)
						var/oldhealth=c_target.health
						var/I2=1
						while(I)
							I--
							I2+=1
							sleep(1)
							for(var/mob/F in A.loc)
								F.health=oldhealth
								F.move=0
								F.injutsu=1
								F.canattack=0
								if(src)Prisoner=F
								spawn(2)
									if(F)
										F.move=1
										F.injutsu=0
										F.canattack=1
								if(I2==8)
									I2=0
									if(F)
										F.health-=J.damage
										oldhealth=(oldhealth-J.damage)
										F.health=oldhealth
										var/colour = colour2html("white")
										F_damage(F,J.damage,colour)
										F.Death(src)
							sleep(1)
						if(src)
							flick("delete",A)
							sleep(4)
							del(A)
						if(c_target)
							c_target.move=1
							c_target.injutsu=0
							c_target.canattack=1
						if(src)
							Prisoner=null
							src.icon_state=""
				//	A.pixel_y+=rand(10,15)
				//	spawn(4) if(A) walk(A,A.dir)
				else src<<output("This technique requires a target.","actionoutput")
				if(src)
					src.firing=0
					src.canattack=1
					src.move=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Bone_Pulse()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Bone_Pulse/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=20)
								var/mob/c_target=src.Target_Get(TARGET_MOB)
								if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
								src.Levelup()
								src.chakra-=rand(10,20)
								src.UpdateHMB()
								//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
								flick("groundjutsuse",src)
								view(src)<<sound('Down_Nornal.wav',0,0)
								src.firing=1
								src.canattack=0
								J.Excluded=1
								J.uses++
								if(J.level==1)J.damage=10
								if(J.level==2)J.damage=20
								if(J.level==3)J.damage=25
								if(J.level==4)J.damage=30
								if(J.level<4)
									if(loc.loc:Safe!=1) J.exp+=rand(3,5)
									J.Levelup()
								if(c_target)
									src.dir=get_dir(src,c_target)
									var/obj/Projectiles/Effects/BoneYard/A = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A.IsJutsuEffect=src
									A.Owner=src
									A.layer=c_target.layer
									A.fightlayer=src.fightlayer
									A.level=J.level
									A.damage=J.damage+round(src.ninjutsu/2+src.strength/2)
									spawn(4)
										for(var/mob/M in view(A,0))
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											var/colour = colour2html("white")
											F_damage(M,A.damage,colour)
											M.health-=A.damage
											if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
											src.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(src)
									if(J.level==2)
										var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
										A2.IsJutsuEffect=src
										A2.Owner=src
										A2.level=J.level
									if(J.level==3)
										var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
										A2.IsJutsuEffect=src
										var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
										A3.IsJutsuEffect=src
										A2.Owner=src
										A3.Owner=src
										A2.level=J.level
										A3.level=J.level
									if(J.level==4)
										var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
										A2.IsJutsuEffect=src
										var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
										A3.IsJutsuEffect=src
										var/obj/Projectiles/Effects/BoneYard/A4 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
										A4.IsJutsuEffect=src
										A2.Owner=src
										A3.Owner=src
										A4.Owner=src
										A2.level=J.level
										A3.level=J.level
										A4.level=J.level
								else
									var/obj/Projectiles/Effects/BoneYard/A = new/obj/Projectiles/Effects/BoneYard(src.loc)
									A.IsJutsuEffect=src
									A.Owner=src
									A.layer=src.layer
									A.fightlayer=src.fightlayer
									A.level=J.level
									A.damage=J.damage+round(src.ninjutsu/2+src.strength/2)
									step(A,src.dir)
									spawn(3)
										for(var/mob/M in view(A,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											var/colour = colour2html("white")
											F_damage(M,A.damage,colour)
											M.health-=A.damage
											if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
											src.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(src)
									if(J.level==2)
										var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(A.loc)
										A2.IsJutsuEffect=src
										A2.Owner=src
										A2.level=J.level
										A2.loc = get_step(A,src.dir)
										spawn(3)
											for(var/mob/M in view(A2,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,A.damage,colour)
												M.health-=A.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
									if(J.level==3)
										var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(A.loc)
										A2.IsJutsuEffect=src
										var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(A.loc)
										A3.IsJutsuEffect=src
										A2.Owner=src
										A2.loc = get_step(A,src.dir)
										A3.loc = get_step(A2,src.dir)
										A3.Owner=src
										A2.level=J.level
										A3.level=J.level
										spawn(3)
											for(var/mob/M in view(A2,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,A.damage,colour)
												M.health-=A.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
										spawn(3)
											for(var/mob/M in view(A3,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,A.damage,colour)
												M.health-=A.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
									if(J.level==4)
										var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(A.loc)
										A2.IsJutsuEffect=src
										var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(A.loc)
										A3.IsJutsuEffect=src
										var/obj/Projectiles/Effects/BoneYard/A4 = new/obj/Projectiles/Effects/BoneYard(A.loc)
										A4.IsJutsuEffect=src
										A2.Owner=src
										A2.loc = get_step(A,src.dir)
										A3.loc = get_step(A2,src.dir)
										A4.loc = get_step(A3,src.dir)
										A3.Owner=src
										A4.Owner=src
										A2.level=J.level
										A3.level=J.level
										A4.level=J.level
										spawn(3)
											for(var/mob/M in view(A2,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,A.damage,colour)
												M.health-=A.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
										spawn(3)
											for(var/mob/M in view(A3,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,A.damage,colour)
												M.health-=A.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
										spawn(3)
											for(var/mob/M in view(A4,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,A.damage,colour)
												M.health-=A.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
								spawn(10)if(src)
									src.firing=0
									src.canattack=1
									src.injutsu=0
								src.JutsuCoolSlot(J)
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(20).</Font>","actionoutput")
		Bone_Tip()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Bone_Tip/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=8)
								var/mob/c_target=src.Target_Get(TARGET_MOB)
								if(loc.loc:Safe!=1)
									src.LevelStat("strength",rand(5,7))
									src.LevelStat("Ninjutsu",rand(5,7))
								src.Levelup()
								src.chakra-=rand(4,8)
								src.UpdateHMB()
								//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
								flick("2fist",src)
								view(src)<<sound('we_revolver_silenced_fire.ogg',0,0)
								src.firing=1
								src.canattack=0
								J.Excluded=1
								J.uses++
								if(J.level==1)J.damage=4
								if(J.level==2)J.damage=8
								if(J.level==3)J.damage=16
								if(J.level==4)J.damage=32
								if(J.level<4)
									if(loc.loc:Safe!=1) J.exp+=rand(2,5)
									J.Levelup()
								if(c_target)
									src.dir=get_dir(src,c_target)
									var/obj/Projectiles/Weaponry/BoneTip/A = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
									A.IsJutsuEffect=src
									if(J.level==1)
										if(prob(50))A.pixel_y+=rand(3,5)
										else A.pixel_y-=rand(1,5)
										if(prob(50))A.pixel_x+=rand(3,8)
										else A.pixel_x-=rand(1,8)
									if(J.level==2)
										A.icon_state="bonetip2"
										if(prob(50))A.pixel_y+=rand(3,5)
										else A.pixel_y-=rand(1,5)
										if(prob(50))A.pixel_x+=rand(3,8)
										else A.pixel_x-=rand(1,8)
									if(J.level==3)
										A.icon_state="bonetip3"
										A.pixel_y+=rand(13,15)
									if(J.level==4)
										A.icon_state="bonetip4"
										A.pixel_y+=rand(13,15)
									A.level=J.level
									A.Owner=src
									A.layer=src.layer
									A.fightlayer=src.fightlayer
									A.damage=J.damage+round(src.ninjutsu/4+src.strength/4)
									walk_towards(A,c_target.loc,0)
									spawn(4)if(A)walk(A,A.dir)
								else
									var/obj/Projectiles/Weaponry/BoneTip/A = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
									A.IsJutsuEffect=src
									if(J.level==1)
										if(prob(50))A.pixel_y+=rand(3,5)
										else A.pixel_y-=rand(1,5)
										if(prob(50))A.pixel_x+=rand(3,8)
										else A.pixel_x-=rand(1,8)
									if(J.level==2)
										A.icon_state="bonetip2"
										if(prob(50))A.pixel_y+=rand(3,5)
										else A.pixel_y-=rand(1,5)
										if(prob(50))A.pixel_x+=rand(3,8)
										else A.pixel_x-=rand(1,8)
									if(J.level==3)
										A.icon_state="bonetip3"
										A.pixel_y+=rand(13,15)
									if(J.level==4)
										A.icon_state="bonetip4"
										A.pixel_y+=rand(13,15)
									A.level=J.level
									A.Owner=src
									A.layer=src.layer
									A.fightlayer=src.fightlayer
									A.damage=J.damage+round(src.ninjutsu/2+src.strength/10)
									walk(A,src.dir)
								spawn(5)if(src)
									src.firing=0
									src.canattack=1
								src.JutsuCoolSlot(J)
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(8).</Font>","actionoutput")
		Bone_Sensation()
			if(ChakraCheck(0)) return
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Bone_Sensation/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.chakra>=10)
								if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
								src.Levelup()
								src.chakra-=rand(5,10)
								src.UpdateHMB()
								flick("jutsuse",src)
								view(src)<<sound('we_revolver_silenced_fire.ogg',0,0)
								src.firing=1
								src.canattack=0
								J.Excluded=1
								J.uses++
								if(J.level==1)J.damage=40
								if(J.level==2)J.damage=60
								if(J.level==3)J.damage=80
								if(J.level==4)J.damage=100
								J.damage = J.damage + src.strength*1.5 + src.ninjutsu/3
								if(J.level<4)
									if(loc.loc:Safe!=1) J.exp+=rand(2,3)
									J.Levelup()
								if(J.level==1)
									for(var/mob/M in oview(3,src))
										if(M.dead||M.swimming)continue
										if(M.dead==0)
											for(var/obj/Hits/BoneTips/N in M.SCaught)
												if(N)
													var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
													I.IsJutsuEffect=src
													M.overlays+=I
													M.overlays-=N
													SCaught-=N
													var/damage=J.damage+round(src.ninjutsu/3+src.strength*1.5)
													var/colour = colour2html("white")
													F_damage(M,damage,colour)
													M.health-=damage
													spawn(50)
														if(M)M.overlays-=I
														if(I)del(I)
													M.Death(src)
								if(J.level==2)
									for(var/mob/M in oview(5,src))
										if(M.dead || M.swimming) continue
										if(M.dead==0)
											for(var/obj/Hits/BoneTips/N in M.SCaught)
												if(N)
													var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
													I.IsJutsuEffect=src
													M.overlays-=N
													M.overlays+=I
													SCaught-=N
													var/damage=J.damage+round(src.ninjutsu/2+src.strength*1.5)
													var/colour = colour2html("white")
													F_damage(M,damage,colour)
													M.health-=damage
													spawn(50)
														if(M)M.overlays-=I
														if(I)del(I)
													M.Death(src)
								if(J.level==3)
									for(var/mob/M in oview(7,src))
										if(M.dead || M.swimming) continue
										if(M.dead==0)
											for(var/obj/Hits/BoneTips/N in M.SCaught)
												if(N)
													var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
													I.IsJutsuEffect=src
													M.overlays-=N
													M.overlays+=I
													SCaught-=N
													var/damage=J.damage+round(src.ninjutsu/2+src.ninjutsu/6)
													var/colour = colour2html("white")
													F_damage(M,damage,colour)
													M.health-=damage
													spawn(50)
														if(M)M.overlays-=I
														if(I)del(I)
													M.Death(src)
								if(J.level==4)
									for(var/mob/M in oview(10,src))
										if(M.dead || M.swimming) continue
										if(M.dead==0)
											for(var/obj/Hits/BoneTips/N in M.SCaught)
												if(N)
													var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
													I.IsJutsuEffect=src
													M.overlays-=N
													M.overlays+=I
													SCaught-=N
													var/damage=J.damage+round(src.ninjutsu/2+src.strength*1.5)
													var/colour = colour2html("white")
													F_damage(M,damage,colour)
													M.health-=damage
													spawn(50)
														if(M)M.overlays-=I
														if(I)del(I)
													M.Death(src)
								spawn(5)if(src)
									src.firing=0
									src.injutsu=0
									src.canattack=1
								src.JutsuCoolSlot(J)
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
							else src<<output("<Font color=Aqua>You Need More Chakra(10).</Font>","actionoutput")
		C3()
			if(ChakraCheck(0)) return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/C3/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=200)
							if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
							src.Levelup()
							src.chakra-=rand(150,200)
							src.UpdateHMB()
							view(src)<<sound('Skill_MashHit.wav',0,0)
							src.move=0
							src.firing=1
							src.canattack=0
							J.Excluded=1
							J.uses++
							if(J.level==1) J.damage=300
							if(J.level==2) J.damage=350
							if(J.level==3) J.damage=600
							if(J.level==4) J.damage=700
							if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
							src << output("<b>Now to detonate use the defend verb","actionoutput")
							var/obj/O = new/obj/C3bomb(src)
							src.C3bombz=O
							src.copy=null
							src.move=1
							src.firing=0
							src.copy=null
							src.canattack=1
							src.injutsu=0
							src.JutsuCoolSlot(J)
							spawn()
								J.cooltimer=J.maxcooltime
								J.JutsuCoolDown(src)
		Young_Bracken_Dance()
			if(ChakraCheck(0))return
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Young_Bracken_Dance/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=40)
							if(J.Excluded)return
							flick("groundjutsu",src)
							src.icon_state = "groundjutsuse"
							spawn(4)if(src)icon_state = ""
							if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
							src.Levelup()
							src.chakra-=rand(30,40)
							src.UpdateHMB()
							view(src)<<sound('Skill_MashHit.wav',0,0)
							src.move=0
							src.firing=1
							src.canattack=0
							J.Excluded=1
							J.uses++
							if(J.level==1) J.damage=4
							if(J.level==2) J.damage=8
							if(J.level==3) J.damage=12
							if(J.level==4) J.damage=16
							if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
							var/obj/O = new/obj
							O.IsJutsuEffect=src
							O.loc = src.loc
							O.x-=round(J.damage/2)
							O.y-=round(J.damage/2)
							for(var/xi=1,xi<(J.damage),xi++)
								for(var/yi=1,yi<(J.damage),yi++)
									var/obj/Projectiles/Effects/BoneYard/B = new/obj/Projectiles/Effects/BoneYard(O.loc)
									B.IsJutsuEffect=src
									B.Owner=src
									B.loc = O.loc
									B.level=J.level
									B.damage=J.damage+src.ninjutsu*5
									B.x+=xi
									B.y+=yi
									if(B.loc == src.loc) del(B)
									if(B)
										spawn(3)
											for(var/mob/M in view(B,0))
												if(M.dead || M.swimming) continue
												M.injutsu=1
												var/random=rand(1,4)
												if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
												if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
												if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
												if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
												var/colour = colour2html("white")
												F_damage(M,B.damage,colour)
												M.health-=B.damage
												if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
												src.Levelup()
												if(M.henge==4||M.henge==5)M.HengeUndo()
												M.Death(src)
							src.copy=null
							src.move=1
							src.firing=0
							src.copy=null
							src.canattack=1
							src.injutsu=0
							src.JutsuCoolSlot(J)
							spawn()
								J.cooltimer=J.maxcooltime
								J.JutsuCoolDown(src)
		Poison_Mist()
			for(var/obj/Jutsus/Poison_Mist/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(70)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
				src.Levelup()
				J.Excluded=1
				J.uses++
				src.icon_state = "jutsuse"
				var/obj/PoisonMist/O=new(src)
				O.Ownzorz=src
				O.IsJutsuEffect=src
				spawn(1)src.icon_state = ""
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Achiever_of_Nirvana_Fist()
			for(var/obj/Jutsus/Achiever_of_Nirvana_Fist/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(40)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
				src.Levelup()
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
				flick("punchr",src)
				var/mob/Z
				for(var/mob/M in get_step(src,src.dir))Z=M
				if(Z)
					Z.health -= J.damage + src.ninjutsu/5 + src.strength/5
					var/colour = colour2html("white")
					F_damage(Z,J.damage + src.ninjutsu/5 + src.strength/5,colour)
					Z.icon_state="dead"
					Z.move=0
					Z.Sleeping=1
					Z.injutsu=1
					Z.firing=1
					Z.canattack=0
					var/TimeAsleep = J.level*10 + src.genjutsu
					spawn(TimeAsleep)
						if(!Z||Z.dead) continue
						Z.icon_state=""
						Z.move=1
						Z.Sleeping=0
						Z.injutsu=0
						Z.canattack=1
						Z.firing=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Heal()
			for(var/obj/Jutsus/Heal/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(35)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
				src.Levelup()
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=8
				if(J.level==3) J.damage=6
				if(J.level==4) J.damage=4
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
				var/mob/Z
				var/check=0
				for(var/mob/M in get_step(src,src.dir))
					Z=M
					check=1
				if(check==0)Z=src
				if(Z)
					Z.health += Z.maxhealth/J.damage + src.ninjutsu/4
					if(Z.health>Z.maxhealth)Z.health=Z.maxhealth
					var/colour = colour2html("green")
					F_damage(Z,Z.maxhealth/J.damage + src.ninjutsu/4,colour)
					Z.UpdateHMB()
					Z.overlays += 'Healing.dmi'
					src.icon_state = "punchrS"

					spawn(5)
						Z.overlays -= 'Healing.dmi'
						src.icon_state = ""
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Kamui()
			for(var/obj/Jutsus/Kamui/J in src.JutsusLearnt) if(J.Excluded==0)
				if(Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","actionoutput")
					return
				var/mob/player/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a targeted player to use this technique.","actionoutput")
					return
				if(ChakraCheck(200)) return
				if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(12,15))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				J.Excluded=1
				J.uses++
				J.maxcooltime=120
				var/obj/O = new(c_target.loc)
				O.IsJutsuEffect=src
				O.icon='kamui.dmi'
				O.icon_state="kamui"
				O.layer=MOB_LAYER+1
				O.pixel_x=-16
				O.name="kamui"
				var/Timer=J.level*5
				spawn(10)if(O)
					if(O.loc==c_target.loc)
						O.linkfollow(c_target)
						while(Timer&&c_target&&!c_target.dead)
							Timer--
							var/area/A=c_target.loc.loc
							if(A.Safe) break
							c_target.health-=J.level+round(src.ninjutsu/2)
							var/colour = colour2html("red")
							F_damage(c_target,J.level+round(src.ninjutsu/2),colour)
							c_target.Death(src)
							sleep(2)
						if(O)del(O)
					else if(O)del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Curse_Dragon()
			for(var/obj/Jutsus/Curse_Dragon/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(200)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*50
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Curse Dragon.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Curse Dragon.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Summoning_Snake()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Snake_Summoning/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(400)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,11))
					src.Levelup()
					src.UpdateHMB()
					J.Excluded=1
					var/obj/SMOKE = new/obj/MiscEffects/SmokeBomb(usr.loc)
					SMOKE.loc=usr.loc
					view(usr)<<sound('flashbang_explode2.wav',0,0)
					var/mob/summonings/SnakeSummoning/B = new/mob/summonings/SnakeSummoning(usr.loc)
					B.loc=usr.loc
					B.lowner=src
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						walk_to(B,c_target)
					spawn(100)
						del(B)
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		SageMode()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/SageMode/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						src.Levelup()
						src.UpdateHMB()
						view(src)<<sound('Skill_MashHit.wav',0,0)
						J.Excluded=1
						J.uses++
						src.overlays+='Jutsus/sage.dmi'
						src.ninjutsu+=20
						src.insage=1
						src.strength+=10
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime*3
							J.JutsuCoolDown(src)
							spawn(30)
								src.ninjutsu-=20
								src.strength-=10
								src.insage=0
								src.overlays=0
								src.RestoreOverlays()
								src<<"Sage Mode wears off..."
		CurseSeal()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/CurseSeal/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						src.Levelup()
						src.UpdateHMB()
						view(src)<<sound('Skill_MashHit.wav',0,0)
						J.Excluded=1
						J.uses++
						src.underlays+='CS Aura.dmi'
						src.ninjutsu+=10
						src.strength+=15
						src.incurse=1
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime*3
							J.JutsuCoolDown(src)
							spawn(30)
								src.ninjutsu-=10
								src.strength-=15
								src.incurse=0
								src.underlays-='CS Aura.dmi'
								src<<"Curse Seal wears off..."
		GreenPill()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/GreenPill/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.ingpill==1) return
						if(ChakraCheck(100)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.Levelup()
						J.Excluded=1
						J.uses++
						src.strength+=15
						src.health-=src.maxhealth/5
						src.UpdateHMB()
						src.ingpill=1
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							spawn(J.maxcooltime)
								J.JutsuCoolDown(src)
								src.ingpill=0
								src<<"\green Your Green Pill Effect wears off..."
								src.strength-=15
								spawn(J.maxcooltime)
									src<<"\red You feel healthy enough to use the Green Pill again!"
									J.Excluded=0
							//		src.underlays-='greenpillaura.dmi'
		YellowPill()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/YellowPill/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.inypill==1) return
						if(ChakraCheck(200)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.Levelup()
						J.Excluded=1
						J.uses++
						src.strength+=25
						src.health-=src.maxhealth/3.5
						src.UpdateHMB()
						src.inypill=1
						spawn()
							J.cooltimer=J.maxcooltime
							spawn(J.maxcooltime)
								J.JutsuCoolDown(src)
								src.inypill=0
								src<<"\yellow Your Yellow Pill Effect wears off..."
								src.strength-=25
								spawn(J.maxcooltime)
									src<<"\yellow You feel healthy enough to use the Yellow Pill again!"
									J.Excluded=0
							//		src.underlays-='greenpillaura.dmi'
		RedPill()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/RedPill/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.inrpill==1) return
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.Levelup()
						J.Excluded=1
						J.uses++
						src.strength+=40
						src.health-=src.maxhealth/2.4
						src.inrpill=1
						src.UpdateHMB()
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							spawn(J.maxcooltime)
								J.JutsuCoolDown(src)
								src.inrpill=0
								src<<"\red Your Red Pill Effect wears off..."
								src.strength-=40
								spawn(J.maxcooltime)
									src<<"\red You feel healthy enough to use the Red Pill again!"
									J.Excluded=0
							//		src.underlays-='greenpillaura.dmi'

		HumanBulletTank()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/HumanBulletTank/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.inboulder==1) return
						if(ChakraCheck(500)) return
						if(loc.loc:Safe!=1) src.LevelStat("strength",rand(9,11))
						flick("jutsu",src)
						src.Levelup()
						src.UpdateHMB()
						J.Excluded=1
						J.uses++
						var/iicon
						src.canattack=0
						src.firing=1
						iicon=src.icon
						src.icon='AkimichiBullet.dmi'
						src.overlays=0
						src.inboulder=1
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
						spawn(40)
							src.canattack=1
							src.firing=0
							src.inboulder=0
							src.icon=iicon
							src.RestoreOverlays()

		CalorieControl()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/CalorieControl/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.incalorie==1) return
						if(ChakraCheck(1000)) return
						if(loc.loc:Safe!=1) src.LevelStat("strength",rand(15,30))
						flick("jutsu",src)
						src.Levelup()
						src.UpdateHMB()
						J.Excluded=1
						J.uses++
						if(J.level==1) J.damage=10
						if(J.level==2) J.damage=20
						if(J.level==3) J.damage=30
						if(J.level==4) J.damage=40
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,10); J.Levelup()
						src.strength+=J.damage
						src.underlays+='AkimichiWings.dmi'
						src.incalorie=1
					//	var/la=new/obj/Jutsus/Meteor_Punch
					//	src.JutsusLearnt+=la
					//	var/ls=new/obj/Jutsus/Opening_Gate
					//	src.JutsusLearnt+=ls
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							spawn(J.maxcooltime)
								J.JutsuCoolDown(src)
								src.strength-=J.damage
								src.incalorie=0
							//	src.JutsusLearnt-=la
							//	src.JutsusLearnt-=ls
								src.underlays-='AkimichiWings.dmi'
								spawn(J.maxcooltime)
									J.Excluded=0
		Crystal_Arrow()
			for(var/obj/Jutsus/Crystal_Arrow/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*45
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Crystal Arrow.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Crystal Arrow.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Crystal_Mirrors()
			for(var/obj/Jutsus/Crystal_Mirrors/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(250)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(c_target)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
					src.Levelup()
					src.UpdateHMB()
					//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
					flick("jutsuse",src)
					view(src)<<sound('man_fs_l_mt_wat.ogg',0,0)
					src.firing=1
					src.canattack=0
					J.Excluded=1
					src.pixel_x=4
					J.uses++
					c_target.move=0
					c_target.injutsu=1
					c_target.canattack=0
					c_target.firing=1
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=15
					if(J.level==3) J.damage=25
					if(J.level==4) J.damage=35
					J.damage=J.damage+(src.ninjutsu/3.5)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					for(var/i=1,i<8+1,i++)
						var/obj/O = new/obj
						O.IsJutsuEffect=src
						O.loc = c_target.loc
						O.icon = 'Crystal Mirrors.dmi'
						O.icon_state = "rawr"
						O.density=1
						O.layer = MOB_LAYER
						O.owner=src
						switch(i)
							if(1) O.dir = NORTHEAST
							if(2) O.dir = NORTHWEST
							if(3) O.dir = SOUTHEAST
							if(4) O.dir = SOUTHWEST
							if(6) O.dir = EAST
							if(7) O.dir = SOUTH
							if(8) O.dir = WEST
							if(5)
								O.dir = NORTH
								src.loc = O.loc
								src.dir=SOUTH
								O.layer = OBJ_LAYER
								src.injutsu=1
						for(var/ifd=0,ifd<3,ifd++)
							var/IOU = O.dir
							switch(O.dir)
								if(EAST) step(O,WEST)
								if(WEST) step(O,EAST)
								if(SOUTH) step(O,NORTH)
								if(NORTH) step(O,SOUTH)
								if(NORTHEAST) step(O,SOUTHWEST)
								if(NORTHWEST) step(O,SOUTHEAST)
								if(SOUTHEAST) step(O,NORTHWEST)
								if(SOUTHWEST) step(O,NORTHEAST)
							O.dir = IOU
						O.damage = J.damage
						O.name = "[i]"
					src.invisibility=1
					src.injutsu=1
					src.loc = c_target.loc
					step(src,NORTH)
					step(src,NORTH)
					var/turf/NS = get_step(src,NORTH)
					for(var/obj/Ouu in NS)if(Ouu.owner == src)src.loc = NS
					src.dir=SOUTH
					for(var/ivc=0,ivc<33*J.level,ivc++)
						if(src.ArrowTasked==null)
							var/olist = list()
							for(var/obj/Osd in view())if(Osd.owner == src)olist+=Osd
							if(length(olist))
								var/obj/IC = pick(olist)
								src.copy = "Icemir [IC.name]"
								var/image/A3 = new/obj
								A3.loc = IC.loc
								A3.icon = 'Misc Effects.dmi'
								A3.icon_state = "arrow"
								A3.y+=3
								A3.dir = pick(EAST,NORTH,SOUTH,WEST)
								A3.layer=1000000000000000
								src.ArrowTasked = A3
								spawn(16)
									if(A3)
										var/obj/AT = src.ArrowTasked
										del(AT)
										src.ArrowTasked=null
						sleep(1)
					var/obj/AkT = src.ArrowTasked
					del(AkT)
					src.ArrowTasked=null
					for(var/obj/Ohh in view())
						if(Ohh.icon == 'Crystal Mirrors.dmi' && Ohh.owner == src)
							Ohh.invisibility=1
							Ohh.density=0
							Ohh.owner=null
							spawn(20)if(Ohh)del(Ohh)
						if(Ohh)if(Ohh.name == "GUI [src.key]")	del(Ohh)
					src.pixel_x=-16
					src.copy = "Cant move"
					spawn(10-(J.level*2))if(src)
						src.invisibility=0
						src.copy = null
						src.firing=0
						src.injutsu=0
						src.copy=null
						src.canattack=1
					if(c_target)
						c_target.move=1
						c_target.injutsu=0
						c_target.canattack=1
						c_target.firing=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
				else src << output("<Font color=Aqua>You need a target to use this.</Font>","actionoutput")
		Crystal_Pillar()
			for(var/obj/Jutsus/Crystal_Pillar/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(200))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1)J.damage=2
				if(J.level==2)J.damage=4
				if(J.level==3)J.damage=5
				if(J.level==4)J.damage=6
				if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
				if(c_target)
					flick("groundjutsu",src)
					sleep(4)
					src.icon_state="groundjutsuse"
					src.move=0
					spawn(3)if(src)
						src.firing=0
						src.canattack=1
						src.move=1
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/A = new(c_target.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.density=1
						A.layer=MOB_LAYER+1
						var/I=J.damage*7
						A.icon='Crystal Pillar.dmi'
						A.icon_state="stay"
						A.pixel_x=-48
						A.pixel_y=-16
						flick("create",A)
						I = I+round(src.ninjutsu/16)
						var/oldhealth=c_target.health
						var/I2=1
						while(I)
							I--
							I2+=1
							sleep(1)
							for(var/mob/F in A.loc)
								F.health=oldhealth
								F.move=0
								F.injutsu=1
								F.canattack=0
								if(src)Prisoner=F
								spawn(2)
									if(F)
										F.move=1
										F.injutsu=0
										F.canattack=1
								if(I2==8)
									I2=0
									if(F)
										F.health-=J.damage
										oldhealth=(oldhealth-J.damage)
										F.health=oldhealth
										var/colour = colour2html("white")
										F_damage(F,J.damage,colour)
										F.Death(src)
							sleep(1)
						if(src)
							flick("delete",A)
							sleep(4)
							del(A)
						if(c_target)
							c_target.move=1
							c_target.injutsu=0
							c_target.canattack=1
						if(src)
							Prisoner=null
							src.icon_state=""
				//	A.pixel_y+=rand(10,15)
				//	spawn(4) if(A) walk(A,A.dir)
				else src<<output("This technique requires a target.","actionoutput")
				if(src)
					src.firing=0
					src.canattack=1
					src.move=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Crow_Substitution()
			for(var/obj/Jutsus/Crow_Substitution/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(25)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				src.Levelup()
				var/turf/T=src.loc
				J.Excluded=1
				J.uses++
				src<<output("You will be sent to this location the next time your character accumulates damage.","actionoutput")
				var/X = src.health
				while(src.health == X)sleep(1)
				for(var/i=0,i<8,i++)
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'CrowSub.dmi'
					O.pixel_x=-16
					spawn(1) step_rand(O)
					spawn(10)if(O)del(O)
				src.loc = T
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		BubbleBarrage()
			for(var/obj/Jutsus/Bubble_Barrage/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(50)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=3
				if(J.level==2) J.damage=5
				if(J.level==3) J.damage=7
				if(J.level==4) J.damage=9
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level+(round(src.ninjutsu/15))
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.pixel_y+=rand(3,5)
						else A.pixel_y-=rand(1,5)
						if(prob(50))A.pixel_x+=rand(3,8)
						else A.pixel_x-=rand(1,8)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.9+src.strength/4)
						if(c_target) walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*1.2+src.strength/4)
						walk(A,src.dir)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Bubble_Trouble()
			for(var/obj/Jutsus/Bubble_Trouble/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*45
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Bubble Trouble.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Bubble Trouble.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		BubbleSpreader()
			for(var/obj/Jutsus/Bubble_Spreader/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(25)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=8
				if(J.level==3) J.damage=14
				if(J.level==4) J.damage=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level+(round(src.ninjutsu/20))
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						A.icon_state = "bblz"
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/1.2+src.strength/4)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir,5)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.icon_state = "bblz"
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/1.2+src.strength/4)
						walk_away(A,src)
						spawn(4)if(A)walk(A,A.dir,5)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)

		Mind_Control_Jutsu()
			for(var/obj/Jutsus/Mind_Control_Jutsu/J in src.JutsusLearnt)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","actionoutput")
					return
				var/mob/M = c_target
				if(J.Excluded)return
				if(ChakraCheck(200))return
				if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				src.client.eye=M
				src.Mcontrolled=M
				step(M,WEST)
		Rising_Twin_Dragons()
			for(var/obj/Jutsus/Rising_Twin_Dragon/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(200))return
				if(J.Excluded)return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				J.Excluded=1
				J.uses++
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=6
				if(J.level==2) J.damage=7
				if(J.level==3) J.damage=8
				if(J.level==4) J.damage=10
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=round(J.level*1.5)
				if(c_target)
					while(num)
						sleep(1)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/RTD(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1)if(A)A.density=1
						walk_towards(A,c_target,0)
						spawn(7)if(A)walk(A,A.dir)
						var/obj/Aa = new(get_step(src,src.dir))
						Aa.icon = 'RisingTwinDragon.dmi'
						Aa.icon_state="1"
						Aa.IsJutsuEffect=src
						Aa.dir = src.dir
						Aa.pixel_y=16
						Aa.pixel_x=-16
						Aa.layer = src.layer+1
						flick("delete",Aa)
						sleep(4)
						del(Aa)
				else
					while(num)
						sleep(1)
						num--
						var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/RTD(src.loc)
						A.IsJutsuEffect=src
						A.x+=rand(-1,1)
						A.y+=rand(-1,1)
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						A.density=0
						spawn(1) if(A) A.density=1
						walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)

		Gravity_Divergence_Body_Blow()
			for(var/obj/Jutsus/Gravity_Divergence_Body_Blow/J in src.JutsusLearnt)
				if(src.Rinnegan==0)
					src << output("Rinnegan must be active.","actionoutput")
					return
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.icon_state = "punchrS"
				src.move=0
				src.injutsu=1
				src.firing=1
				src.canattack=0
				var/mob/Z
				for(var/mob/M in get_step(src,src.dir))
					M.move=0
					M.injutsu=1
					M.firing=1
					M.canattack=0
					Z = M
				if(Z)
					for(var/i=0,i<5,i++)
						sleep(1)
						flick("jutsu",src)
						sleep(1)
						flick("jutsuse",src)
						var/obj/O = new/obj
						O.loc = Z.loc
						O.layer = 200
						O.pixel_y=-16
						O.pixel_x=-16
						O.pixel_y+=rand(-5,5)
						O.pixel_x+=rand(-5,5)
						flick('GDBlow.dmi',O)
						spawn(4)if(O)del(O)
						Z.chakra=0
						F_damage(Z,(src.strength/5)+(src.ninjutsu/5))
						Z.health-=(src.strength/5)+(src.ninjutsu/5)
					for(var/i=0,i<3,i++)
						step(src,src.dir)
						step(src,src.dir)
						sleep(2)
						flick("jutsu",src)
						sleep(2)
						flick("jutsuse",src)
						step(Z,src.dir)
						step(Z,src.dir)
						Z.dir = get_dir(Z,src)
						var/obj/O = new/obj
						O.loc = Z.loc
						O.layer = 200
						O.pixel_y=-16
						O.pixel_x=-16
						O.pixel_y+=rand(-5,5)
						O.pixel_x+=rand(-5,5)
						flick('GDBlow.dmi',O)
						spawn(4)if(O)del(O)
						Z.chakra=0
						F_damage(Z,(src.strength/5)+(src.ninjutsu/5))
						Z.health-=(src.strength/5)+(src.ninjutsu/5)
					if(Z)
						Z.UpdateHMB()
						Z.move=1
						Z.injutsu=0
						Z.firing=0
						Z.canattack=1
						Z.icon_state = ""
						Z.Death(src)
				src.icon_state = ""
				src.move=1
				src.injutsu=0
				src.firing=0
				src.canattack=1
				J.Excluded=1
				J.uses++
				J.maxcooltime=5
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Rock_Squeeze()
			for(var/obj/Jutsus/Rock_Squeeze/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(65))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1)J.damage=40
				if(J.level==2)J.damage=60
				if(J.level==3)J.damage=80
				if(J.level==4)J.damage=100
				if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
				if(c_target)
					flick("jutsuse",src)
					sleep(4)
					src.icon_state="jutsuse"
					src.move=0
					spawn(3)if(src)
						src.firing=0
						src.canattack=1
						src.move=1
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/A = new(c_target.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.density=1
						A.layer=MOB_LAYER+1
						var/I=J.damage*7
						A.icon='Chiba.dmi'
						A.icon_state="stay"
						A.pixel_x=-48
						A.pixel_y=-16
						flick("create",A)
						I = I+round(src.ninjutsu/16)
						var/oldhealth=c_target.health
						var/I2=1
						while(I)
							I--
							I2+=1
							sleep(1)
							for(var/mob/F in A.loc)
								F.health=oldhealth
								F.move=0
								F.injutsu=1
								F.canattack=0
								if(src)Prisoner=F
								spawn(2)
									if(F)
										F.move=1
										F.injutsu=0
										F.canattack=1
								if(I2==8)
									I2=0
									if(F)
										F.health-=J.damage
										oldhealth=(oldhealth-J.damage)
										F.health=oldhealth
										var/colour = colour2html("white")
										F_damage(F,J.damage,colour)
										F.Death(src)
							sleep(1)
						if(src)
							flick("delete",A)
							sleep(4)
							del(A)
						if(c_target)
							c_target.move=1
							c_target.injutsu=0
							c_target.canattack=1
						if(src)
							Prisoner=null
							src.icon_state=""
				//	A.pixel_y+=rand(10,15)
				//	spawn(4) if(A) walk(A,A.dir)
				else src<<output("This technique requires a target.","actionoutput")
				if(src)
					src.firing=0
					src.canattack=1
					src.move=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		FireMask()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/FireMask/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,13))
						var/obj/Projectiles/Effects/firemask/A=new/obj/Projectiles/Effects/firemask(src.loc)
						J.Excluded=1
						src.Levelup()
						A.dir=src.dir
						J.uses++
						var/obj/Jutsus/AFireBall/la=new/obj/Jutsus/AFireBall()
						A.Owner=src
						src.JutsusLearnt+=la
						la.damage=300
						src.AFire_Ball()
						J.maxcooltime=150
						del(la)
						spawn(J.maxcooltime)
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
							J.Excluded=0
							del(A)



		WindMask()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/WindMask/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/obj/Projectiles/Effects/windmask/A=new/obj/Projectiles/Effects/windmask(src.loc)
						J.Excluded=1
						src.Levelup()
						A.dir=src.dir
						J.uses++
						var/obj/Jutsus/Sickle_Weasel_Technique/la=new/obj/Jutsus/Sickle_Weasel_Technique()
						A.Owner=src
						src.JutsusLearnt+=la
						la:damage=src.ninjutsu*5+src.strength*5
						src.Sickle_Weasel_Technique()
						J.maxcooltime=150
						del(la)
						spawn(J.maxcooltime)
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
							J.Excluded=0
							del(A)
		LightningMask()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/LightningMask/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(14,17))
						var/obj/Projectiles/Effects/lightningmask/A=new/obj/Projectiles/Effects/lightningmask(src.loc)
						A.Owner=src
						src.Levelup()
						A.dir=src.dir
						J.uses++
						var/obj/Jutsus/Kirin/la=new/obj/Jutsus/Kirin()
						src.JutsusLearnt+=la
						J.Excluded=1
						la.damage=src.ninjutsu*8
						src.Kirin()
						J.maxcooltime=150
						del(la)
						spawn(J.maxcooltime)
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
							J.Excluded=0
							del(A)

		EarthMask()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/EarthMask/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(300)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/obj/Projectiles/Effects/earthmask/A=new/obj/Projectiles/Effects/earthmask(src.loc)
						J.Excluded=1
						src.Levelup()
						A.dir=src.dir
						J.uses++
						var/obj/Jutsus/Mud_Dragon_Projectile/la=new/obj/Jutsus/Mud_Dragon_Projectile()
						A.Owner=src
						src.JutsusLearnt+=la
						la.damage=6
						src.Mud_Dragon_Projectile()
						J.maxcooltime=150
						del(la)
						spawn(J.maxcooltime)
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
							J.Excluded=0
							del(A)


		MudWall()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/MudWall/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(100)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(11,13))
						J.Excluded=1
						src.Levelup()
						J.uses++
						var/obj/Projectiles/Effects/mudwall/A=new/obj/Projectiles/Effects/mudwall(src.loc)
						A.Owner=src
						var/mob/forjutsu/mudwallmob/B=new/mob/forjutsu/mudwallmob(src.loc)
						B.health+=1
						spawn(100)
							J.Excluded=0
		Weapon_Manipulation_Jutsu()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Weapon_Manipulation_Jutsu/J in src.JutsusLearnt) if(J.Excluded==0)
					if(J.Excluded)return
					if(ChakraCheck(200)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,4))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.Levelup()
					J.Excluded=1
					J.uses++
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					J.Excluded=1
					J.uses++
					if(J.level==1) J.damage=4
					if(J.level==2) J.damage=5
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*1.5)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu+src.strength)
								A.density=0
								spawn(1)if(A)A.density=1
								walk_towards(A,c_target,0)
								spawn(7)if(A)walk(A,A.dir)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu+src.strength)
								A.density=0
								spawn(1)if(A)A.density=1
								walk_towards(A,c_target,0)
								spawn(7)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(1)
							num--
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu+src.strength)
								A.density=0
								spawn(1) if(A) A.density=1
								walk(A,src.dir)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu+src.strength)
								A.density=0
								spawn(1) if(A) A.density=1
								walk(A,src.dir)
					src.firing=0
					src.canattack=1
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		TwinDragons()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/TwinDragons/J in src.JutsusLearnt) if(J.Excluded==0)
					if(J.Excluded)return
					if(ChakraCheck(500)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.Levelup()
					J.Excluded=1
					J.uses++
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					J.Excluded=1
					J.uses++
					if(J.level==1) J.damage=4
					if(J.level==2) J.damage=5
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*3)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
								A.density=0
								spawn(1)if(A)A.density=1
								spawn(1)if(A)walk_rand(A)
								spawn(4)
									walk_towards(A,c_target.loc)

							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
								A.density=0
								spawn(1)if(A)A.density=1
								spawn(1)if(A)walk_rand(A)
								spawn(4)
									walk_towards(A,c_target.loc)
					else
						while(num)
							sleep(1)
							num--
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
								A.density=0
								spawn(1) if(A) A.density=1
								walk_rand(A)
								spawn(10)
									del(A)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
								A.density=0
								spawn(1) if(A) A.density=1
								walk_rand(A)
								spawn(10)
									del(A)
					src.firing=0
					src.canattack=1
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		C1Snake()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/C1Snake/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(150)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.Levelup()
					J.Excluded=1
					src.firing=1
					src.canattack=0
					J.uses++
					if(J.level==1) J.damage=40
					if(J.level==2) J.damage=80
					if(J.level==3) J.damage=120
					if(J.level==4) J.damage=130
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					flick("jutsuse",src)
					if(c_target)
						var/obj/Projectiles/Effects/SnakeC1/A = new/obj/Projectiles/Effects/SnakeC1(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.damage=J.damage+round(src.ninjutsu*1.5)
						A.layer=src.layer
						walk_towards(A,c_target.loc)
						spawn(50)
							del(A)
					else
						var/obj/Projectiles/Effects/SnakeC1/A = new/obj/Projectiles/Effects/SnakeC1(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.layer=src.layer
						A.damage=J.damage+round(src.ninjutsu*6)
						walk(A,A.dir)
						spawn(50)
							del(A)
					src.firing=0
					src.canattack=1
					src.JutsuCoolSlot(J)
					J.cooltimer=J.maxcooltime
					spawn(J.maxcooltime)
						J.JutsuCoolDown(src)
						J.Excluded=0
		HiddenSnakeStab()	//needs fixing.
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/HiddenSnakeStab/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(200)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,13))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					J.uses++
					src.overlays+='Snake Jutsu.dmi'
					src.icon_state = "punchrS"
					flick("punchr",src)
					for(var/mob/player/M in get_dir(src,src.dir))
						M.health-=J.level*src.strength/2+src.genjutsu*2
						M.Death(src)
						M.Bleed()
						src.UpdateHMB()
						M.UpdateHMB()
						view(M)<<sound('knife_hit1.wav',0,0,volume=50)
					spawn(12)
						src.overlays=0
						src.RestoreOverlays()
						src.icon_state=""
						src.move=1
						src.injutsu=0
						src.firing=0
						src.canattack=1
						src.JutsuCoolSlot(J)
						J.cooltimer=J.maxcooltime
						spawn(J.maxcooltime)
							J.JutsuCoolDown(src)
							J.Excluded=0
		WoodStyleFortress()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/WoodStyleFortress/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(130))return
						flick("groundjutsu",src)
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						src.Levelup()
						src.UpdateHMB()
						view(src)<<sound('Skill_MashHit.wav',0,0)
						src.move=0
						src.firing=1
						src.canattack=0
						J.Excluded=1
						J.uses++
						if(J.level==1) J.damage=4
						if(J.level==2) J.damage=8
						if(J.level==3) J.damage=12
						if(J.level==4) J.damage=16
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						new/obj/WoodStyle/Fortres(locate(src.x-2,src.y-2,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x,src.y-2,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+2,src.y-2,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x-2,src.y+2,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x,src.y+2,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+2,src.y+2,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+2,src.y,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x-2,src.y,src.z))
						src.move=1
						src.firing=0
						src.copy=null
						src.canattack=1
						src.injutsu=0
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
		Root_Strangle()
			if(src.firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Root_Strangle/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("This jutsu requires a target.","actionoutput")
						return
					if(ChakraCheck(200)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					J.uses++
					flick("groundjutsu",src)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					var/obj/senjuu/Strangle1/s=new/obj/senjuu/Strangle1(c_target.loc)
					var/turf/lol=c_target.loc
					spawn(3)
					src.copy=null
					src.move=1
					src.firing=0
					src.copy=null
					src.canattack=1
					src.injutsu=0
					if(c_target.loc==lol)
						c_target.move=0
						c_target.injutsu=1
						c_target.firing=1
						c_target.canattack=0
						c_target.health-=src.ninjutsu+J.level
						c_target.Death(src)
						src.UpdateHMB()
						c_target.UpdateHMB()
						spawn(100)
						c_target.move=1
						c_target.injutsu=0
						c_target.firing=0
						c_target.canattack=1
						c_target.overlays=0
						del(s)
						c_target.RestoreOverlays()
					else

						c_target.overlays=0
						c_target.RestoreOverlays()
						spawn(2)
							del(s)
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Wood_Balvan()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Wood_Balvan/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(200)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					src.Levelup()
					J.Excluded=1
					src.injutsu=1
					J.uses++
					flick("jutsuse",src)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					var/obj/O = new/obj/Projectiles/Effects/Balvan
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					O.IsJutsuEffect=src
					O.loc = src.loc
					O.dir = src.dir
					O.Owner = src
					if(c_target)
						walk_towards(O,c_target)
						spawn(5)if(src)
							walk_towards(O,0)
							walk(O,O.dir)
					else walk(O,src.dir)
					spawn(1)
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Root_Stab()
			if(src.firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Root_Stab/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(200)) return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("You need a target to use this.","actionoutput")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					src.firing=1
					src.canattack=0
					flick("groundjutsu",src)
					J.uses++
					var/obj/senjuu/stab/s=new/obj/senjuu/stab(c_target.loc)
					spawn(1)
						if(c_target.loc==s.loc)
							c_target.move=0
							c_target.health-=round(src.ninjutsu*J.level)
							c_target.Death(src)
							c_target.Bleed()
							src.UpdateHMB()
							c_target.UpdateHMB()
							view(c_target)<<sound('knife_hit1.wav',0,0,volume=50)
							spawn(3)
								c_target.move=1
						else
							spawn(3)
								del(s)
					src.copy=null
					src.move=1
					src.firing=0
					src.canattack=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)

		Crystal_Shards()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Crystal_Shards/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(180)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,12))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.Levelup()
					if(J.level==1) J.damage=40
					if(J.level==2) J.damage=80
					if(J.level==3) J.damage=120
					if(J.level==4) J.damage=160
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					J.Excluded=1
					src.firing=1
					src.canattack=0
					J.uses++
					flick("jutsuse",src)
					if(c_target)
						var/obj/Projectiles/Effects/CrystalShards/A = new/obj/Projectiles/Effects/CrystalShards(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.damage=J.damage+round(src.ninjutsu*3+src.strength*4)
						A.layer=src.layer
						walk_towards(A,c_target.loc)
						spawn(50)
							del(A)
					else
						var/obj/Projectiles/Effects/CrystalShards/A = new/obj/Projectiles/Effects/CrystalShards(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.layer=src.layer
						A.damage=J.damage+round(src.ninjutsu*3+src.strength*4)
						walk(A,A.dir)
						spawn(50)
							del(A)
					src.firing=0
					src.canattack=1
					src.JutsuCoolSlot(J)
					J.cooltimer=J.maxcooltime
					spawn(J.maxcooltime)
						J.JutsuCoolDown(src)
						J.Excluded=0
		Crystal_Needles()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Crystal_Needles/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(150)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,12))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.Levelup()
					if(J.level==1) J.damage=40
					if(J.level==2) J.damage=80
					if(J.level==3) J.damage=120
					if(J.level==4) J.damage=160
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					J.Excluded=1
					src.firing=1
					src.canattack=0
					J.uses++
					flick("jutsuse",src)
					if(c_target)
						var/obj/Projectiles/Effects/CrystalNeedles/A = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.damage=J.damage+round(src.ninjutsu+src.strength*2)
						A.layer=src.layer
						walk_towards(A,c_target.loc)
						sleep(1)
						var/obj/Projectiles/Effects/CrystalNeedles/B = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						B.Owner=src
						B.dir=src.dir
						B.damage=J.damage+round(src.ninjutsu+src.strength*2)
						B.layer=src.layer
						walk_towards(B,c_target.loc)
						spawn(50)
							del(A)
							del(B)
					else
						var/obj/Projectiles/Effects/CrystalNeedles/A = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.layer=src.layer
						A.damage=J.damage+round(src.ninjutsu+src.strength*2)
						walk(A,A.dir)
						sleep(1)
						var/obj/Projectiles/Effects/CrystalNeedles/B = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						B.Owner=src
						B.dir=src.dir
						B.layer=src.layer
						B.damage=J.damage+round(src.ninjutsu+src.strength*2)
						walk(B,B.dir)
						spawn(50)
							del(A)
							del(B)

					src.canattack=1
					src.JutsuCoolSlot(J)
					J.cooltimer=J.maxcooltime
					spawn(20)
						src.firing=0
					spawn(J.maxcooltime)
						J.JutsuCoolDown(src)
						J.Excluded=0

		Crystal_Spikes()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Crystal_Spikes/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(300)) return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("You need a target to use this.","actionoutput")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,20))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					src.firing=1
					src.canattack=0
					flick("groundjutsu",src)
					J.uses++
					var/obj/senjuu/stab/s=new/obj/crystal/spikes(c_target.loc)
					spawn(1)
						if(c_target.loc==s.loc)
							c_target.move=0
							c_target.health-=round(src.ninjutsu*3*J.level/2)
							c_target.Death(src)
							c_target.Bleed()
							src.UpdateHMB()
							c_target.UpdateHMB()
							view(c_target)<<sound('knife_hit1.wav',0,0,volume=50)
							spawn(3)
								c_target.move=1
						else
							spawn(3)
								del(s)
					src.copy=null
					src.move=1
					src.firing=0
					src.canattack=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		Crystal_Explosion()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Crystal_Explosion/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(400)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(15,20))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					src.firing=1
					src.canattack=0
					src.icon_state="groundjutsuse"
					J.uses++
					var/obj/crystal/explosion/A=new/obj/crystal/explosion(src.loc)
					A.damage=src.ninjutsu*10+J.level*100
					walk(A,src.dir)
					spawn(50)
						src.icon_state=""
						src.copy=null
						src.move=1
						src.firing=0
						src.canattack=1
						src.injutsu=0
						src.JutsuCoolSlot(J)
						spawn()
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)//Kazekage Puppet.dmi
		Summon_Kazekage_Puppet()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Summon_Kazekage_Puppet/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(200)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,15))
					src.Levelup()
					J.Excluded=1
					var/mob/jutsus/KazekagePuppet/A=new/mob/jutsus/KazekagePuppet(src.loc)
					A.OWNER=src
					A.dir=src.dir
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						walk_to(A,c_target)
					spawn(100)
						del(A)
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime*2
						J.JutsuCoolDown(src)
		LightningPillars()

			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/LightningPillars/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(200)) return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target||!c_target.key)
						src << output("This jutsu requires a target.","actionoutput")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					var/howmuchtime=1
					if(J.level==1) howmuchtime=5
					if(J.level==2) howmuchtime=7
					if(J.level==3) howmuchtime=10
					if(J.level==4) howmuchtime=12
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,8); J.Levelup()
					src.firing=1
					src.canattack=0
					src.icon_state="jutsuse"
					J.uses++
					c_target.overlays+=/obj/lightning/pillar
					src.copy=null
					src.move=1
					src.firing=0
					src.canattack=1
					src.injutsu=0
					c_target.move=0
					c_target.injutsu=1
					c_target.firing=1
					c_target.canattack=0
					c_target.icon_state="pull"
					spawn(howmuchtime)
						c_target.move=1
						c_target.injutsu=0
						c_target.firing=0
						c_target.canattack=1
						c_target.icon_state=""
						c_target.overlays-=/obj/lightning/pillar
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		EarthBoulder()


			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/EarthBoulder/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(200)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(8,10); J.Levelup()
					src.firing=1
					src.canattack=0
					flick("2fist",src)
					J.uses++
					var/obj/earth/dotondango/A=new/obj/earth/dotondango(src.loc)
					A.ooowner=src
					A.dir=src.dir
					if(J.level==1) A.dmg=120
					if(J.level==2) A.dmg=140
					if(J.level==3) A.dmg=160
					if(J.level==4) A.dmg=180
					walk(A,A.dir)
					src.copy=null
					src.move=1
					src.firing=0
					src.canattack=1
					src.injutsu=0
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
		BugTornado()
			for(var/obj/Jutsus/BugTornado/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(600)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				flick("throw",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=15
				if(J.level==3) J.damage=25
				if(J.level==4) J.damage=45
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/BugTornado/A = new/obj/Projectiles/Effects/BugTornado(src.loc)
					A.IsJutsuEffect=src
					A.level=J.level
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu/4+src.strength/2)
					A.dir = get_dir(A,c_target)
					walk_towards(A,c_target.loc,5)
					spawn(25)if(A)walk(A,A.dir,5)
				else
					var/obj/Projectiles/Effects/BugTornado/A = new/obj/Projectiles/Effects/BugTornado(src.loc)
					A.IsJutsuEffect=src
					if(A.loc == src.loc)A.loc = get_step(src,src.dir)
					A.level=J.level
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(src.ninjutsu/10+src.strength/5)
					A.dir = src.dir
					if(A)walk(A,A.dir,5)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		AlmightyPush()
			for(var/obj/Jutsus/Almighty_Push/J in src.JutsusLearnt)
				if(src.firing==1) return
				if(J.Excluded)return
				if(src.ChakraCheck(600))return
				src.copy=null
				src.icon_state="jutsuse"
				src.injutsu=1
				src.move=0
				src.canattack=0
				src.firing=1
				J.Excluded=1
				view(src)<<sound('wind_leaves.ogg',0,0)
				var/obj/Projectiles/Effects/shinratensei/A=new/obj/Projectiles/Effects/shinratensei(src.loc)
				A.IsJutsuEffect=src
				A.Owner=src
				A.layer=src.layer
				sleep(1)
				if(A.level==1) A.damage=100
				if(A.level==2) A.damage=200
				if(A.level==3) A.damage=300
				if(A.level==4) A.damage=500
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(20,30); J.Levelup()
				var/Jdamage=A.damage+round(src.ninjutsu*10)
				for(var/atom/S in orange(src,A.level+4))
					if(istype(S,/mob/))
						var/mob/M=S
						if(M.dead || M.swimming) continue
						M.icon_state="push"
						M.injutsu=1
						M.health-=Jdamage
						var/colour = colour2html("white")
						F_damage(M,Jdamage,colour)
						if(M.client)
							spawn()M.ScreenShake(80)
						walk_away(M,src)
						spawn(30)
							if(M)
								M.injutsu=0
								walk(M,0)
							if(M) if(!M.swimming) M.icon_state=""
							if(M) M.Death(src)
					if(istype(S,/obj/Projectiles/))
						if(S==A) continue
						walk_away(S,A)
				spawn(10)if(src)
					del(A)
					src.copy=null
					src.ArrowTasked=null
					src.arrow=null
					src.cranks=null
					src.copy=null
					src.injutsu=0
					src.move=1
					src.canattack=1
					src.icon_state=""
					src.firing=0
					J.Excluded=1
					J.uses++
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime*3
						J.JutsuCoolDown(src)
		Chibaku_Tensei()
			for(var/obj/Jutsus/Chibaku_Tensei/J in src.JutsusLearnt)
				if(src.firing==1) return
				if(J.Excluded)return
				if(src.ChakraCheck(800))return

		WebShoot()
			for(var/obj/Jutsus/WebShoot/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(100)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				flick("throw",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=20
				if(J.level==3) J.damage=30
				if(J.level==4) J.damage=40
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/obj/Projectiles/Effects/webshoot/S=new/obj/Projectiles/Effects/webshoot(src.loc)
				S.Owner=src
				S.damage=J.damage
				if(c_target)
					walk_towards(S,c_target.loc)
				else
					walk(S,S.dir)
				src.copy=null
				src.injutsu=0
				src.move=1
				src.canattack=1
				src.firing=0
				J.Excluded=1
				J.uses++
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		ArrowShoot()
			for(var/obj/Jutsus/ArrowShoot/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(100)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
				src.Levelup()
				src.UpdateHMB()
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=50
				if(J.level==2) J.damage=80
				if(J.level==3) J.damage=100
				if(J.level==4) J.damage=150
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/obj/Projectiles/Effects/arrowshoot/S=new/obj/Projectiles/Effects/arrowshoot(src.loc)
				S.Owner=src
				S.damage=J.damage+src.ninjutsu*4
				if(c_target)
					walk_towards(S,c_target.loc)
				else
					walk(S,S.dir)
				src.copy=null
				src.injutsu=0
				src.move=1
				src.canattack=1
				src.firing=0
				J.Excluded=1
				J.uses++
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Summon_Spider()
			if(ChakraCheck(500)) return
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Summon_Spider/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					src.Levelup()
					J.Excluded=1
					var/mob/jutsus/Summon_Spider/A=new/mob/jutsus/Summon_Spider(src.loc)
					A.OWNER=src
					A.dir=src.dir
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						walk_to(A,c_target)
					spawn(100)
						del(A)
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime*2
						J.JutsuCoolDown(src)
		Wind_Tornados()

			if(firing)return
			if(src.firing==0 && src.canattack==1 && src.dead==0)
				for(var/obj/Jutsus/Wind_Tornados/J in src.JutsusLearnt)
					if(J.Excluded==1) return
					if(ChakraCheck(500)) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(11,15))
					src.Levelup()
					J.Excluded=1
					src.move=0
					src.injutsu=1
					if(J.level==1)J.damage=1
					if(J.level==2)J.damage=2
					if(J.level==3)J.damage=4
					if(J.level==4)J.damage=6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(8,10); J.Levelup()
					src.firing=1
					src.canattack=0
					var/s=J.damage
					while(s>0)
						var/obj/forwind/windstyle/A=new/obj/forwind/windstyle(src.loc)
						s--
						A.owner=src
						walk_rand(A)
					src.copy=null
					src.injutsu=0
					src.move=1
					src.canattack=1
					src.firing=0
					J.Excluded=1
					J.uses++
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
//No Clan - Merge


// Lightning
mob
	proc
		Chidori_Nagashi()
			for(var/obj/Jutsus/Chidori_Nagashi/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(200)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
				src.firing=1
				src.canattack=0
				spawn(2)
					src.firing=0
					src.canattack=1
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=1
				if(J.level==2) J.damage=2
				if(J.level==3) J.damage=3
				if(J.level==4) J.damage=5
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				nagashi=1
				overlays+='Chidori Nigashi.dmi'
				spawn(80)
					if(src)
						RestoreOverlays()
						nagashi=0
				while(nagashi)
					for(var/mob/M in get_step(src,1))
						if(M.dead || M.swimming)return
						M.health-=J.damage+src.strength+src.ninjutsu/2
						var/colour = colour2html("white")
						F_damage(M,J.damage+src.strength+src.ninjutsu,colour)
						LevelStat("Ninjutsu",0.1)
						Levelup()
						if(M.henge==4||M.henge==5)M.HengeUndo()
						M.Death(src)
					sleep(10)
					continue
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
//Uchiha
		WarpDim()
			for(var/obj/Jutsus/WarpDim/J in src.JutsusLearnt) if(J.Excluded==0)
				if(ChakraCheck(300))return
				if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(3,8))
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				src.Levelup()
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=50
				if(J.level==2) J.damage=100
				if(J.level==3) J.damage=150
				if(J.level==4) J.damage=250
				src.move=1
				src.canattack=1
				src.injutsu=0
				src.firing=0
				flick("jutsuse",src)
				src.icon_state = "jutsuse"
				c_target.canattack=0
				c_target.injutsu=1
				c_target.move=0
				c_target.health-=J.damage
				c_target.loc=locate(104,55,21)
				src.loc=c_target.loc
				view(10)<<"[usr]: Allow me to warp you into the dimension that belongs to me: Dimensional Warp!"
				sleep(130)
				c_target.loc=locate("[x],[y],[z]")
				src.loc=c_target.loc
				c_target.canattack=1
				c_target.injutsu=0
				c_target.move=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Intangible_Jutsu()
			for(var/obj/Jutsus/Intangible_Jutsu/J in src.JutsusLearnt)
				if(ChakraCheck(110))return
				if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(5,10))
				src.canattack=1
				src.injutsu=0
				src.firing=0
				src.density=0
				sleep(30)
				src.firing=0
				src.injutsu=0
				src.density=1
//Nara
		Shadow_Explosion()
			for(var/obj/Jutsus/Shadow_Explosion/J in src.JutsusLearnt)
				if(!NaraTarget)
					src<<output("You must first trap someone using Shadow Extension jutsu.","actionoutput")
					return
				if(J.Excluded) return
				if(src.ChakraCheck(150)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level==1) J.damage=5
				if(J.level==2) J.damage=10
				if(J.level==3) J.damage=15
				if(J.level==4) J.damage=30
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/Timer=J.level
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				J.Excluded=1
				J.uses++
				var/mob/M=NaraTarget
				var/obj/O=new
				O.IsJutsuEffect=src
				O.icon='NewNara.dmi'
				O.loc=M.loc
				O.pixel_x=-16
				O.layer=MOB_LAYER+1
				flick("grab",O)
				J.damage = J.damage+src.ninjutsu*1.3
				while(Timer&&NaraTarget&&M)
					Timer--
					sleep(4)
					O.icon_state = "explode"
					M.health-=J.damage
					var/colour = colour2html("white")
					F_damage(M,J.damage,colour)
					M.Death(src)
				del(O)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Shadow_Punch()
			for(var/obj/Jutsus/Shadow_Punch/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*30
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Shadow Punch.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Shadow Punch.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.ninjutsu*4)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
//Wind
		Wind_Dragon_Projectile()
			for(var/obj/Jutsus/Wind_Dragon_Projectile/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*45
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'Wind Dragon Projectile.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'Wind Dragon Projectile.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
//Ink
		SaiRat()
			for(var/obj/Jutsus/Sai_Rat/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(100)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('046.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=20
				if(J.level==3) J.damage=40
				if(J.level==4) J.damage=60
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=5
				if(c_target)
					while(num)
						sleep(1)
						src.dir=get_dir(src,c_target)
						var/obj/A = new/obj/Projectiles/Weaponry/SaiRat(src.loc)
						A.IsJutsuEffect=src
						A.density=0
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.5+src.strength*0.3)
						var/turf/Tg
						Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
						var/k = rand(1,5)
						spawn() switch(k)
							if(1)
								spawn(1) A.density=1
								walk_towards(A,c_target.loc,0)
							else
								spawn(1) A.density=1
								walk_towards(A,Tg,0)
						spawn(4)
							spawn(1) if(A) A.density=1
							if(A) walk(A,A.dir)
						num--
				else
					while(num)
						num--
						sleep(1)
						var/obj/A = new/obj/Projectiles/Weaponry/SaiRat(src.loc)
						A.IsJutsuEffect=src
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						step(A,A.dir)
						if(A)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu*1.5+src.strength*0.8)
						spawn() walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Sai_Snakes()
			for(var/obj/Jutsus/Sai_Snakes/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(200)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('046.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=60
				if(J.level==2) J.damage=80
				if(J.level==3) J.damage=100
				if(J.level==4) J.damage=120
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=5
				if(c_target)
					while(num)
						sleep(1)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Weaponry/Sai_Snakes/A = new/obj/Projectiles/Weaponry/Sai_Snakes(src.loc)
						A.IsJutsuEffect=src
						A.density=0
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.5+src.strength*0.3)
						var/turf/Tg
						Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
						var/k = rand(1,5)
						spawn() switch(k)
							if(1)
								spawn(1) A.density=1
								walk_towards(A,c_target.loc,0)
							else
								spawn(1) A.density=1
								walk_towards(A,Tg,0)
						spawn(4)
							spawn(1) if(A) A.density=1
							if(A) walk(A,A.dir)
						num--
				else
					while(num)
						num--
						sleep(1)
						var/obj/Projectiles/Weaponry/Sai_Snakes/A = new/obj/Projectiles/Weaponry/Sai_Snakes(src.loc)
						A.IsJutsuEffect=src
						switch(num)
							if(5)
								switch(src.dir)
									if(EAST)A.x+=1
									if(WEST)A.x-=1
									if(NORTH)A.y+=1
									if(SOUTH)A.y-=1
							if(4)
								switch(src.dir)
									if(EAST)
										A.y+=1
										A.x+=1
									if(WEST)
										A.y+=1
										A.x-=1
									if(NORTH)
										A.x+=1
										A.y+=1
									if(SOUTH)
										A.x+=1
										A.y-=1
							if(3)
								switch(src.dir)
									if(EAST)
										A.y+=2
										A.x+=1
									if(WEST)
										A.y+=2
										A.x-=1
									if(NORTH)
										A.x+=2
										A.y+=1
									if(SOUTH)
										A.x+=2
										A.y-=1
							if(2)
								switch(src.dir)
									if(EAST)
										A.y-=1
										A.x+=1
									if(WEST)
										A.y-=1
										A.x-=1
									if(NORTH)
										A.x-=1
										A.y+=1
									if(SOUTH)
										A.x-=1
										A.y-=1
							if(1)
								switch(src.dir)
									if(EAST)
										A.y-=2
										A.x+=1
									if(WEST)
										A.y-=2
										A.x-=1
									if(NORTH)
										A.x-=2
										A.y+=1
									if(SOUTH)
										A.x-=2
										A.y-=1
						step(A,A.dir)
						if(A)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu*1.5+src.strength*0.8)
						spawn() walk(A,src.dir)
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		InkLions()
			for(var/obj/Jutsus/Ink_Lions/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(50)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=3
				if(J.level==2) J.damage=5
				if(J.level==3) J.damage=7
				if(J.level==4) J.damage=9
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level+(round(src.ninjutsu/15))
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/InkLions/A = new/obj/Projectiles/Effects/InkLions(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.pixel_y+=rand(3,5)
						else A.pixel_y-=rand(1,5)
						if(prob(50))A.pixel_x+=rand(3,8)
						else A.pixel_x-=rand(1,8)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*0.9+src.strength/4)
						if(c_target) walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Effects/InkLions/A = new/obj/Projectiles/Effects/InkLions(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*1.2+src.strength/4)
						walk(A,src.dir)
				spawn(5)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Ultimate_Ink_Bird()
			for(var/obj/Jutsus/Ultimate_Ink_Bird/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*45
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'InkBird.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'InkBird.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
//Uzumaki
mob
	proc
		Seal_of_Terror()
			for(var/obj/Jutsus/Seal_of_Terror/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(injutsu) return
				if(copy=="Climb") return
				if(ChakraCheck(150)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
			//	view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
			//	src.move=0
				src.injutsu=1
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=5*src.ninjutsu
				if(J.level==2) J.damage=10*src.ninjutsu
				if(J.level==3) J.damage=15*src.ninjutsu
				if(J.level==4) J.damage=20*src.ninjutsu
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				c_target.overlays+='Seal of Terror.dmi'
				c_target.firing=1
				c_target.canattack=0
				c_target.move=0
				c_target.injutsu=1
				spawn(J.level*8)if(src)
					src.firing=0
					src.move=1
					src.injutsu=0
					src.canattack=1
					c_target.firing=0
					c_target.RestoreOverlays()
					c_target.canattack=1
					c_target.move=1
					c_target.injutsu=0
					c_target.health-=J.damage
					c_target.Death(src)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=200
					J.JutsuCoolDown(src)

		Soul_Devastator_Seal()
			for(var/obj/Jutsus/Soul_Devastator_Seal/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(!move) return
				if(injutsu) return
				if(copy=="Climb") return
				if(ChakraCheck(300)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return
				src.Levelup()
				src.UpdateHMB()
				flick("jutsuse",src)
			//	view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				src.move=0
				src.injutsu=1
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=10
				if(J.level==2) J.damage=15
				if(J.level==3) J.damage=20
				if(J.level==4) J.damage=30
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
				c_target.overlays+='SoulDevestator.dmi'
				c_target.firing=1
				c_target.canattack=0
				c_target.move=0
				c_target.injutsu=1
				spawn(J.damage)if(src)
					src.firing=0
					src.move=1
					src.injutsu=0
					src.canattack=1
					c_target.firing=0
					c_target.RestoreOverlays()
					c_target.canattack=1
					c_target.move=1
					c_target.injutsu=0
					c_target.health-=J.damage
					c_target.Death(src)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=250
					J.JutsuCoolDown(src)

		Reaper_Death_Seal()
			for(var/obj/Jutsus/Reaper_Death_Seal/J in src.JutsusLearnt)
				if(J.Excluded&&src.injutsu) return
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return
				if(get_dist(src,c_target)>2)
					src<<"Your target isn't near you."
					return
				if(ChakraCheck(300)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(15,25))
				J.Excluded=1
				src.UpdateHMB()
				//view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				J.Excluded=1
				src.injutsu=1
				src.canattack=0
				src.move=0
				c_target.move=0
				c_target.firing=1
				c_target.injutsu=1
				c_target.canattack=0
				src.overlays+='Shiki Fuujin.dmi'
				spawn(30)
					src.health-=src.health-src.ninjutsu*10
					c_target.health-=src.ninjutsu*12+src.genjutsu*10 - (c_target.defence*5 + c_target.agility*5)
					c_target.move=1
					c_target.firing=0
					c_target.injutsu=0
					c_target.canattack=1
					src.firing=0
					src.injutsu=0
					src.canattack=1
					src.move=1
					spawn(10)
						src.overlays-='Shiki Fuujin.dmi'
						src.RestoreOverlays()
					src.UpdateHMB()
					c_target.UpdateHMB()
					c_target.Death(src)
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Wind_Cutter()
			for(var/obj/Jutsus/Wind_Cutter/J in src.JutsusLearnt)
				if(J.Excluded==1) return
				if(ChakraCheck(100)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('dash.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				spawn(10-(J.level*2))
					if(src)if(src)
						src.firing=0
						src.canattack=1
						src.copy = null
				J.uses++
				if(J.level==1) J.damage=8
				if(J.level==2) J.damage=11
				if(J.level==3) J.damage=18
				if(J.level==4) J.damage=40
				J.damage+=round(src.ninjutsu/10)
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
				var/obj/O = new/obj
				O.IsJutsuEffect=src
				O.loc = src.loc
				O.icon = 'Wind Cutter.dmi'
				O.icon_state = "Cut"
				O.name="Cut"
				spawn(5)
					if(src)
						if(O)O.dir = src.dir
						var/moves=0
						while(moves<>(10+J.level))
							moves+=1
							sleep(1)
							if(O) step(O,O.dir)
							if(O)
								var/turf/T = O.loc
								if(T.density)moves=10
								else
									for(var/obj/Projectiles/Effects/OnFire/Fire in O.loc)del(Fire)
									for(var/obj/Projectiles/Effects/Fire/Fire in O.loc)	del(Fire)
									for(var/obj/Projectiles/Effects/MasterFireNoSound/Fire in O.loc)del(Fire)
									for(var/obj/Projectiles/Effects/MasterFire/Fire in O.loc)del(Fire)
									for(var/mob/M in O.loc)
										if(M.dead || M.swimming) continue
										if(M) M.icon_state = "push"
										if(M) step(M,O.dir)
										if(M) M.dir = get_dir(M,O)
										if(M) M.health-=J.damage
										if(M) M.Death(src)
										var/colour = colour2html("white")
										F_damage(M,J.damage,colour)
										spawn(1)if(M)M.icon_state = ""
							sleep(1)
					if(O)del(O)
				src.copy = "Cant move"
				spawn(10-(J.level*2))
					if(src)
						src.firing=0
						src.copy=null
						src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Wind_Balls()
			for(var/obj/Jutsus/WindBalls/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(50))return
				if(firing)return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('wirlwind.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=4
				if(J.level==2) J.damage=6
				if(J.level==3) J.damage=8
				if(J.level==4) J.damage=10
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=J.level*2
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Weaponry/WindBalls/A = new/obj/Projectiles/Weaponry/WindBalls(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.pixel_y+=rand(3,5)
						else A.pixel_y-=rand(1,5)
						if(prob(50))A.pixel_x+=rand(3,8)
						else A.pixel_x-=rand(1,8)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/15)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Weaponry/WindBalls/A = new/obj/Projectiles/Weaponry/WindBalls(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						walk(A,src.dir)
				spawn(5)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Iceball()
			for(var/obj/Jutsus/Iceball/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(150)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("2fist",src)
				view(src)<<sound('046.wav',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level==1) J.damage=40
				if(J.level==2) J.damage=60
				if(J.level==3) J.damage=80
				if(J.level==4) J.damage=90
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/num=5
				if(c_target)
					while(num)
						sleep(2)
						num--
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Weaponry/Iceball/A = new/obj/Projectiles/Weaponry/Iceball(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.pixel_y+=rand(3,5)
						else A.pixel_y-=rand(1,5)
						if(prob(50))A.pixel_x+=rand(3,8)
						else A.pixel_x-=rand(1,8)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/15)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
				else
					while(num)
						sleep(2)
						num--
						var/obj/Projectiles/Weaponry/Iceball/A = new/obj/Projectiles/Weaponry/Iceball(src.loc)
						A.IsJutsuEffect=src
						if(prob(50))A.y+=1
						else A.y-=1
						if(prob(50))A.x+=1
						else A.x-=1
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
						walk(A,src.dir)
				spawn(5)if(src)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Omega_Ice_Ball()
			for(var/obj/Jutsus/Omega_Ice_Ball/J in src.JutsusLearnt)
				if(J.Excluded) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(ChakraCheck(250)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				view()<<sound('man_fs_r_mt_wat.ogg')
				src.firing=1
				src.canattack=0
				src.move=0
				J.damage=J.level*45
				J.Excluded=1
				J.uses++
				if(c_target)src.dir=get_dir(src,c_target)
				var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
				Aa.icon = 'GiantIceBall.dmi'
				Aa.IsJutsuEffect=src
				Aa.dir = src.dir
				Aa.layer = src.layer+1
				Aa.pixel_y=16
				Aa.pixel_x=-16
				var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
				A.icon = 'GiantIceBall.dmi'
				A.dir = src.dir
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.pixel_y=16
				A.pixel_x=-16
				A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
				A.level=J.level
				walk(A,dir,0)
				src.firing=0
				src.canattack=1
				src.move=1
				icon_state=""
				Aa.dir = src.dir
				spawn(15)
					src.firing=0
					src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Angel_Wings()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Angel_Wings/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(ChakraCheck(200)) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						src.Levelup()
						src.UpdateHMB()
						J.Excluded=1
						src.underlays+='Angel Wings.dmi'
						src.inAngel=1
						src.JutsuCoolSlot(J)
						spawn()
							J.maxcooltime=300
							J.cooltimer=J.maxcooltime
							J.JutsuCoolDown(src)
							spawn(100)
								src.inAngel=0
								src.underlays-='Angel Wings.dmi'
								src<<"Angel mode goes off."



















obj
	forwind
		windstyle
			icon='Tornado.dmi'
			layer=MOB_LAYER+1
			density=1
			var/mob/ownerrr=null
			New()
				spawn(40)
					del(src)
				..()
			Move()
				..()
				for(var/mob/M in view(3))
					if(M==ownerrr)
						return
					M.health-=round(ownerrr.ninjutsu*4)
					M.Death(ownerrr)
					step_away(M,src)
					step_away(M,src)
					step_away(M,src)
					step_away(M,src)
			Bump(A)
				if(istype(A,/mob/))
					var/mob/M=A
					M.health-=round(ownerrr.ninjutsu*4)
					M.Death(ownerrr)
					step_away(M,src)
					step_away(M,src)
					step_away(M,src)
					step_away(M,src)
					..()
				else
					del(src)

	snakeeelol
		icon='Snake Jutsu.dmi'
		pixel_y=-20
		pixel_x=37
	senjuu
		layer=MOB_LAYER+2
		stab
			icon='Senjuu.dmi'
			icon_state="stab"
			density=1
			New()
				spawn(30)
					if(src) del(src)

		Strangle1
			icon='Senjuu.dmi'
			density=1
			New()
				spawn(10)
					flick(src,"RootStrangle")

				spawn(100)
					if(src) del(src)
	lightning
		pillar
			icon='LightningPillars.dmi'
			pixel_x=-30
			pixel_y=-25
	earth
		dotondango
			icon='DotonBoulder.dmi'
			density=1
			var/mob/ooowner=null
			var/dmg=100
			New()
				spawn(80)
					del(src)
				..()
			Bump(A)
				if(istype(A,/mob/))
					var/mob/M=A
					if(M==ooowner) del(src)
					M.health-=round(ooowner.strength+dmg+ooowner.ninjutsu)
					M.Death(ooowner)
					src.density=0
					step(src,src.dir)
				else
					del(src)

	WoodStyle
		Fortres
			icon='WoodStyleFortress.dmi'
			density=1
			layer=MOB_LAYER+1
			New()
				spawn(100)
				del(src)

	crystal
		pixel_x=-16
		spikes
			icon='CrystalIcons.dmi'
			icon_state="spikes"
			density=1
			layer=MOB_LAYER+2
			New()
				spawn(30)
					if(src) del(src)
		explosion
			icon='CrystalIcons.dmi'
			icon_state="explosion"
			density=1
			layer=MOB_LAYER+2
			New()
				..()
				spawn(60)
					if(src) del(src)
			Move()
				new/obj/crystal/explosion(src.loc)
				sleep(1)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						if(M)
							if(M <> src.Owner)
								var/mob/Owner=src.Owner
								if(M.dead || M.swimming || M.key == src.name) return
								if(M.fightlayer==src.fightlayer)
									view(src)<<sound('knife_hit1.wav',0,0,volume=60)
									src.layer=MOB_LAYER+1
									if(M)
										src.loc = M.loc
										M.move=0
										var/colour = colour2html("red")
										F_damage(M,src.damage,colour)
										M.health-=src.damage
										spawn()if(M)M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
										Owner.Levelup()
										if(M.henge==4||M.henge==5)M.HengeUndo()
										M.Death(Owner)
										spawn(10)
											M.move=1
obj
	Projectiles
		Effects
			webshoot
				icon='SpiderJutsus.dmi'
				icon_state="webshoot"
				density=1
				layer=MOB_LAYER+2
				New()
					..()
					spawn(90)
						if(src) del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
									//	view(src)<<sound('knife_hit1.wav',0,0,volume=60)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.move=0
											M.injutsu=1
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage*2
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(5,7))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
											spawn(src.damage)
												M.move=1
												M.injutsu=0
												del(src)
			arrowshoot
				icon='SpiderJutsus.dmi'
				icon_state="arrowshoot"
				density=1
				layer=MOB_LAYER+2
				New()
					..()
					spawn(40)
						if(src) del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.swimming || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
									//	view(src)<<sound('knife_hit1.wav',0,0,volume=60)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.move=0
											var/colour = colour2html("red")
											F_damage(M,src.damage,colour)
											M.health-=src.damage
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											Owner.Levelup()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											M.Death(Owner)
											walk(src,src.dir)
											spawn(10)
											M.move=1



mob
	var
		insage=0
		incurse=0
		ingpill=0
		inypill=0
		inrpill=0
		incalorie=0
		inboulder=0
		caged=0
mob
	Bump(M)
		if(src.inboulder==1)
			if(istype(M,/mob/))
				src.density=0
				step(src,src.dir)
				step(src,src.dir)
				src.density=1
				M:health-=src.strength*2
				M:Death(src)
				M:UpdateHMB()
		else
			..()

mob
	forjutsu
		mudwallmob
			icon=""
			density=1
			layer=999999999
			health=1500
			maxhealth=1500
			chakra=300
			maxchakra=300
			level=1
			exp=0
			maxexp=10
			ninjutsu=1
			ninexp=0
			maxninexp=10
			genjutsu=1
			genexp=0
			maxgenexp=10
			strength=1
			editing=0
			strengthexp=0
			maxstrengthexp=10
			defence=1
			defexp=0
			maxdefexp=10
			agility=1
			agilityexp=0
			maxagilityexp=10
			New()
				spawn(100)
					del(src)
mob
	proc
		Bind(A)
			spawn(A)
				usr.move=1
				usr.injutsu=0
				usr.firing=0
				usr.canattack=1
				usr.icon_state=""
				usr.overlays=0
				usr.RestoreOverlays()
