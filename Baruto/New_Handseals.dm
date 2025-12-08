mob/var/tmp/list/Handseals = list()

obj
	icon='Handsigns.dmi'
	layer=100
	pixel_y=62
	pixel_x=17

	Bird
		icon_state="bird"

	Boar
		icon_state="boar"

	Dog
		icon_state="dog"

	Dragon
		icon_state="dragon"

	Ox
		icon_state="ox"

	Tiger
		icon_state="Tiger"

	Snake
		icon_state="snake"

	Rat
		icon_state="rat"

	Horse
		icon_state="horse"

	Monkey
		icon_state="monkey"

	Rabbit
		icon_state="rabbit"

	Ram
		icon_state="ram"

mob
	verb
		Bird()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Bird")
			src.client.image += /obj/Bird;spawn(4);src.client.image -= /obj/Bird
		Boar()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Boar")
			src.client.image += /obj/Boar;spawn(4);src.client.image -= /obj/Boar
		Dog()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Dog")
			src.client.image += /obj/Dog;spawn(4);src.client.image -= /obj/Dog
		Dragon()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Dragon")
			src.client.image += /obj/Dragon;spawn(4);src.client.image -= /obj/Dragon
		Ox()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Ox")
			src.client.image += /obj/Ox;spawn(4);src.client.image -= /obj/Ox
		Tiger()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Tiger")
			src.client.image += /obj/Tiger;spawn(4);src.client.image -= /obj/Tiger
		Snake()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Snake")
			src.client.image += /obj/Snake;spawn(4);src.client.image -= /obj/Snake
		Rat()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Rat")
			src.client.image += /obj/Rat;spawn(4);src.client.image -= /obj/Rat
		Horse()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Horse")
			src.client.image += /obj/Horse;spawn(4);src.client.image -= /obj/Horse
		Monkey()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Monkey")
			src.client.image += /obj/Monkey;spawn(4);src.client.image -= /obj/Monkey
		Rabbit()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Rabbit")
			src.client.image += /obj/Rabbit;spawn(4);src.client.image -= /obj/Rabbit
		Ram()
			set hidden = 1
			view(usr)<<sound('switsh.wav',0,0)
			flick("jutsu",usr)
			for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
			usr.Handseals.Add("Ram")
			src.client.image += /obj/Ram;spawn(4);src.client.image -= /obj/Ram
		HandSeal()
			set hidden = 1
			if(client.eye==locate(10,10,4)||client.eye==locate(60,10,4)||client.eye==locate(12,43,4)||client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return
			src.HengeUndo()
			if("[list2params(usr.Handseals)]"=="Rat&Dragon")
				var/obj/Jutsus/SClone/J=new/obj/Jutsus/SClone
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ShadowClone_Jutsu()
						del(J)
			if("[list2params(usr.Handseals)]"=="Rat&Rat&Snake")
				var/obj/Jutsus/MizuClone/J=new/obj/Jutsus/MizuClone
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MizuClone_Jutsu()
						del(J)
			if("[list2params(usr.Handseals)]"=="Rat&Rat&Ox")
				var/obj/Jutsus/Insect_Clone/J=new/obj/Jutsus/Insect_Clone
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.usr.InsectClone()
						del(J)
			if("[list2params(usr.Handseals)]"=="Snake&Dragon&Snake")
				var/obj/Jutsus/Camellia_Dance/J=new/obj/Jutsus/Camellia_Dance
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Camellia_Dance()
						del(J)
			if("[list2params(usr.Handseals)]"=="Snake&Snake&Dog")
				var/obj/Jutsus/Eight_Trigrams_Mountain_Crusher/J=new/obj/Jutsus/Eight_Trigrams_Mountain_Crusher
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_Mountain_Crusher()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Ox&Ox&Dog")
				var/obj/Jutsus/Sand_Funeral/J=new/obj/Jutsus/Sand_Funeral
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Funeral()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Ox&Dog&Ox")
				var/obj/Jutsus/Sand_Sheild/J=new/obj/Jutsus/Sand_Sheild
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Sheild()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Rat&Rat&Dog&Dog&Rat&Dog&Rat")
				var/obj/Jutsus/Fire_Dragon_Projectile/J=new/obj/Jutsus/Fire_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Dragon_Projectile()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Rat&Rat&Dog&Dog&Rat&Dog&Rat&Dragon&Dragon")
				var/obj/Jutsus/Water_Dragon_Projectile/J=new/obj/Jutsus/Water_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Water_Dragon_Projectile()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Rat&Rat&Dog&Dog&Rat&Dog")
				var/obj/Jutsus/Mud_Dragon_Projectile/J=new/obj/Jutsus/Mud_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Mud_Dragon_Projectile()
						del(J)
			if("[list2params(usr.Handseals)]"=="Snake&Dragon&Snake&Rat")
				var/obj/Jutsus/Chakra_Leech/J=new/obj/Jutsus/Chakra_Leech
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chakra_Leech()
						del(J)
			if("[list2params(usr.Handseals)]"=="Horse&Horse&Horse")
				var/obj/Jutsus/Ones_Own_Life_Reincarnation/J=new/obj/Jutsus/Ones_Own_Life_Reincarnation
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Ones_Own_Life_Reincarnation()
						del(J)
			if("[list2params(usr.Handseals)]"=="Ox&Rat&Rat")
				var/obj/Jutsus/Shikigami_Dance/J=new/obj/Jutsus/Shikigami_Dance
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shikigami_Dance()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Ox&Dragon")
				var/obj/Jutsus/Bringer_of_Darkness_Technique/J=new/obj/Jutsus/Bringer_of_Darkness_Technique
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bringer_of_Darkness_Technique()
						del(J)
			if("[list2params(usr.Handseals)]"=="Snake&Dragon&Dragon")
				var/obj/Jutsus/Destruction_Bug_Swarm/J=new/obj/Jutsus/Destruction_Bug_Swarm
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Destruction_Bug_Swarm()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Dog&Ox&Ox")
				var/obj/Jutsus/Desert_Coffin/J=new/obj/Jutsus/Desert_Coffin
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Desert_Coffin()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Dog&Ox")
				var/obj/Jutsus/Sand_Shuriken/J=new/obj/Jutsus/Sand_Shuriken
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Shuriken()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dragon&Snake&Snake&Dragon")
				var/obj/Jutsus/Insect_Coccoon/J=new/obj/Jutsus/Insect_Coccoon
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Insect_Coccoon()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dragon&Dragon&Snake")
				var/obj/Jutsus/Stealth_Bug/J=new/obj/Jutsus/Stealth_Bug
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Stealth_Bug()
						del(J)
			if("[list2params(usr.Handseals)]"=="Ox&Rat&Ox")
				var/obj/Jutsus/Shikigami_Spear/J=new/obj/Jutsus/Shikigami_Spear
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shikigami_Spear()
						del(J)
			if("[list2params(usr.Handseals)]"=="Dog&Dog&Ox&Dog")
				var/obj/Jutsus/Shukakku_Spear/J=new/obj/Jutsus/Shukakku_Spear
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shukakku_Spear()
						del(J)
			if("[list2params(usr.Handseals)]"=="Rabbit&Rabbit&Rabbit")
				var/obj/Jutsus/Earth_Disruption/J=new/obj/Jutsus/Earth_Disruption
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Disruption()
						del(J)
			if("[list2params(usr.Handseals)]"=="Rabbit&Rabbit&Monkey")
				var/obj/Jutsus/Earth_Release_Mud_River/J=new/obj/Jutsus/Earth_Release_Mud_River
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Release_Mud_River()
						del(J)
			usr.Handseals = list()