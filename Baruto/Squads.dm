proc/getOwner(ckey)
	if(!ckey) return
	for(var/mob/player/p in world)if(p.ckey == ckey)return p
obj/Squad
	name = "(Click for Settings)"
	var/tmp/
		Leader // ckey Oriented
		ID
		list/Members =  list() //ckey Oriented
	proc/Menu()
		if(usr.ckey != Leader)
			var/setting = usr.skinput("Select an option","Squad",list("View Squad","Leave Squad", "Cancel"))
			switch(setting)
				if("Cancel") return
				if("View Squad")
					var/html={"
<head>
<title>[getOwner(Leader)]'s Squad</title>
<FONT SIZE="7"><b><u>[getOwner(Leader)]'s Squad</u></b></FONT>
<BODY BGCOLOR="#996633"><hr><br>"}
					var/mob/player/leader=getOwner(Leader)
					html+="[leader.name]  -  Health: [leader.health]/[leader.maxhealth] - Chakra: [leader.chakra]/[leader.maxchakra] - Level: [leader.level] ([(leader.exp/leader.maxexp)*100])<br><br>"
					for(var/ckey in Members)
						var/mob/player/p=getOwner(ckey)
						html+="[p.name]  -  Health: [p.health]/[p.maxhealth] - Chakra: [p.chakra]/[p.maxchakra] - Level: [p.level] ([round((p.exp/p.maxexp)*100)]%)<br><br>"
					usr << browse(html)
					winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
				if("Leave Squad")
					Members -= usr.ckey
					usr.Squad = null
					usr.Channel="Say"
					for(var/i in Members)
						var/mob/M=getOwner(i)
						M<<output("[usr] has left your squad","actionoutput")
					var/mob/L=getOwner(Leader)
					L<<output("[usr] has left your squad","actionoutput")
			return
		var/setting = usr.skinput("Select an option","Squad",list("View Squad","Invite Member", "Remove Member","Leave Squad", "Cancel"))
		switch(setting)
			if("View Squad")
				var/html={"
<head>
<title>[getOwner(Leader)]'s Squad</title>
<FONT SIZE="7"><b><u>[getOwner(Leader)]'s Squad</u></b></FONT>
<BODY BGCOLOR="#996633"><hr><br>"}
				var/mob/player/leader=getOwner(Leader)
				html+="[leader.name]  -  Health: [leader.health]/[leader.maxhealth] - Chakra: [leader.chakra]/[leader.maxchakra] - Level: [leader.level] ([(leader.exp/leader.maxexp)*100])<br><br>"
				for(var/ckey in Members)
					var/mob/player/p=getOwner(ckey)
					html+="[p.name]  -  Health: [p.health]/[p.maxhealth] - Chakra: [p.chakra]/[p.maxchakra] - Level: [p.level] ([(p.exp/p.maxexp)*100])<br><br>"
				usr << browse(html)
				winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
			if("Invite Member")
				if(length(Members) >= 4) //Checks to make sure there aren't already 4 memebers
					usr<<output("You already have a total of 4 members in your squad, including yourself. If you wish to add another, remove one first.","actionoutput")
				else
					var/list/Players = list()
					for(var/mob/player/P in view()) Players += P
					var/mob/player/M = input("Invite Who?") as mob in Players
					if(Members.Find(M.ckey) || M.ckey == Leader)
						usr<<output("[M] is already in the Squad","actionoutput")
						return
					if(alert(M,"[usr] wants you to join their Squad. Join?","Squad","Yes","No") == "Yes")
						if(length(Members) >= 5) return
						if(Members.Find(M.ckey) || M.ckey == Leader)
							usr<<output("[M] is already in the Squad","actionoutput")//oke, imma compile, as soon as its done, updatekk lea
							return
						Members += M.ckey
						M.Squad = src
						usr<<output("[M] is now a part of your Squad.","actionoutput")
						M<<output("You are now a part of [usr]'s Squad.","actionoutput")
			if("Remove Member")
				var/list/Players = list()
				for(var/i in Members)
					if(getOwner(i))
						var/mob/player/M = getOwner(i)
						Players["[M.name]/[M.ckey]"] = M
					else Players += i
				Players += "Cancel"
				var/choice = input("Remove who?") in Players
				if(choice == "Cancel") return
				if(Players[choice])
					var/mob/player/M = Players[choice]
					Members -= M.ckey
					M.Squad = null
					M.Channel="Say"
				else
					Members -= choice
				usr<<output("[choice] has been removed","actionoutput")
			if("Leave Squad")
				if(alert("Are you sure?","Disband Squad","Yes","No") == "Yes")
					if(usr.ckey != Leader) return
					usr.Squad = null // The previous Leader no long has control over this.
					Members -= Leader // The leader's key isn't stored in the member list.
					if(!length(Members)) del src // Del the Squad if no one is left to take over.
					Leader = pick(Members) //It picks a new Leader from the current members
					usr.Channel="Say"
mob/
	var/tmp/
		obj/Squad/Squad
mob/verb/
	SquadMenu()
		set hidden=1
		if(!Squad)
			if(skalert("Would you like to create a squad?","Creation",list("Yes","No"))=="Yes")
				Create_Squad()
			return
		usr.Squad.Menu()
	FactionMenu()
		set hidden=1
		if(!getFaction(src.Faction)&&Squad&&!Faction)
			if(Squad.Members.len>=4&&Squad.Leader==ckey)
				if(skalert("You have the ability to create a Faction. You have five members in your party. It costs 3000 Ryo to create, continue?","Creation",list("Create","Cancel"))=="Create")
					Create_Faction()
			else
				src<<"You need five members in your party, including yourself, and be the leader of your party to form a faction."
			return
		if(!usr.KageUp)
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
	Create_Squad()
		set hidden=1
		set category = "Commands"
		var/obj/Squad/P = new
		usr.Squad = P
		P.Leader = usr.ckey
		P.ID = "[rand(100,999)][rand(100,999)][rand(100,999)]"

