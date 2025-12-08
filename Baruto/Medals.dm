mob/var/tmp/Multikill=0
mob/proc/
	MedalCheck()
		//set background=1
		var/Medal=null
		winset(src, null, {"

							mainwindow.UnlockChild.is-visible = "false";
							MedalUnlock.is-visible      = "false";
							Medal.text=''")
						"})
		if(findtext(world.status,"alpha")||findtext(world.status,"beta")) Medal="Beta Tester"
		if(Multikill==2) Medal="Double Kill"
		if(Multikill==3) Medal="Triple Kill"
		if(Multikill==4) Medal="Multi Kill"
		if(!Medal)return
		var/gotmedal = world.GetMedal(Medal, key)
		if(isnull(gotmedal))
			src<<output("The HUB could not be contacted, and your medal was not saved. We apologize for the inconvience.","actionoutput")
			return
		if(gotmedal) return
		src<<output("You've unlocked the [Medal] medal.","actionoutput")
		winset(src, null, {"
						mainwindow.UnlockChild.is-visible = "true";
						MedalUnlock.is-visible      = "true";
						Medal.text='[Medal]'")
					"})
		spawn(50)
			winset(src, null, {"

						mainwindow.UnlockChild.is-visible = "false";
						MedalUnlock.is-visible      = "false";
						Medal.text=''")
					"})
		world.SetMedal(Medal,key)
		src<<output("Medals have been saved successfully.","actionoutput")
