//I'll continue some other time lmao too much thinking to do and all those images XD so screw it...till later :D

turf
	hoteltransport
		density=0
		icon='Misc Effects.dmi'
		icon_state="transport_for_hotel"
		Enter(mob/M)
			if(M.skalert("Do you wish to enter the Hotel?","Hotel?",list("No","Yes"))=="No") return
			M.loc=locate(40,22,20)
			M<<output("<font color=white>Welcome to the Universal Hotel ! Double click on NPC left from you for detailed help.","actionoutput")

mob
	var
		hasapartmant=0
	hotel
		npc1
			icon='MaleBase.dmi'
			density = 1
			name="Hotel Guide"
			New()
				var/s=rand(1,3)
				if(s==1)
					src.overlays+='Deidara.dmi'
				if(s==2)
					src.overlays+='Long.dmi'
				if(s==3)
					src.overlays+='Short.dmi'
				src.overlays+='SandChuninVest.dmi'
				src.overlays+='Sandals.dmi'
				src.Name(src.name)
			DblClick()
				if(get_dist(src,usr)>1) return
				var/text = {"Hotel Usage Guide:
				</br>
				</br>
				This hotel system will allow you to buy and use your personal apartmans inside the hotel.
				</br>
				You can store items inside it. You can buy furniture for it.
				</br>
				To buy it double click on Hotel Menager and click on buy, if you have enough ryo for it.
				</br>
				To buy furniture double click on Apartmant Main inside your apartman.
				</br>
				To store cash double click on storage chest and add an item you want.
				</br>
				</br>
				---Enjoy :D
							"}
				src << browse(text, "window=HOTEL;size=500x350")
		npc2
			icon='hotel.dmi'
			icon_state="Basic Ninja Skills Teacher"
			density = 1
			name="Menager"
			DblClick()
				if(get_dist(src,usr)>1) return
				if(usr.hasapartmant==1)
					usr<<output("You already have an appartmant...","actionoutput")
					return
				else
					if(usr.skalert("Are you sure you want to buy a hotel apartmant? If your not sure what it means check the other NPC over there...Cost for the apartmant is 50 000 ryo.","Buy Apartmant?",list("No","Yes"))=="No") return
					if(usr.Ryo<50000)
						usr<<output("<font color=red>You do not have 50k ryo with you. Buying aborted.","actionoutput")
						return
					else
						return
