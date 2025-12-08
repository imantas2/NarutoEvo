/*
//////////////////////////////
//////////////////////////////
/////       Soul Ban     /////
/////        V1.0.4      /////
//////////////////////////////
//////////////////////////////
Alright, so this is my first library,
so feel free to comment about any concerns
you might have on the hub.

Soul Ban is free to use and modify by anyone.
The only conditions I'd request is that you don't
claim to have created anything found within this
library. A mention somewhere in your projects credits
would bethoughtful, but is not required.

V1.0.0
	10/02/2012 - Created the basic ban system. Includes the base project and all Ban/Unban verbs and the Ban Check verb.
V1.0.1
	10/02/2012 - Fixed a small bug that I didn't catch before release that prevented people from being unbanned.
V1.0.2
	*Note* You may need to wipe your ServerBanList savefile to be compatable with this new version.
	10/02/2012 - Made several big changes in the library to make it so that there's only one list and one datum container for all bans.
	10/02/2012 - When checking for bans it will only loop once now rather than once for each ban type.
V1.0.3
	10/10/2012 - Fixed a bug that prevented more bans from being added after the first one.
V1.0.4
	10/10/2012 - Minor code tweaks.
	11/19/2012 - Fixed a few minor bugs that were found.
*/


#define _KeyBan 1
#define _IPBan 2
#define _CompIDBan 3






var/list/Bans/ServerBan/ServerBanList=new/list()//Holds the ban container for each player ban.
var/list/BanProtection=list("Imantas2")//Anyone in this list CANNOT be banned within the server.
var/SoulBan="<font color=yellow>{Soul Ban}</font>"//Soul Ban Text Output


Bans
	parent_type=/obj//So each object can have a AssociatedName var
	ServerBan//Each ban will use this container and the associated data.
		var/AssociatedName//AssociatedName of mob at the time of banning
		var/AssociatedKey//Key associated to the ban
		var/AssociatedIP//IP associated to the ban
		var/AssociatedCompID//ID associated to the ban
		var/BannedReason
		var/BanType


mob/Admin/verb
	Check_Bans()//Checks the current bans and the data associated to that ban.
		set category="Moderator"
		set desc="Check on a specific player ban."
		switch(alert("Check which kind of ban?","Check Ban","Key Ban","IP Ban","Computer ID Ban"))
			if("Key Ban")
				var/list/BannedKeys=list()
				for(var/Bans/ServerBan/B)
					if(B.BanType==_KeyBan)
						BannedKeys+=B
				var/Bans/ServerBan/B=input("Which key ban would you like to view?","Check Ban") in BannedKeys
				if(!B)return
				src<<"[SoulBan]<br> <u>AssociatedName:</u> [B.AssociatedName]<br> <u>Key:</u> [B.AssociatedKey]<br> <u>IP:</u> [B.AssociatedIP]<br> <u>Comp ID:</u> [B.AssociatedCompID]<br> <u>Reason:</u> [B.BannedReason]<br>"


			if("IP Ban")
				var/list/BannedIPs=list()
				for(var/Bans/ServerBan/B)
					if(B.BanType==_IPBan)
						BannedIPs+=B
				var/Bans/ServerBan/B=input("Which ip ban would you like to view?","Check Ban")in BannedIPs
				if(!B)return
				src<<"[SoulBan]<br> <u>AssociatedName:</u> [B.AssociatedName]<br> <u>Key:</u> [B.AssociatedKey]<br> <u>IP:</u> [B.AssociatedIP]<br> <u>Comp ID:</u> [B.AssociatedCompID]<br> <u>Reason:</u> [B.BannedReason]<br>"


			if("Computer ID Ban")
				var/list/BannedCompIDs=list()
				for(var/Bans/ServerBan/B)
					if(B.BanType==_CompIDBan)
						BannedCompIDs+=B
				var/Bans/ServerBan/B=input("Which computer id ban would you like to view?","Check Ban")in BannedCompIDs
				if(!B)return
				src<<"[SoulBan]<br> <u>AssociatedName:</u> [B.AssociatedName]<br> <u>Key:</u> [B.AssociatedKey]<br> <u>IP:</u> [B.AssociatedIP]<br> <u>Comp ID:</u> [B.AssociatedCompID]<br> <u>Reason:</u> [B.BannedReason]<br>"



	Unban_IP()//Unban a ip.
		set category="Moderator"
		set desc="Unban a player's ip from the server."
		var/list/BannedIPs=list()
		for(var/Bans/ServerBan/B)
			if(B.BanType==_IPBan)
				BannedIPs.Add(B)
		var/Bans/ServerBan/B=input("Who would you like to unban?","Unban IP") in BannedIPs
		if(!B)return
		switch(alert("Are you sure you want to unban [B.AssociatedName]([B.AssociatedKey])?","Unban IP","Yes","No"))
			if("No")return
			if("Yes")
				world<<"[SoulBan] [B.AssociatedName]([B.AssociatedKey]) was unbanned from the server."
				del(B)
				saveBans()


	IP_Ban()//Bans a specific IP. Hosts have 127.0.0.1 as their IP. Because it shows up blank, they can't be banned.
		set category="Moderator"
		set desc="Ban a player's ip from the server."
		var/list/ConnectedMobs=list()
		for(var/mob/M in world)
			if(M.client)
				ConnectedMobs.Add(M)

		var/mob/M=input("Who would you like to ban?","IP Ban")in ConnectedMobs
		if(!M)return

		if(banProtection(M))
			src<<"[SoulBan] [M] is protected from being banned!"
			return
		if(!M.client.address)
			src<<"[SoulBan] You can't ip ban hosts!"
			return

		var/Reason=input("Why are you banning [M]'s IP?","IP Ban")as text
		if(!Reason)
			src<<"[SoulBan] The reason cannot be blank!"
			return
		if(length(Reason)>750)
			src<<"[SoulBan] The reason cannot be more than 750 characters!"
			return

		switch(alert("Are you sure you want to ban [M]([M.key])?","IP Ban","Yes","No"))
			if("No")return
			if("Yes")
				if(!M)return
				if(hasBan(M,"IP"))
					src<<"[SoulBan] [M] is already ip banned!"
					return
				addBan(M,_IPBan,Reason)
				saveBans()
				world<<"[SoulBan] [M] was ip banned from the server."
				del(M)

