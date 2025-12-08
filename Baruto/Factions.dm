var/list/Factions = list()
var/list/AkatInvites = list()
var/list/Factionnames = list()
mob/var
	Faction
	Factionrank
	list/Factionverbs=list()
mob/proc
	Create_Faction()
		var/Faction/NewFaction = new/Faction
		Factions += NewFaction
		var/html = {"
			<html>
			<head>
			<title> Faction Setup </title>
			</head>
			<body bgcolor=gray><center><font size = +2><u>Faction Settings</u></font></center><br>

			<form name="Factionform" action="byond://" method="get">
			<input type="hidden" name="src" value="\ref[NewFaction]">
			<input type = "hidden" name="form" value="setup">
			<center><b><u>Faction Set-up</b></u></center>
			<hr>
			<br>
			<hr>
			Name:<input type="text" name="name" value="Faction Name"><br />
			Member Rank: (Such as Recruit) <input type="text" name="mname"><br />
			Leader Rank: (Such as Founder) <input type="text" name="headrank"><br />
			Color:<br>
			<button onclick="window.location='byond://?src=\ref[NewFaction]&action=color&player=\ref[src]';">Color</button>
			<br>
			<br>
			<input type="submit" name="go" value="Submit">
			<input type="submit" name="stop" value="Cancel">
			</form>
			</body>

			"}
		usr << browse(html)
		winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
proc
	getFaction(text)
		for(var/Faction/Faction in Factions)
			if(Faction.name == text)return Faction
		return 0
	getMember(Faction/Faction)
		var/list/options = list()
		for(var/mob/player/M in world)
			if(M.rname in Faction.members)options["[M.rname]/[M.key]"] = M
		var/mob/player/target = usr.CustomInput("What member?","Member?",options+"Cancel")
		if(!target||target=="Cancel") return 0
		target = options["[target]"]
		return target
Faction
	var
		list/members=list()
		list/newranklist
		list/ranks = list()
		tmp/list/onlinemembers=list()
		headrank
		headkey
		head
		name
	//	channel
	//	channelv = /Faction/Generic/verb/FactionChannel
		color = "white"
		membername
		list/cverbs=list()
		nname
		Funds=0
		Level=1
		LevelFundsMax=700
		MaxMembers=8
		FMOTD
	proc
		SetMOTD(mob/M)
			if(!M) return
			var/V=M.skinput2("Please input a new message of the day.","MOTD",FMOTD)
			if(lentext(V)>=400)
				M<<"Please keep MOTD messages below 400 characters."
				return
			FMOTD=html_encode(V)
			for(var/mob/player/Player in world) if(getFaction(Player.Faction) == src) Player<<output("<b>Faction MOTD has been changed.<br><br> <i>[FMOTD]</i></b>","actionoutput")
		LevelUp()
			if(Level==10) return
			while(Funds>=LevelFundsMax)
				Funds-=LevelFundsMax
				if(Funds<=0) Funds=0
				Level++
				src.LevelFundsMax += ((src.LevelFundsMax*2)+(Level*80))
				MaxMembers+=2
				if(Level==4)
					cverbs += /Faction/Leveled/verb/FactionMOTD
					for(var/mob/player/Player in world) if(getFaction(Player.Faction) == src) Player<<"<b>[src] has gained the ability to set MOTDs!</b>"
				for(var/mob/player/Player in world) if(getFaction(Player.Faction) == src) Player<<"<b>[src] has leveled up to level [Level]!</b>"
		Funds(mob/M)
			if(!M) return
			var/r = M.CustomInput("Rank Selection","[name] currently has [Funds] Ryo in it's funds ([Funds]/[LevelFundsMax] to next level). Deposit, or Withdraw?", list("Deposit","Withdraw","Cancel"))
			if(!r) return
			switch(r:name)
				if("Cancel") return
				if("Deposit")
					if(!M.Ryo)
						M<<"You have no Ryo to deposit."
						return
					var/Num=M.skinput2("How much would you like to deposit into clan funds?","Ryo Withdraw",null,1)
					if(!isnum(Num))return
					if(Num>M.Ryo||Num<=0)return
					Funds+=Num
					M.Ryo-=Num
					M << output("Successfully deposited [Num] funds.","actionoutput")
					LevelUp()
					return
				if("Withdraw")
					if(M.ckey!=headkey)
						M<<output("You must be the Faction leader to preform this action.","actionoutput")
						return
					if(!Funds)
						M << output("There is no Ryo to withdraw","actionoutput")
						return
					else
						var/Num=M.skinput2("How much would you like to withdraw?","Ryo Withdraw",null,1)
						if(!isnum(Num))
							return
						if(M.Ryo<Num||Num<=0)
							return
						M.Ryo+=Num
						Funds-=Num
						M << output("Successfully withdrawed [Num] funds.","actionoutput")
					return
		Leave(mob/M)
			for(var/mob/player/X in world)
				if(getFaction(X.Faction)==getFaction(M.Faction)&&!isnull(getFaction(M.Faction)))X<<"[M] has left your Faction."
			M.verbs -= /Faction/Generic/verb/FactionLeave
			M.Faction = null
			src.members -= M.rname
			M << output("You have left [Filter(html_encode(src.name))].","actionoutput")
			M.verbs -= cverbs
			src.onlinemembers -= M
			M.overlays=null
			M.RestoreOverlays()
			if(members.len<=0)
				Factionnames -= name
				Factions -= src
				world << output("<font color=[color]><b>[Filter(html_encode(name))] have been disbanded.</font></b>","actionoutput")
				for(var/mob/player/p in world)
					if(p.Faction == name)
						p.Faction = ""
						p.verbs -= cverbs
						p.verbs -= /Faction/Generic/verb/FactionLeave
						p << output("You are no longer a part of [Filter(html_encode(name))], they were disbanded.","actionoutput")
		AddMember(mob/player, mob/M)
			if(members.len>=MaxMembers)
				player.skalert("Your faction is at it's max member count ([MaxMembers]). Level up to gain more space!","Error")
				return 0
			if(M.Faction)
				player.skalert("[M] already has a Faction.","Error")
				return 0
			M.Faction = src.name
			src.members[M.rname] = list(M.key, M.level, M.Factionrank)
			src.onlinemembers += M
			M << output("You are now a [membername]","actionoutput")
			src.onlinemembers << output("<font color=[src.color]>[M.rname] has joined your Faction. </font>","actionoutput")
			for(var/mob/player/P in world)
				if(P.admin)P<<output("<font color=[src.color]>[M.rname]([M.ckey]) is now a member of the [Filter(html_encode(src.name))]</font>","actionoutput")
			M.Faction("[name]",color)
			return 1
		Fire_Member(mob/M)
			M.Faction = null
			src.members -= M.rname
			M << output("You have been fired from [Filter(html_encode(src.name))]","actionoutput")
			M.verbs -= cverbs
			src.onlinemembers -= M
			M.overlays=null
			M.RestoreOverlays()
			if(members.len<=0)
				Factionnames -= name
				Factions -= src
				world << output("<font color=[color]><b>[name] have been disbanded.</font></b>","actionoutput")
				for(var/mob/player/p in world)
					if(p.Faction == name)
						p.Faction = ""
						p.verbs -= cverbs
						p.verbs -= /Faction/Generic/verb/FactionLeave
						p << output("You are no longer a part of [name], they were disbanded.","actionoutput")
		Rank(mob/leader,mob/member)
			if(!leader || !member) return
			var/r = leader.CustomInput("Rank Selection","What rank shall [member] be put at?", ranks)
			if(!r) return
			r=r:name
			member.Factionrank = r
			member.verbs -= cverbs
			var/list/ve = ranks[r]
			member.Factionverbs = list()
			for(var/v in ve)
				member.verbs += /Faction/Generic/verb/FactionLeave
				member.verbs += text2path(v)
				member.Factionverbs += text2path(v)
				member.Factionverbs += /Faction/Generic/verb/FactionLeave
			members[member.rname[3]] = r
		SetUpRanks(mob/setter)
			newranklist = list()
			var/counter=1
			NewRank(counter,setter)
		NewRank(counter,mob/person)
			person << browse(null)
			var/verboptions = ""
			var/value
			cverbs -= /Faction/Generic/verb/FactionLeave
			for(var/v in cverbs)
				verboptions += {"<option value="[v]">[v]</option>"}
			if(counter <= ranks.len) value = ranks[counter]
			else value = "Undefined"
			var/html ={"<html>
			<head>
			<title> Rank Setup </title>
			</head>
			<body bgcolor=gray><center><font size = +2><u>Rank Setup</u></font></center><br>
			<br>
			<form name="rankform" action="byond://" method="get">
			<input type="hidden" name="src" value="\ref[src]">
			<input type = "hidden" name="form" value="ranks">
			<input type = "hidden" name="number" value="[counter]">

			Rank Number:[counter]<br>
			Name:<input type="text" name="rankname" value="[value]"><br>
			Verbs: (Ctrl click to select multiple)
			<select multiple name="rverbs" size = "10" style="width: 100%;">
			[verboptions]
			</select>
			<input type="submit" name="next" value="Next">
			<input type="submit" name="done" value="Done">
			<input type="submit" name="cancel" value="Cancel">
			</form>
			"}
			person << browse(html)
			winset(person, null, {"
						mainwindow.BrowserChild.is-visible = "true";
					"})
	Leveled
		verb
			FactionMOTD()
				set name = "Set MOTD"
				set category = "Faction"
				set desc = "Set MOTD"
				var/Faction/c = getFaction(usr.Faction)
				if(c) c.SetMOTD(usr)
	Generic
		verb
		//	FactionChannel(msg as text)
		//		set category = "Faction"
		//		set name = "Channel"
		//		var/Faction/c = getFaction(usr.Faction)
		//		if(c) c.Channel(usr.rname,msg,/Faction/Generic/verb/FactionChannel)
			FactionFunds()
				set name = "Funds"
				set category = "Faction"
				set desc = "Funds"
				var/Faction/c = getFaction(usr.Faction)
				if(c) c.Funds(usr)
			FactionHire()
				set category = "Faction"
				set name = "Hire"
				var/list/Players = list()
				for(var/mob/player/P in view()) Players["[P.name] ([P.key])"]=P
				var/mob/player/P=usr.CustomInput("Invite Who?","Choose someone to hire.",Players+"Cancel")
				if(P=="Cancel") return
				var/mob/M = Players["[P]"]
				var/Faction/c = getFaction(usr.Faction)
				if(c && M)
					if(M.skalert("You've been invited to join [Filter(html_encode(c.name))]. Accept or Decline?","Creation",list("Accept","Decline"))=="Accept")
						if(c.AddMember(usr,M))c.Rank(usr,M)
			FactionRanks()
				set name = "Ranks"
				set category = "Faction"
				set desc = "Change Member Ranks"
				var/Faction/c = getFaction(usr.Faction)
				var/mob/M = getMember(c)
				if(M) c.Rank(usr,M)
			FactionRankSetUp()
				set category = "Faction"
				set name = "Set Ranks"
				set desc = "Configure Faction rankings"
				var/Faction/c = getFaction(usr.Faction)
				c.SetUpRanks(usr)
			FactionLeave()
				set category = "Faction"
				set name = "Leave"
				var/Faction/c = getFaction(usr.Faction)
				if(!c) return
				if(usr.skalert("Are you sure you want to leave [Filter(html_encode(c.name))]?","Confirm!",list("No","Yes"))=="Yes")
					c.Leave(usr)
			FactionFire()
				set category = "Faction"
				set name = "Fire"
				var/Faction/c = getFaction(usr.Faction)
				var/mob/M
				if(c) M = getMember(c)
				if(M) c.Fire_Member(M)
Faction
	//var/tmp/Waiting = 0
	Topic(href, list/href_list)
		//if(Waiting) return
		//for(var/data in href_list)
		//	usr << data
		//	usr << href_list[data]
	//	var/action = href_list["action"]
		if(href_list["action"] == "color")
			var/mob/p = locate(href_list["player"])
			getColor("color",p)
		var/form  = href_list["form"]
		if(href_list["commandName"])
			switch(href_list["commandName"])
				if("closeWindow") usr<<browse(null,"window=[href_list["windowName"]]")
				if("color")
					var/r=text2num(href_list["r"])
					var/g=text2num(href_list["g"])
					var/b=text2num(href_list["b"])
					usr<<browse(null,"window=[href_list["windowName"]]")
					color="[rgb(r,g,b)]"
		if(form == "ranks")
			if(href_list["cancel"])
				usr << browse(null)
				return
			if(!href_list["rankname"]) return
			var/rverbs = href_list["rverbs"]
			if(istype(rverbs, /list))
				newranklist[href_list["rankname"]] = rverbs
			else
				newranklist[href_list["rankname"]] = list(rverbs)
			if(href_list["next"])
				var/n = text2num(href_list["number"])
				n++
				src.NewRank(n,usr)
				return
			if(href_list["done"])
				var/html = "<center>Confirm</center><body bgcolor=beige><br><br>"
				for(var/r in newranklist)
					html += "[r]:<br>"
					if(istype(newranklist[r],/list))
						for(var/v in newranklist[r])html += "[v]<br>"
					else html += "[newranklist[r]]<br>"
				usr << browse(html)
				winset(usr,"default.tab2","current-tab=browserpane")
				if(alert("Are these ranks and verbs correct?", "Ranks", "Yes","No")=="No")
					usr << browse(null)
					return
				usr << browse(null)
				ranks = new/list()
				for(var/r in newranklist)ranks[r] = newranklist[r]
				del(newranklist)
				return
		if(form == "setup")
			usr << browse(null)
			if(href_list["stop"])
				usr << output("You cancel making a Faction.","actionoutput")
				winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
				Factions-=src
				del(src)
				return
			if(!href_list["name"] || !color)
				usr.skalert("You did not fill out all of the necessary fields.")
				winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
				Factions-=src
				del(src)
				return
			var/leng = lentext(href_list["name"])
			if(leng>=15)
				usr.skalert("Your faction name cannot be longer than 15 characters.")
				winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
				Factions-=src
				del(src)
				return
			for(var/i in Factionnames)
				if(i==href_list["name"])
					usr.skalert("Your faction name has already been taken.")
					winset(usr, null, {"
							mainwindow.BrowserChild.is-visible = "false";
						"})
					Factions-=src
					del(src)
					return
			if(usr.Ryo<3000)
				usr.skalert("You need 3000 Ryo to create a Faction.")
				winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
				Factions-=src
				del(src)
				return
			usr.Ryo-=1500
			name = href_list["name"]
			if(href_list["nname"])nname = href_list["nname"]
			else nname = name
			if(href_list["mname"])membername= "[href_list["mname"]]"
			else membername="member of the [name]"
			winset(usr, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
			cverbs += typesof(/Faction/Generic/verb)
			cverbs -= /Faction/Generic/verb/FactionLeave
			var/mob/_head = usr
			head = _head.rname
			world << output("<b><font color=[color]>The faction: [Filter(html_encode(name))] has been established by [head].</font></b>","actionoutput")
			_head << output("<font color=[color]>You are now leading [Filter(html_encode(name))].</font>","actionoutput")
			_head.verbs += cverbs
			_head.verbs += /Faction/Generic/verb/FactionLeave
			_head.Faction = name
			headkey = _head.ckey
			if(href_list["headrank"]) headrank = href_list["headrank"]
			else headrank = "Head of the [name]"
			_head.Factionrank = headrank
			_head.Factionverbs = cverbs
			_head.Factionverbs += /Faction/Generic/verb/FactionLeave
			members[_head.rname] = list(_head.key, _head.level, _head.Factionrank)
			Factionnames += name
			ranks = list(headrank = cverbs, membername)
			onlinemembers += _head
			if(!_head.Squad) return
			for(var/i in _head.Squad.Members)
				var/mob/M=getOwner(i)
				if(!M) continue
				_head<<"You've recruited [M] into your Faction."
				if(AddMember(_head,M))Rank(_head,M)
			_head.Faction("[name]",color)
///COLOR SYSTEM
var/globalPallette
Faction
	proc
		getColor(commandName,mob/plyr,r=0,g=0,b=0)
			if(!globalPallette)
				var/palette={"<span style="font-size: 1px; height: 16px; border-bottom: 1px solid black; border-top: 1px solid black; background-color: rgb(0,0,0);">&nbsp;</span>"}
				var/scriptAll={"font-size: 1px; cursor: crosshair; height: 16px;"}
				for(var/R=0,R<=255,R++) palette+={"<span onClick="setRed('[R]');" id="red=[R]" style="border-bottom: 1px solid black; border-top: 1px solid black; background-color: rgb([R],0,0); [scriptAll]">&nbsp;</span>"}
				palette+={"<span style="font-size: 1px; height: 16px; border-bottom: 1px solid black; border-top: 1px solid black; background-color: rgb(0,0,0);">&nbsp;</span><br /><span style="font-size: 1px; height: 16px; border-bottom: 1px solid black; background-color: rgb(0,0,0);">&nbsp;</span>"}
				for(var/G=0,G<=255,G++) palette+={"<span onClick="setGreen('[G]');" id="green=[G]" style="border-bottom: 1px solid black; background-color: rgb(0,[G],0); [scriptAll]">&nbsp;</span>"}
				palette+={"<span style="font-size: 1px; height: 16px; border-bottom: 1px solid black; background-color: rgb(0,0,0);">&nbsp;</span><br /><span style="font-size: 1px; height: 16px; border-bottom: 1px solid black; background-color: rgb(0,0,0);">&nbsp;</span>"}
				for(var/B=0,B<=255,B++) palette+={"<span onClick="setBlue('[B]');" id="blue=[B]" style="border-bottom: 1px solid black; background-color: rgb(0,0,[B]); [scriptAll]">&nbsp;</span>"}
				palette+={"<span style="font-size: 1px; height: 16px; border-bottom: 1px solid black; background-color: rgb(0,0,0);">&nbsp;</span><br />"}
				globalPallette=palette
			plyr<<browse({"
<html>
<head>
<title>Color Palette</title>

<script language="javascript" type="text/javascript">

var old_id_r;
var old_id_g;
var old_id_b;
var old_r;
var old_g;
var old_b;

document.oncontextmenu=new Function("return false");

function numOnly(the_value)
	{
		if((the_value==0) && (window.event.keyCode==48))
			window.event.keyCode=0;
		if(window.event.keyCode<48 || window.event.keyCode>57)
			window.event.keyCode=0;
	}

function isMaxLength(the_obj)
	{
		var obj_max_len=the_obj.getAttribute ? parseInt(the_obj.getAttribute("maxlength")) : "";
		if(the_obj.getAttribute && the_obj.value.length>obj_max_len);
			the_obj.value=obj.value.substring(0,obj_max_len);
	}

function setHex(r,g,b)
	{
		var HexChars="0123456789abcdef";
		r=hexValue(r);
		g=hexValue(g);
		b=hexValue(b);
		document.colorPicker.selcolor.value=''+r+''+g+''+b+'';
	}


function convert2dec(the_hex)
	{
		if(the_hex == 0) return 0;
		else if(the_hex == 1) return 1;
		else if(the_hex == 2) return 2;
		else if(the_hex == 3) return 3;
		else if(the_hex == 4) return 4;
		else if(the_hex == 5) return 5;
		else if(the_hex == 6) return 6;
		else if(the_hex == 7) return 7;
		else if(the_hex == 8) return 8;
		else if(the_hex == 9) return 9;
		else if(the_hex == "a") return 10;
		else if(the_hex == "b") return 11;
		else if(the_hex == "c") return 12;
		else if(the_hex == "d") return 13;
		else if(the_hex == "e") return 14;
		else if(the_hex == "f") return 15;
		else return 0;
	}

function HexToDec(the_elem)
	{
		if(the_elem.length != 6)
			return;
		else
			the_elem=the_elem.toLowerCase();
			a=convert2dec(the_elem.substring(0, 1));
			b=convert2dec(the_elem.substring(1, 2));
			c=convert2dec(the_elem.substring(2, 3));
			d=convert2dec(the_elem.substring(3, 4));
			e=convert2dec(the_elem.substring(4, 5));
			f=convert2dec(the_elem.substring(5, 6));
			r=(a*16)+b;
			g=(c*16)+d;
			b=(e*16)+f;
			setRed(r);
			setGreen(g);
			setBlue(b);
	}

function hexValue(the_decimal)
	{
		var HexChars="0123456789abcdef";
		return HexChars.charAt((the_decimal>>4)&0xf)+HexChars.charAt(the_decimal&0xf);
	}

function correctElem(the_elem)
	{
		if(!the_elem) the_elem="0";
		if(the_elem > 255) the_elem="255";
		if(the_elem < 0) the_elem="0";
		if(the_elem > 0) the_elem=Math.abs(the_elem);
		return the_elem;
	}

function setRed(the_elem)
	{
		the_elem=correctElem(the_elem);
		if(old_r && old_id_r) document.getElementById(old_id_r).style.background='rgb('+old_r+',0,0)';
		document.colorPicker.R.value=the_elem;
		setHex(document.colorPicker.R.value,document.colorPicker.G.value,document.colorPicker.B.value);
		document.getElementById('red='+the_elem).style.background="#FFF";
		old_id_r='red='+the_elem;
		old_r=the_elem;
		document.colorPicker.selcolor.style.backgroundColor='rgb('+document.colorPicker.R.value+','+document.colorPicker.G.value+','+document.colorPicker.B.value+')';
		document.colorPicker.selcolor.style.border='2px outset rgb('+document.colorPicker.R.value+','+document.colorPicker.G.value+','+document.colorPicker.B.value+')';
	}

function setGreen(the_elem)
	{
		the_elem=correctElem(the_elem);
		if(old_g && old_id_g) document.getElementById(old_id_g).style.background='rgb(0,'+old_g+',0)';
		document.colorPicker.G.value=the_elem;
		setHex(document.colorPicker.R.value,document.colorPicker.G.value,document.colorPicker.B.value);
		document.getElementById('green='+the_elem).style.background="#FFF";
		old_id_g='green='+the_elem;
		old_g=the_elem;
		document.colorPicker.selcolor.style.backgroundColor='rgb('+document.colorPicker.R.value+','+document.colorPicker.G.value+','+document.colorPicker.B.value+')';
		document.colorPicker.selcolor.style.border='2px outset rgb('+document.colorPicker.R.value+','+document.colorPicker.G.value+','+document.colorPicker.B.value+')';
	}

function setBlue(the_elem)
	{
		the_elem=correctElem(the_elem);
		if(old_b && old_id_b) document.getElementById(old_id_b).style.background='rgb(0,0,'+old_b+')';
		document.colorPicker.B.value=the_elem;
		setHex(document.colorPicker.R.value,document.colorPicker.G.value,document.colorPicker.B.value);
		document.getElementById('blue='+the_elem).style.background="#FFF";
		old_id_b='blue='+the_elem;
		old_b=the_elem;
		document.colorPicker.selcolor.style.backgroundColor='rgb('+document.colorPicker.R.value+','+document.colorPicker.G.value+','+document.colorPicker.B.value+')';
		document.colorPicker.selcolor.style.border='2px outset rgb('+document.colorPicker.R.value+','+document.colorPicker.G.value+','+document.colorPicker.B.value+')';
	}

function submitColor()
	{
		var theR=document.colorPicker.R.value;
		var theG=document.colorPicker.G.value;
		var theB=document.colorPicker.B.value;
		window.location.href="byond://?src=\ref[src];commandName=[commandName]&windowName=[commandName]&r="+theR+"&g="+theG+"&b="+theB;
	}

</script>

<style type="text/css">
input{font-size: 12px; font-family: 'tahoma'; border: 2px outset #aaaaaa; background-color: #aaaaaa;}
</style>

</head>

<body bgcolor="#b0b0b0" onLoad="setRed([r]);setGreen([g]);setBlue([b]);">
<form name="colorPicker">
<center>[globalPallette]</center><br><center>
<input type="text" maxlength="6" onKeyUp="HexToDec(this.value);" style="font-weight: bold; color: white; text-align: center;vertical-align: middle;" name="selcolor" size="20" class="hexfield" /><br />
<input type="text" maxlength="3" style="border: 2px outset red; font-weight: bold; color: white; text-align: center; vertical-align: middle; background-color: red;" name="R" value="0" size="3" class="R" onKeyPress="numOnly(this.value);" onKeyup="setRed(this.value);" />
<input type="text" maxlength="3" style="border: 2px outset green; font-weight: bold; color: white; text-align: center; vertical-align: middle; background-color: green;" name="G" value="0" size="3" class="G" onKeyPress="numOnly(this.value);" onKeyup="setGreen(this.value);" />
<input type="text" maxlength="3" style="border: 2px outset blue; font-weight: bold; color: white; text-align: center; vertical-align: middle; background-color: blue;" name="B" value="0" size="3" class="B" onKeyPress="numOnly(this.value);" onKeyup="setBlue(this.value);" />
<br><br><input type="button" value="Apply Color" onClick="submitColor();" class="button">&nbsp;&nbsp;<input type="button" value="Cancel" class="button" onClick="window.location.href='byond://?src=\ref[src];commandName=closeWindow&windowName=[commandName]'" /><br />
</center>
</form>
"},"window=[commandName];size=350x250;can_close=0;can_resize=0")

proc
	hex2rgb(hex)
		if(!isHex(hex)) return
		var/red=(return_hex_loc(copytext(hex,2,3))*16)+return_hex_loc(copytext(hex,3,4))
		var/green=(return_hex_loc(copytext(hex,4,5))*16)+return_hex_loc(copytext(hex,5,6))
		var/blue=(return_hex_loc(copytext(hex,6,7))*16)+return_hex_loc(copytext(hex,7,8))
		return list(red,green,blue)
	return_hex_loc(char)
		var/list/hexVals=list("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
		var/i=hexVals.Find(lowertext(char))
		return i-1
	isHex(string)
		var/list/hexVals=list("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
		if(text2ascii(string,1)!=35) return FALSE
		if(length(string)!=7) return FALSE
		for(var/i=2,i<=length(string),i++) if(!hexVals.Find(copytext(string,i,i+1))) return FALSE
		return TRUE