var
	list/Mute_Elects=new/list()
	VoteM
	list/VotedYes=list()
	list/VotedNo=list()
	NonVoters

var/Votations=1
var/VotationGoingOn=0
mob/var/Accept_Votes=1
mob/var/CreatedAVotation=0
mob/proc/Vote_Check()
	..()
	for(var/mob/M in world)
		spawn()if(M.client&&M.Accept_Votes==0)
			N+=1
		spawn()if(M.client&&M.Accept_Votes==1)
			var/mob/X = input(M, "[VoteMessage]","Voting System") in list("No", "Yes")
			if(X=="Yes")
				if(VoteMessage=="")
					M<<output("<b><font color=red><center>* You were too late! *","actionoutput")
					return
				Y+=1
				for(var/mob/C in world)
					C<<output("<b><font color=red>* [M.key] voted yes.","actionoutput")
			if(X=="No")
				if(VoteMessage=="")
					M<<output("<b><font color=red><center>* You were too late! *","actionoutput")
					return
				N+=1
				for(var/mob/C in world)
					C<<output("<b><font color=red>* [M.key] voted no.","actionoutput")
proc/Vote_Election()
	spawn(150)
		if(VoteMessage == null)
			Y=0
			N=0
			VoteMessage=""
			spawn(300)VotationGoingOn=0
			return
		world<<output("<b><font color=yellow><center><font size=2>! VOTATION !","actionoutput")
		world<<output("<b><font color=white><center> [VoteMessage] ","actionoutput")
		world<<output("<b><font color=blue><center>- [Y] Players Voted Yes.","actionoutput")
		world<<output("<b><font color=blue><center>- [N] Players Voted No.","actionoutput")
		if(Y>N)world<<output("<b><font size=2><font color=yellow><center>It's Been Approved!","actionoutput")
		if(N>Y)world<<output("<b><font size=2><font color=yellow><center>It's Been Denied!","actionoutput")
		if(N==Y)world<<output("<b><font color=yellow><font size=2><center>There Was Tie!","actionoutput")
		Y=0
		N=0
		VoteMessage=""
		spawn(300)VotationGoingOn=0
var/VoteMessage
var/Y=0
var/N=0

mob/var/MuteTime
mob/verb/
	Vote_Mute()
		set hidden =1
		if(src.RecentVerbsCheck("VoteCoolDown",12000,0))
			src<<output("You can only do a mute vote once every 20 minutes.","actionoutput")
			return
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to call a Mute Vote against?","Mute",X+"Cancel")
		if(P=="Cancel") return
		var/mob/p = X["[P]"]
		Mute_Elects+=p
		var/count=0
		for(var/mob/MV in Mute_Elects) if(MV == p) count++
		if(count>=1 && !VoteM) // This way there needs to be two votes to mute initially.
			src.RecentVerbs["VoteCoolDown"]=world.timeofday
			VoteM=p.name
			for(var/mob/player/M in world)if(M.ckey)NonVoters++
			world<<"[src] has elected to Mute [p]. Vote: <a href=?src=\ref[src];action=VoteYes>Yes</a>, or <a href=?src=\ref[src];action=VoteNo>No</a>."
			spawn()Vote(p)
		else
			if(VoteM)
				src<<"There is already a vote going on for [VoteM]. Vote: <a href=?src=\ref[src];action=VoteYes>Yes</a>, or <a href=?src=\ref[src];action=VoteNo>No</a>.</font>"
				for(var/mob/player/M in world)if(M.ckey)NonVoters++
				NonVoters=(NonVoters/2)
			if(src.RecentVerbsCheck("VoteCoolDown",12000,1))src<<output("You can only do a mute vote once every 20 minutes.","actionoutput")
proc/Vote(mob/Who)
	var/TimeLeft=1200
	while(TimeLeft&&!Who.MuteTime)
		sleep(1)
		TimeLeft--
		if(VotedYes.len>VotedNo.len&&VotedYes.len>NonVoters)
			world<<"Vote passed, [Who] has been muted for 10 minutes."
			Who.Muted=1
			Who.MuteTime=(600*10)
			Who.Muted()
			VotedYes=list()
			VotedNo=list()
			VoteM=null
			Mute_Elects=list()
			NonVoters=0
			return
	if(VotedNo.len>VotedYes.len)
		world<<"Vote failed, [Who] has not been muted."
		VotedYes=list()
		VotedNo=list()
		VoteM=null
		Mute_Elects=list()
		NonVoters=0
		return
	world<<"Time limit has passed, [Who] has not been muted."
	NonVoters=0
	VotedYes=list()
	VotedNo=list()
	VoteM=null
	Mute_Elects=list()
