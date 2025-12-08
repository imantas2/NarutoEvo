
turf
	chuuninhands
		icon = 'Chuuninhands.png'
mob
	var
		list2
		crecord
		maxbunshin=1
		maxmsbunshin=2
		maxmizubunshin=2
		katon=2
		UchihaJ=0
		tmp
			copy
			bunshin=0
			sbunshin=0
			msbunshin=0
			first
			second
			third
			fourth
			fifth
			sixth
			seventh
			eighth
			nineth
			tenth
			eleventh
			twelveth
			rabbit=0
			rat=0
			dog=0
			horse=0
			dragon=0
			monkey=0
			ox=0
			snake=0
			sign=0
obj
	var
		tmp
			Excluded=0
		signs
		rank
		uses=0
mob
	var//Variables
		list
			JutsusLearnt=new()
//mob
//	proc
//		Quake_Effect(mob/M,duration,strength=1)
//			if(!M.client)return
//			spawn(1)
//				var/oldeye=M.client.eye
//				var/x
//				for(x=0;x<duration,x++)
//					M.client.eye = get_steps(M,pick(NORTH,SOUTH,EAST,WEST),strength)
//					sleep(1)
//				M.client.eye=oldeye
//Rat,Ox,Dog,Dragon,Snake,Horse,Rabbit,Monkey
mob/var/list/sbought = list()
obj
	var/Sprice=1
	var/reqs = list()
	var/starterjutsu=0
	var/sharin=0
	Jutsus
		var/Clan
		var/Element
		var/Element2
		var/Kekkai
		icon='Misc Effects.dmi'
		layer=99999
		pixel_x=12
		New()
			if(src.z==4)invisibility=1
		Click()
			if(usr.Tutorial==3&&src.type!=/obj/Jutsus/BodyReplace)
				usr<<"You shouldn't buy this, you need the Substitution Technique found under Non Clan Skills."
				return
			if(src.type in usr.JutsusLearnt)
				if(usr.client.eye==locate(10,10,4)||usr.client.eye==locate(60,10,4)||usr.client.eye==locate(12,43,4)||usr.client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return//lol tenten
				if(src.uses>=100)usr.doslot(src.name)
				else usr<<output("<Font color=red>You need to use [src.name] [100-src.uses] more times([src.uses]).</Font>","actionoutput")
			else
				if(src.name in usr.sbought)return
				if(src.name=="Sage Mode"&&"Curse Seal" in usr.sbought) return
				if(src.name=="Curse Seal"&&"Sage Mode" in usr.sbought) return
				if(usr.UchihaJ>=3)
					usr<<" You can not learn any more clan jutsu."
					return
				var/has_reqs = 0
				var/check=0
				var/Element1
				var/Element2z
				var/KekkaiC
				for(var/X in src.reqs)
					for(var/O in usr.sbought)
						if(O == X)check+=1
				if(check == length(src.reqs))has_reqs=1
				else has_reqs=0
				if(Clan)
					if(Clan!=usr.Clan)
						usr<<output("You are not the appropriate clan to learn this technique. ([Clan]).","actionoutput")
						return
				if(src.Element)if(src.Element!=usr.Element&&src.Element!=usr.Element2)Element1=1
				if(src.Element2)if(src.Element2!=usr.Element&&src.Element2!=usr.Element2)Element2z=1
				if(src.Kekkai)if(src.Kekkai!=usr.Kekkai)KekkaiC=1
				if(Element1)
					usr<<output("You do not have the appropriate element affinity to learn this technique. ([Element][Element2 ? " and [Element2]" : ""]).","actionoutput")
					return
				if(Element2z)
					usr<<output("You do not have the appropriate element affinity to learn this technique. ([Element][Element2 ? " and [Element2]" : ""]).","actionoutput")
					return
				if(KekkaiC)
					usr<<output("You do not have the appropriate Kekkai Genkai to learn this technique..","actionoutput")
					return
				if(has_reqs==1)
					var/I=usr.CustomInput("Skill Tree","[Description]<br><br>Buy this jutsu for [src.Sprice] skill points?",list("Yes","No"))
					if(!I) return
					switch(I:name)
						if("Yes")
							if(usr.skillpoints<src.Sprice)
								usr<<output("Not enough skill points to purchase [src.name]. You need [src.Sprice].","actionoutput")
								return
							usr.skillpoints-=src.Sprice
							if(src.name == "Spider" || src.name == "Deidara" || src.name == "Puppeteer" || src.name == "Sand" || src.name == "Paper Control" || src.name == "Jashin Religion" || src.name == "Kakuzu"||src.name == "Ice")
								usr.sbought+=src.name
								if(src.name == "Sand")usr.Clan = "Sand"
								if(src.name == "Deidara")usr.Clan = "Deidara"
								if(src.name == "Puppeteer")usr.Clan = "Puppeteer"
								if(src.name == "Paper Control")usr.Clan = "Paper"
								if(src.name == "Jashin Religion")usr.Clan = "Jashin"
								if(src.name == "Kakuzu")usr.Clan = "Kakuzu"
								if(src.name == "Spider")usr.Clan = "Spider"
								if(src.name == "Ice")usr.Clan = "Ice"

							else
							/*	if(src.name=="Tsukiyomi"||src.name=="Amaterasu"||src.name=="Kamui"||src.name=="Susanoo"||src.name=="Eternal Mangekyou Sharingan")
									usr.UchihaJ++*/
								if(src.sharin<>0 && src.sharin<>1)
									usr.sbought+=src.name
									for(var/obj/Jutsus/Sharingan/SH in usr.JutsusLearnt)
										var/os = SH.icon_state
										SH.icon_state = src.icon_state
										SH.mouse_drag_pointer = src.mouse_drag_pointer
										SH.name = src.name
										if(usr.HotSlotSave["HotSlot1"]==os)
											for(var/obj/HotSlots/HotSlot1/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot1"]="[src.icon_state]"
												usr.hotslot1=src.name
												h.HotSlotNumber("F1")
										if(usr.HotSlotSave["HotSlot2"]==os)
											for(var/obj/HotSlots/HotSlot2/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot2"]="[src.icon_state]"
												usr.hotslot2=src.name
												h.HotSlotNumber("F2")
										if(usr.HotSlotSave["HotSlot3"]==os)
											for(var/obj/HotSlots/HotSlot3/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot3"]="[src.icon_state]"
												usr.hotslot3=src.name
												h.HotSlotNumber("F3")
										if(usr.HotSlotSave["HotSlot4"]==os)
											for(var/obj/HotSlots/HotSlot4/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot4"]="[src.icon_state]"
												usr.hotslot4=src.name
												h.HotSlotNumber("F4")
										if(usr.HotSlotSave["HotSlot5"]==os)
											for(var/obj/HotSlots/HotSlot5/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot5"]="[src.icon_state]"
												usr.hotslot5=src.name
												h.HotSlotNumber("F5")
										if(usr.HotSlotSave["HotSlot6"]==os)
											for(var/obj/HotSlots/HotSlot6/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot6"]="[src.icon_state]"
												usr.hotslot6=src.name
												h.HotSlotNumber("F6")
										if(usr.HotSlotSave["HotSlot7"]==os)
											for(var/obj/HotSlots/HotSlot7/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot7"]="[src.icon_state]"
												usr.hotslot7=src.name
												h.HotSlotNumber("F7")
										if(usr.HotSlotSave["HotSlot8"]==os)
											for(var/obj/HotSlots/HotSlot8/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot8"]="[src.icon_state]"
												usr.hotslot8=src.name
												h.HotSlotNumber("F8")
										if(usr.HotSlotSave["HotSlot9"]==os)
											for(var/obj/HotSlots/HotSlot9/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot9"]="[src.icon_state]"
												usr.hotslot9=src.name
												h.HotSlotNumber("F9")
										if(usr.HotSlotSave["HotSlot10"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot10"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.HotSlotNumber("F10")
										SH.level +=1
								else
									if(src.name == "Sealing Technique: Seal of Terror")usr.Clan = "Sealing Clan"
									usr.sbought+=src.name
									var/obj/Jutsus/ZZ=new src.type
									usr.JutsusLearnt.Add(ZZ)
									usr.JutsusLearnt.Add(ZZ.type)
									ZZ.owner=usr.ckey
									if(istype(ZZ,/obj/Jutsus/BClone))
										var/obj/Jutsus/BCloneD/D=new
										usr.skillpoints-=src.Sprice
										usr.JutsusLearnt.Add(D)
										usr.JutsusLearnt.Add(D.type)
										D.owner=usr.ckey
							if(src.name <> "Kakuzu"&&src.name <> "Ice" &&src.name <> "Spider" && src.name <> "Deidara" && src.name <> "Puppeteer" && src.name <> "Sand" && src.name <> "Paper Control"&&src.name <> "Sealing Clan")
								usr<<output("Successfully learned [src.name]. Check your Jutsus list for information on the seals.","actionoutput")
							usr.updateskills()

				else
					usr<<output("You do not meet the requirements for this technique.","actionoutput")
		MouseDrop(var/H)
			if(!src in usr.JutsusLearnt)
				return
			if(src.uses>=100)
				if(istype(H,/obj/HotSlots/HotSlot1))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot1"]="[src.icon_state]"
					usr.hotslot1=src.name
					h.HotSlotNumber("F1")
				if(istype(H,/obj/HotSlots/HotSlot2))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot2"]="[src.icon_state]"
					usr.hotslot2=src.name
					h.HotSlotNumber("F2")
				if(istype(H,/obj/HotSlots/HotSlot3))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot3"]="[src.icon_state]"
					usr.hotslot3=src.name
					h.HotSlotNumber("F3")
				if(istype(H,/obj/HotSlots/HotSlot4))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot4"]="[src.icon_state]"
					usr.hotslot4=src.name
					h.HotSlotNumber("F4")
				if(istype(H,/obj/HotSlots/HotSlot5))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot5"]="[src.icon_state]"
					usr.hotslot5=src.name
					h.HotSlotNumber("F5")
				if(istype(H,/obj/HotSlots/HotSlot6))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot6"]="[src.icon_state]"
					usr.hotslot6=src.name
					h.HotSlotNumber("F6")
				if(istype(H,/obj/HotSlots/HotSlot7))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot7"]="[src.icon_state]"
					usr.hotslot7=src.name
					h.HotSlotNumber("F7")
				if(istype(H,/obj/HotSlots/HotSlot8))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot8"]="[src.icon_state]"
					usr.hotslot8=src.name
					h.HotSlotNumber("F8")
				if(istype(H,/obj/HotSlots/HotSlot9))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot9"]="[src.icon_state]"
					usr.hotslot9=src.name
					h.HotSlotNumber("F9")
				if(istype(H,/obj/HotSlots/HotSlot10))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot10"]="[src.icon_state]"
					usr.hotslot10=src.name
					h.HotSlotNumber("F10")
			else
				usr<<output("<Font color=red>You need to use [src.name] [100-src.uses] more times([src.uses]).</Font>","actionoutput")
		Flying_Thunder_God
			icon_state="Flyingthunder"
			mouse_drag_pointer = "Flyingthunder"
			name="Flying Thunder God"
			rank="A"
			signs="<font color=green>Rabbit</font><br>(macro(1))"
			maxcooltime=100
			reqs=list("Body Flicker Technique")
			Description="Flying Thunder God: Utilizing chakra control, this converges chakra to your feet, allowing you to move as fast as if you were teleporting."
		Ultimate_Ink_Bird
			icon_state="InkBird"
			mouse_drag_pointer = "InkBird"
			name="Ultimate Ink Bird"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			Sprice=5
			uses=100
			Clan="Ink"
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Description="An Giant Ink Bird streaming with only power of Ink & destroying all in it's path."
		Ink_Lions
			icon_state="Ink Lions"
			mouse_drag_pointer = "Ink Lions"
			name="Ultimate Ink Style: Lions"
			rank="S"
			signs="<font color=green>Rabbit,Dragon,Dog,Rabbit,Dragon,Dog</font><br>(macro(1,5,E,1,5,E))"
			maxcooltime=240
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Clan="Ink"
			Description="This technique creates a bunch of drawn lions dashing towards your opponent with their full might and explodes!"
		Snake_Rustle_Jutsu
			icon_state="Snake Rustle Jutsu"
			mouse_drag_pointer = "Snake Rustle Jutsu"
			name="Ink Style: Snake Rustle Jutsu"
			rank="B"
			signs="<font color=green>Rabbit,Horse,Monkey,Dragon</font><br>(macro(1,3,4,5))"
			maxcooltime=140
			Sprice=2
			Clan="Ink"
			reqs=list("Ink Style: Rats")
			Description="This technique allows one to convert their chakra into drawings and make them come into motion binding the opponent."
		Sai_Snakes
			icon_state="Sai Snakes"
			mouse_drag_pointer = "Sai Snakes"
			name="Ink Style: Snakes"
			rank="A"
			signs="<font color=green>Rabbit,Dragon,Dog,Monkey,Rabbit</font><br>(macro(1,5,E,4,1))"
			maxcooltime=120
			Sprice=2
			Clan="Ink"
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Description="Bites your opponent poisoning them."
		Sai_Rat
			icon_state="SaiRat"
			mouse_drag_pointer = "SaiRat"
			name="Ink Style: Rats"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Monkey,Rabbit</font><br>(macro(1,E,4,1))"
			maxcooltime=120
			Sprice=2
			Clan="Ink"
			Description="Draws rats that naws on your opponent!"
		Wind_Dragon_Projectile
			icon_state="Wind Dragon Projectile"
			mouse_drag_pointer = "Wind Dragon Projectile"
			name="Wind Dragon Projectile"
			rank="A"
			Element="Wind"
			signs="<font color=green>Dog,Rat,Dog,Rat,Dog,Rat,Dog</font><br>(macro(E,Q,E,Q,E,Q,E))"
			maxcooltime=300
			Sprice=3
			reqs=list("Wind Tornados")
			Description="Summon a powerful dragon from the wind and send it crashing into your enemies."
		Shadow_Punch
			icon_state="Shadow Punch"
			mouse_drag_pointer = "Shadow Punch"
			name="Shadow Punch"
			rank="S"
			Clan="Nara"
			signs="<font color=green>Monkey,Snake,Ox,Monkey</font><br>(macro(4,2,W,4))"
			maxcooltime=300
			reqs=list("Shadow Choke")
			Sprice=3
			Description="Shadow Punch: Summon a powerful palm of destruction from the shadows created by your clans inner will and send it crashing into your enemies."
		Shadow_Explosion
			icon_state="Shadow Explosion"
			mouse_drag_pointer = "Shadow Explosion"
			name="Shadow Explosion"
			rank="S"
			Clan="Nara"
			reqs=list("Shadow Punch")
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=350
			Sprice=3
			uses=100
		//	uses=0;notneeded=1
			Description="Shadow Explosion: A deadly attack to fuck up your opponent."
		Fang_Over_Fang
			icon_state="Gatsuga"
			mouse_drag_pointer = "Gatsuga"
			name="Fang Over Fang"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime=50
			//uses=0;notneeded=1
			Sprice=3
			uses=100
			Clan="Inuzuka"
			Description="This technique allows you to show that you are a part of your dog and your dog is a part of you, this technique is the ace of the Inuzuka, Fang Over Fang!"
		Sage_Style_Giant_Rasengan
			icon_state="Rasenshuriken"
			mouse_drag_pointer = "Rasenshuriken"
			name="Sage Style Giant Rasengan"
			rank="S"
			signs="<font color=green>Rabbit,Ox,Rabbit,Ox,Rabbit,Ox</font><br>(macro(1,W,1,W,1,W))"
		//	uses=0;notneeded=1
			maxcooltime=30
			Sprice=5
			reqs=list("Rasengan","Sage Mode")
			Description="Sage Style Giant Rasengan: Channel your Sage Energy and your knowlege of the Rasengan, and form the almighty SAGE STYLE GIANT RASENGAN!"
		Shadow_Stab
			icon_state="Shadow Stab"
			mouse_drag_pointer = "Shadow Stab"
			name="Shadow Stab"
			rank="A"
			Clan="Nara"
			reqs=list("Shadow Bind")
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=300
			Sprice=2
			uses=100
			Description="A deadly technique that can be used by a member of the Nara clan, Shadow Stab uses a previously used Shadow Extension to trap and stab their target. This can cause serious injury, or even death."
		Shadow_Choke
			icon_state="Shadow Choke"
			mouse_drag_pointer = "Shadow Choke"
			name="Shadow Choke"
			rank="A"
			Clan="Nara"
			reqs=list("Shadow Stab")
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=350
			Sprice=3
			uses=100
			Description="A deadly technique that can be used by a member of the Nara clan, Shadow Choke uses a previously used Shadow Extension to trap and choke their target. This can cause serious injury, or even death."
		Shadow_Extension
			icon_state="Shadow Bind"
			mouse_drag_pointer = "Shadow Bind"
			name="Shadow Bind"
			rank="B"
			Clan="Nara"
			signs="<font color=green>Monkey, Snake, Ox</font><br>(macro(4,2,W))"
			maxcooltime=180
			Description="The Nara's clan specialty. Utilizing the shadows around them, the Nara clan can extend their shadow beyond that of normal range, and are able to interact with one's shadow, locking the target in place."
		MizuClone
			icon_state="Water Bunshin"
			mouse_drag_pointer = "Water Bunshin"
			name="Water Clone"
			rank="B"
			Element="Water"
			signs="<font color=green>Rat, Rat, Snake</font><br>(macro(Q,Q,2))"
			maxcooltime=220
			reqs=list("Water Prison")
			Sprice=2
			Description="Utilizing one's elemental chakra and shape manipulation to craft a replication of theirselves, in order to trap enemies using Water Prison techniques through such clones."
		WaterPrison
			icon_state="Water Prison"
			mouse_drag_pointer = "Water Prison"
			name="Water Prison"
			rank="B"
			Element="Water"
			signs="<font color=green>Ox, Snake, Rat, Snake</font><br>(macro(W,2,Q,2))"
			maxcooltime=500
			Sprice=1
			reqs=list("Water Release: Exploding Water Colliding Wave")
			Description="Utilizing one's elemental chakra and shape manipulation to craft a spherical water prison around a target within their grasp."
		Water_Dragon_Projectile
			icon_state="Water Dragon Projectile"
			mouse_drag_pointer = "Water Dragon Projectile"
			name="Water Dragon Projectile"
			rank="A"
			Element="Water"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog,Rat,Dragon,Dragon</font><br>(macro(E,Q,Q,E,E,Q,E,Q,5,5))"
			maxcooltime=450
			reqs=list("Water Shark Projectile")
			Sprice=4
			Description="Summon a powerful dragon from the water and send it crashing into your enemies."
		Mud_Dragon_Projectile
			icon_state="Mud Dragon Projectile"
			mouse_drag_pointer = "Mud Dragon Projectile"
			name="Mud Dragon Projectile"
			rank="A"
			Element="Earth"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog</font><br>(macro(E,Q,Q,E,E,Q,E))"
			maxcooltime=300
			reqs=list("Earth Release: Mud Wall")
			Sprice=3
			Description="Summon a powerful dragon from the earth and send it crashing into your enemies."
		WaterShark
			icon_state="Water Shark"
			mouse_drag_pointer = "Water Shark"
			name="Water Shark Projectile"
			rank="A"
			Element="Water"
			signs="<font color=green>Ox, Snake, Rat, Rabbit, Dragon</font><br>(macro(W,2,Q,1,5))"
			maxcooltime=250
			reqs=list("Water Clone")
			Sprice=3
			Description="Uses one's elemental chakra and shape manipulation to craft a shark-like projectile of crashing water, and forcing it out one's chakra points towards their target."
		Mystical_Palms
			icon_state="Chakra Scalpel"
			mouse_drag_pointer = "Chakra Scalpel"
			name="Mystical Palms"
			rank="A"
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=120
			Sprice=2
			reqs = list("Heal")
			Description="Mystical Palms forms blades of chakra around your hands so your physical attack strength is boosted."
		Shukakku_Spear
			icon_state="Shukakku Spear"
			mouse_drag_pointer = "Shukakku Spear"
			name="Shukakku Spear"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox,Dog</font><br>(macro(E,E,W,E))"
			maxcooltime=220
			Clan="Sand"
			reqs=list("Sand Shuriken")
			Sprice=3
			Description="Summon sand from the earth and use it to form a powerful spear for hurling towards your foes."
		Sand_Funeral
			icon_state="Sand Funeral"
			mouse_drag_pointer = "Sand Funeral"
			name="Sand Funeral"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Ox,Ox,Dog</font><br>(macro(E,W,W,E))"
			maxcooltime=100
			Clan="Sand"
			reqs=list("Desert Coffin")
			Sprice=3
			Description="Use the sand wrapped around your foe from Desert Coffin to kill them by form sharp spikes and stabbing it inwards."
		Insect_Clone
			icon_state="Insect Clone"
			mouse_drag_pointer = "Insect Clone"
			name="Insect Clone"
			rank="S"
			uses=0
			signs="<font color=green>Snake,Dragon,Snake</font><br>(macro(2,5,2))"
			maxcooltime=220
			Clan="Aburame"
			Sprice=2
			Description="Uses the destruction bugs to make a clone that battles alongside you."
		Bug_Neurotoxin
			icon_state="Bug Neurotoxin"
			mouse_drag_pointer = "Bug Neurotoxin"
			name="Destruction Bug Neurotoxin"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake</font><br>(macro(5,2,2))"
			maxcooltime=240
			Clan="Aburame"
			Sprice=2
			reqs = list("Stealth Bug")
			Description="Use your stealth bugs to stun your opponent for a moment long enough for you to close a quick gap."
		Insect_Coccoon
			icon_state="Insect Coccoon"
			mouse_drag_pointer = "Insect Coccoon"
			name="Insect Coccoon"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake,Dragon</font><br>(macro(5,2,2,5))"
			maxcooltime=100
			Clan="Aburame"
			Sprice=3
			reqs = list("Destruction Bug Neurotoxin")
			Description="Unleash the power of your destruction bugs by channeling your body's chakra straight through their nest within you to increase your physical strength and attack range."
		Hunter_Scarabs
			icon_state="Hunter Scarabs"
			mouse_drag_pointer = "Hunter Scarabs"
			name="Destruction Bug Hunter Scarabs"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake</font><br>(macro(5,2))"
			maxcooltime=40
			Clan="Aburame"
			Sprice=2
			reqs = list("Destruction Bug Swarm")
			Description="Summon Destruction Bugs that crawl slowly on the ground and protect you for great mobile area control."
		Destruction_Bug_Swarm
			icon_state="Destruction Bug Swarm"
			mouse_drag_pointer = "Destruction Bug Swarm"
			name="Destruction Bug Swarm"
			rank="S"
			uses=0
			signs="<font color=green>Snake,Dragon,Dragon</font><br>(macro(2,5,5))"
			maxcooltime=160
			Clan="Aburame"
			reqs = list("Insect Clone")
			Sprice=3
			Description="Uses the destruction bugs to make a large swarm that tears apart your enemies savagely."
		Stealth_Bug
			icon_state="Stealth Bug"
			mouse_drag_pointer = "Stealth Bug"
			name="Stealth Bug"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Dragon,Snake</font><br>(macro(5,5,2))"
			maxcooltime=240
			Clan="Aburame"
			reqs = list("Insect Clone")
			Sprice=2
			Description="Uses the destruction bugs to make a swarm of parasites that attack your enemy relentlessly from the inside."
		Sand_Shuriken
			icon_state="Sand Shuriken"
			mouse_drag_pointer = "Sand Shuriken"
			name="Sand Shuriken"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox</font><br>(macro(E,E,W))"
			maxcooltime=150
			Clan="Sand"
			reqs=list("Sand")
			Sprice=2
			Description="Summon sand from the earth and use it to form multiple shurikens for hurling towards your foes."
		Desert_Coffin
			icon_state="Desert Coffin"
			mouse_drag_pointer = "Desert Coffin"
			name="Desert Coffin"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox,Ox</font><br>(macro(E,E,W,W))"
			maxcooltime=300
			Clan="Sand"
			reqs=list("Sand")
			Sprice=2
			Description="Summon sand from the earth and use it to trap your opponent for a long amount of time."
		Sand
			icon_state="Sand"
			mouse_drag_pointer = "Sand"
			name="Sand"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			Clan="No Clan"
			Element="Earth"
			Description="Gain the ability to convert chakra into sand."
		Tsukiyomi
			icon_state="Tsukiyomi"
			mouse_drag_pointer = "Tsukiyomi"
			name="Tsukiyomi"
			rank="S"
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=550
			//Clan="Itachi"
			Sprice=3
			reqs=list("Mangekyou Sharingan")
			Description="An extremely powerful genjutsu that will instantly warp your target to a moonlit insane world, where they will be endlessly tortured. Only the strongest have ever come out of this technique mentally intact."
		TreeBinding
			icon_state="Tree Binding"
			mouse_drag_pointer = "Tree Binding"
			name="Demonic Illusion: Tree Binding Death"
			rank="B"
			signs="<font color=green>Ox,Snake,Rabbit,Dog</font><br>(macro(W,2,1,E))"
			maxcooltime=220
			Sprice=2
			Description="A relatively powerful Genjutsu that will convince your target's mind that they are locked to a nearby tree. This will allow one to attack them from multiple angles, rendering them helpless."
		Amaterasu
			icon_state="Amaterasu"
			mouse_drag_pointer = "Amaterasu"
			name="Amaterasu"
			rank="S"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=220
			//Clan="Sasuke"
			Sprice=3
			reqs=list("Mangekyou Sharingan")
			Description="One of the most fearsome techniques on the face of the planet, the unextinguishable fire. This technique using the power of Mangekyo Sharingan will summon this fearsome fire onto the battlefield, and on your target, causing devastating effects."
		First_Puppet_Summoning
			icon_state="puppet 1"
			mouse_drag_pointer = "puppet 1"
			name="First Puppet Summoning"
			rank="C"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=10
			Sprice=2
			reqs = list("Puppeteer")
			Description="Though it takes a long time to learn, the art of puppetry is a valuable technique to have in battle. This skill alows you to summon a puppet which can uses its hidden weapons to attack opponents."
		Puppet_Dash
			icon_state="puppet dashing"
			mouse_drag_pointer = "puppet dashing"
			name="Puppet Dash"
			rank="B"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=20
			reqs = list("First Puppet Summoning")
			Description="Imbue more chakra into the strands that bind your puppet to you than normal and enable the ability to move your puppets at greater speeds than ever before."
		Puppet_Shoot
			icon_state="puppet shoot"
			mouse_drag_pointer = "puppet shoot"
			name="Puppet Shoot"
			rank="B"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			Sprice=2
			maxcooltime=200
			reqs = list("First Puppet Summoning")
			Description="Make your puppets load one of their hidden weapons, the Arm Knife, for use."
		Puppet_Transform
			icon_state="puppet transform"
			mouse_drag_pointer = "puppet transform"
			name="Puppet Transform"
			rank="B"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=20
			reqs = list("Second Puppet Summoning")
			Description="Make your puppets transform to look identical to you."
		Puppet_Grab
			icon_state="puppet grab"
			mouse_drag_pointer = "puppet grab"
			name="Puppet Grab"
			rank="B"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			Sprice=2
			maxcooltime=120
			reqs = list("Puppet Transform")
			Description="Make your puppets loosen their arms' joints, ready to grab a foe."
		Second_Puppet_Summoning
			icon_state="puppet 2"
			mouse_drag_pointer = "puppet 2"
			name="Second Puppet Summoning"
			rank="B"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			Sprice=3
			maxcooltime=10
			reqs = list("First Puppet Summoning")
			Description="Though it takes a long time to learn, the art of puppetry is a valuable technique to have in battle. This skill alows you to summon a second puppet which can uses its hidden weapons to attack opponents."
		Temple_Of_Nirvana
			icon_state="Temple of Nirvana"
			mouse_drag_pointer = "Temple of Nirvana"
			name="Temple of Nirvana"
			rank="B"
			signs="<font color=green>Dog,Rabbit,Dog,Snake</font><br>(macro(E,1,E,2))"
		//	uses=100
			Sprice=3
			maxcooltime=350
			reqs=list("Demonic Illusion: Tree Binding Death")
			Description="Under the illusion of mystic feathers, this genjutsu will lull anyone near them into a deep sleep, rendering them suseptible to future attacks."
		Jinrai
			icon_state="Chidori Jinrai"
			mouse_drag_pointer = "Chidori Jinrai"
			name="Chidori Jinrai"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Dog</font><br>(macro(2,1,E))"
		//	uses=100
			Element="Lightning"
			maxcooltime=200
			Sprice=2
			reqs = list("Chidori Needles")
			Description="Utilizing chidori's destructive power into a single point of energy, one can channel it down into a beam of devastating force, capable of tearing through rock."
		Eight_Trigrams_Mountain_Crusher
			icon_state="Eight Trigrams Mountain Crusher"
			mouse_drag_pointer = "Eight Trigrams Mountain Crusher"
			name="Eight Trigrams: Mountain Crusher"
			rank="A"
			signs="<font color=green>Snake,Snake,Dog</font><br>(macro(2,2,E))"
			maxcooltime=100
			Description="A more powerful variation of Eight Trigrams Empty Palm. The user hits the target at close range with a powerful wave of chakra."
			Sprice=2
			reqs = list("Eight Trigrams: Empty Palm")
			Clan="Hyuuga"
		Kirin
			icon_state="Kirin"
			mouse_drag_pointer = "Kirin"
			name="Kirin"
			rank="S"
			signs="<font color=green>Ox,Rabbit,Snake,Dog,Dog,Rabbit</font><br>(macro(W,1,2,E,E,1))"
		//	uses=100
			Element="Lightning"
			maxcooltime=500
			Sprice=4
			reqs = list("Chidori Jinrai")
			Description="The ultimate lightning technique. Utilizing the thunder in the clouds, one can manipulate nature itself into their own use. Commanding a powerful lightning strike to be thrown towards their target, with devastating effects ."
		Chidori_Needles
			icon_state="Chidori Needles"
			mouse_drag_pointer = "Chidori Needles"
			name="Chidori Needles"
			rank="A"
			signs="<font color=green>Ox,Rabbit</font><br>(macro(W,1))"
		//	uses=100
			Element="Lightning"
			maxcooltime=110
			Sprice=2
			reqs = list("Chidori")
			Description="Converting lightning elemented chakra into sharp dense needles, allows one to create a weapon of significant power, one that can slice through even rock."
		Sickle_Weasel_Technique
			icon_state="Sickle Weasel Technique"
			mouse_drag_pointer = "Sickle Weasel Technique"
			name="Sickle Weasel Technique"
			rank="A"
			signs="<font color=green>Ox,Snake,Rabbit,Ox</font><br>(macro(W,2,1,W))"
		//	uses=100
			Element="Wind"
			maxcooltime=60
			Sprice=1
			Description="Convert chakra into air, and launch it in a rapid spinning form towards your target at a speed that can slice through trees."
		Rasengan
			icon_state="Rasengan"
			mouse_drag_pointer = "Rasengan"
			name="Rasengan"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Ox</font><br>(macro(1,1,W))"
		//	uses=100
		//	Element="Wind"
			maxcooltime=20
			Sprice=2
			Description="Channeling your chakra into a ball of spinning air, allows one to create a very deadly close-range weapon."
		Rasenshuriken
			icon_state="Rasenshuriken"
			mouse_drag_pointer = "Rasenshuriken"
			name="Rasenshuriken"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Ox,Ox,Ox,Ox</font><br>(macro(1,1,W,W,W,W))"
		//	uses=100
			Element="Wind"
			maxcooltime=30
			Sprice=3
			reqs=list("Rasengan")
			Description="Channeling your chakra into a ball of spinning air, allows one to create a very deadly close-range weapon. More advanced than a normal rasengan, and is much more explosive but takes more chakra."
		Raikiri
			icon_state="Raikiri"
			mouse_drag_pointer = "Raikiri"
			name="Raikiri"
			rank="A"
			signs="<font color=green>Snake,Ox,Ox</font><br>(macro(2,W,W))"
			//uses=100
			Sprice=3
			Element="Lightning"
			maxcooltime=100
			reqs=list("Chidori")
			Description="Create a blade of lightning and drive it through your enemies.."
		Chidori
			icon_state="Chidori"
			mouse_drag_pointer = "Chidori"
			name="Chidori"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Ox</font><br>(macro(2,1,W))"
			//uses=100
			Element="Lightning"
			maxcooltime=20
			Sprice=2
			Description="Channeling your chakra into a ball of lightning, allows one to create a very deadly close-range weapon."
		Chakra_Control
			icon_state="chak2"
			mouse_drag_pointer = "chak2"
			name="Chakra Control"
			rank="E"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=120
			Description="Imbue your chakra to your feet, allowing you to walk on water, and up mountains."
		ChakraRelease
			icon_state="chak"
			mouse_drag_pointer = "chak"
			name="Chakra Release"
			rank="E"
			signs="<font color=green>Rat,Rat</font><br>(macro(Q,Q))"
			uses=100
			maxcooltime=20
			Description="Expel all weaponry placed upon you outwards in a blast of chakra. Released weaponry can fly in the direction it is blasted to harm opponents."
		Shikigami_Spear
			icon_state="Shikigami Spear"
			mouse_drag_pointer = "Shikigami Spear"
			name="Shikigami Spear"
			rank="A"
			signs="<font color=green>Ox,Rat,Ox</font><br>(macro(W,Q,W))"
			uses=0
			Clan = "Paper"
			reqs = list("Paper Control")
			maxcooltime=360
			Description="Channel your chakra through paper and fire a deadly spear created from it."
		Shikigami_Dance//Angel_Wings
			icon_state="Shikigami Dance"
			mouse_drag_pointer = "Shikigami Dance"
			name="Shikigami Dance"
			rank="A"
			signs="<font color=green>Ox,Rat,Rat</font><br>(macro(W,Q,Q))"
			uses=0
			Clan = "Paper"
			reqs = list("Paper Chakram")
			maxcooltime=240
			Description="Replace your body with paper upon receiving damage with this jutsu active."
		Angel_Wings//Angel_Wings
			icon_state="Angel Wings"
			mouse_drag_pointer = "Angel Wings"
			name="Angel Wings"
			rank="S"
			signs="<font color=green>None</font><br>"
			uses=100
			Clan = "Paper"
			reqs = list("Paper Chakram")
			maxcooltime=300
			Description="Creates huge Paper Wings which boost your Clan's power by a lot. Each Jutsu gains an additional effect!"
		Paper_Chakram
			icon_state="Paper Chakram"
			mouse_drag_pointer = "Paper Chakram"
			name="Paper Chakram"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Clan = "Paper"
			reqs = list("Paper Control")
			maxcooltime=200
			Sprice=3
			Description="A technique that consists of pouring one's chakra into a scrap of paper in a split second, hardening and sharpening it, so it can be used as a chakram."
		Paper_Control
			icon_state="Paper Control"
			mouse_drag_pointer = "Paper Control"
			name="Paper Control"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			Clan="No Clan"
			Description="Gain the ability to convert chakra into paper."
		Jashin_Religion
			icon_state="Jashin Religion"
			mouse_drag_pointer = "Jashin Religion"
			name="Jashin Religion"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=4
			Clan="No Clan"
			Description="Learn to worship Jashin and harness evil powers."
		Death_Ruling_Possesion_Blood
			icon_state="Death Ruling Possesion Blood"
			mouse_drag_pointer = "Death Ruling Possesion Blood"
			name="Sorcery: Death Ruling Possesion Blood"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			uses=100
			Clan="Jashin"
			Description="Create a circle of blood and, while standing within it, turn yourself into a voodoo doll and stab yourself to harm another."
		Immortality
			icon_state="Immortality"
			mouse_drag_pointer = "Immortality"
			name="Sacrifice to Jashin"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			uses=100
			reqs = list("Sorcery: Death Ruling Possesion Blood")
			Clan="Jashin"
			Description="Sacrifice someone's life to grant yourself immortality."
		Immortal
			icon_state="Immortal"
			mouse_drag_pointer = "Immortal"
			name="Immortal"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=5
			uses=100
			reqs = list("Sacrifice to Jashin")
			Clan="Jashin"
			Description="Grants a period of complete Immortality to Jashin worshipers."
		Sharingan
			icon_state="Sharingan 1 tomoe"
			mouse_drag_pointer = "Sharingan 1 tomoe"
			name="Sharingan 1 tomoe"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=35
			uses=100
			sharin=1
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."
		Sharingan_2
			icon_state="Sharingan 2 tomoe"
			mouse_drag_pointer = "Sharingan 2 tomoe"
			name="Sharingan 2 tomoe"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=35
			Sprice=2
			uses=100
			sharin=2
			reqs = list("Sharingan 1 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."
		Sharingan_3
			icon_state="Sharingan 3 tomoe"
			mouse_drag_pointer = "Sharingan 3 tomoe"
			name="Sharingan 3 tomoe"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=35
			Sprice=2
			uses=100
			sharin=3
			reqs = list("Sharingan 2 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."
		Sharingan_4
			icon_state="Mangekyou Sharingan"
			mouse_drag_pointer = "Mangekyou Sharingan"
			name="Mangekyou Sharingan"
			rank="A"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=35
			Sprice=3
			uses=100
			sharin=4
			reqs = list("Sharingan 3 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."
		Sharingan_5
			icon_state="Eternal Mangekyou"
			mouse_drag_pointer = "Eternal Mangekyou"
			name="Eternal Mangekyou Sharingan"
			rank="S"
			Clan="Uchiha"
			signs="<font color=green>None</font<br>(macro(None))"
			maxcooltime=280
			Sprice=3
			uses=100
			sharin=5
			reqs = list("Mangekyou Sharingan")
			Description="The unbelieveable strong, only and only... ETERNAL MANGEKYOU SHARINGAN! Mastered only among the best of the Uchihas."
		Sharingan_Copy
			icon_state="Sharingan Copy"
			mouse_drag_pointer = "Sharingan Copy"
			name="Sharingan Copy"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=5
			Sprice=2
			uses=100
			reqs = list("Sharingan 3 tomoe")
			Description="Use your Sharingan to allow you to copy techniques used by other Shinobi."
		Susanoo
			icon_state="Susanoo"
			mouse_drag_pointer = "Susanoo"
			name="Susanoo"
			Sprice=3
			rank="S"
			Clan= "Uchiha"
			signs="<font color=green>Dog,Ox,Dragon,Ox,Dog</font><br>(macro(E,W,5,W,E))"
			maxcooltime=750
			reqs = list("Mangekyou Sharingan")
			Description="The last technique one will learn through the Mangekyou Sharingan, Susanoo creates a giant warrior god to aid you who is very useful in all situations."
		AdvancedBodyReplace
			icon_state="Abodyreplace"
			mouse_drag_pointer = "Abodyreplace"
			name="Advanced Body Replacement Jutsu"
			rank="E"
			signs="<font color=green>Dog,Dog</font><br>(macro(E,E))"
			maxcooltime=240
			Description="Body replacement technique. Substitute your body with a log, allowing you to escape from battle."
		Sensatsu_Suishou
			icon_state="Sensatsu Suishou"
			mouse_drag_pointer = "Sensatsu Suishou"
			name="Sensatsu Suishou"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Rabbit</font><br>(macro(1,E,1))"
			maxcooltime=120
			Sprice=2
			Clan = "Ice"
			reqs = list("Ice")
			Description="This technique forms deadly ice needles that impale your opponents."
		BodyReplace
			icon_state="bodyreplace"
			mouse_drag_pointer = "bodyreplace"
			name="Body Replacement Jutsu"
			rank="E"
			signs="<font color=green>Dog</font><br>(macro(E))"
			maxcooltime=60
			//starterjutsu=1
			Description="Body replacement technique. Substitute your body with a log, allowing you to escape from battle."
		Eight_Trigrams_Palm_Heavenly_Spin
			icon_state="Kaiten"
			mouse_drag_pointer = "Kaiten"
			name="Eight Trigrams Palm: Heavenly Spin"
			rank="B"
			signs="<font color=green>Snake,Rat,Snake,Dragon</font><br>(macro(2,Q,2,5))"
			maxcooltime=120
			Sprice=2
			Clan="Hyuuga"
			reqs=list("Byakugan")
			Description="This technique allows the user to utilize their Byakugan and spin rapidly in a 360 degree motion, repelling all offensives against the user."
		Transformation
			icon_state="henge"
			mouse_drag_pointer = "henge"
			name="Transformation Jutsu"
			rank="E"
			signs="<font color=green>Dog,Rat</font><br>(macro(E,Q))"
			maxcooltime=100
			starterjutsu=1
			Description="This technique transforms the user into the selected target."
		Eight_Trigrams_64_Palms
			icon_state="64 Palms"
			mouse_drag_pointer = "64 Palms"
			name="Eight Trigrams: 64 Palms"
			rank="A"
			signs="<font color=green>Snake,Rat,Dragon,Rat,Dragon</font><br>(macro(2,Q,5,Q,5))"
			maxcooltime=450
			Sprice=3
			Clan="Hyuuga"
			reqs=list("Eight Trigrams: Empty Palm")
			Description="This technique allows the user to utilize Byakugan and Jyuuken simultaneously. The user can rapidly strike all of an opponents chakra points, disabling their ability to use chakra."
		Eight_Gates_Assault
			icon_state="Eight Gates Assault"
			mouse_drag_pointer = "Eight Gates Assault"
			name="Last Resort: Eight Gates Assault"
			rank="S"
			signs="<font color=green>Snake,Rat,Dragon,Rat,Dragon,Dragon</font><br>(macro(2,Q,5,Q,5,5))"
			maxcooltime=350
			Sprice=4
			Clan="Hyuuga"
			reqs=list("Eight Trigrams: 64 Palms")
			Description="This technique allows the user to utilize Byakugan and Jyuuken simultaneously. The user can strike and close the opponent's eight chakra gates, mortally wounding them."
		Eight_Trigrams_Empty_Palm
			icon_state="Eight Trigrams Empty Palm"
			mouse_drag_pointer = "Eight Trigrams Empty Palm"
			name="Eight Trigrams: Empty Palm"
			rank="S"
			signs="<font color=green>Snake,Rat</font><br>(macro(2,Q))"
			maxcooltime=30
			Sprice=2
			Clan="Hyuuga"
			reqs=list("Byakugan")
			Description="This technique allows the user to utilize Byakugan and Jyuuken simultaneously. The user can deliver a punch so powerful it creates an impact shell of air and works like a projectile."
		Deidara
			icon_state="Deidara"
			mouse_drag_pointer = "Deidara"
			name="Deidara"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			Clan="No Clan"
			Element="Earth"
			Description="By using the forbidden Kinjutsu of the Iwagakure along with exploding clay, you gain the ability to create dolls which attack the opponent and explode."
		Ice
			icon_state="IceKekkeiGenkai"
			mouse_drag_pointer = "IceKekkeiGenkai"
			name="Ice"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			Clan="No Clan"
			Description="Allows user to gain powers of the Ice Kekkei Genkai."
		Puppeteer
			icon_state="Puppeteer"
			mouse_drag_pointer = "Puppeteer"
			name="Puppeteer"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=2
			Clan="No Clan"
			Description="Train yourself to learn to control a puppet through chakra strings that come from your fingers."
		SClone
			icon_state="Shadclone"
			mouse_drag_pointer = "Shadclone"
			name="Shadow Clone Jutsu"
			rank="A"
			signs="<font color=green>Rat,Dragon</font><br>(macro(Q,5))"
			maxcooltime=120
			Sprice=1
			reqs=list("Clone Destroy")
			Description="This technique allows the user to replicate themselves into a single solid form on the battlefield.."
		Water_Release_Exploding_Water_Colliding_Wave
			icon_state="Water Release Exploding Water Colliding Wave"
			mouse_drag_pointer = "Water Release Exploding Water Colliding Wave"
			name="Water Release: Exploding Water Colliding Wave"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Snake</font><br>(macro(1,E,2))"
			maxcooltime=200
			Element="Water"
			Description="This technique unleashes a massive torrent of water from the user's mouth. It will wash away any foes it meets."
		Body_Flicker
			icon_state="Shunshin"
			mouse_drag_pointer = "Shunshin"
			name="Body Flicker Technique"
			rank="D"
			signs="<font color=green>None</font><br>"
			maxcooltime=100
			uses=100
			Description="Utilizing chakra control, this converges chakra to your feet, allowing you to move extremely fast to a location."
		One_Thousand_Years_of_Death
			icon_state="One Thousand Years of Death"
			mouse_drag_pointer = "One Thousand Years of Death"
			name="Leaf Hidden Finger Jutsu: One Thousand Years of Death"
			rank="D"
			signs="<font color=green>None</font><br>"
			maxcooltime=100
			uses=100
			Description="Launch your opponent into the air with a powerful strike in a ... specific... place."
		BClone
			icon_state="clone"
			mouse_drag_pointer = "clone"
			name="Clone Jutsu"
			rank="D"
			signs="<font color=green>Rat</font><br>(macro(Q))"
			maxcooltime=120
			starterjutsu=1
			Description="This technique allows the user to replicate themself in a non-solid form. It is an illusionary technique that has no solid form"
		BCloneD
			icon_state="cloneD"
			mouse_drag_pointer = "cloneD"
			name="Clone Destroy"
			rank="D"
			signs="<font color=green>Rat,Ox</font><br>(macro(Q,W))"
			uses=100
			maxcooltime=120
			reqs=list("Clone Jutsu")
			starterjutsu=1
			Description="This technique destroys the clones you have out on the field."
		Demonic_Ice_Mirrors
			icon_state="Demonic Ice Mirrors"
			mouse_drag_pointer = "Demonic Ice Mirrors"
			name="Demonic Ice Mirrors"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Ox,Rabbit</font><br>(macro(1,E,E,W,1))"
			maxcooltime=140
			Sprice=2
			Clan = "Ice"
			reqs = list("Ice")
			Description="This technique creates multiple ice-like mirrors around the selected target, and allows the user to throw needles towards the target from different angles by warping to the different mirrors at high speeds."
		Opening_Gate
			icon_state="Gate 1"
			mouse_drag_pointer = "Gate 1"
			name="Opening Gate"
			rank="B"
			Sprice=2
			signs="<font color=green>None</font><br>"
			maxcooltime=200
			uses=100
			Description="Opens the first chakra gate, increasing your strength and causing damage to yourself."
		Bringer_of_Darkness_Technique
			icon_state="Bringer of Darkness Technique"
			mouse_drag_pointer = "Bringer of Darkness Technique"
			name="Bringer of Darkness Technique"
			rank="B"
			signs="<font color=green>Dog,Ox,Dragon</font><br>(macro(E,W,5))"
			maxcooltime=400
			uses=100
			Sprice=3
			Description="Force the opponent to not be able to see light for a short amount of time."
		Energy_Gate
			icon_state="Gate 2"
			mouse_drag_pointer = "Gate 2"
			name="Energy Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=200
			Sprice=2
			uses=100
			reqs=list("Opening Gate")
			Description="Opens the second chakra gate, causing you to have temporary invincibility."
		Life_Gate
			icon_state="Gate 3"
			mouse_drag_pointer = "Gate 3"
			name="Life Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=200
			Sprice=2
			uses=100
			reqs=list("Opening Gate","Energy Gate")
			Description="Opens the third chakra gate, allowing you to dramatically increase your strength and cause more damage to yourself."
		Pain_Gate
			icon_state="Gate 4"
			mouse_drag_pointer = "Gate 4"
			name="Pain Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=200
			Sprice=3
			uses=100
			reqs=list("Opening Gate","Energy Gate","Life Gate")
			Description="Opens the fourth chakra gate, increasing your strength, giving you blinding speed, and causing damage to yourself."
		Limiter_Gate
			icon_state="Gate 5"
			mouse_drag_pointer = "Gate 5"
			name="Limiter Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=200
			Sprice=4
			uses=100
			reqs=list("Opening Gate","Energy Gate","Life Gate","Pain Gate")
			Description="Opens the fifth chakra gate, increasing your strength unbeleivably and causing damage to yourself."
		Curse_Seal_of_Heaven
			icon_state="Curse Seal"
			mouse_drag_pointer = "Curse Seal"
			name="Curse Seal of Heaven"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime=600
			Sprice=3
			uses=100
			Description="Release the power of your Curse Seal and gain infinite chakra for a short amount of time at the cost of physical damage."

		Sand_Sheild
			icon_state="Sand Sheild"
			mouse_drag_pointer = "Sand Sheild"
			name="Sand Sheild"
			rank="B"
			signs="<font color=green>Dog,Ox,Dog,Ox</font><br>(macro(E,W,E,W))"
			maxcooltime=300
			Sprice=2
			uses=0
			reqs=list("Desert Coffin")
			Description="Creates a sheild of sand around you which can block most attacks and attack with powerful close-range spikes."
		MSClone
			icon_state="Mclone"
			mouse_drag_pointer = "Mclone"
			name="Multiple Shadow Clone Jutsu"
			rank="A"
			signs="<font color=green>Rat,Dragon,Dog,Monkey,Monkey</font><br>(macro(Q,5,E,4,4))"
			maxcooltime=200
			Sprice=2
			reqs=list("Shadow Clone Jutsu")
			Description="This technique is similar to Shadow Clone Jutsu, only it allows the user to create multiple solid copies of themself."
		FireBall
			icon_state="fireball"
			mouse_drag_pointer = "fireball"
			name="Fire Release: Fire Ball"
			rank="D"
			signs="<font color=green>Dog,Dog,Rat</font><br>(macro(E,E,Q))"
			maxcooltime=70
			Element="Fire"
			Description="This technique unleashes a small fireball from the caster's hands."
		AFireBall
			icon_state="Afireball"
			mouse_drag_pointer = "Afireball"
			name="Fire Release: Blazing Sun"
			rank="A"
			signs="<font color=green>Dog,Rat,Dog,Rabbit,Snake</font><br>(macro(E,Q,E,1,2))"
			maxcooltime=175
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Phoenix Immortal Fire Technique")
			Description="This technique is similar to fireball, but it is a significantly larger fireball that can devastate multiple opponents."
		Ones_Own_Life_Reincarnation
			icon_state="Ones Own Life Reincarnation"
			mouse_drag_pointer = "Ones Own Life Reincarnation"
			name="One's Own Life Reincarnation"
			rank="A"
			signs="<font color=green>Horse,Horse,Horse</font><br>(macro(3,3,3))"
			maxcooltime=150
			Sprice=2
			reqs=list("Heal")
			Description="Sacrifice your own life to revive a fallen comrade."
		Cherry_Blossom_Impact
			icon_state="Cherry Blossom Impact"
			mouse_drag_pointer = "Cherry Blossom Impact"
			name="Cherry Blossom Impact"
			rank="C"
			signs="<font color=green>Horse,Horse,Rabbit</font><br>(macro(3,3,1))"
			maxcooltime=20
			Sprice=2
			reqs=list("Mystical Palms")
			Description="Use a precise injection of chakra from your hand to an opponent to blast them away with immense strength."
		Achiever_of_Nirvana_Fist
			icon_state="Achiever of Nirvana Fist"
			mouse_drag_pointer = "Achiever of Nirvana Fist"
			name="Achiever of Nirvana Fist"
			rank="A"
			signs="<font color=green>Horse,Horse,Snake</font><br>(macro(3,3,2))"
			maxcooltime=450
			Sprice=2
			Description="Strike someone down with a precise hit, making them fall asleep."
		Poison_Mist
			icon_state="Poison Mist"
			mouse_drag_pointer = "Poison Mist"
			name="Poison Mist"
			rank="B"
			signs="<font color=green>Dragon,Horse,Snake</font><br>(macro(5,3,2))"
			maxcooltime=100
			Sprice=2
			Description="Convert your chakra into poison gas and breath it out through your mouth."
		Blade_Manipulation_Jutsu
			icon_state="Blade Manipulation Jutsu"
			mouse_drag_pointer = "Blade Manipulation Jutsu"
			name="Blade Manipulation Jutsu"
			rank="B"
			Clan="Weaponist"
			signs="<font color=green>Dragon,Horse,Dragon</font><br>(macro(5,3,5))"
			maxcooltime=180
			Sprice=2
			Description="Tie several kunai along a chakra string and throw to home in on a target."
		Fire_Release_Ash_Pile_Burning
			icon_state="Ash Pile Burning"
			mouse_drag_pointer = "Ash Pile Burning"
			name="Fire Release: Ash Pile Burning"
			rank="B"
			signs="<font color=green>Dog,Rat,Dog,Rabbit,Dog</font><br>(macro(E,Q,E,1,E))"
			maxcooltime=500
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Fire Ball")
			Description="Spewing ash from the caster's mouth, this technique allows one to burn multiple enemies at once by igniting the ash into a raging torrent."
		Byakugan
			icon_state="Byakugan"
			mouse_drag_pointer = "Byakugan"
			name="Byakugan"
			rank="D"
			signs="<font color=green>Snake</font><br>(macro(2))"
			maxcooltime=300
			Clan="Hyuuga"
			Description="The Hyuuga clan's Doujutsu. This technique gives the user 359 degree vision, and allows them to use strength style: Jyuuken."
		Rinnegan
			icon_state="Rinnegan"
			mouse_drag_pointer = "Rinnegan"
			name="Rinnegan"
			rank="S"
			uses=100
			maxcooltime=500
			Clan="Rinnegan"
			Description="The Legendary Doujutsu, the Rinnegan. The forefather of all doujutsu, capable of mastering the Yin and Yang elements."
		PheonixFire
			icon_state="fireballs"
			mouse_drag_pointer = "fireballs"
			name="Fire Release: Phoenix Immortal Fire Technique"
			rank="C"
			signs="<font color=green>Dog,Rat,Rat,Dog</font><br>(macro(E,Q,Q,E))"
			maxcooltime=250
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Ash Pile Burning")
			Description="This technique is similar to fireball, but it unleashes multiple fireballs in succession."
		Fire_Dragon_Projectile
			icon_state="Fire Dragon Projectile"
			mouse_drag_pointer = "Fire Dragon Projectile"
			name="Fire Release: Fire Dragon Projectile"
			rank="C"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog,Rat</font><br>(macro(E,Q,Q,E,E,Q,E,Q))"
			maxcooltime=350
			Sprice=4
			Element="Fire"
			reqs=list("Fire Release: Phoenix Immortal Fire Technique")
			Description="Breath a raging blast of fire out of your mouth."
		Induction
			icon_state="induct"
			mouse_drag_pointer = "induct"
			name="Gravity Divergence: Induction"
			rank="A"
			signs="<font color=green>Snake,Rabbit</font><br>(macro(2,1))"
			maxcooltime=50
			Sprice=2
			Description="Controlling the force of gravity itself, this allows the user to force their target towards them."
		Repulsion
			icon_state="repulse"
			mouse_drag_pointer = "repulse"
			name="Gravity Divergence: Repulsion"
			rank="A"
			signs="<font color=green>Rabbit,Snake</font><br>(macro(1,2))"
			maxcooltime=50
			Sprice=2
			reqs=list("Gravity Divergence: Induction")
			Description="Controlling the force of gravity itself, this allows the user to force their target away from them."
		Tree_Summoning
			icon_state="Tree Summoning"
			mouse_drag_pointer = "Tree Summoning"
			name="Wood Style: Tree Summoning"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Ox,Ox,Ox</font><br>(macro(E,Q,Q,Q))"
			maxcooltime=150
			Clan="Senjuu"
			reqs=list("Wood Drill")
			Sprice=2
			Description="Summon a Tree towering over even the toughest of foes."
		Almighty_Push
			icon_state="Apush"
			mouse_drag_pointer = "Apush"
			name="Gravity Divergence: Almighty Push"
			rank="S"
			signs="<font color=green>Rabbit,Rabbit,Snake,Snake,Rabbit,Snake</font><br>(macro(1,1,2,2,1,2))"
			maxcooltime=450
			Sprice=4
			reqs=list("Summoning Jutsu: Snake")
			Clan="Rinnegan"
			Description="The ultimate gravity control technique. This technique channels massive amounts of chakra into a gravitational force, allowing one to propel multiple enemies away from themself."
		Meteor_Punch
			icon_state="mpunch"
			mouse_drag_pointer = "mpunch"
			name="Meteor Punch"
			rank="C"
			signs="<font color=green>None"
			maxcooltime=90
			uses=100
			Sprice=2
			reqs = list("Opening Gate")
			Description="Summoning up monsterous strength, this strength ability allows one to channel this strength into a single punch."
		Wind_Sheild
			icon_state="Tornado Sheild"
			mouse_drag_pointer = "Tornado Sheild"
			name="Wind Sheild"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Monkey</font><br>(macro(1,2,4))"
			maxcooltime=60
			uses=0
			Sprice=2
			reqs = list("Sickle Weasel Technique")
			Description="Rapidly spin the air around you using your chakra, and blow away close foes with sharp winds."
		Blade_of_Wind
			icon_state="Blade of Wind"
			mouse_drag_pointer = "Blade of Wind"
			name="Blade of Wind"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Rabbit</font><br>(macro(1,2,1))"
			maxcooltime=50
			uses=0
			Sprice=1
			reqs = list("Sickle Weasel Technique")
			Description="This technique is a pinpoint slashing strike, where the user emits chakra from their fingertips and materializes it into an invisible sword that assaults the enemy in a gust of wind."
		Earth_Disruption
			icon_state="Earth Disruption"
			mouse_drag_pointer = "Earth Disruption"
			name="Earth Disruption"
			rank="D"
			signs="<font color=green>Rabbit,Rabbit,Rabbit</font><br>(macro(1,1,1))"
			maxcooltime=200
			uses=0
			Sprice=2
			Element = "Earth"
			reqs = list("Earth Release: Earth Cage")
			Description="Charge your fist with chakra and plummet it into the ground, knocking down nearby enemies"
		Earth_Style_Dark_Swamp
			icon_state="Earth Style Dark Swamp"
			mouse_drag_pointer = "Earth Style Dark Swamp"
			name="Earth Release: Dark Swamp"
			rank="C"
			signs="<font color=green>Rabbit,Rabbit</font><br>(macro(1,1))"
			maxcooltime=150
			uses=0
			Sprice=3
			Element = "Earth"
			reqs = list("Earth Disruption")
			Description="Turn the ground your opponents stand on into thick mud and make their movement impaired."
		Leaf_Whirlwind
			icon_state="Lwind"
			mouse_drag_pointer = "Lwind"
			name="Leaf Whirlwind"
			rank="C"
			signs="<font color=green>None"
			maxcooltime=120
			uses=100
			Sprice=2
			reqs=list("Life Gate")
			Description="Using a single, yet powerful kick this technique allows one to attack multiple opponents simultaneously."
		Morning_Peacock
			icon_state="Asakujaku"
			mouse_drag_pointer = "Asakujaku"
			name="Morning Peacock"
			rank="C"
			signs="<font color=green>None"
			maxcooltime=150
			Sprice=2
			uses=100
			reqs=list("Limiter Gate")
			Description="This technique unleashes a absolute fury of punches towards their target, and is capable of injuring multiple enemies at once."
		Bone_Pulse
			icon_state="BoneP"
			mouse_drag_pointer = "BoneP"
			name="Bone Pulse"
			rank="C"
			signs="<font color=green>Rat,Dog,Ox</font><br>(macro(Q,E,W))"
			maxcooltime=90
			Clan="Kaguya"
			Sprice=2
			reqs=list("Bone Sensation")
			Description="This technique allows one to unleash their bones from their body into large sharp bone fangs that erupt from the ground before them. They are able to pierce their opponent."
		Young_Bracken_Dance
			icon_state="young bracken dance"
			mouse_drag_pointer = "young bracken dance"
			name="Young Bracken Dance"
			rank="C"
			signs="<font color=green>Rat,Dog,Ox,Ox</font><br>(macro(Q,E,W,W))"
			maxcooltime=240
			Sprice=2
			Clan="Kaguya"
			reqs=list("Bone Pulse")
			Description="This technique allows one to unleash their bones from their body into large sharp bone fangs that erupt from the ground all around them, in a range that varies on the user's ability to control the skill."
		Bone_Tip
			icon_state="BoneT"
			mouse_drag_pointer = "BoneT"
			name="Bone Tip"
			rank="C"
			signs="<font color=green>Ox</font><br>(macro(W))"
			maxcooltime=100
			Clan="Kaguya"
			Description="Using the finger tip-like bones, this technique allows one to blast off those bones towards their target. Skilled users can get the bones lodged in the target"
		Bone_Sensation
			icon_state="BoneS"
			mouse_drag_pointer = "BoneS"
			name="Bone Sensation"
			rank="C"
			signs="<font color=green>Ox,Ox,Rat</font><br>(macro(W,W,Q))"
			maxcooltime=200
			Sprice=2
			Clan="Kaguya"
			reqs=list("Bone Tip")
			Description="After using the finger-tip like bones that have been implanted into your opponent, you can follow it up with this deadly technique which forces the bone-tips to expel outwards from the target's body.."
		Camellia_Dance
			icon_state="Camellia Dance"
			mouse_drag_pointer = "Camellia Dance"
			name="Camellia Dance"
			rank="C"
			signs="<font color=green>Rat,Rat,Ox</font><br>(macro(Q,Q,W))"
			maxcooltime=200
			Sprice=3
			Clan="Kaguya"
			reqs=list("Bone Tip")
			Description="Harden your bones to form a sword which can make your physical attacks stronger."
		Bone_Drill
			icon_state="Bone Drill"
			mouse_drag_pointer = "Bone Drill"
			name="Bone Drill"
			rank="C"
			signs="<font color=green>Rat,Rat,Rat</font><br>(macro(Q,Q,Q))"
			maxcooltime=220
			Sprice=3
			Clan="Kaguya"
			reqs=list("Camellia Dance")
			Description="Harden your bones to form a drill which can drive through your opponents."
		Heal
			icon_state="Heal"
			mouse_drag_pointer = "Heal"
			name="Heal"
			rank="C"
			signs="<font color=green>Dog,Snake,Rat</font><br>(macro(E,2,Q))"
			maxcooltime=300
			Description="This technique allows one to channel their chakra into life force, allowing them to significantly heal themselves in battle."
		Chakra_Leech
			icon_state="Chakra Leech"
			mouse_drag_pointer = "Chakra Leech"
			name="Chakra Leech"
			rank="C"
			signs="<font color=green>Snake,Dragon,Snake,Rat</font><br>(macro(2,5,2,Q))"
			maxcooltime=300
			Description="This technique allows one to draw from another Shinobi's chakra to replenish their own."
		Crow_Clone
			icon_state="Crow Clone"
			mouse_drag_pointer = "Crow Clone"
			name="Crow Clone"
			rank="C"
			Sprice=2
			signs="<font color=green>Rat,Dragon,Dog,Monkey</font><br>(macro(Q,5,E,4))"
			maxcooltime=400
			Description="Create multiple realistic clones by diffusing into multiple crows and solidifying in scattered places to confuse your opponent."
		Earth_Release_Earth_Cage
			icon_state="Doton Cage"
			mouse_drag_pointer = "Doton Cage"
			name="Earth Release: Earth Cage"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Snake,Dog,Rat</font><br>(macro(1,2,2,E,Q))"
			maxcooltime=400
			Element="Earth"
			Description="This technique allows one to channel the forces of the earth into forming a large cage like structure around their opponent, encasing them whilst damaging them from lack of oxygen."
		Earth_Release_Mud_River
			icon_state="Mud River"
			mouse_drag_pointer = "Mud River"
			name="Earth Release: Mud River"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Monkey</font><br>(macro(1,1,4))"
			maxcooltime=250
			Sprice=2
			Element="Earth"
			Description="This technique allows one to convert their chakra into the earth element and make the ground their opponent is standing on turn into mud, disabling the opponent temporarily"
		C2
			icon_state="C2"
			mouse_drag_pointer = "C2"
			name="C2"
			rank="S"
			signs="<font color=green>Dragon,Dragon,Dragon,Dragon,Dragon</font><br>(macro(5,5,5,5,5))"
			maxcooltime=600
			Sprice=3
			Element="Earth"
			reqs = list("C1: Tracking Birds","C1: Spider Swarm")
			Description="This technique allows one to use special mouths on the palms of their hands to create a large clay dragon, which can use the clay it consists of to fire a managerie of explosives at it's oppoenents."
		C3
			icon_state="C3"
			mouse_drag_pointer = "C3"
			name="C3"
			rank="S"
			signs="<font color=green>Dragon,Dragon,Dragon,Dragon,Dog</font><br>(macro(5,5,5,5,E))"
			maxcooltime=300
			Sprice=3
			Element="Earth"
			reqs = list("C2")
			Description="This technique allows one to use special mouths on the palms of their hands to create a large clay doll slightly in the shape of a human, which then falls down from the sky and delivers death to below with an apocalyptic explosion."
		C1_Birds
			icon_state="C1 bird"
			mouse_drag_pointer = "C1 bird"
			name="C1: Tracking Birds"
			rank="B"
			signs="<font color=green>Dragon,Rabbit,Dragon</font><br>(macro(5,1,5))"
			maxcooltime=240
			Element="Earth"
			reqs = list("Deidara")
			Description="This technique allows one to use special mouths on the palms of their hands to create a swarm of clay tracking birds, which fly towards a target and explode on impact."
		C1_Spiders
			icon_state="C1 spider"
			mouse_drag_pointer = "C1 spider"
			name="C1: Spider Swarm"
			rank="B"
			signs="<font color=green>Dragon,Dog,Dragon</font><br>(macro(5,E,5))"
			maxcooltime=260
			Element="Earth"
			reqs = list("Deidara")
			Description="This technique allows one to use special mouths on the palms of their hands to create a swarm of clay spiders, which slowly stalk a target and explode on impact."
		Kamui
			icon_state="Kamui"
			mouse_drag_pointer = "kamui"
			name="Kamui"
			rank="S"
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=550
			Clan="Uchiha"
			reqs=list("Mangekyou Sharingan")
			Description="An extremely powerful genjutsu that will instantly warp your target to another dimension, where they will be endlessly tortured."
		Curse_Dragon
			icon_state="Curse Dragon"
			mouse_drag_pointer = "Curse Dragon"
			name="Curse Dragon"
			rank="S"
			signs="<font color=green>Dog,Rat,Rat</font><br>(macro(E,Q,Q))"
			maxcooltime=300
			reqs=list("Curse Seal")
			Sprice=4
			Description="Summon a powerful dragon from the darkness in your heart and send it crashing into your enemies."
		Snake_Summoning
			icon_state="SnakeSummoning"
			mouse_drag_pointer = "SnakeSummoning"
			name="Summoning Jutsu: Snake"
			rank="B"
			maxcooltime=200
			Clan="Rinnegan"
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			reqs=list("Rinnegan")
			Description="Allows you to summon small snake to aid you in combat!"
		WoodClan
			icon_state="wood style"
			mouse_drag_pointer = "wood style"
			name="Wood Style"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			Clan="No Clan"
			Element="Earth"
			Element2="Water"
			Description="Allows one to combine water and earth element to create Wood!"
		SageMode
			icon_state="Sage Mode"
			mouse_drag_pointer = "Sage Mode"
			name="Sage Mode"
			rank="S"
			maxcooltime=240
			Sprice=5
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			Description="Grants powerful boost to strength and ninjutsu to the user provided by powers of nature."
		CurseSeal
			icon_state="Curse Seal"
			mouse_drag_pointer = "Curse Seal"
			name="Curse Seal"
			rank="S"
			maxcooltime=440
			Sprice=555
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			Description="Grants powerful boost to strength and ninjutsu to the user provided by powers of darkness."
		GreenPill
			icon_state="GreenPill"
			mouse_drag_pointer = "GreenPill"
			name="GreenPill"
			rank="D"
			maxcooltime=130
			Sprice=1
			Clan="Akimichi"
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			Description="Akimichi clan pill. Gives it's user boost in strenght but has health side effects..."
		YellowPill
			icon_state="YellowPill"
			mouse_drag_pointer = "YellowPill"
			name="YellowPill"
			rank="C"
			maxcooltime=140
			Sprice=2
			Clan="Akimichi"
			uses=100
			signs="<font color=green>None</font><br>(macro(None))"
			reqs=list("GreenPill")
			Description="Akimichi clan pill. Gives it's user more strenght and has stronger health side effects..."
		RedPill
			icon_state="RedPill"
			mouse_drag_pointer = "RedPill"
			name="RedPill"
			rank="B"
			uses=100
			maxcooltime=150
			Sprice=3
			Clan="Akimichi"
			signs="<font color=green>None</font><br>(macro(None))"
			reqs=list("YellowPill")
			Description="Akimichi clan pill. Last and most unsafe of Akimichi pills. User becomes super strong at cost of health demage at the pill effect end..."
		HumanBulletTank
			icon_state="Human Bullet Tank"
			mouse_drag_pointer = "Human Bullet Tank"
			name="Human Bullet Tank"
			rank="A"
			Clan="Akimichi"
			signs="<font color=green>None</font><br>(macro(None))"
			maxcooltime=190
			Sprice=5
			uses=100
			reqs=list("YellowPill")
			Description="Akimichi clan speciallity. User becomes transformed into anormous ball of mostly chakra. If spinned at a high speed it allows one to crush his enemies in the way..."
		CalorieControl
			icon_state="CalorieControl"
			mouse_drag_pointer = "CalorieControl"
			name="Calorie Control"
			rank="S"
			signs="<font color=green>Ox,Ox,Dragon,Ox</font><br>(macro(W,W,5,W))"
			Sprice=8
			maxcooltime=240
			Clan="Akimichi"
			reqs=list("RedPill")
			Description="Last and best of Akimichi jutsus. When used person acumulates his body calories into chakra and releases that chakra in a wing shape. Gives anormous amount of strength.."
		Kakuzu
			icon_state="Kakuzu"
			mouse_drag_pointer = "Kakuzu"
			name="Kakuzu"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=4
			Clan="No Clan"
			Description="Gain powers of Kakuzu that allow you to use elemental jutsus without affinity towards that element!"
		FireMask
			icon_state="FireMask"
			mouse_drag_pointer = "FireMask"
			name="Fire Mask"
			rank="A"
			signs="<font color=green>Dog,Snake</font><br>(macro(E,2))"
			maxcooltime=120
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Fire Heart that uses a single Fire jutsu."
		WindMask
			icon_state="WindMask"
			mouse_drag_pointer = "WindMask"
			name="Wind Mask"
			rank="A"
			signs="<font color=green>Ox,Snake</font><br>(macro(W,2))"
			maxcooltime=120
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Wind Heart that uses a single Wind jutsu."
		EarthMask
			icon_state="EarthMask"
			mouse_drag_pointer = "EarthMask"
			name="Earth Mask"
			rank="A"
			signs="<font color=green>Dragon,Rabbit</font><br>(macro(5,1))"
			maxcooltime=120
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Earth Heart that uses a single Earth jutsu."
		LightningMask
			icon_state="LightningMask"
			mouse_drag_pointer = "LightningMask"
			name="Lightning Mask"
			rank="A"
			signs="<font color=green>Dog,Rabbit</font><br>(macro(E,1))"
			maxcooltime=120
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Lightning Heart that uses a single Lightning jutsu."
		MudWall
			icon_state="MudWall"
			mouse_drag_pointer = "MudWall"
			name="Earth Release: Mud Wall"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Rabbit,Rabbit</font><br>(macro(1,1,1,1))"
			maxcooltime=240
			uses=0
			Sprice=2
			Element = "Earth"
			reqs = list("Earth Release: Mud River")
			Description="Focuses large amount of chakra into creating a wall made out of mud to serve as a protection to it's user."
		Weapon_Manipulation_Jutsu
			icon_state="wmj"
			mouse_drag_pointer = "wmj"
			name="Weapon Manipulation Jutsu"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse</font><br>(macro(5,3,5,3))"
			maxcooltime=200
			Clan="Weaponist"
			reqs = list("Blade Manipulation Jutsu")
			Sprice=3
			Description="Tie several kunai along a chakra string and throw to home in on a target."
		TwinDragons
			icon_state="twindragons"
			mouse_drag_pointer = "twindragons"
			name="Twin Dragons"
			rank="S"
			signs="<font color=green>Dragon,Horse,Dragon,Horse,Dragon</font><br>(macro(5,3,5,3,5))"
			maxcooltime=240
			Clan="Weaponist"
			reqs = list("Weapon Manipulation Jutsu")
			Sprice=5
			Description="Tie several kunai along a chakra string and throw to home in on a target."
		C1Snake
			icon_state="C1Snake"
			mouse_drag_pointer = "C1Snake"
			name="C1: Exploding Snake"
			rank="B"
			signs="<font color=green>Dragon,Snake,Dragon</font><br>(macro(5,2,5))"
			maxcooltime=270
			Element="Earth"
			reqs = list("C1: Tracking Birds")
			Description="This technique allows one to use special mouths on the palms of their hands to create a deadly exploding snake that can devaste it's target."
		HiddenSnakeStab
			icon_state="HiddenSnakeStab"
			mouse_drag_pointer = "HiddenSnakeStab"
			name="Hidden Snake Stab"
			rank="S"
			signs="<font color=green>Rat,Snake,Dog</font><br>(macro(Q,2,E))"
			maxcooltime=200
			reqs=list("Curse Dragon")
			Sprice=3
			Description="Turns ones hand into deadly snakes to stab anything in it's way."
		//senjuu
		Root_Strangle
			icon_state="Tree Bind"
			mouse_drag_pointer = "Tree Bind"
			name="Wood Release: Root Strangle"
			rank="B"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox</font><br>(macro(E,1,W))"
			maxcooltime=200
			Clan="Senjuu"
			Sprice=2
			Description="Focuses chakra in order to create a tree to stun the enemy."
		Wood_Balvan
			icon_state="Wood Balvan"
			mouse_drag_pointer = "Wood Balvan"
			name="Wood Release: Wooden Balvan"
			rank="A"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox,Dog</font><br>(macro(E,1,W,E))"
			maxcooltime=220
			Clan="Senjuu"
			Sprice=3
			reqs=list("Wood Release: Root Strangle")
			Description="Focuses chakra in order to create a huge balvan to strike the enemy."
		WoodStyleFortress
			icon_state="WoodStyleFortress"
			mouse_drag_pointer = "WoodStyleFortress"
			name="Wood Release: Wood Fortress"
			rank="B"
			signs="<font color=green>Dog,Dog,Dog,Ox</font><br>(macro(E,E,E,W))"
			maxcooltime=200
			Sprice=2
			reqs=list("Wood Release: Root Strangle")
			Description="This technique allows one to create huge wooden fortrest to protect the user."
		Root_Stab
			icon_state="Root Stab"
			mouse_drag_pointer = "Root Stab"
			name="Wood Release: Root Stab"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox,Dog,Dog</font><br>(macro(E,1,W,E,E))"
			maxcooltime=240
			Clan="Senjuu"
			Sprice=3
			reqs=list("Wood Release: Wood Fortress")
			Description="Summons deadly spikes made out of wood to severely damage ."
		Crystal_Shards
			icon_state="Crystal Shards"
			mouse_drag_pointer = "Crystal Shards"
			name="Crystal Release: Crystal Shards"
			rank="B"
			uses=0
			signs="<font color=green>Ox,Rabbit,Dog</font><br>(macro(W,1,E))"
			maxcooltime=200
			Clan="Crystal"
			Sprice=2
			Description="Focuses chakra in order to create a shard to strike the enemy."
		Crystal_Needles
			icon_state="Crystal Needles"
			mouse_drag_pointer = "Crystal Needles"
			name="Crystal Release: Crystal Needles"
			rank="A"
			uses=0
			signs="<font color=green>Dog,Rabbit,Rabbit,Dog</font><br>(macro(E,1,1,E))"
			maxcooltime=220
			Clan="Crystal"
			Sprice=3
			reqs=list("Crystal Release: Crystal Shards")
			Description="Focuses chakra in order to create a couple of needles to strike the enemy."
		Crystal_Spikes
			icon_state="Crystal Spikes"
			mouse_drag_pointer = "Crystal Spikes"
			name="Crystal Release: Crystal Spikes"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Ox</font><br>(macro(1,E,E,W))"
			maxcooltime=220
			Sprice=2
			reqs=list("Crystal Release: Crystal Needles")
			Description="Deadly spikes made out of crystal that come out of ground to stab users target."
		Crystal_Explosion
			icon_state="Crystal Explosion"
			mouse_drag_pointer = "Crystal Explosion"
			name="Crystal Release: Crystal Explosion"
			rank="S"
			uses=0
			signs="<font color=green>Rabbit,Rabbit,Ox,Dog,Dog</font><br>(macro(1,1,W,E,E))"
			maxcooltime=240
			Clan="Crystal"
			Sprice=3
			reqs=list("Crystal Release: Crystal Spikes")
			Description="Strongest Crystal Release jutsu. Huge number of crystal spikes hurls foward in order to kill anything it touches !"
		Summon_Kazekage_Puppet
			icon_state="kpuppet"
			mouse_drag_pointer = "kpuppet"
			name="Forbiden Tehnique: Kazekage Puppet"
			rank="S"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=240
			Clan="Puppeteer"
			reqs = list("Second Puppet Summoning")
			Description="Puppet Master's ultimate jutsu and a forbiden one. Summons a Puppet made from body of a Kazekage."
		LightningPillars
			icon_state="LightningPillars"
			mouse_drag_pointer = "LightningPillars"
			name="Lightning Pillars"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Dog,Dog</font><br>(macro(2,1,E,E))"
			Element="Lightning"
			maxcooltime=450
			Sprice=2
			reqs = list("Chidori Jinrai")
			Description="Channels lightning chakra flowing through users veins in order to create big Lightning Pillars to freeze the enemy."
		EarthBoulder
			icon_state="EarthBoulder"
			mouse_drag_pointer = "EarthBoulder"
			name="Earth Release: Earth Boulder"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Rabbit,Snake</font><br>(macro(1,1,1,2))"
			Element="Earth"
			maxcooltime=220
			Sprice=3
			reqs = list("Earth Release: Mud River")
			Description="Creates a massive boulder made from earth itself and throws it foward smashing anything in it's way."
		BugTornado
			icon_state="BugTornado"
			mouse_drag_pointer = "BugTornado"
			name="Bug Tornado"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake,Dragon,Dragon</font><br>(macro(5,2,2,5,5))"
			maxcooltime=400
			Clan="Aburame"
			Sprice=5
			reqs = list("Destruction Bug Swarm")
			Description="Summon Destruction Bugs that crawl slowly on the ground and protect you for great mobile area control."
		WebShoot
			icon_state="WebShoot"
			mouse_drag_pointer = "WebShoot"
			name="Spider Web Shoot"
			rank="B"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=200
			Sprice=2
			Clan="Spider"
			Description="Fires off a spider web that can immobilze the target on hit."
		ArrowShoot
			icon_state="ArrowShoot"
			mouse_drag_pointer = "ArrowShoot"
			name="Spider Arrow Shoot"
			rank="A"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=200
			Sprice=3
			reqs = list("Spider Web Shoot")
			Description="Fires off a deadly arrow that pierces through anything!"
		Spider
			icon_state="Spider"
			mouse_drag_pointer = "SpiderSpider"
			name="Spider"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			Sprice=3
			Clan="No Clan"
			Description="Become the spider itself and learn its ways!"
		Summon_Spider
			icon_state="spiders"
			mouse_drag_pointer = "spiders"
			name="Summon Spider"
			rank="S"
			signs="<font color=green>None</font><br>(macro(None))"
			uses=100
			maxcooltime=240
			Clan="Spider"
			reqs = list("Spider Arrow Shoot")
			Description="Summon a huge spider to fight for your cause in combat!"
		//	Description="Summoning up monsterous strength, this strength ability allows one to channel this strength into a single punch."
		Wind_Tornados
			icon_state="Wind Tornados"
			mouse_drag_pointer = "Wind Tornados"
			name="Wind Tornados"
			rank="A"
			signs="<font color=green>Rabbit,Snake,Monkey,Rabbit,Snake</font><br>(macro(1,2,4,1,2))"
			maxcooltime=240
			uses=0
			Sprice=4
			reqs = list("Wind Sheild")
			Description="Rapidly spin the air around you using your chakra, creating tornados themselves to tear appart opponents!"
		Shishi
			icon_state="shishi"
			mouse_drag_pointer = "shishi"
			name="ShiShi Rendan"
			rank="D"
			maxcooltime=100
			Sprice=1
			reqs = list("Energy Gate")
			uses=100
			Description="Shishi Rendan: Very Powerfull combo where user uses its speed to create a series off attacks"
		Teppoudama
			icon_state="tepo"
			mouse_drag_pointer = "tepo"
			name="Suiton Teppoudama"
			rank="B"
			signs="<font color=green>Rat,Dragon,Rat,Ox,Snake</font><br>(macro(Q,5,Q,W,2))"
			maxcooltime=250
			Sprice=1
			Element="Water"
			reqs = list("Water Prison")
			Description="Teppoudama: Shoots Water Ball from user's mouth"
		Dango
			icon_state="dango"
			mouse_drag_pointer = "dango"
			name="Doton Doryo Dango"
			rank="S"
			signs="<font color=green>Dog,Dog,Ox,Rabbit</font><br>(macro(E,E,W,1))"
			maxcooltime=250
			Element="Earth"
			Sprice=1
			Description="Dango: Throws a Huge Rock in user's direction"
		Suijinheki
			icon_state="suijin"
			mouse_drag_pointer = "suijin"
			name="Suiton Suijinheki no Jutsu"
			rank="B"
			signs="<font color=green>Ox,Dragon,Dragon,Rat,Rat</font><br>(macro(W,5,5,Q,Q))"
			maxcooltime=150
			Sprice=1
			Element="Water"
			reqs = list("Water Dragon Projectile")
			Description="Suijunheki: Creates a water wave infront of the user's to protect him"
		Zankuuha
			icon_state="zanku"
			mouse_drag_pointer = "zanku"
			name="Zankuuha"
			rank="D"
			signs="<font color=green>Monkey,Monkey,Rat</font><br>(macro(4,4,Q))"
			maxcooltime=300
			Sprice=1
			Element="Wind"
			Description="Zankuuha: Shoots wind from user's hand"
		JukaiKoutan
			icon_state="Jukai"
			mouse_drag_pointer = "Jukai"
			name="Mokuton Hijutsu - Jukai Koutan"
			rank="S"
			signs="<font color=green>Snake,Snake,Rabbit,Rat,Rabbit</font><br>(macro(2,2,1,Q,1))"
			maxcooltime=600
			Sprice=4
			Clan="Senjuu"
			reqs=list("Wood Drill")
			reqs = list("Mokuton - Jubaku Eisou")
			Description=" Jukai Koutan: User creates a forest that will damage everyone in it"
		JubakuEisou
			icon_state="jubakueisou"
			mouse_drag_pointer = "jubakueisou"
			name="Mokuton - Jubaku Eisou"
			rank="B"
			signs="<font color=green>Rat,Snake,Snake,Rabbit</font><br>(macro(Q,2,2,1))"
			maxcooltime=300
			Sprice=1
			Clan="Senjuu"
			reqs=list("Wood Drill")
			Description="Jubaku Eisou: User creates a prison made of wood around his target to paralyze him"
		Daijurin
			icon_state="daijurin"
			mouse_drag_pointer = "daijurin"
			name="Mokuton - Daijurin no Jutsu"
			rank="B"
			signs="<font color=green>Rat,Rat,Snake,Rabbit,Rabbit</font><br>(macro(Q,Q,2,1,1))"
			maxcooltime=400
			Sprice=1
			reqs=list("Wood Release: Wooden Balvan")
			Clan="Senjuu"
			Description="Daijurin: User stretchs is arm creating wood from it that wood arm will damage anyone he touches"
		Daitoppa
			icon_state="daitoppa"
			mouse_drag_pointer = "daitoppa"
			name="Fuuton Daitoppa"
			rank="B"
			signs="<font color=green>Dragon,Rat,Rat,Rabbit</font><br>(macro(5,Q,Q,1))"
			maxcooltime=200
			Sprice=1
			reqs=list("Wind Cutter")
			Element="Wind"
			Description="Daitoppa: Wind Element jutsu where user releases a huge wind that can push enemys while damaging them"
		Doryuusou
			icon_state="doryuusou"
			mouse_drag_pointer = "doryuusou"
			name="Doton Doryuusou no Jutsu"
			rank="A"
			signs="<font color=green>Dragon,Snake,Monkey</font><br>(macro(5,2,4))"
			maxcooltime=300
			Sprice=1
			Element="Earth"
			Description="Doryuusou: User creates spikes under the targets feet to hurt them"
		Reaper_Death_Seal
			icon_state="RDS"
			mouse_drag_pointer="RDS"
			name="Reaper Death Seal"
			Clan="Sealing Clan"
			rank="S"
			reqs = list("Soul Devastator Seal")
			signs="<font color=green>None</font><br>"
			maxcooltime=340
			uses=100
			Sprice=6
			Description="An advanced move which cuts the enemies life pool by a large amount. Deals a huge amount of damage to the user himself aswell."
		Seal_of_Terror
			icon_state="CT"
			mouse_drag_pointer="CT"
			name="Sealing Technique: Seal of Terror"
			Clan="No Clan"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime=400
			uses=100
			Sprice=3
			Description="A powerful jutsu that creates a strong bind which restricts movement of a person and also damages them for a huge amount."
		Chidori_Nagashi
			icon_state="Nagashi"
			mouse_drag_pointer = "Nagashi"
			name="Chidori Nagashi"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Monkey,Rabbit</font><br>(macro(1,2,4,1))"
			maxcooltime=60
			uses=0
			Sprice=2
			reqs = list("Chidori Needles")
			Description="Chidori Nagashi: Focus chakra mixed with Lightning style to create a shield of lightning defending inflicting damage to those who are nearby, however this technique can not kill."
		Intangible_Jutsu
			icon_state="In"
			mouse_drag_pointer = "In"
			name="Intangible"
			rank="S"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			Sprice=3
			uses=100
		//	uses=0;notneeded=1
			Description="...You can't mark me."
		WarpDim
			icon_state="WD"
			mouse_drag_pointer = "WD"
			name="Warp Dimension"
			rank="A"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			Sprice=3
			uses=100
		//	uses=0;notneeded=1
			Description="You're in my world now."
		Warp_Rasengan
			icon_state="WarpRasengan"
			mouse_drag_pointer = "WarpRasengan"
			name="Warp Rasengan"
			rank="S"
			signs="<font color=green>Rabbit,Monkey,Monkey,Rabbit,Monkey</font><br>(macro(1,4,4,1,4))"
			maxcooltime=100
		//	uses=0;notneeded=1
		//	Clan="Uzumaki"
			reqs=list("Flying Thunder God","Rasengan")
			Sprice=3
			Description="Warp Rasengan: Instantly warp to your opponent sending them flying with a Rasengan."
		LimbParalyzeSeal
			icon_state="LimbParalyzeSeal"
			mouse_drag_pointer = "LimbParalyzeSeal"
			name="Sealing Jutsu: Limb Paralyzis"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Monkey,Monkey</font><br>(macro(1,1,4,4))"
			maxcooltime=140
			Sprice=2
			Clan="Sealing Clan"
			reqs = list("Soul Devastator Seal")
			Description="Limb Paralyze Seal: This technique stuns your opponent for a certain amount of time"
		Soul_Devastator_Seal
			icon_state="SD"
			mouse_drag_pointer = "SD"
			name="Soul Devastator Seal"
			rank="A"
			signs="<font color=green>Rabbit,Snake,Horse,Rabbit,Rat</font><br>(macro(1,2,3,1,Q))"
			maxcooltime=140
			uses=0
			Sprice=4
			Clan="Sealing Clan"
			reqs = list("Sealing Technique: Seal of Terror")
			Description="A powerful immobilising seal capable of binding even the most powerful shinobi."
		Lariat
			icon_state="Lariat"
			mouse_drag_pointer = "Lariat"
			name="Lariat"
			rank="A"
			signs="<font color=green>Snake,Ox,Ox,Snake</font><br>(macro(2,W,W,2))"
			//uses=0;notneeded=1
			maxcooltime=50
			Clan="Yotsuki"
			Sprice=2
			Description="Channeling your chakra into a strike of visible chakra, allows one to create a very deadly close-range weapon."
		Snake_Release_Jutsu
			icon_state="Snake_Release_Jutsu"
			mouse_drag_pointer = "Snake_Release_Jutsu"
			name="Sage Style: Giant Snake!"
			rank="A"
			signs="<font color=green>Dog,Rat,Rat,Dragon,Dog</font><br>(macro(E,Q,Q,5,E))"
			maxcooltime=300
			Sprice=3
			Clan="Curse"
			reqs=list("Curse Dragon")
			Description="Summon a powerful snake from the darkness in your heart and send it crashing into your enemies."
		Snake_Skin_Replacement_Jutsu
			icon_state="Snake Skin Replacement Jutsu"
			mouse_drag_pointer = "Snake Skin Replacement Jutsu"
			name="Snake Skin Replacement"
			rank="C"
			signs="<font color=green>Ox,Rat,Rat,Ox</font><br>(macro(W,Q,Q,W))"
			uses=0
			Clan = "Curse"
			reqs=list("Curse Dragon")
			maxcooltime=60
			Description="Replace your body with a snake skin upon receiving damage with this jutsu active."
		Chibaku_Tensei
			icon_state="ChibakuTensei"
			mouse_drag_pointer = "ChibakuTensei"
			name="Chibaku Tensei"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			Sprice=5
		//	uses=0;notneeded=1
			Clan="Pain"
			reqs=list("Gravity Divergence: Body Blow")
			Description=("Chibaku Tensei: An Giant ball streaming with only power of Destruction & NOTHING BUT DESTRUCTION!")
		Gravity_Divergence_Body_Blow
			icon_state="GDBlow"
			mouse_drag_pointer = "GDBlow"
			name="Gravity Divergence: Body Blow"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			Sprice=3
		//	uses=0;notneeded=1
			Clan="Pain"
			reqs=list("Rinnegan")
			Description="Gravity Divergence Body Blow: Blow the opponent backwars with incredible damage."
		Shinra_Tensei
			icon_state="Apush"
			mouse_drag_pointer = "Apush"
			name="Gravity Divergence: Shinra Tensei"
			rank="S"
			signs="<font color=green>Snake,Snake,Snake,Snake,Dragon,Dragon,Rabbit,Rabbit</font><br>(macro(2,2,2,2,5,5,1,1))"
			maxcooltime=300
			Sprice=10
			Clan="Pain"
			reqs=list("Rinnegan")
			Description="Blow away everything with this devestating jutsu. Use at your own risk."
		Gedo_Revival
			icon_state="Gedo Revival"
			mouse_drag_pointer = "Gedo Revival"
			name="Gedo Revival"
			rank="S"
			signs="<font color=green>Horse,Rabbit,Horse</font><br>(macro(3,1,3))"
			maxcooltime=50
			Sprice=3
			reqs=list("Gravity Divergence: Almighty Push")
			Clan="Pain"
			Description="Gedo Revival: Summon the Gedo Statue and revive friends or foes."

		Rock_Squeeze
			icon_state="ChibakuTensei"
			mouse_drag_pointer = "ChibakuTensei"
			name="Rock Squeeze"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime=100
			Sprice=4
		//	uses=0;notneeded=1
			reqs=list("Almigthy Push")
			Clan="Pain"
			Description="Rock Squeeze: An awesome jutsu which compiles thousands of rocks to create a big ball of destruction."
		Demon_Wind_Shuriken
			icon_state="Demon Wind Shuriken"
			mouse_drag_pointer = "Demon Wind Shuriken"
			name="Demon Wind Shuriken"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse,Dragon</font><br>(macro(5,3,5,3,5))"
			maxcooltime=180
			Sprice=3
			reqs=list("Blade Manipulation Jutsu")
			Description="Tie several wind shurikens along a chakra string and throw them on a target by using your chakra."
		Snake_Rustle_Jutsu
			icon_state="Snake Rustle Jutsu"
			mouse_drag_pointer = "Snake Rustle Jutsu"
			name="Ink Style: Snake Rustle Jutsu"
			rank="B"
			signs="<font color=green>Rabbit,Horse,Monkey,Dragon</font><br>(macro(1,3,4,5))"
			maxcooltime=140
			Sprice=2
			Clan="Ink"
			reqs=list("Ink Style: Rats")
			Description="This technique allows one to convert their chakra into drawings and make them come into motion binding the opponent."
		Multiple_Chakra_Kunai
			icon_state="Multiple Chakra Kunai"
			mouse_drag_pointer = "Multiple Chakra Kunai"
			name="Multiple Chakra Kunai"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse</font><br>(macro(5,3,5,3))"
			maxcooltime=180
			Sprice=3
			Clan="Uzumaki"
			reqs=list("Sealing Jutsu: Limb Paralyzis")
			Description="Tie several kunai along a chakra string and swing them hazing into your opponent."
		Magma_Crush
			icon_state="Magma Crush"
			mouse_drag_pointer = "Magma Crush"
			name="Magma Style: Magma Cage"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Dog,Rat</font><br>(macro(1,2,E,Q))"
			maxcooltime=400
			Element="Earth"
			Element2="Fire"
			Description="Magma Crush: This technique allows one to channel the forces of the heat in the air and create magma forming a large cage with floating magma"
		Magma_Needles
			icon_state="Magma Needles"
			mouse_drag_pointer = "Magma Needles"
			name="Magma Style: Magma Needles"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Snake,Rabbit</font><br>(macro(1,E,2,1))"
			maxcooltime=120
			Sprice=2
			Element="Earth"
			Element2="Fire"
			Description="Magma Needles: Used in combination with fire & earth, this technique forms deadly magma needles that impale your opponents."
		Bubble_Trouble
			icon_state="Bubble Trouble"
			mouse_drag_pointer = "Bubble Trouble"
			name="Bubble Trouble"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Dragon,Rabbit,Dragon,Rabbit,Dragon,Dragon</font><br>(macro(1,1,5,1,5,1,5,5))"
			maxcooltime=240
			reqs=list("Bubble Barrage")
			Clan="Bubble"
			Description="Bubble Trouble: Create a Giant bubble streaming with all your power impaling your opponents defense no matter how hard it may be!"
		Bubble_Spreader
			icon_state="Bubble Spreader"
			mouse_drag_pointer = "Bubble Spreader"
			name="Bubble Spreader"
			rank="B"
			signs="<font color=green>Dog,Dog,Dragon,Dog</font><br>(macro(E,E,5,E))"
			maxcooltime=260
			Clan="Bubble"
			Description="Bubble Spreader: This technique creates bubble smashing upon every direction unable of being controlled, very powerful if you are facing multiple enemies."
		Bubble_Guardian
			icon_state="bubble guardian"
			mouse_drag_pointer = "bubble guardian"
			name="Bubble Guardian"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime=600
			Sprice=3
		//	uses=0;notneeded=1
			Clan="Bubble"
			Description="Bubble Guardian: Show the true power of bubbles by activating the ace jutsu of the clan, Bubble Guardian!"
		Bubble_Barrage
			icon_state="Bubble Barrage"
			mouse_drag_pointer = "Bubble Barrage"
			name="Bubble Barrage"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Dragon,Rabbit</font><br>(macro(1,1,5,1))"
			maxcooltime=240
			reqs=list("Bubble Spreader")
			Clan="Bubble"
			Description="Bubble Barrage: This technique allows the use to stream an certain amount of bubbles dashing towards the enemy."
		Crystal_Mirrors
			icon_state="Crystal Mirrors"
			mouse_drag_pointer = "Crystal Mirrors"
			name="Crystal Mirrors"
			rank="B"
			signs="<font color=green>Ox,Rabbit,Dog,Ox</font><br>(macro(W,1,E,W))"
			maxcooltime=140
			Sprice=3
			Clan="Crystal"
			reqs=list("Crystal Pillar")
			Description="Crystal Mirrors: This technique creates solid mirrors of the hardest iron in the world, Crystal. Allowing you to attack from each & every mirror."
		Crystal_Arrow
			icon_state="Crystal Arrow"
			mouse_drag_pointer = "Crystal Arrow"
			name="Crystal Arrow"
			rank="S"
			signs="<font color=green>Ox,Rabbit,Dog,Ox,Ox,Rabbit,Dog,Ox</font><br>(macro(W,1,E,W,W,1,E,W))"
			maxcooltime=300
			Sprice=3
			Clan="Crystal"
			reqs=list("Crystal Mirrors")
			Description="Crystal Arrow: An Giant Arrow shot by the will & the determination of the user."
		Crystal_Pillar
			icon_state="Crystal Pillar"
			mouse_drag_pointer = "Crystal Pillar"
			name="Crystal Pillar"
			rank="S"
			signs="<font color=green>Ox,Ox,Dog,Rabbit</font><br>(macro(W,W,E,1))"
			maxcooltime=300
			Sprice=3
			Clan="Crystal"
			Description="Crystal Pillar: An Giant Arrow shot by the will & the determination of the user."
		Crystal_Drill
			icon_state="Crystal Drill"
			mouse_drag_pointer = "Crystal Drill"
			name="Crystal Drill"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			Sprice=3
		//	uses=0;notneeded=1
			Clan="Crystal"
			reqs=list("Crystal Arrow")
			Description="Crystal Drill: An Giant Drill made of one the hardest materials ever; Crystal."
		Crow_Substitution
			icon_state="CrowSub"
			mouse_drag_pointer = "CrowSub"
			name="Crow Substitution"
			rank="C"
			signs="<font color=green>Ox,Rat,Rat</font><br>(macro(W,Q,Q))"
			uses=0
			Sprice=2
			Clan="Kakuzu"
			maxcooltime=60
			Description="Crow Substitution: Replace your body with crows upon receiving damage with this jutsu active."
		Shinra_Tensei
			icon_state="Apush"
			mouse_drag_pointer = "Apush"
			name="Gravity Divergence: Shinra Tensei"
			rank="S"
			signs="<font color=green>Snake,Snake,Snake,Snake,Dragon,Dragon,Rabbit,Rabbit</font><br>(macro(2,2,2,2,5,5,1,1))"
			maxcooltime=300
			Sprice=10
			Clan="Pain"
			reqs=list("Rinnegan")
			Description="Blow away everything with this devestating jutsu. Use at your own risk."
		Chibaku_Tensei
			icon_state="Chibaku Tensei"
			mouse_drag_pointer = "Chibaku Tensei"
			name="Chibaku Tensei"
			rank="S"
			signs="<font color=green>Rabbit,Rabbit,Snake,Snake,Rabbit,Snake,Rabbit</font><br>(macro(1,1,2,2,1,2,1))"
			maxcooltime=450
			Sprice=4
			reqs=list("Summoning Jutsu: Snake")
			Clan="Rinnegan"
			Description="It is said that Sage of the Six Paths used this tehnique in order to create the Moon itself. Can you achieve that level of power with this technique?"
		Gedo_Revival
			icon_state="Gedo Revival"
			mouse_drag_pointer = "Gedo Revival"
			name="Gedo Revival"
			rank="S"
			signs="<font color=green>Horse,Rabbit,Horse</font><br>(macro(3,1,3))"
			maxcooltime=50
			Sprice=3
			reqs=list("Gravity Divergence: Almighty Push")
			Clan="Pain"
			Description="Gedo Revival: Summon the Gedo Statue and revive friends or foes."
		Rock_Squeeze
			icon_state="ChibakuTensei"
			mouse_drag_pointer = "ChibakuTensei"
			name="Rock Squeeze"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime=100
			Sprice=4
		//	uses=0;notneeded=1
			reqs=list("Almigthy Push")
			Clan="Pain"
			Description="Rock Squeeze: An awesome jutsu which compiles thousands of rocks to create a big ball of destruction."
		Mind_Control_Jutsu
			icon_state="MC"
			mouse_drag_pointer="MC"
			name="Mind Transfer Jutsu"
			Clan="Yamanaka"
			rank="B"
			signs="<font color=green>Ox,Ox,Ox</font><br>(macro(Q,Q,Q))"
			maxcooltime=150
			uses=0
			Sprice=2
			Description="Mind Control Jutsu: A basic move where the user can take control of the foe for a short amount of time."
		Rising_Twin_Dragon
			icon_state="RTD"
			mouse_drag_pointer = "RTD"
			name="Rising Twin Dragons"
			rank="B"
			signs="<font color=green>Rat,Rat,Rat</font><br>(macro(Q,Q,Q))"
		//	uses=0;notneeded=1
			maxcooltime=150
			Description="Rising Twin Dragon: Expel all weaponry placed upon you outwards in a blast along with dragons, the weaponary can fly in any direction it will engage enemies."
		ShadowCloneSmash
			icon_state="SCS"
			mouse_drag_pointer="SCS"
			name="Shadow Clone Smash"
			rank="B"
			signs="<font color=green>Rat,Dragon,Rat,Rat,Monkey</font><br>(macro(Q,5,Q,Q,4))"
			maxcooltime=150
	//		uses=0;notneeded=1
			Sprice=5
			Description="An advanced move that creates a shadow clone which then explodes causing heavy damage to the target."
		JukaiKoutan
			icon_state="Jukai"
			mouse_drag_pointer = "Jukai"
			name="Mokuton Hijutsu - Jukai Koutan"
			rank="S"
			signs="<font color=green>Snake,Snake,Rabbit,Rat,Rabbit</font><br>(macro(2,2,1,Q,1))"
			maxcooltime=600
			Sprice=4
			Clan="Senjuu"
			reqs=list("Wood Drill")
			reqs = list("Mokuton - Jubaku Eisou")
			Description=" Jukai Koutan: User creates a forest that will damage everyone in it"
		JubakuEisou
			icon_state="jubakueisou"
			mouse_drag_pointer = "jubakueisou"
			name="Mokuton - Jubaku Eisou"
			rank="B"
			signs="<font color=green>Rat,Snake,Snake,Rabbit</font><br>(macro(Q,2,2,1))"
			maxcooltime=300
			Sprice=1
			Clan="Senjuu"
			reqs=list("Wood Drill")
			Description="Jubaku Eisou: User creates a prison made of wood around his target to paralyze him"
		Daijurin
			icon_state="daijurin"
			mouse_drag_pointer = "daijurin"
			name="Mokuton - Daijurin no Jutsu"
			rank="B"
			signs="<font color=green>Rat,Rat,Snake,Rabbit,Rabbit</font><br>(macro(Q,Q,2,1,1))"
			maxcooltime=400
			Sprice=1
			Clan="Senjuu"
			Description="Daijurin: User stretchs is arm creating wood from it that wood arm will damage anyone he touches"
		Daitoppa
			icon_state="daitoppa"
			mouse_drag_pointer = "daitoppa"
			name="Fuuton Daitoppa"
			rank="B"
			signs="<font color=green>Dragon,Rat,Rat,Rabbit</font><br>(macro(5,Q,Q,1))"
			maxcooltime=200
			Sprice=1
			Element="Wind"
			Description="Daitoppa: Wind Element jutsu where user releases a huge wind that can push enemys while damaging them"
		Doryuusou
			icon_state="doryuusou"
			mouse_drag_pointer = "doryuusou"
			name="Doton Doryuusou no Jutsu"
			rank="A"
			signs="<font color=green>Dragon,Snake,Monkey</font><br>(macro(5,2,4))"
			maxcooltime=300
			Sprice=1
			Element="Earth"
			Description="Doryuusou: User creates spikes under the targets feet to hurt them"
		Baika
			icon_state="baika"
			mouse_drag_pointer = "baika"
			name="Baika no Jutsu"
			rank="D"
			signs="<font color=green>Rat,Rat,Rat,Rat,Rabbit,Rabbit</font><br>(macro(Q,Q,Q,Q,1,1))"
			maxcooltime=100
			Sprice=1
			Clan="Akimichi"
			Description="Baika: Jutsu that is used for preparation for Nikudan Sensha and Nikudan Hari Sensha"
		Nikudan
			icon_state="nikudan"
			mouse_drag_pointer = "nikudan"
			name="Nikudan Sensha"
			rank="C"
			signs="<font color=green>Dragon,Snake,Monkey,Monkey</font><br>(macro(5,2,4,4))"
			maxcooltime=300
			Sprice=1
			Clan="Akimichi"
			reqs = list("Baika no Jutsu")
			Description="Nikudan: User turns himself into a huge Meat Tank that will hurt anything that touches"
		Teppoudama
			icon_state="tepo"
			mouse_drag_pointer = "tepo"
			name="Suiton Teppoudama"
			rank="B"
			signs="<font color=green>Rat,Dragon,Rat,Ox,Snake</font><br>(macro(Q,5,Q,W,2))"
			maxcooltime=250
			Sprice=1
			Element="Water"
			Description="Teppoudama: Shoots Water Ball from user's mouth"
		Dango
			icon_state="dango"
			mouse_drag_pointer = "dango"
			name="Doton Doryo Dango"
			rank="S"
			signs="<font color=green>Dog,Dog,Ox,Rabbit</font><br>(macro(E,E,W,1))"
			maxcooltime=250
			Element="Earth"
			Sprice=1
			Description="Dango: Throws a Huge Rock in user's direction"
		Suijinheki
			icon_state="suijin"
			mouse_drag_pointer = "suijin"
			name="Suiton Suijinheki no Jutsu"
			rank="B"
			signs="<font color=green>Ox,Dragon,Dragon,Rat,Rat</font><br>(macro(W,5,5,Q,Q))"
			maxcooltime=150
			Sprice=1
			Element="Water"
			Description="Suijunheki: Creates a water wave infront of the user's to protect him"
		Zankuuha
			icon_state="zanku"
			mouse_drag_pointer = "zanku"
			name="Zankuuha"
			rank="D"
			signs="<font color=green>Monkey,Monkey,Rat</font><br>(macro(4,4,Q))"
			maxcooltime=300
			Sprice=1
			Element="Wind"
			Description="Zankuuha: Shoots wind from user's hand"
		Shishi
			icon_state="shishi"
			mouse_drag_pointer = "shishi"
			name="ShiShi Rendan"
			rank="D"
			maxcooltime=100
			Sprice=1
			uses=100
			Description="Shishi Rendan: Very Powerfull combo where user uses its speed to create a series off attacks"
		Wind_Cutter
			icon_state="WC"
			mouse_drag_pointer="WC"
			name="Wind Cutter"
			Element="Wind"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime=150
			reqs = list("Sickle Weasel Technique")
			Description="Wind Cutter: Slice through every thing in your path with the power of wind."
		WindBalls
			icon_state="WB"
			mouse_drag_pointer="WB"
			name="Wind Balls"
			Element="Wind"
			rank="C"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime=150
			Description="Wind Balls: Fire a certain amount of wind balls depending on your ninjutsus strength."
		Omega_Ice_Ball
			icon_state="GiantIceBall"
			mouse_drag_pointer = "GiantIceBall"
			name="Omega Ice Ball"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=300
			reqs=list("Ice Ball")
			Sprice=5
			uses=100
			Clan = "Ice"
			Description="Omega Ice Ball: An Giant Iceball streaming with only power of ice & destroying all in it's path."
		Iceball
			icon_state="Iceball"
			mouse_drag_pointer = "Iceball"
			name="Ice ball"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Rabbit</font><br>(macro(1,E,E,1))"
			maxcooltime=120
			Sprice=2
			Clan = "Ice"
			reqs=list("Sensatsu Suishou")
			Description="Ice Ball: Used in combination with water, this technique forms a deadly ice ball that impale your opponents."
mob
	verb/JutsuReference()
		set hidden=1
		//set category = "Browser"
		var/Display = {"
		<STYLE>BODY {background: black; color: white}</STYLE><table border = "3" cellspacing = "1" cellpadding = "1">
		<Caption><B>Jutsus learnt</B></font></Caption>"}
		for(var/obj/Jutsus/I in usr.JutsusLearnt)
			Display += {"
			<tr><td align = "center"><font color=yellow><b>[I.name]</Font><font color=#C0C0C0>([I.level]))[I.exp]/[I.maxexp])</Font></td>
			<td align = "center"><b><font color=#C0C0C0>Hand Signs: -</Font>[I.signs]</td>
			<td align = "center"><b><font color=red>Jutsu Rank=[I.rank]</td>
			</tr>"}
		spawn(1)
			usr<< browse("[Display]")
			winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
		//#CC9933
	verb/BugReport()
		set hidden=1
		winset(usr,"default.tab2","current-tab=browserpane")
		usr << browse({"<html>
<head>
<title>Bug Report Form</title>
<FONT SIZE="7"><b><u>Bug Report Form</u></b></FONT>
<BODY BGCOLOR="#996633 ">
<style type="text/css">
form
{
	background-color:#CC9933;
	color:#000010;
	border: 1px inset #000000;
	padding: 4pt;
}
input
{
	background-color:#ffffff ;
	color:#000;
	border: 1px inset #000000;
}
a
{
	color:#000000;
	text-decoration:none;
}
</style>
</head>

<body>

<form name="Bug Report" action="byond://" method="get">
<p>
<input type="hidden" name="action" value="bug" />
<input type="hidden" name="src" value="\ref[src]" />
<input type="hidden" name="name" value="[name]-[ckey]-[client.address] reported: " />
<FONT SIZE="2"><b><u>Rules</u></b></FONT>
<br><br>
This submission form is taken very seriously.<br>
Abuse it, and you will be suspended from the game<br>
for a minimum of one month.<br><br>

Bugs that are reported here will automatically include:<BR>
<i>-Your Submission<BR>
-Your Game Name<BR>
-Your BYOND Key<BR></i>

<br>
Please enter any bugs you have found.<br />

<textarea name="report"rows=20 cols=50></textarea>
<br>
<input type="submit" value="Report Bug!" />
</p>
</form>


</body>
</html>"})
		winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
atom/Topic(href, href_list[])
	..()
	switch(href_list["action"])
		if("bug")
			var/html ={"<html>
<title>Bug Report Form</title>
<FONT SIZE="7"><b><u>Bug Report Form</u></b></FONT>
<BODY BGCOLOR="#996633 ">
<style type="text/css">
form
{
	background-color:#CC9933;
	color:#000010;
	border: 1px inset #000000;
	padding: 4pt;
}
input
{
	background-color:#ffffff ;
	color:#000;
	border: 1px inset #000000;
}
a
{
	color:#000000;
	text-decoration:none;
}
</style>
</head>

<body>

<form>
<p>
<FONT SIZE="2"><b><u>
</head>
Thank you.<br>
<br></u></b>
Your bug has been submitted to the file succesfully.<br>
The game creators will work on it as soon as possible.
</form>


</body>
</html>"}
			var/bugs = file("Bugs.txt")
			var/msg = html_encode(href_list["report"])
			var/who = html_encode(href_list["name"])
			if(usr.Bugreported)
				usr<<output("You recently submitted a bug report. Please do not overuse the verb.","actionoutput")
				return
			if(!msg)return
			var/bug = "[who] [msg]"
			src << browse(html)
			winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
			text2file(bug,bugs)
			usr<<output("Bug succesfully reported.","actionoutput")
			usr.Bugreported=1
			spawn(200)if(usr)usr.Bugreported=0
obj
	HSigns
		icon='HandSigns.dmi'
		dog
			icon_state = "dog"
			layer = 20
			screen_loc = "17,20"
		rat
			icon_state = "rat"
			layer = 20
			screen_loc = "17,20"
		rabbit
			icon_state = "rabbit"
			layer = 20
			screen_loc = "17,20"
		horse
			icon_state = "horse"
			layer = 20
			screen_loc = "17,20"
		ox
			icon_state = "ox"
			layer = 20
			screen_loc = "17,20"
		snake
			icon_state = "snake"
			layer = 20
			screen_loc = "17,20"
		monkey
			icon_state = "monkey"
			layer = 20
			screen_loc = "17,20"
		dragon
			icon_state = "dragon"
			layer = 20
			screen_loc = "17,20"
mob
	verb
		HandSeal()
			set hidden=1
			if(client.eye==locate(10,10,4)||client.eye==locate(60,10,4)||client.eye==locate(12,43,4)||client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return
			src.HengeUndo()
			if(usr.sign>=1)
				view(usr)<<sound('active.wav',0,0)
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/SClone/J=new/obj/Jutsus/SClone
					if(J.type in usr.JutsusLearnt)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ShadowClone_Jutsu()
						del(J)
			//		else
			//			usr.JutsusLearnt.Add(J)
			//			usr.JutsusLearnt.Add(J.type)
			//			J.Owner=usr
//signs="<font color=green>Ox,Rabbit,Snake,Dog,Dog,Rabbit</font><br>(macro(W,1,2,E,E,1))"
//signs="<font color=green>Snake,Rabbit,Dog</font><br>(macro(2,1,E))"
//signs="<font color=green>Ox, Snake, Rat, Rabbit, Dragon</font><br>(macro(W,2,Q,1,5))"
//signs="<font color=green>Ox, Snake, Rat, Snake</font><br>(macro(W,2,Q,2))"
//signs="<font color=green>Rat, Rat, Snake</font><br>(macro(Q,Q,2))"
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/MizuClone/J=new/obj/Jutsus/MizuClone
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MizuClone_Jutsu()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="ox"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Camellia_Dance/J=new/obj/Jutsus/Camellia_Dance
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Camellia_Dance()
				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Insect_Clone/J=new/obj/Jutsus/Insect_Clone
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.InsectClone()
				if(usr.first=="snake"&&usr.second=="snake"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Mountain_Crusher/J=new/obj/Jutsus/Eight_Trigrams_Mountain_Crusher
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_Mountain_Crusher()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Funeral/J=new/obj/Jutsus/Sand_Funeral
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Funeral()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Sheild/J=new/obj/Jutsus/Sand_Sheild
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Sheild()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.eighth=="rat"&&usr.rat==4&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Fire_Dragon_Projectile/J=new/obj/Jutsus/Fire_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Dragon_Projectile()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.eighth=="rat"&&usr.nineth=="dragon"&&usr.tenth=="dragon"&&usr.rat==4&&usr.dog==4&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Water_Dragon_Projectile/J=new/obj/Jutsus/Water_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Water_Dragon_Projectile()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.rat==3&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Mud_Dragon_Projectile/J=new/obj/Jutsus/Mud_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Mud_Dragon_Projectile()
				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="snake"&&usr.fourth=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Chakra_Leech/J=new/obj/Jutsus/Chakra_Leech
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chakra_Leech()
				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==3&&usr.rabbit==0)
					var/obj/Jutsus/Ones_Own_Life_Reincarnation/J=new/obj/Jutsus/Ones_Own_Life_Reincarnation
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Ones_Own_Life_Reincarnation()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shikigami_Spear/J=new/obj/Jutsus/Shikigami_Spear
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shikigami_Spear()
				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Stealth_Bug/J=new/obj/Jutsus/Stealth_Bug
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Stealth_Bug()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shikigami_Dance/J=new/obj/Jutsus/Shikigami_Dance
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shikigami_Dance()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bringer_of_Darkness_Technique/J=new/obj/Jutsus/Bringer_of_Darkness_Technique
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bringer_of_Darkness_Technique()
				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Destruction_Bug_Swarm/J=new/obj/Jutsus/Destruction_Bug_Swarm
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Destruction_Bug_Swarm()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shukakku_Spear/J=new/obj/Jutsus/Shukakku_Spear
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shukakku_Spear()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Desert_Coffin/J=new/obj/Jutsus/Desert_Coffin
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Desert_Coffin()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Shuriken/J=new/obj/Jutsus/Sand_Shuriken
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Shuriken()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Insect_Coccoon/J=new/obj/Jutsus/Insect_Coccoon
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Insect_Coccoon()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Earth_Disruption/J=new/obj/Jutsus/Earth_Disruption
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Disruption()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Earth_Release_Mud_River/J=new/obj/Jutsus/Earth_Release_Mud_River
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Release_Mud_River()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rat"&&usr.fourth=="snake"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WaterPrison/J=new/obj/Jutsus/WaterPrison
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WaterPrison()
				if(usr.first=="monkey"&&usr.second=="snake"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shadow_Extension/J=new/obj/Jutsus/Shadow_Extension
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shadow_Extension()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Wind_Sheild/J=new/obj/Jutsus/Wind_Sheild
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Sheild()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/WaterShark/J=new/obj/Jutsus/WaterShark
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WaterShark()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/TreeBinding/J=new/obj/Jutsus/TreeBinding
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.TreeBinding()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Temple_Of_Nirvana/J=new/obj/Jutsus/Temple_Of_Nirvana
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Temple_Of_Nirvana()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Earth_Style_Dark_Swamp/J=new/obj/Jutsus/Earth_Style_Dark_Swamp
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Style_Dark_Swamp()
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Jinrai/J=new/obj/Jutsus/Jinrai
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori_Jinrai()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bug_Neurotoxin/J=new/obj/Jutsus/Bug_Neurotoxin
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bug_Neurotoxin()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Hunter_Scarabs/J=new/obj/Jutsus/Hunter_Scarabs
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Hunter_Scarabs()
				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/C1_Birds/J=new/obj/Jutsus/C1_Birds
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ClayBirds()//signs="<font color=green>Dragon,Dog,Dragon</font><br>(macro(5,E,5))"
				if(usr.first=="dragon"&&usr.second=="dog"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C1_Spiders/J=new/obj/Jutsus/C1_Spiders
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ClaySpiders()
				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==5&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C2/J=new/obj/Jutsus/C2
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.C2()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Susanoo/J=new/obj/Jutsus/Susanoo
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Susanoo()
				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="dragon"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C3/J=new/obj/Jutsus/C3
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.C3()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Blade_Manipulation_Jutsu/J=new/obj/Jutsus/Blade_Manipulation_Jutsu
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Blade_Manipulation_Jutsu()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Kirin/J=new/obj/Jutsus/Kirin
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Kirin()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Chidori_Needles/J=new/obj/Jutsus/Chidori_Needles
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori_Needles()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Rasengan/J=new/obj/Jutsus/Rasengan
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Rasengan()
				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Cherry_Blossom_Impact/J=new/obj/Jutsus/Cherry_Blossom_Impact
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Cherry_Blossom_Impact()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Drill/J=new/obj/Jutsus/Bone_Drill
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Drill()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Blade_of_Wind/J=new/obj/Jutsus/Blade_of_Wind
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Blade_of_Wind()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.fifth=="ox"&&usr.sixth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==4&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Rasenshuriken/J=new/obj/Jutsus/Rasenshuriken
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Rasenshuriken()
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Chidori/J=new/obj/Jutsus/Chidori
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori()
				if(usr.first=="snake"&&usr.second=="ox"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Raikiri/J=new/obj/Jutsus/Raikiri
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Raikiri()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Sickle_Weasel_Technique/J=new/obj/Jutsus/Sickle_Weasel_Technique
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sickle_Weasel_Technique()
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.fifth=="monkey"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/MSClone/J=new/obj/Jutsus/MSClone
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MultipleShadowClone_Jutsu()
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Crow_Clone/J=new/obj/Jutsus/Crow_Clone
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crow_Clone()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
				//	if(usr.Element!="Water"&&usr.Element2!="Wind") return
					var/obj/Jutsus/Demonic_Ice_Mirrors/J=new/obj/Jutsus/Demonic_Ice_Mirrors
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Demonic_Ice_Mirrors()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="snake"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					if(usr.Element!="Water"&&usr.Element2!="Water") return
					var/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave/J=new/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Water_Release_Exploding_Water_Colliding_Wave()
				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Achiever_of_Nirvana_Fist/J=new/obj/Jutsus/Achiever_of_Nirvana_Fist
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Achiever_of_Nirvana_Fist()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Poison_Mist/J=new/obj/Jutsus/Poison_Mist
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Poison_Mist()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dog"&&usr.rat==1&&usr.dog==3&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					if(usr.Element!="Fire"&&usr.Element2!="Fire") return
					var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J=new/obj/Jutsus/Fire_Release_Ash_Pile_Burning
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Release_Ash_Pile_Burning()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Hyuuga") return
					var/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin/J=new/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Kaiten()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Hyuuga") return
					var/obj/Jutsus/Eight_Trigrams_Empty_Palm/J=new/obj/Jutsus/Eight_Trigrams_Empty_Palm
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_Empty_Palm()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
				//	if(usr.Element!="Water"&&usr.Element2!="Wind") return
					var/obj/Jutsus/Sensatsu_Suishou/J=new/obj/Jutsus/Sensatsu_Suishou
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sensatsu_Suisho()
				if(usr.first=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Hyuuga") return
					var/obj/Jutsus/Byakugan/J=new/obj/Jutsus/Byakugan
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Byakugan()
				if(usr.first=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BClone/J=new/obj/Jutsus/BClone
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Clone_Jutsu()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="dragon"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Hyuuga") return
					var/obj/Jutsus/Eight_Trigrams_64_Palms/J=new/obj/Jutsus/Eight_Trigrams_64_Palms
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_64_Palms()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="dragon"&&usr.sixth=="dragon"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Hyuuga") return
					var/obj/Jutsus/Eight_Gates_Assault/J=new/obj/Jutsus/Eight_Gates_Assault
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Gates_Assault()
			//	if(usr.first=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
			//		var/obj/Jutsus/Body_Flicker/J=new/obj/Jutsus/Body_Flicker
			//		if(J.type in usr.JutsusLearnt)
			//			del(J)
			//			if(genintesters.Find(src)) SealsDoneGenin++
			//			usr.Shunshin()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rat"&&usr.rat==3&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==00)
					var/obj/Jutsus/Tree_Summoning/J=new/obj/Jutsus/Tree_Summoning
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Tree_Summoning()
				if(usr.first=="dog"&&usr.second=="snake"&&usr.third=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Heal/J=new/obj/Jutsus/Heal
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Heal()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dog"&&usr.fifth=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Earth_Release_Earth_Cage/J=new/obj/Jutsus/Earth_Release_Earth_Cage
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Release_Earth_Cage()//signs="<font color=green>Rabbit,Snake,Snake,Dog,Rat</font><br>(macro(1,2,2,E,Q))"
				if(usr.first=="rat"&&usr.second=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BCloneD/J=new/obj/Jutsus/BCloneD
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Clone_Jutsu_Destroy()
				if(usr.first=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BodyReplace/J=new/obj/Jutsus/BodyReplace
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Body_Replacement_Technique()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Transformation/J=new/obj/Jutsus/Transformation
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Transformation_Jutsu()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Advanced_Body_Replacement_Technique()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/ChakraRelease/J=new/obj/Jutsus/ChakraRelease
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chakra_Release()
			//if(usr.village=="Leaf")
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="rat"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					if(usr.Element!="Fire"&&usr.Element2!="Fire") return
					var/obj/Jutsus/FireBall/J=new/obj/Jutsus/FireBall
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Ball()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					if(usr.Element!="Fire"&&usr.Element2!="Fire") return
					var/obj/Jutsus/PheonixFire/J=new/obj/Jutsus/PheonixFire
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Phoenix_Immortal_Fire_Technique()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					if(usr.Element!="Fire"&&usr.Element2!="Fire") return
					var/obj/Jutsus/AFireBall/J=new/obj/Jutsus/AFireBall
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.AFire_Ball()
			//"Gravity"
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					//if(usr.Clan!="Sage of Six Paths Descendant") return
					var/obj/Jutsus/Induction/J=new/obj/Jutsus/Induction
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Induction()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					//if(usr.Clan!="Sage of Six Paths Descendant") return
					var/obj/Jutsus/Repulsion/J=new/obj/Jutsus/Repulsion
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Repulsion()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.fourth=="snake"&&usr.fifth=="rabbit"&&usr.sixth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==3&&usr.horse==0&&usr.rabbit==3)
					//if(usr.Clan!="Sage of Six Paths Descendant") return
					var/obj/Jutsus/Almighty_Push/J=new/obj/Jutsus/Almighty_Push
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.AlmightyPush()
			//"Kaguya"
				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&&usr.rat==1&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Kaguya") return
					var/obj/Jutsus/Bone_Pulse/J=new/obj/Jutsus/Bone_Pulse
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Pulse()
				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.rat==1&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Kaguya") return
					var/obj/Jutsus/Bone_Pulse/J=new/obj/Jutsus/Young_Bracken_Dance
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Young_Bracken_Dance()
				if(usr.first=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Kaguya") return
					var/obj/Jutsus/Bone_Tip/J=new/obj/Jutsus/Bone_Tip
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Tip()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					if(usr.Clan!="Kaguya") return
					var/obj/Jutsus/Bone_Tip/J=new/obj/Jutsus/Bone_Sensation
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Sensation()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Curse_Dragon/J=new/obj/Jutsus/Curse_Dragon
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Curse_Dragon()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Kamui/J=new/obj/Jutsus/Kamui
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Kamui()
				if(usr.first=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Flying_Thunder_God/J=new/obj/Jutsus/Flying_Thunder_God
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Flying_Thunder_God()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/LimbParalyzeSeal/J=new/obj/Jutsus/LimbParalyzeSeal
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.LimbParalyzeSeal()
				if(usr.first=="rabbit"&&usr.second=="monkey"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.fifth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==3&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Warp_Rasengan/J=new/obj/Jutsus/Warp_Rasengan
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Warp_Rasengan()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
				//	if(usr.Element!="Water"&&usr.Element2!="Wind") return
					var/obj/Jutsus/Sai_Rat/J=new/obj/Jutsus/Sai_Rat
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.SaiRat()
				if(usr.first=="snake"&&usr.second=="ox"&&usr.third=="ox"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Lariat/J=new/obj/Jutsus/Lariat
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Lariat()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dragon"&&usr.fifth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Release_Jutsu/J=new/obj/Jutsus/Snake_Release_Jutsu
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Snake_Release_Jutsu()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="ox"&&usr.rat==2&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Skin_Replacement_Jutsu/J=new/obj/Jutsus/Snake_Skin_Replacement_Jutsu
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Snake_Skin_Replacement_Jutsu()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Demon_Wind_Shuriken/J=new/obj/Jutsus/Demon_Wind_Shuriken
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Demon_Wind_Shuriken()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Multiple_Chakra_Kunai/J=new/obj/Jutsus/Multiple_Chakra_Kunai
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Multiple_Chakra_Kunai()
				if(usr.first=="rabbit"&&usr.second=="horse"&&usr.third=="monkey"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==1&&usr.rabbit==1)
					var/obj/Jutsus/Snake_Rustle_Jutsu/J=new/obj/Jutsus/Snake_Rustle_Jutsu
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Snake_Rustle_Jutsu()
				if(usr.first=="rabbit"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sai_Snakes/J=new/obj/Jutsus/Sai_Snakes
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sai_Snakes()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Magma_Needles/J=new/obj/Jutsus/Magma_Needles
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Magma_Needles()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="dog"&&usr.fourth=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Magma_Crush/J=new/obj/Jutsus/Magma_Crush
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Magma_Crush()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rat"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.rat==3&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Wind_Dragon_Projectile/J=new/obj/Jutsus/Wind_Dragon_Projectile
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Dragon_Projectile()
				if(usr.first=="monkey"&&usr.second=="snake"&&usr.third=="ox"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==2&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shadow_Punch/J=new/obj/Jutsus/Shadow_Punch
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shadow_Punch()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Crow_Substitution/J=new/obj/Jutsus/Crow_Substitution
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crow_Substitution()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Bubble_Barrage/J=new/obj/Jutsus/Bubble_Barrage
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.BubbleBarrage()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.sixth=="rabbit"&&usr.seventh=="dragon"&&usr.eighth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==4)
					var/obj/Jutsus/Bubble_Trouble/J=new/obj/Jutsus/Bubble_Trouble
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bubble_Trouble()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dragon"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bubble_Spreader/J=new/obj/Jutsus/Bubble_Spreader
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.BubbleSpreader()
				if(usr.first=="rabbit"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.sixth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Ink_Lions/J=new/obj/Jutsus/Ink_Lions
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.InkLions()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Mirrors/J=new/obj/Jutsus/Crystal_Mirrors
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Mirrors()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==4)
					var/obj/Jutsus/MudWall/J=new/obj/Jutsus/MudWall
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MudWall()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Weapon_Manipulation_Jutsu/J=new/obj/Jutsus/Blade_Manipulation_Jutsu
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Weapon_Manipulation_Jutsu()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C1Snake/J=new/obj/Jutsus/C1Snake
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.C1Snake()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/TwinDragons/J=new/obj/Jutsus/TwinDragons
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.TwinDragons()
				if(usr.first=="rat"&&usr.second=="snake"&&usr.third=="dog"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/HiddenSnakeStab/J=new/obj/Jutsus/HiddenSnakeStab
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.HiddenSnakeStab()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Root_Strangle/J=new/obj/Jutsus/Root_Strangle
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Root_Strangle()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Wood_Balvan/J=new/obj/Jutsus/Wood_Balvan
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wood_Balvan()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Root_Stab/J=new/obj/Jutsus/Root_Stab
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Root_Stab()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Pillar/J=new/obj/Jutsus/Crystal_Pillar
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Pillar()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.fifth=="ox"&&usr.sixth=="rabbit"&&usr.seventh=="dog"&&usr.eighth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==4&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Arrow/J=new/obj/Jutsus/Crystal_Arrow
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Arrow()
				if(usr.first=="rabbit"&&usr.second=="ox"&&usr.third=="rabbit"&&usr.fourth=="ox"&&usr.fifth=="rabbit"&&usr.sixth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Sage_Style_Giant_Rasengan/J=new/obj/Jutsus/Sage_Style_Giant_Rasengan
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sage_Style_Giant_Rasengan()
				if(usr.first=="snake"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="snake"&&usr.fifth=="dragon"&&usr.sixth=="dragon"&&usr.seventh=="rabbit"&&usr.eighth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==4&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Shinra_Tensei/J=new/obj/Jutsus/Shinra_Tensei
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shinra_Tensei()
				if(usr.first=="horse"&&usr.second=="rabbit"&&usr.third=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Gedo_Revival/J=new/obj/Jutsus/Gedo_Revival
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Gedo_Revival()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Chidori_Nagashi/J=new/obj/Jutsus/Chidori_Nagashi
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori_Nagashi()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Mind_Control_Jutsu/J=new/obj/Jutsus/Mind_Control_Jutsu
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Mind_Control_Jutsu()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Rising_Twin_Dragon/J=new/obj/Jutsus/Rising_Twin_Dragon
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Rising_Twin_Dragons()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Dango/J=new/obj/Jutsus/Dango
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.Dango()
				if(usr.first=="monkey"&&usr.second=="monkey"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Zankuuha/J=new/obj/Jutsus/Zankuuha
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.Zankuuha()
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="rat"&&usr.fourth=="ox"&&usr.fifth=="snake"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Teppoudama/J=new/obj/Jutsus/Teppoudama
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.Teppoudama()
				if(usr.first=="ox"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Suijinheki/J=new/obj/Jutsus/Suijinheki
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.Suijinheki()
				if(usr.first=="dragon"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Daitoppa/J=new/obj/Jutsus/Daitoppa
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.FuutonDaitoppa()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Doryuusou/J=new/obj/Jutsus/Doryuusou
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.Doryuusou()
				if(usr.first=="snake"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="rat"&&usr.fifth=="rabbit"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/JukaiKoutan/J=new/obj/Jutsus/JukaiKoutan
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.JukaiKoutan()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/JubakuEisou/J=new/obj/Jutsus/JubakuEisou
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.JubakuEisou()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.fifth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Daijurin/J=new/obj/Jutsus/Daijurin
					if(J.type in usr.JutsusLearnt)
						del(J)

						usr.Daijurin()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="horse"&&usr.fourth=="rabbit"&&usr.fifth=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==2)
					var/obj/Jutsus/Soul_Devastator_Seal/J=new/obj/Jutsus/Soul_Devastator_Seal
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Soul_Devastator_Seal()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
				//	if(usr.Element!="Water"&&usr.Element2!="Wind") return
					var/obj/Jutsus/Iceball/J=new/obj/Jutsus/Iceball
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Iceball()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WoodStyleFortress/J=new/obj/Jutsus/WoodStyleFortress
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WoodStyleFortress()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/CalorieControl/J=new/obj/Jutsus/CalorieControl
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.CalorieControl()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Shards/J=new/obj/Jutsus/Crystal_Shards
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Shards()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Needles/J=new/obj/Jutsus/Crystal_Needles
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Needles()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Spikes/J=new/obj/Jutsus/Crystal_Spikes
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Spikes()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Explosion/J=new/obj/Jutsus/Crystal_Explosion
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Explosion()
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/LightningPillars/J=new/obj/Jutsus/LightningPillars
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.LightningPillars()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/EarthBoulder/J=new/obj/Jutsus/EarthBoulder
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.EarthBoulder()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Wind_Tornados/J=new/obj/Jutsus/Wind_Tornados
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Tornados()

				if(usr.first=="dog"&&usr.second=="snake"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/FireMask/J=new/obj/Jutsus/FireMask
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.FireMask()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WindMask/J=new/obj/Jutsus/WindMask
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WindMask()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/LightningMask/J=new/obj/Jutsus/LightningMask
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.LightningMask()
				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/EarthMask/J=new/obj/Jutsus/EarthMask
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.EarthMask()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BugTornado/J=new/obj/Jutsus/BugTornado
					if(J.type in usr.JutsusLearnt)
						del(J)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.BugTornado()
				if(usr.sign>=1)
					view(usr)<<sound('active.wav',0,0)
				usr.sign=0
				usr.rat=0
				usr.ox=0
				usr.dragon=0
				usr.dog=0
				usr.monkey=0
				usr.snake=0
				usr.horse=0
				usr.rabbit=0
				usr.first=0
				usr.second=0
				usr.third=0
				usr.fourth=0
				usr.fifth=0
				usr.sixth=0
				usr.seventh=0
				usr.eighth=0
				usr.nineth=0
				usr.tenth=0
				usr.eleventh=0
				usr.twelveth=0
				spawn()
					usr.client.images=0
					usr.Target_ReAdd()
					//for(var/obj/O in usr.client.images)
					//	del(O)
			else
				if(usr.sign<1)
					if(usr.copy=="AlmightyPush")
						usr.AlmightyPush()
						usr.move=1
					usr.sign=0
					usr.rat=0
					usr.ox=0
					usr.dragon=0
					usr.dog=0
					usr.monkey=0
					usr.snake=0
					usr.horse=0
					usr.rabbit=0
					usr.first=0
					usr.second=0
					usr.third=0
					usr.fourth=0
					usr.fifth=0
					usr.sixth=0
					usr.seventh=0
					usr.eighth=0
					usr.nineth=0
					usr.tenth=0
					usr.eleventh=0
					usr.twelveth=0
					spawn()
						usr.client.images=0
						usr.Target_ReAdd()
						//for(var/obj/O in usr.client.images)
						//	del(O)
mob
	verb
		Rat()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="rat"
					if(usr.sign==2)usr.second="rat"
					if(usr.sign==3)usr.third="rat"
					if(usr.sign==4)usr.fourth="rat"
					if(usr.sign==5)usr.fifth="rat"
					if(usr.sign==6)usr.sixth="rat"
					if(usr.sign==7)usr.seventh="rat"
					if(usr.sign==8)usr.eighth="rat"
					if(usr.sign==9)usr.nineth="rat"
					if(usr.sign==10)usr.tenth="rat"
					if(usr.sign==11)usr.eleventh="rat"
					if(usr.sign==12)usr.twelveth="rat"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.rat+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="rat",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								//for(var/obj/HSigns/rat/O in usr.client.screen)
								//	del(O)
								usr.client.images-=HSign
								del(HSign)
								usr.rat-=1
								usr.sign-=1
	verb
		Ox()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="ox"
					if(usr.sign==2)usr.second="ox"
					if(usr.sign==3)usr.third="ox"
					if(usr.sign==4)usr.fourth="ox"
					if(usr.sign==5)usr.fifth="ox"
					if(usr.sign==6)usr.sixth="ox"
					if(usr.sign==7)usr.seventh="ox"
					if(usr.sign==8)usr.eighth="ox"
					if(usr.sign==9)usr.nineth="ox"
					if(usr.sign==10)usr.tenth="ox"
					if(usr.sign==11)usr.eleventh="ox"
					if(usr.sign==12)usr.twelveth="ox"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.ox+=1
//					usr.client.screen += new/obj/HSigns/ox
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="ox",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								//for(var/obj/HSigns/ox/O in usr.client.screen)
								//	del(O)
								usr.ox-=1
								usr.sign-=1
	verb
		Dog()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="dog"
					if(usr.sign==2)usr.second="dog"
					if(usr.sign==3)usr.third="dog"
					if(usr.sign==4)usr.fourth="dog"
					if(usr.sign==5)usr.fifth="dog"
					if(usr.sign==6)usr.sixth="dog"
					if(usr.sign==7)usr.seventh="dog"
					if(usr.sign==8)usr.eighth="dog"
					if(usr.sign==9)usr.nineth="dog"
					if(usr.sign==10)usr.tenth="dog"
					if(usr.sign==11)usr.eleventh="dog"
					if(usr.sign==12)usr.twelveth="dog"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.dog+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="dog",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								usr.dog-=1
								usr.sign-=1
	verb
		Snake()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="snake"
					if(usr.sign==2)usr.second="snake"
					if(usr.sign==3)usr.third="snake"
					if(usr.sign==4)usr.fourth="snake"
					if(usr.sign==5)usr.fifth="snake"
					if(usr.sign==6)usr.sixth="snake"
					if(usr.sign==7)usr.seventh="snake"
					if(usr.sign==8)usr.eighth="snake"
					if(usr.sign==9)usr.nineth="snake"
					if(usr.sign==10)usr.tenth="snake"
					if(usr.sign==11)usr.eleventh="snake"
					if(usr.sign==12)usr.twelveth="snake"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.snake+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="snake",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								usr.snake-=1
								usr.sign-=1
	verb
		Rabbit()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="rabbit"
					if(usr.sign==2)usr.second="rabbit"
					if(usr.sign==3)usr.third="rabbit"
					if(usr.sign==4)usr.fourth="rabbit"
					if(usr.sign==5)usr.fifth="rabbit"
					if(usr.sign==6)usr.sixth="rabbit"
					if(usr.sign==7)usr.seventh="rabbit"
					if(usr.sign==8)usr.eighth="rabbit"
					if(usr.sign==9)usr.nineth="rabbit"
					if(usr.sign==10)usr.tenth="rabbit"
					if(usr.sign==11)usr.eleventh="rabbit"
					if(usr.sign==12)usr.twelveth="rabbit"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.rabbit+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="rabbit",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								usr.rabbit-=1
								usr.sign-=1
	verb
		Horse()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="horse"
					if(usr.sign==2)usr.second="horse"
					if(usr.sign==3)usr.third="horse"
					if(usr.sign==4)usr.fourth="horse"
					if(usr.sign==5)usr.fifth="horse"
					if(usr.sign==6)usr.sixth="horse"
					if(usr.sign==7)usr.seventh="horse"
					if(usr.sign==8)usr.eighth="horse"
					if(usr.sign==9)usr.nineth="horse"
					if(usr.sign==10)usr.tenth="horse"
					if(usr.sign==11)usr.eleventh="horse"
					if(usr.sign==12)usr.twelveth="horse"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.horse+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="horse",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								usr.horse-=1
								usr.sign-=1
	verb
		Monkey()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="monkey"
					if(usr.sign==2)usr.second="monkey"
					if(usr.sign==3)usr.third="monkey"
					if(usr.sign==4)usr.fourth="monkey"
					if(usr.sign==5)usr.fifth="monkey"
					if(usr.sign==6)usr.sixth="monkey"
					if(usr.sign==7)usr.seventh="monkey"
					if(usr.sign==8)usr.eighth="monkey"
					if(usr.sign==9)usr.nineth="monkey"
					if(usr.sign==10)usr.tenth="monkey"
					if(usr.sign==11)usr.eleventh="monkey"
					if(usr.sign==12)usr.twelveth="monkey"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.monkey+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="monkey",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								usr.monkey-=1
								usr.sign-=1
	verb
		Dragon()
			set hidden=1
			if(usr.canattack==1&&usr.firing==0&&usr.dead==0)
				if(usr.sign<12)
					usr.sign+=1
					if(usr.sign==1)usr.first="dragon"
					if(usr.sign==2)usr.second="dragon"
					if(usr.sign==3)usr.third="dragon"
					if(usr.sign==4)usr.fourth="dragon"
					if(usr.sign==5)usr.fifth="dragon"
					if(usr.sign==6)usr.sixth="dragon"
					if(usr.sign==7)usr.seventh="dragon"
					if(usr.sign==8)usr.eighth="dragon"
					if(usr.sign==9)usr.nineth="dragon"
					if(usr.sign==10)usr.tenth="dragon"
					if(usr.sign==11)usr.eleventh="dragon"
					if(usr.sign==12)usr.twelveth="dragon"
					view(usr)<<sound('switsh.wav',0,0)
					flick("jutsu",usr)
					for(var/mob/Clones/C in world)if(C.Owner==usr)flick("jutsu",C)
					var/same=usr.sign
					usr.dragon+=1
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="dragon",layer=9998)
						HSign.pixel_y=98
						usr<<HSign
					//usr.client.screen += new/obj/HSigns/rat
						spawn(20)
							if(usr.sign==same)
								usr.client.images-=HSign
								del(HSign)
								usr.dragon-=1
								usr.sign-=1
