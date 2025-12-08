#define WORLD_SAVE "World.sav"


var/list/Badwords = list("byond://","www.","http://","\n")
var/const/allowed_characters_name = "abcdefghijklmnopqrstuvwxyz' .	"
mob/var/Logins
proc/filter_characters(var/string, var/allowed = allowed_characters_name)
	set background = 1
	if(!string || !allowed) return 0
	var/stringlen = lentext(string)
	var/newstring = ""
	for(var/i = 1 to stringlen)
		var/char = copytext(string, i, i+1)
		if(findtext(allowed, char)) newstring += char
		sleep(-1)
	return newstring
proc/hasSavefile(var/ckey)
	ckey=lowertext(ckey)
	var/letter = copytext(ckey,1,2)
	return fexists("Players/[letter]/[ckey].sav")
proc/uppercase(var/string, var/pos=1)
	if(!string || !pos) return
	return uppertext(copytext(string, pos, pos+1))+copytext(string, pos+1)
client/Del()
	if(Members.Find(src.ckey)) Members-=src.ckey
	..()
client/New()
	if(isBanned(src))
		sleep(5)
		del(src)
		return
	if(full)
		if(IsByondMember())
			if(Members.len<MaxMembers)
				Members++
				src<<"You've been let into the server due to your BYOND Membership. Thanks for supporting BYOND!"
				..()
				return
		src<<"Server is full."
		del(src)
		return
	..()

var/full=0
var/servertype = "Official"
world
	name = "Naruto:Ninja Power"
	hub= "Imantas2.NarutoNinjaPower"
	hub_password = "imantasss"
	status="<font face= Times New Roman>Loading Configuration..."
	mob = /mob/Login
	view = 16
	loop_checks=1
	proc/PlayerCount()
		set background=1
		while(world)
			sleep(600)//One minute each to check! Not .2 seconds=EPIC LAG!
			var/number=0
			for(var/mob/player/M in world)if(M.key)number++
			Players=number
			if(Players>=MaxPlayers)full=1
			else full=0
			status="<font face= Times New Roman>Naruto: Evolution ([Players]/[MaxPlayers]) Server: [global.servertype]"

proc/RepopWorld()
	set background=1
	while(world)
		sleep(600*3)
		world.Repop()

proc/Advert()
	set background = 1
	while(world)
		world<<"<font color=white><b>Don't forget to visit our <a href=http://www.Neforum.forumotion.com/>Forums!</a></b></font>!"
		sleep(600*15)
var/MOTD
var/list/MapLoadSpawn= newlist()
var/list/Respawn= newlist()
mob/proc/MapLoadSpawn()
	for(var/turf/Spawns/StartSpot/S in world)
		if(S.Village==village)return S
mob/proc/RespawnSpawn()
	var/list/Respawns=list()
	for(var/turf/Spawns/RespawnSpot/S in world)
		if(S.Village==village)Respawns+=S
	return Respawns
mob
	var/ownkey
	var/hasownkey=0
//	return pick(MapLoadSpawn)
world
	New()
		//..()
		//world.status="<font face= Times New Roman>Ninja Adventure(Alpha Version) (TEST SERVER)"
		//spawn()
		//	TimeEffect()
		log = file("Errorlog.txt")
		spawn(10) RepopWorld()
		spawn(10) GeninExam()
		spawn(10) ChuuninExam()
		spawn(10) Advert()
		spawn(10) RepopWorld()
	//	spawn(5)  loadBans()
		spawn() AutoCheck()
		//spawn() AutomaticReboot()
		spawn(5)  PlayerCount()
		spawn(5)  HTMLlist()
		if(!fexists(WORLD_SAVE)) return
		var/savefile/F = new(WORLD_SAVE)
		if(!isnull(F["Factions"])) F["Factions"] >> Factionnames
		if(!isnull(F["Maps"])) F["Maps"] >> maps
		if(!isnull(F["SandLevel"])) F["SandLevel"] >> SandLevel
		if(!isnull(F["LeafLevel"])) F["LeafLevel"] >> LeafLevel
		if(!isnull(F["SandExp"])) F["SandExp"] >> SandExp
		if(!isnull(F["LeafExp"])) F["LeafExp"] >> LeafExp
		if(!isnull(F["SandExpmax"])) F["SandExpmax"] >> SandExpmax
		if(!isnull(F["LeafExpmax"])) F["LeafExpmax"] >> LeafExpmax
		if(!isnull(F["Expboosts"])) F["Expboosts"] >> Expboosts
		if(!isnull(F["Admins"])) F["Admins"] >> Admins
		if(!isnull(F["MasterGMs"])) F["MasterGMs"] >> MasterGMs
		if(!isnull(F["Moderators"])) F["Moderators"] >> Moderators
		if(!isnull(F["Enforcers"])) F["Enforcers"] >> Enforcers
		if(!isnull(F["PArtists"])) F["PArtists"] >> PArtists
		if(!isnull(F["AkatInvites"])) F["AkatInvites"] >> AkatInvites
		for(var/c in Factionnames)
			var/path = "Factions/[c].sav"
			var/savefile/G = new(path)
			if(!fexists(path))
				Factionnames -= c
				continue
			var/Faction/Faction
			G >> Faction
			Factions += Faction
		..()
	Del()
		//for(var/a in BootedList)crban_unban(a)
		var/savefile/F = new(WORLD_SAVE)
		Factionnames = new/list()
		for(var/Faction/c in Factions)
			if(!c.name) continue
			var/path = "Factions/[c.name].sav"
			var/savefile/G = new(path)
			G << c
			Factionnames += c.name
		if(maps.len) F["Maps"] << maps
		F["Factions"] << Factionnames
		F["SandLevel"] << SandLevel
		F["LeafLevel"] << LeafLevel
		F["SandExp"] << SandExp
		F["LeafExp"] << LeafExp
		F["SandExpmax"] << SandExpmax
		F["LeafExpmax"] << LeafExpmax
		F["Expboosts"] << Expboosts
		F["Admins"] << Admins
		F["MasterGMs"] << MasterGMs
		F["Moderators"] << Moderators
		F["Enforcers"] << Enforcers
		F["PArtists"] << PArtists
		F["AkatInvites"] << AkatInvites
		..()
		//for(var/turf/Spawns/RespawnSpot/GS in world)
		//	Respawn.Add(GS)
		//for(var/turf/Spawns/StartSpot/GS in world)
	//		MapLoadSpawn.Add(GS)