mob/proc/Muted()
	set background = 1
	while(src&&src.Muted)
		sleep(1)
		if(MuteTime > 0)
			MuteTime --
			winset(src, null, {"
							MuteTime.is-visible      = "true";
							MuteTime.text='Minutes Left: [round(MuteTime/600)]'")
						"})
		else
			Muted = 0
			MuteTime = 0
			world<<"[src.name] has been unmuted."
			winset(src, null, {"
							MuteTime.is-visible      = "false";
							MuteTime.text=''")
						"})
	..()
atom/Topic(href,href_list[])
	switch(href_list["action"])
		if("VoteYes")
			if(VoteM&&!VotedYes.Find(usr.ckey)&&!VotedNo.Find(usr.ckey))
				usr<<"Thank you, your vote has been recieved."
				VotedYes+=usr.ckey
				world<<"Mute Vote is now [VotedYes.len] Yes - [VotedNo.len+NonVoters] No"
				NonVoters--
		if("VoteNo")
			if(VoteM&&!VotedNo.Find(usr.ckey)&&!VotedYes.Find(usr.ckey))
				usr<<"Thank you, your vote has been recieved."
				VotedNo+=usr.ckey
				world<<"Mute Vote is now [VotedYes.len] Yes - [VotedNo.len+NonVoters] No"
				NonVoters--
		if("VoteYesBoot")
			if(VoteB&&!VotedYesB.Find(usr.ckey)&&!VotedNoB.Find(usr.ckey))
				usr<<"Thank you, your vote has been recieved."
				VotedYesB+=usr.ckey
				world<<"Boot Vote is now [VotedYesB.len] Yes - [VotedNoB.len+NonVotersB] No"
				NonVotersB--
		if("VoteNoBoot")
			if(VoteB&&!VotedNoB.Find(usr.ckey)&&!VotedYesB.Find(usr.ckey))
				usr<<"Thank you, your vote has been recieved."
				VotedNoB+=usr.ckey
				world<<"Mute Vote is now [VotedYesB.len] Yes - [VotedNoB.len+NonVotersB] No"
				NonVotersB--
	..()
var
	list/BootedList=list()
	list/Boot_Elects=new/list()
	VoteB
	list/VotedYesB=list()
	list/VotedNoB=list()
	NonVotersB
/*
proc/UnbanBoot(var/Who)
	sleep(600*15)
	BootedList-=Who
	crban_unban(Who)
mob/verb/
	Vote_Boot()
		set hidden =1
		if(src.RecentVerbsCheck("VoteCoolDownBoot",12000,0))
			src<<output("You can only do a boot vote once every 20 minutes.","actionoutput")
			return
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to call a Boot Vote against?","Mute",X+"Cancel")
		if(P=="Cancel") return
		var/mob/p = X["[P]"]
		if(p.admin)
			src<<output("You cannot call a vote against this person.","actionoutput")
			return
		Boot_Elects+=p
		var/count=0
		for(var/mob/MV in Boot_Elects) if(MV == p) count++
		if(count>=1 && !VoteB) // This way there needs to be two votes to mute initially.
			src.RecentVerbs["VoteCoolDownBoot"]=world.timeofday
			VoteB=p.name
			for(var/mob/player/M in world)if(M.ckey)NonVotersB++
			world<<"[src] has elected to boot [p]. Vote: <a href=?src=\ref[src];action=VoteYesBoot>Yes</a>, or <a href=?src=\ref[src];action=VoteNoBoot>No</a>."
			spawn()VoteB(p)
		else
			if(VoteB)
				src<<"There is already a vote going on for [VoteB]. Vote: <a href=?src=\ref[src];action=VoteYesBoot>Yes</a>, or <a href=?src=\ref[src];action=VoteNoBoot>No</a>.</font>"
				for(var/mob/player/M in world)if(M.ckey)NonVotersB++
				NonVotersB=(NonVotersB/2)
			if(src.RecentVerbsCheck("VoteCoolDownBoot",12000,1))src<<output("You can only do a mute vote once every 20 minutes.","actionoutput")
proc/VoteB(mob/Who)
	var/TimeLeft=1200
	while(TimeLeft&&!Who.MuteTime)
		sleep(1)
		TimeLeft--
		if(VotedYes.len>VotedNo.len&&VotedYes.len>NonVoters)
			world<<"Vote passed, [Who] has been booted, and will be banned for 15 minutes."
			var/WhoKey=Who.key
			spawn() UnbanBoot(Who.key)
			BootedList+=Who.key
			crban_fullban(WhoKey)
			NonVotersB=0
			VotedYesB=list()
			VotedNoB=list()
			VoteB=null
			Boot_Elects=list()
			return
	if(VotedNo.len>VotedYes.len)
		world<<"Vote failed, [Who] has not been booted."
		NonVotersB=0
		VotedYesB=list()
		VotedNoB=list()
		VoteB=null
		Boot_Elects=list()
		return
	world<<"Time limit has passed, [Who] has not been booted."
	NonVotersB=0
	VotedYesB=list()
	VotedNoB=list()
	VoteB=null
	Boot_Elects=list()*/