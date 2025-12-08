var/GeninTest=0
var/list/genintesters = list()
mob/var/tmp/SealsDoneGenin=0
turf
	geninexamsealstest
proc/GeninExam()
	while(world)
		sleep((600*20)+rand(200,400))
		for(var/mob/player/M in world)M<<output("<center>A Genin exam is about to begin in all Village Academies.</center>","actionoutput")
		sleep(600*3)
		for(var/mob/player/M in world)M<<output("<center>The Genin exam has begun!</center>","actionoutput")
		GeninTest=1
		sleep(600*2)
		for(var/mob/player/M in world)M<<output("<center>The written Genin exam is now over! Handseals testing will begin in one minute for all who passed!</center>","actionoutput")
		GeninTest=0
		sleep(100)
		for(var/mob/M in global.genintesters)M << output("You are to execute 3 of your ninjutsu or genjutsu within thirty seconds.","actionoutput")
		sleep(300)
		for(var/mob/M in global.genintesters)
			if(M.SealsDoneGenin>=3)
				M.SealsDoneGenin=0
				M.givegenin()
				M.loc=M.MapLoadSpawn()
			else M.loc=M.MapLoadSpawn()
		genintesters=list()
		for(var/mob/player/M in world)M<<output("<center>The practical examination for the Genin Exams are now over. Thank you for those that participated!</center>","actionoutput")
mob
	proc/givegenin()
		src<<output("You are now a Genin.","actionoutput")
		src.rank="Genin"
		if(village=="Hidden Leaf")
			new/obj/Inventory/Clothing/HeadWrap/LeafHeadBand(src)
		if(village=="Hidden Sand")
			new/obj/Inventory/Clothing/HeadWrap/SandHeadBand(src)
		if(village=="Hidden Rock")
			new/obj/Inventory/Clothing/HeadWrap/SandHeadBand(src)//they use the same one!
		if(village=="Hidden Sound")
			new/obj/Inventory/Clothing/HeadWrap/SoundHeadBand(src)
		if(village=="Hidden Mist")
			new/obj/Inventory/Clothing/HeadWrap/HeadBand(src)//wait one sec i gotta check something on my pc
obj/Special/GeninExam
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	var/village="Hidden Leaf"
	var/list/Questions=list("Morning Peacock is a strength technique"="True","Eight Trigrams 64 Palms requires no reaction commands"="False",
"The fastest way for new players to train is by kicking logs"="False","Ash Pile Burning is triggered with the down arrow"="True","Body Flicker Technique requires a target"="False",
"Rasengan is a thunder element technique"="False","Sensatsu Suishou is an ice element technique"="True",
"Akatsuki are bounty hunters"="True","Heavenly Spin requires Byakugan"="True","Sickle Weasel Slash is an earth element technique"="False","Gentle Fist can disable chakra points"="True",
"Bone Sensation only works if there is a Bone Bullet lodged in your enemy"="True","Basic Clone Jutsu creates clones that attack"="False")
	Click()
		if(get_dist(src,usr)>1) return
		var/QuestionNum
		var/CorrectAnswer=0
		var/InUse
		var/list/NewQuestions=Questions.Copy()
		if(usr.village!=village)
			usr<<output("You are not apart of this village.","actionoutput")
			return
		if(usr.rank!="Academy Student")
			usr<<output("You are not an Academy Student.","actionoutput")
			return
		if(!GeninTest)
			usr<<output("The Genin Exam has not begun, do not start too early.","actionoutput")
			return
		if(usr.level<5)
			usr<<output("You must be level 5 more higher to write the Genin exam.","actionoutput")
			return
		if(InUse)
			usr<<output("Someone is already writing the exam here!","actionoutput")
			return
		if(usr.RecentVerbsCheck("Genin Test",6000,1)) return
		usr.RecentVerbs["Genin Test"]=world.timeofday
		InUse=1
		while(QuestionNum<10)
			sleep(1)
			if(!GeninTest)
				usr<<output("You have ran out of time!","actionoutput")
				QuestionNum=0
				CorrectAnswer=0
				return
			var/Question=pick(NewQuestions)
			NewQuestions-=Question
			QuestionNum++
			if(usr.skalert("Question #[QuestionNum]: [Question]","Question [QuestionNum]",list("True","False"))=="[Questions[Question]]")
				CorrectAnswer++
		usr<<output("You have completed the test, please wait for the result.","actionoutput")
		while(GeninTest)
			sleep(10)
		if(CorrectAnswer>=7)
			usr<<output("You passed the test with [CorrectAnswer]/10 questions correct! You will now be taken to the handseals testing.","actionoutput")
			usr.loc = locate(/turf/geninexamsealstest)
			global.genintesters+=usr
		else usr<<output("You failed the test with [CorrectAnswer]/10 questions correct.","actionoutput")
		InUse=0
		QuestionNum=0
		CorrectAnswer=0