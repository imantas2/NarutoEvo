mob/var/tmp/mob/opponent
mob/var/tmp/dueling
mob/var/tmp/list/barriers=list()
mob/var/tmp/arena
mob/var/tmp/turf/Arena/Starting_Circle/arenaturf
mob/var/tmp/Disabled=0
proc
	EndMatch(mob/A as mob, mob/B as mob)
		A.dueling = null
		B.dueling = null
		A.arena = null
		B.arena = null
		A.opponent = null
		B.opponent = null
		B.verbs -= /turf/Arena/Starting_Circle/proc/End_Match
		A.verbs -= /turf/Arena/Starting_Circle_2/proc/End_Match
		for(var/b in A.barriers)del(b)
		A.barriers = null
		B.barriers = null
		A.arenaturf.duel = ""
		B.arenaturf.duel = ""
obj/Barrier
	icon='Concrete.dmi'
	icon_state="B"
	density=1
	var/list/Stuff=list()
	New()
		..()
		var/obj/BarrierTop/T=new()
		T.loc=locate(x,y+1,z)
		Stuff+=T
	Del()
		for(var/obj/O in Stuff)del(O)
		..()
obj/BarrierTop
	density=1
	icon_state="T"
turf/Arena
	icon='GRND.dmi'
	name="Arena"
	Edge
		icon='GRND.dmi'
		icon_state="Chewnin exam tile"
	Floor
		icon='GRND.dmi'
		icon_state="Chewnin exam tile"
	Starting_Circle
		name = "Arena"
		icon_state="Circle"
		var/duel
		Click()
			if(get_dist(usr,src)>1) return
			if(duel)
				if(!usr.opponent)
					usr << output("There is already an arena match in progress.","actionoutput")
					return
				else
					EndMatch(usr,usr.opponent)
					return
			for(var/turf/Arena/Starting_Circle_2/s2 in view(25,usr))
				s2 = locate(/turf/Arena/Starting_Circle_2)
				for(var/mob/M in s2)usr.opponent = M
				if(!usr.opponent)
					usr << output("You do not have an opponent.","actionoutput")
					return
				if(usr.skalert("Fight [usr.opponent]?","Duel",list("Yes","No")) == "No")
					usr.opponent = null
					return
				if(usr.opponent) usr.opponent.opponent = usr
				if(!duel)
					hearers()<<output("<center><b>Arena match initiating between [usr] and [usr.opponent]</b></center>","actionoutput")
					usr.barriers = new
					usr.opponent.barriers = new
					for(var/turf/Arena/Edge/e in oview(25,usr))
						var/b = new/obj/Barrier(e)
						usr.barriers += b
						usr.opponent.barriers += b
					duel = 1
					usr.dir = WEST
					usr.opponent.dir = EAST
					usr.move = 0
					usr.Disabled=1
					usr.opponent.move =0
					usr.opponent.Disabled=1
					usr.dueling = 1
					usr.opponent.dueling = 1
					usr.arena = src.loc
					usr.arenaturf = src
					usr.opponent.arenaturf = src
					var/turf/list/field = list()
					for(var/turf/Arena/Floor/t in view())if(istype(t))field += t
					for(var/mob/M in usr.arena)
						if(M.dueling) continue
						if(M.loc in field)M.loc=locate(110,90,3)
					usr.opponent.arena = src.loc
					usr.health = usr.maxhealth
					usr.chakra = usr.maxchakra
					usr.opponent.health = usr.opponent.maxhealth
					usr.opponent.chakra = usr.opponent.maxchakra
					sleep(30)
					hearers(15,src)<< output("<center><b>In 5.","actionoutput")
					sleep(10)
					for(var/count=4, count >= 1, count --)
						hearers()<< output("<center><b>[count].","actionoutput")
						sleep(10)
					hearers(15,src)<< output("<center><b>FIGHT!","actionoutput")
					usr.Disabled=0
					usr.move = 1
					usr.opponent.move = 1
					usr.opponent.Disabled=0
					usr.verbs += /turf/Arena/Starting_Circle/proc/End_Match
					usr.opponent.verbs += /turf/Arena/Starting_Circle_2/proc/End_Match
		proc
			End_Match()
				usr.arena << output("[usr] ends the match.","actionoutput")
				EndMatch(usr, usr.opponent)
	Starting_Circle_2
		name = "Arena"
		icon_state="Circle"
		var/turf/Arena/Starting_Circe_2/s1
		proc
			End_Match()
				usr.arena << output("[usr] ends the match.","actionoutput")
				EndMatch(usr, usr.opponent)