mob/Admin/verb
	Key_Ban()//Bans a specific key.
		set category="Moderator"
		set desc="Ban a player's key from the server."
		var/list/ConnectedMobs=list()
		for(var/mob/M in world)
			if(M.client)
				ConnectedMobs+=M

		var/mob/M=input("Who would you like to ban?","Key Ban")in ConnectedMobs
		if(!M)return

		if(banProtection(M))
			src<<"[SoulBan] [M] is protected from being banned!"
			return

		var/Reason=input("Why are you banning [M]'s key?","Key Ban")as text
		if(!Reason)
			src<<"[SoulBan] The reason cannot be blank!"
			return
		if(length(Reason)>750)
			src<<"[SoulBan] The reason cannot be more than 750 characters!"
			return

		switch(alert("Are you sure you want to ban [M]([M.key])?","Key Ban","Yes","No"))
			if("No")return
			if("Yes")
				if(!M)return
				if(hasBan(M,"Key"))
					src<<"[SoulBan] [M] is already key banned!"
					return
				addBan(M,_KeyBan,Reason)
				saveBans()
				world<<"[SoulBan] [M] was key banned from the server."
				del(M)

	Computer_ID_Ban()//Bans a specific computer
		set category="Moderator"
		set desc="Ban a player's computer id from the server."
		var/list/ConnectedMobs=list()
		for(var/mob/M in world)
			if(M.client)
				ConnectedMobs+=M

		var/mob/M=input("Who would you like to ban?","Computer ID Ban") in ConnectedMobs
		if(!M)return

		if(banProtection(M))
			src<<"[SoulBan] [M] is protected from being banned!"
			return

		var/Reason=input("Why are you banning [M]'s Computer ID?","Computer ID Ban")as text
		if(!Reason)
			src<<"[SoulBan] The reason cannot be blank!"
			return
		if(length(Reason)>750)
			src<<"[SoulBan] The reason cannot be more than 750 characters!"
			return

		switch(alert("Are you sure you want to ban [M]([M.key])?","Computer ID Ban","Yes","No"))
			if("No")return
			if("Yes")
				if(!M)return
				if(hasBan(M,"CompID"))
					src<<"[SoulBan] [M] is already computer id banned!"
					return
				addBan(M,_CompIDBan,Reason)
				saveBans()
				world<<"[SoulBan] [M] was computer id banned from the server."
				del(M)



	Unban_Key()//Unban a key.
		set category="Moderator"
		set desc="Unban a player's key from the server."
		var/list/BannedKeys=list()
		for(var/Bans/ServerBan/B)
			if(B.BanType==_KeyBan)
				BannedKeys+=B
		var/Bans/ServerBan/B=input("Who would you like to unban?","Unban Key") in BannedKeys
		if(!B)return
		switch(alert("Are you sure you want to unban [B.AssociatedName]([B.AssociatedKey])?","Unban Key","Yes","No"))
			if("No")return
			if("Yes")
				world<<"[SoulBan] [B.AssociatedName]([B.AssociatedKey]) was unbanned from the server."
				del(B)
				saveBans()




	Unban_Computer_ID()//Unban a computer id.
		set category="Moderator"
		set desc="Unban a player's computer id from the server."
		var/list/BannedCompIDs=list()
		for(var/Bans/ServerBan/B)
			if(B.BanType==_CompIDBan)
				BannedCompIDs+=B
		var/Bans/ServerBan/B=input("Who would you like to unban?","Unban Computer ID") in BannedCompIDs
		if(!B)return
		switch(alert("Are you sure you want to unban [B.AssociatedName]([B.AssociatedKey])?","Unban Computer ID","Yes","No"))
			if("No")return
			if("Yes")
				world<<"[SoulBan] [B.AssociatedName]([B.AssociatedKey]) was unbanned from the server."
				del(B)
				saveBans()



