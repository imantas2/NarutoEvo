obj/var/Colorable=1
mob/NPC
	New()
		NewStuff()
		..()
	layer=MOB_LAYER
	move=0
	var/list/OriginalOverlays=list()
//	New()
//		spawn() Stuff()
//		src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
//		src.overlays+='Shirt.dmi'
//		src.overlays+='Sandals.dmi'
//		OriginalOverlays=overlays
//		..()
	Death()return
	Move()return
	proc/Stuff()
		spawn(20)
			while(src)
				if(OriginalOverlays.len) overlays=OriginalOverlays.Copy()
				icon_state=""
				sleep(10)
	Hair_Stylist
		name="Barber"
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.Name(name)
			spawn() Stuff()
			..()
		icon='MaleBase.dmi'
		pixel_x=-15
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			var/obj/Hair = usr.CustomInput("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut","Deidara V1","Deidara V2","Deidara V3","Spikey","Mohawk","Neji Hair","Distance"))
			switch(Hair.name)
				if("Long") usr.HairStyle='Long.dmi'
				if("Short") usr.HairStyle='Short.dmi'
				if("Tied Back") usr.HairStyle='Short2.dmi'
				if("Bald") usr.HairStyle=null
				if("Bowl Cut") usr.HairStyle='Short3.dmi'
				if("Deidara V1") usr.HairStyle='Deidara.dmi'
				if("Deidara V2") usr.HairStyle='DeidaraHair.dmi'
				if("Deidara V3") usr.HairStyle='NewDeidara.dmi'
				if("Spikey") usr.HairStyle='Spikey.dmi'
				if("Mohawk") usr.HairStyle='Mohawk.dmi'
				if("Neji Hair") usr.HairStyle='Neji Hair.dmi'
				if("Distance") usr.HairStyle='Distance.dmi'

			var/list/Colors=usr.ColorInput("Please select a hair color.")
			usr.HairColorRed=text2num(Colors[1])
			usr.HairColorGreen=text2num(Colors[2])
			usr.HairColorBlue=text2num(Colors[3])
			HairColorStyle=null
			usr.RestoreOverlays()
	Clothier
		icon='MaleBase.dmi'
		pixel_x=-15
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.Name(name)
			spawn() Stuff()
			..()
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			var/newitems=usr.items+1
			if(newitems>usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","actionoutput")
				return
			usr.move=0
			var/list/Options=list()
			for(var/obj/Inventory/Clothing/C in world)
				if(C.loc==locate(199,199,2)) Options["[C.name]-[C.Cost] Ryo"]=C
			var/obj/Choice = usr.CustomInput("Purchase","What would you like to purchase?",Options + "Cancel",0)
			if(Choice.name=="Cancel")
				usr.move=1
				return
			var/obj/S = Options["[Choice]"]
			if(usr.Ryo>=S.Cost)
				var/obj/I=new S.type()
				if(I.Colorable)
					var/list/Colors=usr.ColorInput("What colour would you like the [I] to be?")
					var/icon/X=new(I.icon)
					X.Blend(rgb(text2num(Colors[1]),text2num(Colors[2]),text2num(Colors[3])),ICON_ADD)
					I.icon=X
				usr.itemAdd(I)
				usr<<output("You bought the [S.name] for [S.Cost] Ryo.","actionoutput")
				usr.Ryo-=S.Cost
				usr.move=1
			else
				usr.move=1
				usr<<output("You need [S.Cost] Ryo to purchase this.","actionoutput")
				return
				//obj/Inventory/Clothing/Vests/Robe
	Weapons_Dealer
		icon='MaleBase.dmi'
		pixel_x=-15
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.Name(name)
			spawn() Stuff()
			..()
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			usr.move=0
			var/list/Options=list()
			for(var/obj/Inventory/Weaponry/C in world)
				if(C.loc==locate(199,199,2)) Options["[C.name]-[C.Cost] Ryo"]=C
			var/obj/Choice=usr.CustomInput("Purchase","What would you like to purchase?",Options + "Cancel")
			if(Choice.name=="Cancel")
				usr.move=1
				return
			var/obj/S = Options["[Choice]"]
			var/Num=usr.skinput2("How many would you like to buy?","Purchase",null,1)
			if(!isnum(Num))
				usr.move=1
				return
			var/RealPrice=S.Cost*Num
			var/newitems=usr.items+Num
			if(newitems>usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","actionoutput")
				usr.move=1
				return
			if(Num<=0)
				usr.move=1
				return
			if(usr.Ryo>=RealPrice)
				for(var/i=Num,i>0,i--)
					var/obj/I=new S.type()
					usr.itemAdd(I)
				usr<<output("You bought [Num] [S.name](s) for [RealPrice] Ryo.","actionoutput")
				usr.Ryo-=RealPrice
				usr.move=1
			else
				usr<<output("You need [RealPrice] Ryo to purchase this.","actionoutput")
				usr.move=1
				return
	Banker
		icon='MaleBase.dmi'
		pixel_x=-15
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.Name(name)
			spawn() Stuff()
			..()
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			if(!usr.move) return
			usr.move=0
			switch(usr.skalert("You have [usr.Ryo] Ryo on you and [usr.RyoBanked] banked here.","Bank",list("Deposit","Withdraw","Cancel")))
				if("Cancel")
					usr.move=1
					return
				if("Withdraw")
					if(!usr.RyoBanked)
						usr << output("[src] says, You do not have any Ryo to withdraw","actionoutput")
					else
						var/Num=usr.skinput2("How much would you like to withdraw?","Ryo Withdraw",null,1)
						if(!isnum(Num))
							usr.move=1
							return
						if(usr.RyoBanked<Num||Num<=0)
							usr.move=1
							return
						usr.Ryo+=Num
						usr.RyoBanked-=Num
						usr << output("[src] says, Thanks, here's your Ryo.","actionoutput")
					usr.move=1
					return
				if("Deposit")
					if(!usr.Ryo)
						usr << output("[src] says, You don't have any Ryo to deposit","actionoutput")
					else
						var/Num=usr.skinput2("How much would you like to deposit?","Ryo Deposit",null,1)
						if(!isnum(Num))
							usr.move=1
							return
						if(usr.Ryo<Num||Num<=0)
							usr.move=1
							return
						usr.RyoBanked+=Num
						usr.Ryo-=Num
						usr << output("[src] says,  Thank you for your deposit.","actionoutput")
					usr.move=1
					return