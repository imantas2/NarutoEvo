#define TEST key
mob/verb/OutputColor()
	set hidden=1
	var/R
	var/G
	var/B
	R=text2num(winget(src,"ColorWindow.RedBar","Value"))
	G=text2num(winget(src,"ColorWindow.GreenBar","Value"))
	B=text2num(winget(src,"ColorWindow.BlueBar","Value"))
	spawn()
		var/icon/I = new('Misc Effects.dmi', "Black")
		I.Blend(rgb(R,G,B),ICON_ADD)
		var/iconfile = fcopy_rsc(I)
		winset(src, "ColorWindow.Picture", "image=\ref[iconfile]")
		del(I)
	//I.icon+=rgb(R,G,B)
	//src << output(I,"ColorWindow.Grid:1,1")
client/Command(T)
	..()
	if(!mob||!mob.prompt||!src) return
	if(findtextEx(T,".skalert",1,9))
		if(!mob.prompt) mob.prompt = new /Skalert
		var/POS = findtextEx(T," ")
		if(mob.prompt) mob.prompt.answer = text2num(copytext(T,POS++))
	if(findtextEx(T,".skinput",1,12)&&mob.prompt)
		if(!mob.prompt) mob.prompt = new /Skalert
		var/POS = findtextEx(T," ")
		if(mob.prompt) mob.prompt.answer = text2num(copytext(T,POS++))
	if(findtextEx(T,".skinputbar",1,12))
		if(!mob.prompt) mob.prompt = new /Skalert
		if(mob.prompt&&!isnull(mob.prompt)&&src) mob.prompt.answer = winget(src,"skinput22.skinputbar","text")
		winset(src,"skinput22.skinputbar","text=\"\"")
	if(findtextEx(T,".colorinput",1,12))
		if(!mob.prompt) mob.prompt = new /Skalert
		var/R
		var/G
		var/B
		R=winget(usr,"ColorWindow.RedBar","Value")
		G=winget(usr,"ColorWindow.GreenBar","Value")
		B=winget(usr,"ColorWindow.BlueBar","Value")
		if(mob.prompt) mob.prompt.answer = list(R,G,B)
Skalert
	var/answer
mob/var/tmp/Skalert/prompt
mob/proc/GET_ANSWERCOLOR()
	while(prompt&&src) sleep(10)
	if(src) prompt = new /Skalert
	while(!prompt.answer&&src) sleep(10)
	var/X = prompt.answer
	if(src) del(prompt)
	if(src) return X
mob/proc/GET_ANSWER()
	while(prompt&&src) sleep(10)
	prompt = new /Skalert
	while(!prompt.answer&&src) sleep(10)
	var/X = prompt.answer
	del(prompt)
	return X
mob/Del()
	if(prompt) del(prompt)
	..()
mob/proc/skalert(prompt,title,answers[3])
	if(!client) return
	if(!answers) answers = new/list
	if(!answers.len)
		answers.len = 1
		answers[1] = "Ok"
	if(answers.len > 3) answers.len = 3
	if(answers.len == 1)
		for(var/X in 2 to 3)
			winset(src,"skalert[X]","is-visible=false")
		winset(src,"skalert1","is-visible=true")
		winset(src,"skalert1","text=\"[answers[1]]\"")
	if(answers.len == 3)
		for(var/X in 1 to 3)
			winset(src,"skalert[X]","is-visible=true")
			winset(src,"skalert[X]","text=\"[answers[X]]\"")
	if(answers.len == 2)
		for(var/X in 2 to 3)
			winset(src,"skalert[X]","is-visible=true")
			winset(src,"skalert[X]","text=\"[answers[X-1]]\"")
		winset(src,"skalert1","is-visible=false")
		answers = list(null,answers[1],answers[2])
	src << output(null,"skalert_out")
	src << output(prompt,"skalert_out")
	winset(src,"skalert","title=\"[title]\"")
	winset(src,"skalert","is-visible=true")
	if(src&&src.client)
		if(!answers.len) return
		var/ANSWER = answers[src.GET_ANSWER()]
		if(src&&src.client) winset(src,"skalert","is-visible=false")
		return ANSWER
mob/proc/skinput(prompt,title,answers[12])
	if(!client) return
	if(!answers) answers = new/list
	if(!answers.len)
		answers.len = 1
		answers[1] = "Ok"
	if(answers.len > 12) answers.len = 12
	for(var/X in 1 to 12)
		winset(src,"skinput.skinput[X]","is-visible=false")
	for(var/X in 1 to answers.len)
		winset(src,"skinput.skinput[X]","is-visible=true")
		winset(src,"skinput.skinput[X]","text=\"[answers[X]]\"")
	src << output(null,"skinput_out")
	src << output(prompt,"skinput_out")
	winset(src,"skinput","title=\"[title]\"")
	winset(src,"skinput","is-visible=true")
	var/ANSWER = answers[src.GET_ANSWER()]
	winset(src,"skinput","is-visible=false")
	return ANSWER
