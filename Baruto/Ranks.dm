mob/Kage/verb
	Boot_From_Village()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village) continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to use this on?","Invite",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village)
			src<<output("They're not from your village.","actionoutput")
			return
		if(skalert("Are you sure you want to boot [M] from the [village] village?","Confirm",list("No","Yes"))=="No") return
		world<<output("[M] has been booted from the [village] village.","actionoutput")
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
	Invite_to_Village()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.rank != "Missing-Nin") continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to use this on?","Invite",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M.skalert("[src] invites you to join the [village] village, accept?","Confirm",list("No","Yes"))=="No") return
		world<<output("[M] has joined the [village] village.","actionoutput")
		M.village="[village]"
		M.rank="Genin"
	Make_ANBU()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank == "Jounin") continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to ANBU?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been promoted the ANBU Ops.","actionoutput")
		M.rank="ANBU"
		if(M.village=="Hidden Sand"||M.village=="Hidden Sound"||M.village=="Hidden Rock")
			new/obj/Inventory/Clothing/Masks/Anbu_Black(M)
		else
			new/obj/Inventory/Clothing/Masks/Anbu(M)
	Demote_ANBU()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank == "ANBU") continue
			X+=M
		var/mob/P=CustomInput("Who do you want to demote from ANBU?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been booted from the ANBU Ops, and are now a Jounin.","actionoutput")
		M.rank="Jounin"
		for(var/obj/Inventory/Clothing/Masks/Anbu/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/Masks/Anbu_Black/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Make_Jounin()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank == "Chuunin") continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to Jounin?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been promoted to Jounin.","actionoutput")
		M.rank="Jounin"
	Demote_Jounin()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank == "Jounin") continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey&&e.rank=="Jounin") X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to demote from Jounin?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been demoted from Jounin, and are now a Chuunin.","actionoutput")
		M.rank="Chuunin"
		for(var/obj/Inventory/Clothing/Masks/Anbu/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/Masks/Anbu_Black/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Make_Sage()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank == "ANBU") continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to Sage?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been promoted Sage.","actionoutput")
		M.rank="Sage"
		new/obj/Inventory/Clothing/Robes/Sage_Robe(M)
	Demote_Sage()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank == "Sage") continue
			X+=M
		for(var/mob/player/e in world)  X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to demote from the Sages?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been booted from the Sages, and are now a ANBU.","actionoutput")
		M.rank="ANBU"
		for(var/obj/Inventory/Clothing/Robes/Sage_Robe/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Kage"
		var/list/X=list()
		if(skalert("Are you sure you would like to retire as kage?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village) continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel") return
		if(P==src)
			src<<"Can't promote yourself as kage..."
			return
		var/mob/M = X["[P]"]
		if(!M)
			src<<"Messed up, please try again."
			return
		Kages["[village]"]=null
		rank="Genin"
		RemoveAdminVerbs()
		switch(village)
			if("Hidden Leaf")
				world<<output("<b><center>[src] has retired as Hokage, and [M] has been promoted as their successor!<b></center>","actionoutput")
				M.rank="Hokage"
				Kages["Hidden Leaf"]=M.ckey
				for(var/obj/Inventory/Clothing/HeadWrap/HokageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/HokageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/HokageHat(M)
				new/obj/Inventory/Clothing/Robes/HokageRobe(M)
			if("Hidden Sand")
				world<<output("<b><center>[src] has retired as Kazekage, and [M] has been promoted as their successor!<b></center>","actionoutput")
				M.rank="Kazekage"
				Kages["Hidden Sand"]=M.ckey
				for(var/obj/Inventory/Clothing/HeadWrap/KazekageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/KazekageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/KazekageHat(M)
				new/obj/Inventory/Clothing/Robes/KazekageRobe(M)
			if("Hidden Sound")
				world<<output("<b><center>[src] has retired as Sound Leader, and [M] has been promoted as their successor!<b></center>","actionoutput")
				M.rank="Sound Leader"
				Kages["Hidden Sound"]=M.ckey
				for(var/obj/Inventory/Clothing/HeadWrap/SoundleaderHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/SoundLeaderRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/SoundleaderHat(M)
				new/obj/Inventory/Clothing/Robes/SoundLeaderRobe(M)
			if("Hidden Mist")
				world<<output("<b><center>[src] has retired as Mizukage, and [M] has been promoted as their succesor!<b></center>","actionoutput")
				M.rank="Mizukage"
				Kages["Hidden Mist"]=M.ckey
				for(var/obj/Inventory/Clothing/HeadWrap/MizukageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/MizukageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/MizukageHat(M)
				new/obj/Inventory/Clothing/Robes/MizukageRobe(M)
			if("Hidden Rock")
				world<<output("<b><center>[src] has retired as Tsuchikage, and [M] has been promoted as their succesor!<b></center>","actionoutput")
				M.rank="Tsuchikage"
				Kages["Hidden Rock"]=M.ckey
				for(var/obj/Inventory/Clothing/HeadWrap/TsuchikageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/TsuchikageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/TsuchikageHat(M)
				new/obj/Inventory/Clothing/Robes/TsuchikageRobe(M)
		M.AddAdminVerbs()
		src.overlays=0
		src.RestoreOverlays()
	ANBU_Meeting()
		set category="Kage"
		for(var/mob/player/M in world)
			if(M.village==src.village&&M.rank=="ANBU")
				if(M.skalert("Your Kage, [src] sends a call for all ANBUs for a meeting with him... Do you wish to attend?","Kage and ANBU Meeting !",list("No","Yes"))=="No")
					src<<"[M] can't attend this meeting."
					return
				if(src.village=="Hidden Sand")
					M.loc=locate(189,6,4)
				if(src.village=="Hidden Leaf")
					M.loc=locate(186,194,4)
				if(src.village=="Hidden Mist")
					M.loc=locate(12,194,4)
				if(src.village=="Hidden Sound")
					M.loc=locate(72,194,2)
				if(src.village=="Hidden Rock")
					goto killit
		if(src.village=="Hidden Sand")
			src.loc=locate(189,6,4)
		if(src.village=="Hidden Leaf")
			src.loc=locate(186,194,4)
		if(src.village=="Hidden Mist")
			src.loc=locate(12,194,4)
		if(src.village=="Hidden Sound")
			src.loc=locate(72,194,2)
		killit

mob/AkatsukiLeader/verb/
	Make_Akatsuki()
		set category="Akatsuki"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the Akatsuki?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["Akatsuki Leader"]!=src.ckey) return
		if(M.village!="Missing-Nin") return
		if(AkatInvites>6)
			src<<"You cannot invite any more Akatsukis."
			return
		if(skalert("Are you sure you want to invite [M] to be a Akatsuki?","Confirm",list("No","Yes"))=="No") return
		if(M.skalert("You have been invited to join the Akatsuki. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline") return
		for(var/mob/Z in world) if(Z.village=="Akatsuki") Z<<"[M] has joined your ranks."
		M.village="Akatsuki"
		M.rank="Akatsuki"
		AkatInvites++
		new/obj/Inventory/Clothing/Robes/Akatsuki_Robe(M)
		new/obj/Inventory/Clothing/HeadWrap/AkatsukiHat(M)
		M.AddAdminVerbs()
	Remove_Akatsuki()
		set category="Akatsuki"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Akatsuki?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["Akatsuki Leader"]!=src.ckey) return
		if(M.village!="Akatsuki") return
		if(skalert("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))=="No") return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		AkatInvites--
		for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/HeadWrap/AkatsukiHat/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Akatsuki"
		var/list/X=list()
		if(skalert("Are you sure you would like to retire as Akatsuki Leader?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Missing-Nin"
		village="Missing-Nin"
		for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/HeadWrap/AkatsukiHat/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/HeadWrap/TobiMask/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Weaponry/MadaraFan/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		overlays=null
		RestoreOverlays()
		RemoveAdminVerbs()
		M.rank="Akatsuki Leader"
		M.AddAdminVerbs()
mob/SMLeader/verb/
	Make_7SM()
		set category="7SM"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the 7SM?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM Leader"]!=src.ckey) return
		if(M.village!="Missing-Nin") return
		if(AkatInvites>6)
			src<<"You cannot invite any more 7SMs."
			return
		if(skalert("Are you sure you want to invite [M] to be a 7SM?","Confirm",list("No","Yes"))=="No") return
		if(M.skalert("You have been invited to join the 7SM. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline") return
		for(var/mob/Z in world) if(Z.village=="7SM") Z<<"[M] has joined your ranks."
		M.village="7SM"
		M.rank="7SM"
		AkatInvites++
		new/obj/Inventory/Weaponry/Samehada(M)
		M.AddAdminVerbs()
	Remove_7SM()
		set category="7SM"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the 7SM?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM Leader"]!=src.ckey) return
		if(M.village!="7SM") return
		if(skalert("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))=="No") return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		AkatInvites--
		for(var/obj/Inventory/Weaponry/Samehada/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="7SM"
		var/list/X=list()
		if(skalert("Are you sure you would like to retire as 7SM Leader?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Missing-Nin"
		village="Missing-Nin"
		for(var/obj/Inventory/Weaponry/Samehada/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		overlays=null
		RestoreOverlays()
		RemoveAdminVerbs()
		M.rank="7SM Leader"
		M.AddAdminVerbs()