var/ServerPassword="BetaServer"
var/serveraddress="byond://76.23.251.36:1202/"
world/Topic(T,Addr)
	if(T=="ping")return ..()
	var/list/topic = params2list(T)
	var/P=topic["Pass"]
	if(P!=ServerPassword)return
	switch(topic["dowhat"])
		if("announcement")
			var/Announcement=topic["msg"]
			world<<"<center><b>---------------------------------</b></center>"
			world<<"<center><br><br><font face=verdana><font color=white>[Announcement]</b></font></center></p></br></b></center>"
			world<<"<center><b>---------------------------------</b></center>"
		if("reboot")world.Reboot(2)
		if("savefile")
			var/savefile/F = topic["savefile"]
			var/LoginID=topic["LoginID"]
			fcopy(F,"Players/[copytext(LoginID,1,2)]/[LoginID].sav")
world/New()
	..()
	spawn(10)
		var/Pingit="byond://[world.internet_address]:[world.port]"
		if(Pingit=="byond://76.23.251.36:1202")
			serveraddress="byond://96.9.134.52:5000"
			servertype="Overflow"
		else if(Pingit=="byond://96.9.134.52:5000")
			serveraddress="byond://76.23.251.36:1202"
			servertype="Official"
//byond://76.23.251.36:1202
//76.23.251.36:4240
proc/SendServerTopic(dowhat, params)
	params["dowhat"] = dowhat
	params["Pass"] = ServerPassword
	return world.Export("[serveraddress]?[list2params(params)]")
mob/Admin/verb
	SetOtherServerAddress()
		set category = "Administrator"
		var/t = input("What would you like to set it as?") as text
		if(!t||!admin)return
		serveraddress=t
	MultiServerAnnounce()
		set category = "Administrator"
		var/t = input("What would you like to send to the world?") as text
		if(!t||!admin)return
		return SendServerTopic("announcement", list("msg" = t))
	/*RebootSecondaryServer()
		set category = "Administrator"
		if(!admin)return
		SendServerTopic("announcement", list("msg" = "World is being remotely rebooted."))
		return SendServerTopic("reboot", list())*/
proc/SendSavefile(var/savefile/F,var/LoginID)
//	return SendServerTopic("savefile", list("save"=F,"LoginID"=LoginID))

