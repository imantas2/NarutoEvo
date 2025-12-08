mob/var/tmp/skz
mob/var/list/clanskills=list()
turf/SkillTree
	SkillTreeBack
		icon='GRND.dmi'
		icon_state="skillback"
	Title
		icon='Skill tree options.dmi'
		ClanJutsu
			icon_state="clan"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(60,10,4)
		ClanJutsu2
			icon_state="clan2"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(9,124,4)
		ClanJutsu22
			icon_state="clan22"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(9,124,4)
		NonClan
			icon_state="non clan"
			layer=9
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(12,43,4)
		Element
			icon_state="element"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(55,43,4)
		Back
			icon_state="back"
			Click()
				usr.client.eye=locate(10,75,4)
		Ultimate
			icon='Ultimate.dmi'
		aburame
			icon='Ultimate.dmi'
			icon_state="aburame"
		rinnengan
			icon='Ultimate.dmi'
			icon_state="rinnengan"
		puppeter
			icon='Ultimate.dmi'
			icon_state="puppeter"
mob
	verb
		ultimate()
			set hidden=1
			if(Tutorial<3)
				src<<output("You cannot do this right now.","actionoutput")
				return
			if(!tutorialskilltree) tutorialskilltree=1
			if(icon_state!="" && icon_state <> "run" && icon_state <> "dead")
				src<<output("You cannot do this right now.","actionoutput")
				return
			if(client.eye==locate(143,38,14)) return
			if(usr.client.eye==locate(37,75,4))
				new/obj/Screen/Bar(src)
				if(src.village == "Hidden Leaf")new/obj/Screen/LeafSymbol(src)
				if(src.village == "Hidden Sand")new/obj/Screen/SandSymbol(src)
				new/obj/Screen/WeaponSelect(src)
				new/obj/Screen/Health(src)
				new/obj/Screen/Chakra(src)
				new/obj/Screen/EXP(src)
				new/obj/HotSlots/HotSlot1(src)
				new/obj/HotSlots/HotSlot2(src)
				new/obj/HotSlots/HotSlot3(src)
				new/obj/HotSlots/HotSlot4(src)
				new/obj/HotSlots/HotSlot5(src)
				new/obj/HotSlots/HotSlot6(src)
				new/obj/HotSlots/HotSlot7(src)
				new/obj/HotSlots/HotSlot8(src)
				new/obj/HotSlots/HotSlot9(src)
				new/obj/HotSlots/HotSlot10(src)
				client.eye=src
				client.images=null
				UpdateSlots()
				Target_ReAdd()
				return
			if(client.eye!=src)return
			for(var/obj/Screen/O in src.client.screen)del(O)
			for(var/obj/HotSlots/O in src.client.screen)del(O)
			updateskills()
			src.client.eye=locate(37,75,4)
			src.client:perspective = EYE_PERSPECTIVE
obj/SkillTree/Linker
		icon='Misc Effects.dmi'
		icon_state="Linker"
		pixel_x=12
mob
	verb
		viewskilltree()
			set hidden=1
			if(Tutorial<3)
				src<<output("You cannot do this right now.","actionoutput")
				return
			if(!tutorialskilltree) tutorialskilltree=1
			if(icon_state!="" && icon_state <> "run" && icon_state <> "dead")
				src<<output("You cannot do this right now.","actionoutput")
				return
			if(client.eye==locate(143,38,14)) return
			if(client.eye==locate(10,10,4)||client.eye==locate(60,10,4)||client.eye==locate(9,124,4)||client.eye==locate(12,43,4)||client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)||usr.client.eye==locate(37,75,4))
				new/obj/Screen/Bar(src)
				if(src.village == "Hidden Leaf")new/obj/Screen/LeafSymbol(src)
				if(src.village == "Hidden Sand")new/obj/Screen/SandSymbol(src)
				new/obj/Screen/WeaponSelect(src)
				new/obj/Screen/Health(src)
				new/obj/Screen/Chakra(src)
				new/obj/Screen/EXP(src)
				new/obj/HotSlots/HotSlot1(src)
				new/obj/HotSlots/HotSlot2(src)
				new/obj/HotSlots/HotSlot3(src)
				new/obj/HotSlots/HotSlot4(src)
				new/obj/HotSlots/HotSlot5(src)
				new/obj/HotSlots/HotSlot6(src)
				new/obj/HotSlots/HotSlot7(src)
				new/obj/HotSlots/HotSlot8(src)
				new/obj/HotSlots/HotSlot9(src)
				new/obj/HotSlots/HotSlot10(src)
				client.eye=src
				client.images=null
				UpdateSlots()
				Target_ReAdd()
				return
			if(client.eye!=src)return
			for(var/obj/Screen/O in src.client.screen)del(O)
			for(var/obj/HotSlots/O in src.client.screen)del(O)
			updateskills()
			src.client.eye=locate(10,75,4)
			src.client:perspective = EYE_PERSPECTIVE

	proc
		updateskills()
			client.images=null
			for(var/obj/Jutsus/O in world) if(O.z==4)
				var/image/I=new
				I.icon_state=O.icon_state
				I.icon=O.icon
				I.mouse_opacity=0
				I.loc=O
				I.layer=O.layer+1
				O.invisibility=0
				src<<I
				if(O.name in usr.sbought)I.overlays+=image('Misc Effects.dmi',"hasit!")
				else
					var/has_reqs=0
					var/check=0
					var/Element1
					var/Element2z
					for(var/X in O.reqs)for(var/Oss in usr.sbought)if(Oss == X)check+=1
					if(check == length(O.reqs))has_reqs=1
					else has_reqs=0
					if(O.Clan)if(O.Clan!=usr.Clan)has_reqs=0
					if(O.Element)if(O.Element!=usr.Element&&O.Element!=usr.Element2)Element1=1
					if(O.Element2)if(O.Element2!=usr.Element&&O.Element2!=usr.Element2)Element2z=1
					if(Element1)has_reqs=0
					if(Element2z)has_reqs=0
					if(has_reqs==0)I.overlays+=image('Misc Effects.dmi',"X")