//atom
//	movable
//		pixel_step_size=4
//		animate_movement=2
obj
	MaleParts
		UnderShade
			icon='Shade.dmi'
			icon_state="undershade"
			pixel_y=-2
			pixel_x=15
			layer=TURF_LAYER+1
client
	mouse_pointer_icon='mousepointer.dmi'
	//lazy_eye = 5
	//mouse_over_pointer='pointero.dmi'
//	Stat()
//		.=..()
		//src.overlays=0//Clears the player's overlays so the letters won't build up on top of each other.
obj/CinematicFollower
	//icon='checkbox.dmi'
	//icon_state="unchecked"
	layer=99999999999999999999999999999999999
	New(var/mob/M)
		if(!ismob(M)) return
		M.client.screen+=src
		screen_loc = "CENTER-6,CENTER"
		src.loc=locate(0,0,0)
		..()
obj/FadingHUD
	icon = 'Misc Effects.dmi'
	screen_loc = "SOUTHWEST to NORTHEAST"
	icon_state = "Fade"
	layer = 600
	name = null
	mouse_opacity=0
	New(var/client/C)
		..()
		C.screen += src
		spawn(10) del(src)


mob/Login
	verb/Logins()
		set hidden=1
		for(var/client/A in world)
			if(src.client.computer_id == A.computer_id)
				src<<"Multi keying is fixed."
				src.Logout()
		var/LoginID=winget(src,"titlescreen.Username","text")
		var/LoginPW=winget(src,"titlescreen.Password","text")
		LoginID=lowertext(LoginID)
		var/letter = copytext(LoginID,1,2)
		if(!key)
			client.Command(".reconnect")
		if(hasSavefile(LoginID))
			var/savefile/F = new("Players/[lowertext(letter)]/[lowertext(LoginID)].sav")
			if(!F)
				src.skalert("Invalid account path.","Invalid")
				return
			var/PasswordRight
			if(isnull(F["Password"]))
				src.skalert("No password set for this account, please try again.","Invalid")
				return
			F["Password"] >> PasswordRight
			if(!istext(PasswordRight))
				src.skalert("Error reading password.","Invalid")
				return
			if(!PasswordRight)
				src.skalert("Please enter a password.","Invalid")
				return
			if(!LoginID)
				src.skalert("Please enter an account ID.","Invalid")
				return
			if(!hasSavefile(LoginID))
				src.skalert("Invalid Account ID.","Invalid")
				return
			if(LoginPW!=PasswordRight)
				src.skalert("Invalid Password.","Invalid")
				return
			LoadCharacter(LoginID,F)
		else
			src.skalert("Invalid Account ID.","Invalid")
			return
	/*Login()
		..()
		spawn(5)GetScreenResolution(src)
		var/mob/EYEBALL=new()
		EYEBALL.name="EYE"
		EYEBALL.loc=locate(101,100,17)
		EYEBALL.density=0
		EYEBALL.invisibility=1
		if(src in Bans)
			src<<"You have been banned from this game!"
			src.Logout()
		spawn()
			var/obj/Titlescreen/Logo/L=new(src)
			while(istype(src,/mob/Login))
				sleep(10)
			del(EYEBALL)
			del(L)
		//src<<sound('hotaru no hikari.wav')
		winset(src, null, {"
							Maplink.right=titlescreen;
							mainwindow.is-maximized=true
							mainwindow.UnlockChild.is-visible = "false";
							mainwindow.InvenChild.is-visible = "false";
							Stats.is-visible      = "false";
							SkillBar.is-visible      = "false";
							ChatOut.is-visible      = "false";
							ActionOutputChild.is-visible      = "false";
						"})
		winset(src, null, {"
							TitleChild.right=mapwindow;
						"})
		src.AddAdminVerbs()
		if(src)src.loc=locate(0,0,0)
		var/Ticked=0
		spawn()
			for(var/mob/player/M in world)
				if(!M.client) continue
				if(!src.client) continue
				if(M==src||M.client==client) continue
				if(M.client.address==src.client.address&&src.client.computer_id==M.client.computer_id)Ticked=1
			if(Ticked)
				src<<"You already have someone from the same computer logged in. We do not allow multikeys."
				sleep(10)
				del(src)*/
	Login()
		..()
		spawn(5)GetScreenResolution(src)
		var/mob/EYEBALL=new()
		EYEBALL.name="EYE"
		EYEBALL.loc=locate(101,100,7)
		EYEBALL.density=0
		//src.skalert("When you create your account, you won't be automatically teleported to the spawn. Please relog and log in to be teleported to the tutorial. This is to prevent spam.")
		EYEBALL.invisibility=1
		EYEBALL.byakuview = 0
		EYEBALL.canteleport = 0
		src.client.eye=EYEBALL
		src.client:perspective = EYE_PERSPECTIVE
		spawn()
			var/obj/Titlescreen/Logo/L=new(src)
			while(istype(src,/mob/Login))
				step_rand(EYEBALL)
				sleep(10)
			del(EYEBALL)
			del(L)
	//	src<<sound('preview.ogg')
		if(prob(50))
			winset(src, null, {"
					titlescreen.Shikamaru.is-visible="false"
						"})
		winset(src, null, {"
							Maplink.right=titlescreen;
							mainwindow.is-maximized=true
							mainwindow.UnlockChild.is-visible = "false";
							mainwindow.InvenChild.is-visible = "false";
							Stats.is-visible      = "false";
							SkillBar.is-visible      = "false";
							ChatOut.is-visible      = "false";
							target.is-visible = "false";
							ActionOutputChild.is-visible      = "false";
						"})
		winset(src, null, {"
							TitleChild.right=mapwindow;
						"})
		src.AddAdminVerbs()
		var/Ticked=0
		var/mob/t1
		var/mob/t2
		spawn()
			for(var/mob/player/M in world)
				if(!M.client) continue
				if(!src.client) continue
				if(M==src||M.client==client) continue
				if(M.client.address==src.client.address&&src.client.computer_id==M.client.computer_id)Ticked=1
			if(Ticked)
				world<<"[t1] and [t2] are the same person. We do not allow multikeys."
				sleep(10)
				del(src)

	proc/LoadCharacter(var/LoginID,var/savefile/F)
		ASSERT(hasSavefile(LoginID) && src.client)
		src.loc=locate(0,0,0)
		winset(src, null, {"
							Maplink.right=mapwindow;
						"})
		for(var/obj/Titlescreen/Logo/L in src.client.screen)del(L)
		LoginID=lowertext(LoginID)
		var/letter = copytext(LoginID,1,2)
		var/mob/player/M = F["mob"]
		if(!M || !typesof(M))
			alert(src, "Your savefile is corrupt.")
			fcopy("Players/[letter]/[LoginID].sav","Players/Corrupted/[LoginID].sav")
			fdel("Players/[letter]/[LoginID].sav")
			client.Command(".reconnect")
			return
		else
			if(!M.hasownkey)
				M.ownkey = src.key
				M.hasownkey=1
		GetScreenResolution(M)
		M.client = src.client
		M.verbs.Add(typesof(/mob/verb))
		M.name = M.rname
		M.icon = M.ricon
		M.icon_state = M.riconstate
		M.density=1
		M.sight=0
		M.invisibility=0
		M.Move(locate(F["x"], F["y"], F["z"]))
		if(!M.loc)
			if(M.Tutorial==6) M.loc=M.MapLoadSpawn()
			else M.loc=locate(39,158,14)
		if(M.dead)
			M.density=1
			M.health=M.maxhealth
			M.chakra=M.maxchakra
			M.injutsu=0
			M.dead=0
			M.canattack=1
			M.firing=0
			M.icon_state=""
			M.wait=0
			M.rest=0
			M.dodge=0
			M.move=1
			M.swimming=0
			M.overlays=0
		M.client.eye=M
		M.client:perspective = EYE_PERSPECTIVE
		M.namecolor="green"
		M.chatcolor="white"
		M.RestoreOverlays()
		world<<"[M.rname] has logged in."
		M << output("Welcome to the game. This is currently a server for heavy testing. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F10: Hotslots<br>R: Recharge chakra<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
		if(!M.key)
			world<<"[M] lol"
			M.Logout()
		if(M.key=="Imantas2")
			M.admin=1
			src.admin=1
			winset(M,"Options.ShowKage","is-visible=true")

		winset(M, "mainwindow", "is-maximized=true")
		new/obj/Screen/Bar(M)
		if(M.village=="Hidden Leaf")new/obj/Screen/LeafSymbol(M)
		if(M.village=="Hidden Sand")new/obj/Screen/SandSymbol(M)
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
		for(var/i in M.JutsusLearnt)if(isnull(i))del(i)
		var/Faction/c = getFaction(M.Faction)
		if(c)
			if(M.Faction == c.name)
				M.verbs += M.Factionverbs
				c.onlinemembers.Add(M)
				c.members[M.rname] = list(M.key, M.level, M.Factionrank)
				if(c.FMOTD) M<<output("Faction MOTD: <br>[c.FMOTD]</br>","actionoutput")
				M.verbs += /Faction/Generic/verb/FactionLeave
		if(M.Faction&&!getFaction(M.Faction))
			M<<"Your Faction no longer exists. You have been removed from [M.Faction]"
			M.Faction=null
			M.Factionrank=null
			M.verbs-=M.Factionverbs
			M.Factionverbs=list()
		M.UpdateBars()
		spawn(1)M.Run()
		//spawn(1)M.lifecycle()
		M.UpdateHMB()
		M.pixel_x=-16
		M.Name(M.name)
		M.RestoreOverlays()
		M.AddAdminVerbs()
		M.UpdateSlots()
		spawn() M.WeaponryDelete()
		if(M.MuteTime) spawn() M.Muted()
		//M.px = 32 * M.x
		//M.py = 32 * M.y
		//spawn() M.MedalCheck()
		src.name="[name]CLIENT"
		if(!M.name) M.name=M.key
		winset(M, null, {"
							SkillBar.is-visible      = "true";
							ChatOut.is-visible      = "true";
							ActionOutputChild.is-visible      = "true";
							Maplink.right=mapwindow;
						"})
		M<<"Now speaking in: [M.Channel]."
		spawn(30)if(M)M.ASave()
	verb/CreateCharacter()
		set hidden=1
		if(src.client)
			var/mob/player/M = new//had to put this here because it kept freezing for the new mob ///// This screwed up A LOT of stuff, please do not do that
			M.loc=locate(0,0,0)
			src.loc=locate(0,0,0)
			M.gender = src.gender // We need to create a new player mob, otherwise the player is just a /mob, not /mob/player
			M.icon='MaleBase.dmi'
			M.verbs.Add(typesof(/mob/verb))
			M.client=src.client
			M.riconstate = M.icon_state
			M.ricon=M.icon
			M.Ryo=25
			M.ownkey = src.key
			M.hasownkey=1
			M.name = null
			M.creating=1
			GetScreenResolution(M)
			var/ck = uppercase(M.ckey, 1)
			while(M.name==null)
			//skinput2(prompt,title,initial,Number
				if(M)
					var/ZZ
					ZZ=M.skinput2("Type in a name. Names from the anime are strongly looked down upon.","Name",ck,0)
					if(M)
						M.name = ZZ
						var/leng = lentext(M.name)
						if(hasSavefile(M.name))
							M.skalert("The name you entered already exists.")
							M.name = null
							continue
						if((leng>20) || (leng<3))
							M.skalert("The name must be between 3 and 20 characters.")
							M.name = null
							continue
						if(uppertext(M.name) == M.name)
							M.skalert("Your name may not consist entirely of capital letters.")
							M.name = null
							continue
						if(filter_characters(M.name)!=M.name)
							M.skalert("\"[M.name]\" contains an invalid character.  Allowed characters are:\n[allowed_characters_name]")
							M.name = null
							continue
					else return
				else return
				sleep(1)
			M.Logins=lowertext(M.name)
			while(M.Password==null)
			//skinput2(prompt,title,initial,Number
				if(M)
					var/ZZ
					ZZ=M.skinput2("Please select a password for this account.","Password",0)
					if(M)
						M.Password = ZZ
						if(lentext(M.Password)<3)
							M.skalert("Password must have atleast 3 characters.")
							M.Password = null
							continue
					else return
				else return
				sleep(1)
			if(!istext(M.Password)) M.Password="[M.Password]"
			if(M)
				M.name = uppercase(M.name, 1)
				M.rname = M.name
				M.overlays=0
				//M.HairStyle='Long.dmi'
//				var/obj/SkinTone
//				SkinTone = M.CustomInput("Skin Color Options","Please choose a Skin Tone.",list("White","Dark"))
//				if(M)
//					if(SkinTone)
//						switch(SkinTone.name)
//							if("White") M.icon='MaleBase.dmi'
//							if("Dark") M.icon='Black MaleBase.dmi'  // We need to make a proc to check for skintone then replace EVERY icon='malebase.dmi' with that proc.
				var/obj/Hair
				Hair = M.CustomInput("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut","Deidara V3","Deidara V2","Deidara V1","Spikey","Mohawk","Neji Hair","Distance"))
				if(M)
					if(Hair)
						switch(Hair.name)
							if("Long") M.HairStyle='Long.dmi'
							if("Short") M.HairStyle='Short.dmi'
							if("Tied Back") M.HairStyle='Short2.dmi'
							if("Bald") M.HairStyle=null
							if("Bowl Cut") M.HairStyle='Short3.dmi'
							if("Deidara V1") M.HairStyle= 'Deidara.dmi'
							if("Deidara V2") M.HairStyle='DeidaraHair.dmi'
							if("Deidara V3") M.HairStyle='NewDeidara.dmi'
							if("Spikey") M.HairStyle='Spikey.dmi'
							if("Mohawk") M.HairStyle='Mohawk.dmi'
							if("Neji Hair") M.HairStyle='Neji Hair.dmi'
							if("Distance") M.HairStyle='Distance.dmi'
			if(M)
				var/list/Colors=M.ColorInput("Please select a hair color.")
				if(M)
					M.HairColorRed=text2num(Colors[1])
					M.HairColorGreen=text2num(Colors[2])
					M.HairColorBlue=text2num(Colors[3])
			if(M)
				if(M) M.Element=M.CustomInput("Element Options","Please choose your primary elemental affinity.",list("Fire","Water","Wind","Earth","Lightning"))
				if(M&&M.Element)M.Element=M.Element:name
			if(M)
				M.Specialist=M.CustomInput("Specialist Options","What area of skills would you like to specialize in?.",list("strength","Ninjutsu","Genjutsu","Balanced"))
				if(M&&M.Specialist)M.Specialist=M.Specialist:name
			if(M)
				if(M) M.Clan=M.CustomInput("Clan Options","What clan would you like to be born in?.",list("Senjuu","Crystal","Akimichi","Weaponist","Aburame","Hyuuga","Nara","Kaguya","Uchiha","Ink","Bubble","No Clan"))
				if(M&&M.Clan)
					M.Clan=M.Clan:name
					if(M.Clan=="No Clan")
						if(M)
							var/list/Specialties=list("strength","Ninjutsu","Genjutsu","Balanced")
							var/obj/K=M.CustomInput("Specialist Options","Since you are a non-clan, you get to pick a second specialty. Please choose another.",Specialties-M.Specialist)
							if(M)if(K)M.Specialist2=K.name
					if(M)
						var/obj/K=M.CustomInput("Village Options","What village would you like to be born in?.",list("Hidden Leaf","Hidden Sand","Hidden Rock","Hidden Mist","Hidden Sound"))
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
				M << output("Welcome to the game. Enjoy. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F5: Hotslots<br>R: Recharge chakra<br>Tab: Target<br>Shift+Tab: Untarget<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
				if(M.key=="Imantas2"||M.key=="")
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
				//spawn()if(M)M.MedalCheck()
				world<<"[M.rname] has logged in for the first time."
				src.name="[name]CLIENT"
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
					M.loc = locate(75,54,8)
				if(M.village=="Hidden Rock")
					M.loc = locate(126,35,15)
				for(var/client/A in world)
					if(src.client.computer_id == A.computer_id)
						src<<"Multi keying is fixed."
						src.Logout()


mob/var/tmp/Prisoner
mob/var/tmp/creating
mob/player
	Logout()
		if(creating) del(src)
		for(var/obj/O in world)if(O.IsJutsuEffect==src) del(O)
		for(var/mob/M in src.puppets)del(M)
		if(src.inboulder==1)
			src.inboulder=0
		if(src.ingpill==1)
			src.ingpill=0
			src.strength-=15
		if(src.inypill==1)
			src.inypill=0
			src.strength-=25
		if(src.inrpill==1)
			src.inrpill=0
			src.strength-=40
		if(src.dueling==1)
			src.opponent.loc=MapLoadSpawn
			src.opponent.dueling = 0
			arenaprogress=0
			world<<"[src] has logged out during an Arena challenge. Match has become Null."
		if(src.incalorie==1)
			for(var/obj/Jutsus/CalorieControl/J in src.JutsusLearnt)
				src.incalorie=0
				src.strength-=J.damage
				src.overlays=0
		if(src.incurse==1)
			src.incurse=0
			src.strength-=15
			src.ninjutsu-=10
			src.underlays=null
			src.overlays=null
		if(src.insage==1)
			src.insage=0
			src.strength-=10
			src.ninjutsu-=20
			src.underlays=null
			src.overlays=null
		if(src.inAngel==1)
			src.inAngel=0
			src.underlays=null
			src.overlays=null
		if(src in global.genintesters)
			global.genintesters-=src
			src.loc = locate(11,69,2)
		if(Chuunins.Find(src))
			Chuunins-=src
			src.loc=MapLoadSpawn()
		if(village!="Akatsuki")
			for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(village!="7SM")
			for(var/obj/Inventory/Weaponry/Samehada/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="ANBU")
			for(var/obj/Inventory/Clothing/Masks/Anbu/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Masks/Anbu_Black/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Sage")
			for(var/obj/Inventory/Clothing/Robes/Sage_Robe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Hokage")
			for(var/obj/Inventory/Clothing/Robes/HokageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/HokageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Kazekage")
			for(var/obj/Inventory/Clothing/Robes/KazekageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/KazekageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Sound Leader")
			for(var/obj/Inventory/Clothing/Robes/SoundLeaderRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/SoundleaderHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Mizukage")
			for(var/obj/Inventory/Clothing/HeadWrap/MizukageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Robes/MizukageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
				del(O)
		if(rank!="Tsuchikage")
			for(var/obj/Inventory/Clothing/HeadWrap/TsuchikageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Robes/TsuchikageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(loc in block(locate(71,95,4),locate(200,163,4))) // If they are in FoD
			loc=MapLoadSpawn() // Remember to change depending on villages!
			for(var/obj/ChuuninExam/Scrolls/S in src)del(S)
		if(loc in block(locate(113,29,4),locate(146,58,2)))loc=MapLoadSpawn()
		if(NaraTarget)
			var/mob/M=NaraTarget
			M.move=1
			M.injutsu=0
			M.canattack=1
			NaraTarget=null
		if(Prisoner)
			var/mob/M=Prisoner
			M.client.eye=M
			M.client:perspective = EYE_PERSPECTIVE
			M.move=1
			M.canattack=1
			M.injutsu=0
			Prisoner=null
		if(src.key&&src.name)world<<"[src.name] has logged out!"
		if(Squad)
			if(Squad.Leader == ckey)del Squad
			else if(Squad.Members.Find(ckey))
				for(var/i in Squad.Members)
					var/mob/player/P = getOwner(i)
					P.Squad.Members -= ckey
				var/mob/player/P = getOwner(Squad.Leader)
				P.Squad.Members -= ckey
		for(var/mob/Clones/C in world)if(C.Owner==src)del(C)
		var/Faction/c=getFaction(src.Faction)
		if(c)
			c.onlinemembers -= usr
			c.members[rname] = list(key, level, Factionrank)
			usr.verbs -= Factionverbs
		if(!src.key)
			world.log << "[src.rname] has had an error while logging out. Mob deleted."
			del src
			return
		if(src.ownkey && src.ownkey != src.key) //This means that something went wrong.
			world.log << "[src.rname] has had an error while logging out. Mob deleted."
			del src
			return
		src.overlays-=src.overlays
		//image('Jutsus.dmi',"burning")
		//src.overlays-=image('Jutsus2.dmi',"Meat Tank")
		pixel_y = 0
		pixel_x = 0
		for(var/mob/jutsus/Summon_Spider/A in world)
			if(A.OWNER==src)
				del(A)
		//var/list/possible_entries = typesof(/mob/Jutsus/verb)
		//var/list/current_verbs = src.verbs.Copy()
		//for(var/R in current_verbs) if(!(R in possible_entries)) current_verbs -= R
		if(!src.key) //This means that they're simply switching mobs
			world.log << "[src.rname] has left their mob without logging out."
			del src
			return
		var/letter = copytext(Logins,1,2)
		if(fexists("Players/[letter]/[Logins].sav")) fdel("Players/[letter]/[Logins].sav")
		var/savefile/F = new("Players/[letter]/[Logins].sav")
	//	var/list/Jutsus=list()
	//	for(var/obj/Jutsus/O in JutsusLearnt)
	//		if(istype(O))
	//			Jutsus.Add(O)
	//			world.log<<"Added [O] to Jutsus."
	//			world.log<<"Jutsus.len is now [Jutsus.len]"
		ASSERT(src && ismob(src))
		F["x"] << src.x
		F["y"] << src.y
		F["z"] << src.z
		F["Clan"] << src.Clan
		F["Password"] << Password
		//F["Jutsus"] << Jutsus
		//F["verbs"] << current_verbs
		F["mob"] << src
		//SendSavefile(F,Logins)
		del(src)
		..()
mob/proc/ASave()
	while(src)
		Save()
		sleep(600*3)//Three minutes to save periodically!
mob/proc/Save()
	var/letter = copytext(Logins,1,2)
	if(fexists("Players/[letter]/[Logins].sav")) fdel("Players/[letter]/[Logins].sav")
	var/savefile/F = new("Players/[letter]/[Logins].sav")
	ASSERT(src && ismob(src))
	F["x"] << src.x
	F["y"] << src.y
	F["z"] << src.z
	F["Clan"] << src.Clan
	F["Password"] << Password
	//F["Jutsus"] << Jutsus
	//F["verbs"] << current_verbs
	F["mob"] << src
	//SendSavefile(F,Logins)
	src<<output("Game saved successfully.","actionoutput")
mob
	var/tmp
		Channel="Say"
	verb
		WorldAddy()
			set hidden=1
			usr << output("<FONT FACE= Times New Roman>byond://[world.internet_address]:[world.port]", "actionoutput")
	verb
		CloseBrowser()
			set hidden=1
			winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
		MiniWindow()
			set hidden=1
			winset(usr, "mainwindow", "is-minimized=true")
		ChangeChannel()
			set hidden=1
			if(Channel=="World")
				Channel="Say"
				src<<"Now speaking in: [Channel]"
				return
			if(Channel=="Say")
				Channel="Whisper"
				src<<"Now speaking in: [Channel]. Type a name in dashes, and then your message.."
				src<<"Example: -Username- Message"
				return
		//	if(Channel=="Whisper") // World
		//		Channel="Village"
		//		src<<"Now speaking in: [Channel]"
		//		return
			if(Squad && Channel=="Village") // Squad  Squad AND Channel is Village
				Channel="Squad"
				src<<"Now speaking in: [Channel]"
				return
			if(Channel=="Village" || Channel=="Squad") // Say -- Village or Squad
				Channel="World"
				src<<"Now speaking in: [Channel]"
				return
			if(Faction && getFaction(src.Faction))
				if(Channel=="Whisper") // Village
					Channel="Faction"
					src<<"Now speaking in: [Channel]"
					return
			if(village)
				if(Channel=="Whisper" || Channel=="Faction") // Village Village AND Channel is World
					Channel="Village"
					src<<"Now speaking in: [Channel]"
					return
mob/player
	var/SayUp
	see_in_dark=3
	New()
		..()
		if(!src.client)src.beAI()
	verb
		Winsay()
			set hidden=1
			if(Muted)
				src<<"You're muted!"
				return
			if(SayUp)
				SayUp=0
				winset(usr, null, {"
				SayBoxChild.focus      = "false";
				SayBoxChild.is-visible      = "false";
				"})
				winset(src, null, {"
				MainWindow.Maplink.focus      = "true";
				"})
				return
			winset(usr, null, {"
				SayBoxChild.focus      = "true";
				SayBoxChild.is-visible      = "true";
			"})
			SayUp=1
	verb
		ChatBox()
			set hidden=1
			if(src.chatbox)
				src.chatbox=0
				winset(usr, null, {"
					ChatOut.focus      = "false";
					ChatOut.is-visible      = "false";
				"})
			else
				if(!src.chatbox)
					src.chatbox=1
					winset(usr, null, {"
						ChatOut.focus      = "true";
						ChatOut.is-visible      = "true";
					"})
mob
	var
		tmp
			statbox=0
			jutsutab=0
	verb
		ViewJutsuTab()
			set hidden=1
			if(jutsutab)
				jutsutab=0
				winset(usr, null, {"
				JutsuTabChild.focus      = "false";
				JutsuTabChild.is-visible      = "false";
				"})
				return
			RefreshJutsus()
			winset(usr, null, {"
				JutsuTabChild.focus      = "true";
				JutsuTabChild.is-visible      = "true";
			"})
			jutsutab=1
		RefreshJutsus()
			set hidden=1
			winset(src,"JutsuTab.Grid","cells=0x0")
			var/Row = 1
		//	var/a=1
			src<<output("","Grid:1,1")
			for(var/obj/Jutsus/O in src.JutsusLearnt)
				Row++
				src << output(O,"Grid:1,[Row]")
		Stats()
			set hidden=1
			if(usr.statbox==1)
				usr.statbox=0
				winset(usr, null, {"
					Stats.focus      = "false";
					Stats.is-visible      = "false";
				"})
			else
				if(usr.statbox==0)
					usr.statbox=1
					winset(usr, null, {"
						Stats.focus      = "true";
						Stats.is-visible      = "true";
						Status.Name.text      = "[usr.name]";
						Status.Level.text      = "[usr.level]";
						Status.EXP.text      = "[usr.exp]/[usr.maxexp]";
						Status.Tai.text      = "[usr.strength]([usr.strengthexp]/[usr.maxstrengthexp])";
						Status.Nin.text      = "[usr.ninjutsu]([usr.ninexp]/[usr.maxninexp])";
						Status.Gen.text      = "[usr.genjutsu]([usr.genexp]/[usr.maxgenexp])";
						Status.Str.text      = "[usr.strength]([usr.strengthexp]/[usr.maxstrengthexp])";
						Status.Def.text      = "[usr.defence]([usr.defexp]/[usr.maxdefexp])";
						Status.Str2.text      = "[usr.strength]([usr.strengthexp]/[usr.maxstrengthexp])";
						Status.Def2.text      = "[usr.defence]([usr.defexp]/[usr.maxdefexp])";
						Status.Agi.text      = "[usr.agility]([usr.agilityexp]/[usr.maxagilityexp])";
						Status.Health.text      = "([usr.health]/[usr.maxhealth])";
						Status.Chakra.text      = "([usr.chakra]/[usr.maxchakra])";
						Status.statpoints.text      = "[usr.statpoints] -- [usr.skillpoints]";
					"})
		RefreshStats()
			set hidden=1
			winset(usr, null, {"
						Stats.focus      = "true";
						Stats.is-visible      = "true";
						Status.Name.text      = "[usr.name]";
						Status.Level.text      = "[usr.level]";
						Status.EXP.text      = "[usr.exp]/[usr.maxexp]";
						Status.Tai.text      = "[usr.strength]([usr.strengthexp]/[usr.maxstrengthexp])";
						Status.Nin.text      = "[usr.ninjutsu]([usr.ninexp]/[usr.maxninexp])";
						Status.Gen.text      = "[usr.genjutsu]([usr.genexp]/[usr.maxgenexp])";
						Status.Str.text      = "[usr.strength]([usr.strengthexp]/[usr.maxstrengthexp])";
						Status.Def.text      = "[usr.defence]([usr.defexp]/[usr.maxdefexp])";
						Status.Str2.text      = "[usr.strength]([usr.strengthexp]/[usr.maxstrengthexp])";
						Status.Def2.text      = "[usr.defence]([usr.defexp]/[usr.maxdefexp])";
						Status.Agi.text      = "[usr.agility]([usr.agilityexp]/[usr.maxagilityexp])";
						Status.Health.text      = "([usr.health]/[usr.maxhealth])";
						Status.Chakra.text      = "([usr.chakra]/[usr.maxchakra])";
						Status.statpoints.text      = "[usr.statpoints] -- [usr.skillpoints]";
					"})
		StrengthUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			strength++
			src<<output("<font color=yellow>You leveled up Strength!</Font>","actionoutput")
			RefreshStats()
		DefenceUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			defence++
			src<<output("<font color=yellow>You leveled up Defence!</Font>","actionoutput")
			RefreshStats()
		AgilityUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			agility++
			src<<output("<font color=yellow>You leveled up Agility!</Font>","actionoutput")
			RefreshStats()
		HealthUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			maxhealth+=30
			src<<output("<font color=yellow>You leveled up Health!</Font>","actionoutput")
			RefreshStats()
		ChakraUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			maxchakra+=25
			src<<output("<font color=yellow>You leveled up Chakra!</Font>","actionoutput")
			RefreshStats()
mob
	var
		InventoryUp = 0//Variable telling whether your OSI is up, or not
		//AdminUp=0
		KageUp=0
		OptionsUp=0
	verb
		LeaveVillage()
			set hidden=1
			if(village=="Missing-Nin") return
			if(rank=="Missing-Nin") return
			if(skalert("Are you sure you want to leave your village?","Confirmation",list("Yes","No"))=="Yes")
				world<<output("[src.name] has defected from the [src.village] village.","actionoutput")
				if(village=="Akatsuki")
					for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						del(O)
				if(village=="7SM")
					for(var/obj/Inventory/Weaponry/Samehada/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						del(O)
					src.overlays=null
					src.ReAddClothing()
					src.RestoreOverlays()
					src.RemoveAdminVerbs()
				village="Missing-Nin"
				rank="Missing-Nin"
		OptionsPanel()
			set hidden=1
			if(usr.dead==0)
				if(usr.OptionsUp == 0)
					usr.OptionsUp = 1
					//src.UpdateInventory()
					if(getFaction(src.Faction))
						winset(src, null, {"
						Options.FactionTab.is-visible = "true";
					"})
					if(Squad) if(Squad.Leader == ckey) if(Squad.Members.len>=4)
						winset(src, null, {"
						Options.FactionTab.is-visible = "true";
					"})
					winset(src, null, {"
						mainwindow.OptionsChild.is-visible = "true";
					"})
				else
					usr.OptionsUp = 0
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.OptionsChild.is-visible = "false";
					"})
					winset(src, null, {"
						Options.FactionTab.is-visible = "false";
					"})
		KagePanel()
			set hidden=1
			if(usr.dead==0)
				if(usr.KageUp == 0)
					usr.KageUp = 1
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.KageChild.is-visible = "true";
					"})
				else
					usr.KageUp = 0
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.KageChild.is-visible = "false";
					"})
	//	AdminUp()
	//		set hidden=1
	//		if(usr.dead==0)
	//			if(usr.AdminUp == 0)
	//				usr.AdminUp = 1
	//				//src.UpdateInventory()
	//				winset(src, null, {"
	//					mainwindow.AdminChild.is-visible = "true";
	//				"})
	///			else
	//				usr.AdminUp = 0
	//				//src.UpdateInventory()
	//				winset(src, null, {"
	//					mainwindow.AdminChild.is-visible = "false";
	//				"})
		RefreshInventory()
			set hidden=1
			if(!client) return
			winset(src,"Equip.Ryo","text=\"Ryo: [Ryo]\"")
			winset(src,"Equip.Items","text=\"Items: [items]/[maxitems]\"")
			winset(src,"Equip.GridEquip","cells=0x0")
			var/Row = 1
		//	src<<output("Ryo:","Equip.GridEquip:1,1")
		//	src<<output("Items:","Equip.GridEquip:1,2")
		//	src<<output("[src.items]/[src.maxitems]","Equip.GridEquip:2,2")
			src<<output(" ","Equip.GridEquip:1,1")
			for(var/obj/O in src.contents)
				Row++
				src << output(O,"Equip.GridEquip:1,[Row]")
				src << output("[O.suffix]","Equip.GridEquip:2,[Row]")
			sleep(40)
		Inventory()
			set hidden=1
			if(usr.dead==0)
				if(usr.InventoryUp == 0)
					usr.InventoryUp = 1
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.InvenChild.is-visible = "true";
					"})
					winset(usr, "ItemName", "text=\"\"")
					winset(usr, "ItemPic", "image=\"\"")
					usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>","ItemInfo")
					RefreshInventory()
				else
					if(usr.InventoryUp)
						winset(usr, "ItemName", "text=\"\"")
						winset(usr, "ItemPic", "image=\"\"")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>","ItemInfo")
						winset(src, null, {"
							mainwindow.InvenChild.is-visible = "false";
						"})
						usr.InventoryUp = 0
mob/var/tmp/checkcuss
proc
	symbol(length as num)
		var/T
		for(var/i = 0,i < length,i++)
			T += "*"
			//T += pick("!","@","#","$","%","^","&","*")
		return T
mob
	proc
		filter(msg as text)
			var/txt = lowertext(msg)
			var/a
			var/out
			for(var/cuss in Badwords)
				if(findtext(txt,"[cuss]"))
					for(var/i = 1, i <= length(txt))
						a = copytext(msg, i , i+length(cuss))
						if(lowertext(a) == "[cuss]")
							a = symbol(length(cuss))
							i+= length(cuss)
							out += "[a]"
							usr.checkcuss = 1
						else
							out += copytext(msg, i, i+1)
							i ++
					msg = out
					txt = lowertext(msg)
					out = ""
			return msg
mob
	proc
		showtarget()
			if(!src)return
			if(!target_mob)
				winset(src, null, {"
							target.is-visible="false";
						"})
				return
			winset(src, null, {"
							target.is-visible="true";
							target.hpp.text="[target_mob.health*100/target_mob.maxhealth]";
							target.tlvll.text="[target_mob.level]";
							target.ttname.text="[target_mob.name]";
						"})
			sleep(60)
			src.showtarget()
proc
	Filter(msg as text)
		var/txt = lowertext(msg)
		var/a
		var/out
		for(var/cuss in Badwords)
			if(findtext(txt,"[cuss]"))
				for(var/i = 1, i <= length(txt))
					a = copytext(msg, i , i+length(cuss))
					if(lowertext(a) == "[cuss]")
						a = symbol(length(cuss))
						i+= length(cuss)
						out += "[a]"
					else
						out += copytext(msg, i, i+1)
						i ++
				msg = out
				txt = lowertext(msg)
				out = ""
		return msg
mob/player
	var/tmp/ExpLockDelay=0
	verb
		ExpLock()
			set hidden=1
			if(ExpLockDelay)return
			if(src.ExpLock)
				src.ExpLockDelay=1
				var/Num=rand(1,9999)
				src<<"<u>Verification Number:</u> [Num]."
				var/LOCK=input("Enter the correct number shown to unlock your EXP Gain.","Unlock EXP Gain")as num
				if(Num==LOCK)
					src<<"Your Exp Lock was removed!"
					src.ExpLock=0
					ExpLockDelay=0
					return
				else
					src<<"You did not enter the right verification code!"
					ExpLockDelay=0
			else
				src<<"You are not EXP Locked!"
				return
		say(msg as text)
			set hidden=1
			switch(village)
				if("Hidden Sand")
					namecolor="#f4a460"
				if("Hidden Leaf")
					namecolor="green"
				if("Missing-Nin")
					namecolor="white"
				if("Akatsuki")
					namecolor="#dc143c"
				if("7SM")
					namecolor="#0000ff"
			var/lengtext = lentext(msg)
			SayUp=0
			winset(src, null, {"
				SayBoxChild.focus      = "false";
				SayBoxChild.is-visible      = "false";
			"})
			winset(src, null, {"
				MainWindow.Maplink.focus      = "true";
			"})
			if(Muted) return
			if(lengtext>300) return
			if(lengtext > 10 && !usr.admin)
				var/caps = 0
				for(var/i=1 to lengtext)
					var/l = text2ascii(msg,i)
					if(l > 64 && l < 93) caps ++
					if(l==32||l==255) lengtext --
				var/percent = 20
				switch(lengtext)
					if(0 to 3)percent = 100
					if(4 to 7)percent = 80
					if(8 to 11)percent = 60
					if(12 to 15)percent = 30
				if((100 * (caps / lengtext)) > percent)msg = lowertext(msg)
			if(findtext(msg,lowertext("/World"))==1)
				usr.WorldAddy()
				return
		//	if(findtext(msg,"/NameColor")==1)
		//		usr.ChangeNameColor()
		//		return
		//	if(findtext(msg,"/ChatColor")==1)
		//		usr.ChangeTextColor()
		//		return
			if(findtext(msg,lowertext("/Mute"))==1)
				usr.Vote_Mute()
				return
			if(findtext(msg,lowertext("/Help"))==1)
				usr.Help()
				return
			if(findtext(msg,lowertext("/Stuck"))==1)
				if(usr.xplock==1)
					usr<<"You can't do that now..."
					return
				usr.Stuck()
				return
			if(!usr.likeaclone)
				if(msg)
					if(Channel=="Say")
						if(usr.admin) view(usr)<<"<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else view(usr)<<("<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="World")
						if(usr.admin)
							world<<"<font color=red>World-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else
							world<<filter("<font color=red>World-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Squad")
						if(!Squad) return
						for(var/i in Squad.Members)
							var/mob/M=getOwner(i)
							if(!M) continue
							if(usr.admin) M<<"<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
							else M<<filter("<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
						var/mob/player/Leader=getOwner(Squad.Leader)
						if(usr.admin) Leader<<"<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else Leader<<filter("<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Village")
						for(var/mob/player/M in world) if(M.village==src.village||M.admin)
							if(usr.admin) M<<"<font color=yellow>[src.village]-[src.rank]-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
							else M<<filter("<font color=yellow>[src.village]-[src.rank]-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Faction")
						var/Faction/faction=getFaction(src.Faction)
						if(!faction) return
						for(var/mob/player/p in world)
							var/t
							if(getFaction(p.Faction) == getFaction(src.Faction)) t=1
							if(p.admin || t)
								p << filter("<font color = [faction.color]><b>[faction.name]-</b></font><font color=[usr.namecolor]>([usr.name]):</Font><font color=[usr.chatcolor]> [html_encode(msg)]</font>")
					if(Channel=="Whisper")
						var/Quotation=findtext(msg,"-",2)
						if(!Quotation) return
						var/Person=copytext(msg,2,Quotation)
						var/Message=copytext(msg,Quotation)
						var/mob/t
						for(var/mob/player/M in world)if(Person==M.name)t=M
						if(t)
							src<<"<b><u>You whisper:</u></b> [Message]"
							t<<"<b><u>[src] whispers:</u></b> [Message]"
						else
							src<<"Unable to find: [Person]"
							return
			else
				if(msg&&Channel=="Say")
					var/mob/SC = usr.likeaclone
					if(usr.admin) view(SC)<<"<b><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
					else view(SC)<<filter("<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
mob
	proc
		Help()
			src<<"/Stuck -- Will teleport you out of the area after 20 seconds."
			src<<"/World -- Shows the current servers IP address."
			src<<"/Mute -- Vote to mute a player."
		//	src<<"/Boot -- Vote to boot a player."
			src<<"Options->Arena Challenge -- Challenge a player."
			src<<"Options->Who's Online -- Check who is online."
			src<<"/Help -- View all commands."
	//	ChangeNameColor()
	//		namecolor = input("What color will your name be?") as null|color
	//	ChangeTextColor()
	//		chatcolor=input("What color will your chat text be?") as null|color
		Stuck()

			if(Tutorial!=6)
				src<<"You still didn't finish tutorial so your getting teleported at the beggining..."
				src.loc=locate(40,158,14)
				return
			src<<"You are about to be teleported out of the area. Please do not move or touch any buttons for 20 seconds"
			sleep(200)
			if(src.client.inactivity >= 200)
				src.loc = MapLoadSpawn()
				src.move=1
				src.injutsu=0
				src.canattack=1
				src.firing=0
			else src<<"Results show that you have moved or touched a button within the last 20 seconds."
	var/accepted
var/arenaprogress=0
mob
	verb
		Challange()
			set hidden = 1
			if(arenaprogress==1)
				usr<<"Arena fight is already in progress!"
				return
			var/mob/M=input("Pick your opponent") as mob in world
			if(M.key==usr.key)
				usr<<"You can't challenge yourself!"
				return
			if(!M.key)
				return
			if(M.jailed==1)
				usr<<"He is jailed"
				return
			Accept(M)
mob
	proc
		Accept(mob/M)
			if(M.skalert("Fight [src]?","Duel",list("Yes","No")) == "Yes")
				src.opponent=M
				M.opponent=src
				M.loc=locate(141,157,20)
				src.loc=locate(164,157,20)
				world<<"[M] accepts challange from [src]!"
				src.dueling=1
				M.dueling=1
				arenaprogress=1
			else
				world<<"[M] declines the challange from [src]..."

mob
	verb
		Who()
			set hidden = 1
			var/amount=0
			var/Who={"<html><center>
	<head><title>Who's Online</title><body>
	<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
	</body><html>"}
			for(var/mob/player/M) if(M.client) amount+=1
			for(var/mob/player/M) if(M.client) Who+={"<html><center>
	<head><title>Staff Who</title><body>
	<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
	<br><font color=white>[M.name] ([M.key])
	</body><html>"}
			Who+={"<html>
	<head><title></head></title><body>
	<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color=blue><b>
	<br><u>[amount] player(s) online</u>
	</body><html>"}
			src<<browse(Who,"window=Who;size=400x400")
			Who={"<html><center>
	<head><title>Staff Who</title><body>
	<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
	</body><html>"}