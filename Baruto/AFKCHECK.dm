var/AFKLog=file("Logs/AFK Log.txt")
proc
	AutoCheck()
		set background=1
		var/SleepTime=rand(18000,27000)//30 and 45 mins
		sleep(SleepTime)//sleep a random amount of time so players can't predict when the next check is
		world<<"<font color=red>Exp lock was auto initiated! Everyone on the server is now officially Exp Locked!"
		world<<"<font color=red>Please use the command \"Remove Exp Lock\" under the options pane to remove the lock!"
		for(var/mob/M in world)
			if(M.key)
				M.ExpLock=1
				M.Save()
			else
				continue
		AutoCheck()