proc/saveBans()//Saves the ban data.
	if(fexists("Ban/ServerBans.sav")) fdel("Ban/ServerBans.sav")
	var/savefile/F=new("Ban/ServerBans.sav")
	F["ServerBanList"]<<ServerBanList

proc/loadBans()//Loads the ban data.
	var/savefile/F=new("Ban/ServerBans.sav")
	F["ServerBanList"]>>ServerBanList
	if(!length(ServerBanList)) ServerBanList = list()


proc/addBan(var/mob/M,var/Type,var/Reason)
	var/Bans/ServerBan/B=new()
	B.AssociatedName=M.key
	B.AssociatedName=M.name
	B.AssociatedKey=M.key
	B.AssociatedIP=M.client.address
	B.AssociatedCompID=M.client.computer_id
	B.BannedReason=Reason
	switch(Type)
		if(1) B.BanType=_KeyBan
		if(2) B.BanType=_IPBan
		if(3) B.BanType=_CompIDBan
	if(isnull(ServerBanList))
		ServerBanList=new/list
	ServerBanList+=B


proc/hasBan(var/mob/M,var/Type)//Returns true if the clients has a ban container for the specified type
	switch(Type)
		if("CompID")
			for(var/Bans/ServerBan/B)
				if(M.client.computer_id==B.AssociatedCompID && B.BanType==_CompIDBan)
					return 1

		if("IP")
			for(var/Bans/ServerBan/B)
				if(M.client.address==B.AssociatedIP && B.BanType==_IPBan)
					return 1

		if("Key")
			for(var/Bans/ServerBan/B)
				if(M.key==B.AssociatedKey && B.BanType==_KeyBan)
					return 1
	return 0



proc/banProtection(var/mob/M)//Returns true if the clients key is in the BanProtection list. Otherwise, false.
	if(BanProtection.Find(M.key)) return 1
	else return 0



proc/isBanned(var/client/M)//If the client is banned, it will send the message to them and return true.
	for(var/Bans/ServerBan/B)
		if(M.computer_id==B.AssociatedCompID && B.BanType==_CompIDBan)
			M<<"[SoulBan] You are computer id banned from the server. <u>Reason:</u> <i>[B.BannedReason]</i>"
			return 1

		if(M.address==B.AssociatedIP && B.BanType==_IPBan)
			M<<"[SoulBan] You are ip banned from the server. <u>Reason:</u> <i>[B.BannedReason]</i>"
			return 1

		if(M.key==B.AssociatedKey && B.BanType==_KeyBan)
			M<<"[SoulBan] You are key banned from the server. <u>Reason:</u> <i>[B.BannedReason]</i>"
			return 1