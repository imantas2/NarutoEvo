mob/var/tmp
	counting=0
mob/verb/Countdown()
	set hidden=1
//	set name = "Countdown"
	if(usr.counting)
		return
	usr.counting = 1
	view() << "<font color = yellow>[usr]:THREE"
	sleep(15)
	view() << "<font color = yellow>[usr]: TWO"
	sleep(15)
	view() << "<font color = yellow>[usr]: ONE"
	sleep(15)
	view() << "<font color = yellow>[usr]: GOOO!!!"
	sleep(20)
	usr.counting=0

mob
	verb
	/*	HerosComeback()
			set hidden=1
			src<<sound(null)
			src<<sound('preview.ogg')*/
		BlueBird()
			set hidden=1
			src<<sound(null)
			src<<sound('BlueBird.ogg')
		ShaLaLa()
			set hidden=1
			src<<sound(null)
			src<<sound('ShaLaLa.ogg')
		Lovers()
			set hidden=1
			src<<sound(null)
			src<<sound('Lovers.ogg')
		MusicStop()
			set hidden=1
			src<<sound(null)