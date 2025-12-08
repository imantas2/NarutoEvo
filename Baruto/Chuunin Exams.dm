var/tmp/ChuuninExam=0
var/tmp/list/Chuunins=list()
var/tmp/mob/ChuuninOpponentOne
var/tmp/mob/ChuuninOpponentTwo
var/tmp/mob/ChuuninDuelWinner
var/tmp/mob/ChuuninDuelLoser
obj/Special/ChuuninExam
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	var/list/Questions=list("Morning Peacock is a strength technique"="True","Eight Trigrams 64 Palms requires no reaction commands"="False",
"The fastest way for new players to train is by kicking logs"="False","Ash Pile Burning is triggered with the down arrow"="True","Body Flicker Technique requires a target"="False",
"Rasengan is a thunder element technique"="False","Sensatsu Suishou is an ice element technique"="True",
"Akatsuki are bounty hunters"="False","Heavenly Spin requires Byakugan"="True","Sickle Weasel Slash is an earth element technique"="False","Gentle Fist can disable chakra points"="True",
"Bone Sensation only works if there is a Bone Bullet lodged in your enemy"="True","Multiple Shadow Clone Jutsu creates clones that can attack"="True","Rasengan requires you to press arrow keys in a triangular pattern."="False",
"The skill tree is divided in non-clan, elemental, and clan jutsus"="True","Tsukiyomi is utilized by the Nara clan"="False","Susano'o is an Uchiha clan technique"="True",
"Naruto: Evolution was once called Naruto: Ninja Way"="False","Shark Water Projectile creates three shark like jets of water."="True","Players will lose 10% of the experience points for killing a fellow villager."="True",
"The level requirement for the Genin Exams is 10."="False","The techniques utilized by \"Deidara\" in the series, are the Earth element in the game."="True",
"B rank missions are assigned to Chuunin level shinobi."="True","An A rank mission may send you against enemy villagers."="True","The resting graphic will change according to your player's maximum chakra levels."="True")
	Click()
		if(get_dist(src,usr)>1) return
		var/QuestionNum
		var/CorrectAnswer=0
		var/InUse
		var/list/NewQuestions=Questions.Copy()
		if(usr.village=="Missing-Nin")usr<<output("You are a missing shinobi.","actionoutput")
		if(usr.rank!="Genin")
			usr<<output("You are not a Genin.","actionoutput")
			return
		if(ChuuninExam!="Written")
			usr<<output("The Chuunin examination has not begun, do not start too early.","actionoutput")
			return
		if(usr.level<=10)
			usr<<output("You are under level'ed. To achive Chuunin rank, you need to be at least level 10.","actionoutput")
			return
		if(InUse)
			usr<<output("Someone is already writing the exam here!","actionoutput")
			return
		if(usr.RecentVerbsCheck("Chuunin Test",6000,1)) return
		usr.RecentVerbs["Chuunin Test"]=world.timeofday
		InUse=1
		//usr.cheww=1/////////DELETE THIS ONCE DONE TESTINGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
		if(usr.level<15)
			while(QuestionNum<25)
				sleep(1)
				if(ChuuninExam!="Written")
					usr<<output("You have ran out of time!","actionoutput")
					InUse=0
					CorrectAnswer=0
					QuestionNum=0
					return
				var/Question=pick(NewQuestions)
				NewQuestions-=Question
				QuestionNum++
				if(usr.skalert("Question #[QuestionNum]: [Question]","Question [QuestionNum]",list("True","False"))=="[Questions[Question]]")
					CorrectAnswer++
		else
			usr << output("You don't have to take the written exam at your level.","actionoutput")
			usr<<output("You have completed the test, please wait for the result.","actionoutput")
			CorrectAnswer=25
			usr.cheww=1
		if(CorrectAnswer>=17)
			usr<<output("You passed the test with [CorrectAnswer]/25 questions correct! You will now be taken to the Forest of Death.","actionoutput")
			usr.cheww=1
		else usr<<output("You failed the test with [CorrectAnswer]/25 questions correct.","actionoutput")
		while(ChuuninExam!="Forest of Death")sleep(10)
		InUse=0
		CorrectAnswer=0
		QuestionNum=0
