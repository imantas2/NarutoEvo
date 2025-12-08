mob
	var
		Password
		Username

mob/player
	Login()
		var/mob/EYEBALL=new()
		EYEBALL.name="EYE"
		EYEBALL.loc=locate(101,100,7)
		EYEBALL.density=0
		EYEBALL.invisibility=1
		EYEBALL.byakuview = 0
		EYEBALL.canteleport = 0
		src.client.eye=EYEBALL
		src.client:perspective = EYE_PERSPECTIVE
		spawn()
			new /obj/Titlescreen/Logo
		winset(src, null, {"
							Maplink.right=titlescreen;
							mainwindow.is-maximized=true
							mainwindow.UnlockChild.is-visible = "false";
							mainwindow.InvenChild.is-visible = "false";
							Stats.is-visible      = "false";
							SkillBar.is-visible      = "false";
							ChatOut.is-visible      = "false";
							target.is-visible = "false";
							ActionOutputChild.is-visible      = "false";
						"})
	verb
		Logins()
			set hidden =1
			for(var/client/A in world)
				if(src.client.computer_id == A.computer_id)
					src<<"Multi keying is fixed."
					src.Logout()
				else
					var/LoginID=winget(src,"titlescreen.Username","text")
					var/LoginPW=winget(src,"titlescreen.Password","text")
					LoginID=lowertext(LoginID)
					var/letter = copytext(LoginID,1,2)
					if(hasSavefile(LoginID))
						var/savefile/F = new("Players/[lowertext(letter)]/[lowertext(LoginID)].sav")
						var/Pass
						F["Password"] >> PasswordRight
						if(!hasSavefile(LoginID))
							src.skalert("Invalid Account ID.","Invalid")
							return
						if(LoginPW!=PasswordRight)
							src.skalert("Invalid Password.","Invalid")
							return
						if(!PasswordRight)
							src.skalert("Please enter a password.","Invalid")
							return
						if(!LoginID)
							src.skalert("Please enter an account ID.","Invalid")
							return
						LoadCharacter(LoginID,F)
					else
						src.skalert("Invalid Account ID.","Invalid")
						return