/*mob/proc/skinput(prompt,title,answers[12])//Just saving this, if you want to change it all up and it doesn't work or anything.
	if(!client) return
	if(!answers) answers = new/list
	if(!answers.len)
		answers.len = 1
		answers[1] = "Ok"
	if(answers.len > 12) answers.len = 12
	for(var/X in 1 to 12)
		winset(src,"skinput.skinput[X]","is-visible=false")
	for(var/X in 1 to answers.len)
		winset(src,"skinput.skinput[X]","is-visible=true")
		winset(src,"skinput.skinput[X]","text=\"[answers[X]]\"")
	src << output(null,"skinput_out")
	src << output(prompt,"skinput_out")
	winset(src,"skinput","title=\"[title]\"")
	winset(src,"skinput","is-visible=true")
	var/ANSWER = answers[src.GET_ANSWER()]
	winset(src,"skinput","is-visible=false")
	return ANSWER*/
/*mob/proc/skinputatom(prompt,title,answers[])
	if(!client) return
	if(!answers) answers = new/list
	if(!answers.len)
		answers.len = 1
		answers[1] = "Broken!"
	winset(src,"skinput.Grid","cells=0x0")
	for(var/O in answers)
		Row++
		src << output(O,"skinput.Grid:1,[Row]")
		//src << output("<center><font size =1>[O.name]","skinput.Grid:1,[Row]")
	src << output(null,"skinput_out")
	src << output(prompt,"skinput_out")
	winset(src,"skinputatom","title=\"[title]\"")
	winset(src,"skinputatom","is-visible=true")
	var/ANSWER = answers[src.GET_ANSWER()]
	winset(src,"skinputatom","is-visible=false")
	return ANSWER
*/
mob/proc/skinput2(prompt,title,initial,Number)
	if(!client) return
	src << output(null,"skinput22.skinput2_out")
	src << output(prompt,"skinput22.skinput2_out")
	if(initial) winset(src,"skinput22.skinputbar","text=\"[initial]\"")
	winset(src,"skinput22","title=\"[title]\"")
	winset(src,"skinput22","is-visible=true")
	var/ANSWER=src.GET_ANSWER()
	winset(src,"skinput22","is-visible=false")
	if(Number)return text2num(ANSWER)
	return ANSWER
mob/proc/ColorInput(prompt)
	if(!client) return
	winset(src,"ColorWindow.RedBar","Value=0")
	winset(src,"ColorWindow.GreenBar","Value=0")
	winset(src,"ColorWindow.BlueBar","Value=0")
	src << output(null,"ColorWindow.Prompt")
	src << output(prompt,"ColorWindow.Prompt")
	winset(src,"ColorWindow","is-visible=true")
	var/ANSWER=src.GET_ANSWERCOLOR()
	winset(src,"ColorWindow","is-visible=false")
	return ANSWER
mob/var/tmp/list/CurrentGrid=list()
obj/Copy
	icon='checkbox.dmi'
	icon_state="unchecked"
	var/row
	MouseEntered(object,location,control,params)
		if(usr.CurrentGrid.Find(src))
			src.icon_state="checked"
			if(!usr.CurrentGrid.Find(src)) return
			usr << output(src,"yutput.grid:1,[row]")
	MouseExited(location,control,params)
		if(usr.CurrentGrid.Find(src))
			src.icon_state="unchecked"
			if(!usr.CurrentGrid.Find(src)) return
			usr << output(src,"yutput.grid:1,[row]")
	Click()
		if(usr.CurrentGrid.Find(src))
			usr.copy = src
			usr << output(null,"yutput.grid:1,[row]")
mob
	proc/CustomInput(title,message,inputs[],paths)
		if(!client) return
		if(!inputs) inputs = new/list
		if(!inputs.len)
			inputs.len = 1
			inputs[1] = "Broken!"
		winset(src,"yutput.title","text = '[title]'")
		src << output(null,"yutput.message")
		src << output("[message]","yutput.message")
		//src << output(null,"yutput.grid")
		winset(src,"yutput.grid","cells=0x0")
		var/Row=1
	/*	if(paths)
			var/list/NewInputs=list()
			for(var/x in inputs)
				var/atom/O=new x
				src.CurrentGrid.Add(O)
				NewInputs.Add(O)
			src << output("","yutput.grid:1,1")
			for(var/atom/X in NewInputs)
				Row++
				src << output(X,"yutput.grid:1,[Row]")
				continue
		else*/
		src << output(null,"yutput.grid")
		src << output("","yutput.grid:1,1")
		for(var/X in inputs)
			Row++
			var/obj/Copy/I=new
			I.name=X
			I.row=Row
			src.CurrentGrid+=I
			src << output(null,"yutput.grid:1,[Row]")
			src << output(I,"yutput.grid:1,[Row]")
			continue
		winset(src,"yutput","is-visible=true")
		src.copy = "waiting"
		while(src.copy=="waiting")
			sleep(2)
		var/C = src.copy
		src.copy=null
		src.CurrentGrid=list()
		winset(src,"yutput","is-visible=false")
		return C