mob/var/cheww=0
proc/ChuuninExam()
	sleep(600*60)
	ChuuninExam="Starting"
	world<<output("<b><center>A Chuunin exam is about to begin.</b></center>","actionoutput")
	sleep(600*6)
	world<<output("<b><center>The written portion of the Chuunin exam has begun!</b></center>","actionoutput")
	ChuuninExam="Written"
	sleep(600*5)
	world<<output("<b><center>The written portion of the Chuunin exam has ended!</b></center>","actionoutput")
	ChuuninExam="Forest of Death"
	var/count=0
	for(var/mob/player/M in world)
		if(M.cheww==1)
			M.cheww=0
			M.loc = pick(block(locate(73,97,4),locate(198,161,4)))
			if(count==0)
				var/obj/O = new/obj/ChuuninExam/Scrolls/EarthScroll
				O.loc = M
				count=1
			else
				var/obj/O = new/obj/ChuuninExam/Scrolls/HeavenScroll
				O.loc = M
				count=0
	sleep(600*6)
	world<<output("<b><center>The second part of the Chuunin exam is now over!</b></center>","actionoutput")
	ChuuninExam="Tournament"
	ChuuninExamGo()
proc/ChuuninExamGo()
	//Remember to add a check for people here to see if they were in the FoD when it ended. Proper teleportation.
	for(var/mob/player/M in world)
		if(M.loc in block(locate(71,95,4),locate(200,163,4))) // If they are in FoD
			M.loc=M.MapLoadSpawn() // Remember to change depending on villages!
			for(var/obj/ChuuninExam/Scrolls/S in M)	del(S)
	for(var/mob/player/M in world)
		if(M.loc in block(locate(113,29,4),locate(146,58,4))) // If they are in tournament zone
			Chuunins+=M
			for(var/obj/ChuuninExam/Scrolls/S in M)del(S)
	if(Chuunins.len<2)
		for(var/mob/player/M in Chuunins)
			M.rank="Chuunin"
			world<<output("<i>[M.name] is now a Chuunin.</i>","actionoutput")
			if(M.village=="Hidden Leaf") new/obj/Inventory/Clothing/Vests/ChuninVest(M)
			if(M.village=="Hidden Sand") new/obj/Inventory/Clothing/Vests/SandChuninVest(M)
			if(M.village=="Hidden Sound") new/obj/Inventory/Clothing/Vests/SoundVest(M)
			if(M.village=="Hidden Mist") new/obj/Inventory/Clothing/Vests/MistVest(M)
			if(M.village=="Hidden Rock") new/obj/Inventory/Clothing/Vests/RockVest(M)
			M.loc=M.MapLoadSpawn() // Remember to change depending on villages!
		world<<output("<b><center>The Chuunin exam is now over!</b></center>","actionoutput")
		ChuuninExam=0
		ChuuninDuelWinner=null
		ChuuninDuelLoser=null
		ChuuninOpponentOne=null
		ChuuninOpponentTwo=null
		Chuunins=list()
		return
	world<<output("<b><center>The tournament portion of the Chuunin exam has begun!</b></center>","actionoutput")
	while(Chuunins.len)
		if(Chuunins.len<2)
			for(var/mob/player/M in Chuunins)
				M.rank="Chuunin"
				world<<output("<i>[M.name] is now a Chuunin.</i>","actionoutput")
				if(M.village=="Hidden Leaf") new/obj/Inventory/Clothing/Vests/ChuninVest(M)
				if(M.village=="Hidden Sand") new/obj/Inventory/Clothing/Vests/SandChuninVest(M)
				if(M.village=="Hidden Sound") new/obj/Inventory/Clothing/Vests/SoundVest(M)
				if(M.village=="Hidden Mist") new/obj/Inventory/Clothing/Vests/MistVest(M)
				if(M.village=="Hidden Rock") new/obj/Inventory/Clothing/Vests/RockVest(M)
				M.loc=M.MapLoadSpawn()//Teleportation here.
			world<<output("<b><center>The Chuunin exam is now over!</b></center>","actionoutput")
			//for(var/mob/Player/M in world)
				//Teleportation redundancy check here!
			ChuuninExam=0
			ChuuninDuelWinner=null
			ChuuninDuelLoser=null
			ChuuninOpponentOne=null
			ChuuninOpponentTwo=null
			Chuunins=list()
			return
		ChuuninOpponentOne=pick(Chuunins)
		ChuuninOpponentTwo=pick(Chuunins-ChuuninOpponentOne)
		ChuuninOpponentTwo.loc=locate(126,35,4)
		ChuuninOpponentOne.loc=locate(126,50,4)
		world<<output("<i><center>Match Beginning: [ChuuninOpponentOne] vs. [ChuuninOpponentTwo].</center></i>","actionoutput")
		for(var/obj/ChuuninExam/Barrier/O in world)O.invisibility=0 // Barriers up!
		var/timer=5
		while(timer)
			for(var/mob/player/M in Chuunins)M<<output("[timer]","actionoutput")
			ChuuninOpponentOne.move=0
			ChuuninOpponentTwo.move=0
			timer--
			sleep(10)
		for(var/mob/player/M in Chuunins)M<<output("GO!","actionoutput")
		ChuuninOpponentOne.move=1
		ChuuninOpponentTwo.move=1
		while(!ChuuninDuelWinner&&ChuuninOpponentOne&&ChuuninOpponentTwo)sleep(10)
		world<<output("<i><center>[ChuuninDuelWinner] has defeated [ChuuninDuelLoser] in the chuunin exams.</center></i>","actionoutput")
		world<<output("<i>[ChuuninDuelWinner.name] is now a Chuunin.</i>","actionoutput")
		if(ChuuninDuelWinner.village=="Hidden Leaf") new/obj/Inventory/Clothing/Vests/ChuninVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Sand") new/obj/Inventory/Clothing/Vests/SandChuninVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Sound") new/obj/Inventory/Clothing/Vests/SoundVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Mist") new/obj/Inventory/Clothing/Vests/MistVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Rock") new/obj/Inventory/Clothing/Vests/RockVest(ChuuninDuelWinner)
		ChuuninDuelWinner.rank="Chuunin"
		ChuuninDuelWinner.loc=ChuuninDuelWinner.MapLoadSpawn()
		ChuuninDuelLoser.loc=ChuuninDuelLoser.MapLoadSpawn()
		Chuunins-=ChuuninDuelWinner
		Chuunins-=ChuuninDuelLoser
		ChuuninDuelWinner=null
		ChuuninDuelLoser=null
		ChuuninOpponentOne=null
		ChuuninOpponentTwo=null
		for(var/obj/ChuuninExam/Barrier/O in world)O.invisibility=99 // Barriers down!
		continue
	//for(var/mob/Player/M in world)
		//Redundancy check here (teleportation).
	world<<output("<b><center>The Chuunin exam is now over!</b></center>","actionoutput")
	ChuuninExam=0
	ChuuninDuelWinner=null
	ChuuninDuelLoser=null
	ChuuninOpponentOne=null
	ChuuninOpponentTwo=null
	Chuunins=list()
