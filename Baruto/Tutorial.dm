//Briefing on the Game Status.
//strength
//Ninjutsu
//How to buy skills
//Handseals
//Skill leveling
//Interaction
//Training
//Missions
//PVP
mob/var/Tutorial=0
mob/var/tmp/TutorialStrength=0
mob/var/tutorialskilltree=0
obj/Tutorial
	ClickMe
		icon='Misc Effects.dmi'
		icon_state="ClickMe"
		density=0
		layer=99999
mob/NPC
	Tutorial
		name="Jounin"
		density=1
		Move()return
		Death()return
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			src.overlays+='Chunin Vest.dmi'
			spawn() Stuff()
			density=1
		Starting_Jounin
			icon='MaleBase.dmi'
			//var/message
			Tutorial=0
			density=1
			DblClick()
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","actionoutput")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src] says, Hey there, welcome to Naruto: Evolution. We're glad you made the decision to stop in and check it out. You're now
in the tutorial for the game, and we'll be informing you on in-game knowledge. One of the first things you'll probably notice is the interface. I'm going to give
you a little run down of everything that is in the interface. "},"[src]")
				if(usr) usr.skalert({"[src] says, First we have the chat bar, over to the left of the screen. You can probably see dozens of people chatting already.
You can toggle this on or off with the \"Chat\" button at the bottom of the screen. To the right of the screen we have the action output. This will
inform you of every action you do, and anyone around you does. Important events and news will appear in this window. From there, there are a number
of buttons that you can explore yourselves, each doing a different thing, and all easily understandable by their name. Please move on to the next Jounin."},"[src]")
				if(usr)
					usr.Tutorial=1
					usr.move=1
		JouninOne
			icon='MaleBase.dmi'
			//var/message
			Tutorial=1
			density=1
			DblClick()
				if(!usr.TutorialStrength)usr.TutorialStrength=usr.strength
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","actionoutput")
					return
				if(usr.strength<usr.TutorialStrength)
					if(usr) usr.skalert({"[src] says, Hey, talk to me when you've increased your strength. I can't teach the weak! Use A to attack the logs, and watch the action output in the bottom. Speak to me again when your strength reaches level two."},"[src]")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src] says, Howdy there. I am the strength trainer, and I'll be explaining how strength works, and the benefits. Firstly, you should know
that the macro A is to attack an enemy player, and the macro TAB is to cycle through targets nearest you. If you're interesting in fighting using strength styles, then
using attacks coupled with a target, will increase your effectiveness."},"[src]")

				if(usr)usr.skalert({"[src] says, When you have an enemy targetted, you will automatically look in their direction when
fighting. This can help you track and hit your target more often than if you were not targetting. If you choose your speciality to be strength, you will notice an bonus given
towards your strength stat, and the ability to do combos emerges. Combos increase your damage, and allow you to throw kicks and punches towards your opponent faster than a normal
ninja would be able to. You can train your strength and Strength skills whilst in combat, or hone them up on logs. The logs in the Dojos will not reward as much experience as those outside, however. Anywho! That should wrap up the basics of strength, please move on to the next Jounin."},"[src]")
				if(usr)
					usr.Tutorial=2
					usr.move=1
		JouninTwo
			icon='MaleBase.dmi'
		//	var/message
			Tutorial=2
			density=1
			DblClick()
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","actionoutput")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src] says, Hey there, I am the Ninjutsu trainer. I'll be explaining how the art of Ninjutsu works, and how it plays in Naruto: Evolution. To many, Ninjutsu is one of the most vital
roles in a Naruto game. They're probably right, because it does indeed play a large role! In Naruto: Evolution you must first learn techniques via the skill tree, found on the lower bar of the screen. Once you have learned a technique
you can then read the handsigns by clicking the 'Jutsus' tab on the same bar. Using the macros displayed next to the technique, you can preform the jutsu, and execute it by pressing the spacebar. Eventually, you will be able to macro these techniques
and be able to add them to your hotslot bar. Once you have used the technique 100 times, you will be able to press P, and drag it on dow nto your hotbar where you can use it at will. Another important factor in
training Ninjutsu is the levels each technique has. Most techniques will have a mastery level, and it will influence the technique in certain ways depending on it's level. Through using this technique, you will be able to increase your mastery level, and preform
the technique much greater than others."},"[src]")
				if(usr)
					usr.Tutorial=3
					usr.move=1
					usr<<"Please open up your skill tree before continuing and purchase the Substitution Technique, under Non Clan Skills."
		Ending_Jounin
			icon='MaleBase.dmi'
			Tutorial=3
			density=1
		//	var/message
			DblClick()
				if(!usr.tutorialskilltree)
					usr<<"Open up your skill tree first, and purchase the Substitution Technique under Non Clan Skills."
					return
				if(!usr.JutsusLearnt.Find(/obj/Jutsus/BodyReplace))
					usr<<"Open up your skill tree first, and purchase the Substitution Technique under Non Clan Skills."
					return
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","actionoutput")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src] says, Hi. I'm the final Jounin instructor for Naruto: Evolution. I'll be briefing you on the other systems found within the game.
Although most would prefer training in the Dojos, or using logs-- there are many other factors that come into play when playing. You could do missions to gather rewards, or even team up with a squad.
Using a combination of missions and squads, will allow you to gain much more experience than others. "},"[src]")
				if(usr) usr.skalert({"[src] says, The game encourages teamwork and player communication, and thus will reward much more depending
on if you use them. Another important aspect is PVP. However PVP is much more enforced than on other games, and you could get struck down by enemy shinobi, or even your own village shinobi if you act out!
NPC guardians are at every village in the game, and they're just waiting to pounce on aggressors-- so watch out who you attack! This should wrap up the tutorial for now. Head on out those doors to proceed into the
real world. Here's a refresher book, should you ever forget what we taught you. In order to proceed through the doors of this tutorial, you will have to take down one Rogue Shinobi-- they await you outside these doors."},"[src]")
				if(usr)
					usr.Tutorial=4
					usr.move=1