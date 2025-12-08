mob
	var
		mob/playerr
turf
	clanpick
		Aburame
			icon='Aburame.dmi'
		Akimichi
			icon='Akimichi.dmi'
		Crystal
			icon='CreationScreen/clan/Crystal.dmi'
		Hyuuga
			icon='Hyuuga.dmi'
		Kaguya
			icon='Kaguya.dmi'
		Nara
			icon='Nara.dmi'
		Spider
			icon='Spider.dmi'
		Uchiha
			icon='Uchiha.dmi'
		Wood
			name="Senjuu"
			icon='Wood.dmi'
		Weaponist
			icon='Weaponist.dmi'
		nonclan
			name="No Clan"
			icon='CreationScreen/non-clan.png'
		pick
			icon='CreationScreen/clan/pickaclan.dmi'
		/*Click()//usr.playerr)
			if(usr.skalert("Are you sure you want to be born in [src.name] clan?","Clan Picking.",list("No","Yes"))=="No") return
			usr.Clan=src.name
			usr.client.eye=locate(0,0,0)
			usr.Next(usr)
			return*/
/*mob/proc
	Next(mob/player/M)
		if(M.Clan=="No Clan")
			if(M)
				var/list/Specialties=list("strength","Ninjutsu","Genjutsu","Balanced")
				var/obj/K=M.CustomInput("Specialist Options","Since you are a non-clan, you get to pick a second specialty. Please choose another.",Specialties-M.Specialist)
				if(M)if(K)M.Specialist2=K.name
		if(M.Clan!="No Clan")
			M.Specialist2=null
		if(M)
			var/obj/K=M.CustomInput("Village Options","What village would you like to be born in?.",list("Hidden Leaf","Hidden Sand","Hidden Sound","Hidden Mist"))
			if(M)if(K)M.village=K.name
		if(M)
			switch(M.Specialist2)
				if("strength")
					M.strength+=6
					M.maxstrengthexp+=5
				if("Ninjutsu")
					M.ninjutsu+=6
					M.maxninexp+=5
				if("Genjutsu")
					M.genjutsu+=6
					M.maxgenexp+=5
				if("Balanced")
					M.strength+=2
					M.genjutsu+=2
					M.ninjutsu+=2
					M.maxstrengthexp+=2
					M.maxninexp+=2
					M.maxgenexp+=2
			switch(M.Specialist)
				if("strength")
					M.strength+=6
					M.maxstrengthexp+=6
				if("Ninjutsu")
					M.ninjutsu+=6
					M.maxninexp+=6
				if("Genjutsu")
					M.genjutsu+=6
					M.maxgenexp+=6
				if("Balanced")
					M.strength+=2
					M.genjutsu+=2
					M.ninjutsu+=2
					M.maxstrengthexp+=2
					M.maxninexp+=2
					M.maxgenexp+=2
			for(var/SJ in typesof(/obj/Jutsus))
				var/obj/SJT = new SJ
				if(SJT.starterjutsu==1)
					M.JutsusLearnt.Add(SJT)
					M.JutsusLearnt.Add(SJT.type)
					M.sbought+=SJT.name
					SJT.owner=M.ckey
			M.skillpoints=1
			M.RestoreOverlays()
			for(var/obj/Titlescreen/Logo/L in M.client.screen)del(L)
			if(!M)return
		//	M.client.eye=locate(41,148,14)
			M.loc=locate(39,158,14)//M.MapLoadSpawn()
			M.client.eye=M
			M.client:perspective = EYE_PERSPECTIVE
			M << output("Welcome to the game. This is a Naruto: Evolution rip being heavily updated. Enjoy. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F10: Hotslots<br>R: Recharge chakra<br>Tab: Target<br>Shift+Tab: Untarget<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
			if(M.key=="Imantas2")
				M.admin=1
			//M.namecolor="yellow"
				winset(M,"Options.ShowKage","is-visible=true")
				winset(M, null, {"
				ShowAdmin.is-visible="true";
				"})
			winset(M, "mainwindow", "is-maximized=true")
			new/obj/Screen/Bar(M)
			if(M.village == "Hidden Leaf")new/obj/Screen/LeafSymbol(M)
			if(M.village == "Hidden Sand")new/obj/Screen/SandSymbol(M)
			new/obj/Screen/WeaponSelect(M)
			new/obj/Screen/Health(M)
			new/obj/Screen/Chakra(M)
			new/obj/Screen/EXP(M)
			new/obj/HotSlots/HotSlot1(M)
			new/obj/HotSlots/HotSlot2(M)
			new/obj/HotSlots/HotSlot3(M)
			new/obj/HotSlots/HotSlot4(M)
			new/obj/HotSlots/HotSlot5(M)
			new/obj/HotSlots/HotSlot6(M)
			new/obj/HotSlots/HotSlot7(M)
			new/obj/HotSlots/HotSlot8(M)
			new/obj/HotSlots/HotSlot9(M)
			new/obj/HotSlots/HotSlot10(M)
			var/obj/O=new /obj/Screen/healthbar/
			var/obj/Mana=new /obj/Screen/manabar/
			M.hbar.Add(O)
			M.hbar.Add(Mana)
			for(var/obj/Screen/healthbar/HB in M.hbar)M.overlays+=HB
			for(var/obj/Screen/manabar/HB in M.hbar)M.overlays+=HB
			M.UpdateBars()
			spawn(1)if(M)M.Run()
			//spawn(1)M.lifecycle()
			if(M)
				M.UpdateHMB()
				M.Name(M.name)
				M.pixel_x=-16
				M.RestoreOverlays()
			spawn()if(M)M.WeaponryDelete()
			if(M)M.AddAdminVerbs()
			spawn()if(M)M.MedalCheck()
			world<<"[M.rname] has logged in for the first time."
			src.name="[M.rname]"
			M.creating=0
			winset(M, null, {"
							SkillBar.is-visible      = "true";
							ChatOut.is-visible      = "true";
							ActionOutputChild.is-visible      = "true";
							Maplink.right=mapwindow;
						"})
			M<<"Now speaking in: [M.Channel]."
			spawn(30)if(M)M.ASave()
			if(M.skalert("Do you wish to skip the tutorial? Do this only if you are familiar with the game.","Skip Tutorial?",list("No","Yes"))=="No") return
			M.Tutorial=6
			if(M.village=="Hidden Sound")
				M.loc = locate(157,28,6)
			if(M.village=="Hidden Leaf")
				M.loc = locate(116,127,1)
			if(M.village=="Hidden Sand")
				M.loc = locate(91,132,10)
			if(M.village=="Hidden Mist")
				M.loc = locate(130,87,8)
			for(var/client/A in world)
				if(src.client.computer_id == A.computer_id)
					src<<"Multi keying is fixed."
					src.Logout()*/