obj/ChuuninExam/
	//icon='ChuuninStuff.dmi' ICONZ GO HERE.
	Barrier
		icon_state="Barrier"
		invisibility=99
		density=1
	Scrolls
		layer=MOB_LAYER+1
		EarthScroll
			name="Earth Scroll"
			icon = 'chewninz.dmi'
			icon_state="Earth"
		HeavenScroll
			name="Heaven Scroll"
			icon = 'chewninz.dmi'
			icon_state="Heaven"
		Click()
			if(!ChuuninExam)
				usr<<output("You shouldn't pick this up.","actionoutput")
				return
			for(var/obj/ChuuninExam/Scrolls/Y in usr)
				if(Y.type==src.type)
					usr<<output("You already have one of these.","actionoutput")
					return
			if(usr.dead) return
			hearers()<<output("[usr] picks up [src].","actionoutput")
			Move(usr)
			var/EarthScroll
			var/HeavenScroll
			for(var/obj/ChuuninExam/Scrolls/O in usr)
				if(istype(O,/obj/ChuuninExam/Scrolls/EarthScroll))EarthScroll=1
				if(istype(O,/obj/ChuuninExam/Scrolls/HeavenScroll))HeavenScroll=1
			if(EarthScroll&&HeavenScroll)
				usr<<output("If you manage to hold on to both of these scrolls for 25 more seconds you will be teleported to the next area.","actionoutput")
				hearers() << output("[usr] has aquirred both scrolls.","actionoutput")
				sleep(250)
				var/EarthScroll1
				var/HeavenScroll1
				for(var/obj/ChuuninExam/Scrolls/X in usr)
					if(istype(X,/obj/ChuuninExam/Scrolls/EarthScroll))EarthScroll1=1
					if(istype(X,/obj/ChuuninExam/Scrolls/HeavenScroll))HeavenScroll1=1
				if(HeavenScroll1&&EarthScroll1)
					if(prob(50)) usr.loc=locate(144,44,4)
					else usr.loc=locate(115,44,4)
					world<<output("<i>[usr] has made it past the first portion of the Chuunin exam!</i>","actionoutput")
					usr<<output("Do not start killing. This is a tournament match.","actionoutput")
					for(var/obj/ChuuninExam/Scrolls/S in usr)del(S)
			return