mob/var/Bounty
proc/BountyText(number)
	if(number<50)return "D Rank"
	if(number<200&&number>50)return "C Rank"
	if(number<400&&number>200)return "B Rank"
	if(number<1000&&number>400)return "A Rank"
	if(number>1000)return "S Rank"
	return "Unknown Rank"
mob/verb/BingoBook()
	set hidden=1
	set category="Commands"
	var/People=0
	var/HTML="<body bgcolor=black><font color=white><center><b>Bingo Book</i><br><i>(Currently Wanted Online Shinobi)</i></center><br><hr><br>"
	for(var/mob/player/M in world)
		if(M.key&&M.client&&M.Bounty)
			People=1
			HTML+="<center><font color=white>[M.name] ([M.key]) : [BountyText(M.kills)] ($[M.Bounty])</font></center>"
	if(!People) HTML+="<center><font color=white>There is nobody wanted online.</font></center>"
	src<<browse(HTML)
	winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})