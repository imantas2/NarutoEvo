//Player Housing Created by Lavitiz for Nitis NE and his own Personal NE Project.
//Aka Naruto Next Evolution && Project Evolution
proc/SaveHouses()
	var/savefile/F=new("Houses/House.sav")
	for(var/turf/Player_Houses/House/H in world)
		F["HouseID[H.id]-Name"]<<H.name
		F["HouseID[H.id]-Owner"]<<H.Owner
		F["HouseID[H.id]-GuestList"]<<H.AllowedAccess
proc/LoadHouses()
	if(fexists("Houses/House.sav"))
		var/savefile/F=new("Houses/House.sav")
		for(var/turf/Player_Houses/House/H in world)
			F["HouseID[H.id]-Name"]>>H.name
			F["HouseID[H.id]-Owner"]>>H.Owner
			F["HouseID[H.id]-GuestList"]>>H.AllowedAccess
world/New()
	..()
	LoadHouses()
world/Del()
	SaveHouses()
	..()
world/Reboot()
	SaveHouses()
	..()
mob/var/HouseOwned=0
mob/var/HouseMenuOpened=0
turf
	Player_Houses
		Warps
			House1
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House1/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House1/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House1/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House1/Enter)
						return
						..()
			House2
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House2/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House2/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House2/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House2/Enter)
						return
						..()
			House3
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House3/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House3/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House3/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House3/Enter)
						return
						..()
			House4
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House4/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House4/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House4/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House4/Enter)
						return
						..()
			House5
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House5/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House5/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House5/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House5/Enter)
						return
						..()
			House6
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House6/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House6/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House6/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House6/Enter)
						return
						..()
			House7
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House7/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House7/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House7/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House7/Enter)
						return
						..()
			House8
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House8/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House8/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House8/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House8/Enter)
						return
						..()
			House9
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House9/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House9/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House9/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House9/Enter)
						return
						..()
			House10
				Enter
					Enter(mob/M)
						for(var/turf/Player_Houses/House/House10/H in world)
							if(H.Owner=="[M.key]")
								M.loc=locate(/turf/Player_Houses/Warps/House10/Leave)
								return
							if(M in H.AllowedAccess)
								M.loc=locate(/turf/Player_Houses/Warps/House10/Leave)
								return
							M<<"This is not your house and you're not on the guest list."
							return 0
						..()
				Leave
					Enter(mob/M)
						M.loc=locate(/turf/Player_Houses/Warps/House10/Enter)
						return
						..()
		House
			var/Owner="None"
			var/list/AllowedAccess=new/list()
			var/id
			mouse_opacity=2
			DblClick()
				if(src.Owner=="None")
					usr<<"This house is not owned by anybody."
				else
					usr<<"This house belongs to [src.Owner]."
			House1
				layer=TURF_LAYER+2
				icon='KHB.dmi'
				icon_state="1"
				name="Unowned House"
				id="001"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House2
				layer=TURF_LAYER+2
				icon='KHB.dmi'
				icon_state="1"
				name="Unowned House"
				id="002"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House3
				layer=TURF_LAYER+2
				icon='SoundBuilding.dmi'
				icon_state="1"
				name="Unowned House"
				id="003"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House4
				layer=TURF_LAYER+2
				icon='SoundBuilding.dmi'
				icon_state="1"
				name="Unowned House"
				id="004"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House5
				layer=TURF_LAYER+2
				icon='BuildingBig.dmi'
				icon_state="3"
				name="Unowned House"
				id="005"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House6
				layer=TURF_LAYER+2
				icon='BuildingBig.dmi'
				icon_state="3"
				name="Unowned House"
				id="006"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House7
				layer=TURF_LAYER+2
				icon='Building_2.dmi'
				icon_state="1"
				name="Unowned House"
				id="007"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House8
				layer=TURF_LAYER+2
				icon='Building_2.dmi'
				icon_state="1"
				name="Unowned House"
				id="008"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House9
				layer=TURF_LAYER+2
				icon='KHB.dmi'
				icon_state="1"
				name="Unowned House"
				id="009"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."
			House10
				layer=TURF_LAYER+2
				icon='KHB.dmi'
				icon_state="1"
				name="Unowned House"
				id="010"
				var/Price=25000
				verb
					Buy_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(usr.HouseOwned>=1)
							usr<<"You already own a house!"
							usr.HouseMenuOpened=0
							return
						if(src.Owner==""||src.Owner=="None")
							if(usr.Ryo>=src.Price)
								switch(alert("Are you sure you want to buy this house for [src.Price] ryo?","Buy this house?","Yes","No"))
									if("Yes")
										if(src.Owner==""||src.Owner=="None")//Recheck to make sure there were not two windows open between two players
											src.Owner="[usr.key]"
											src.name="[usr.key]'s House"
											usr.HouseOwned+=1
											usr.Ryo-=src.Price
											usr.HouseMenuOpened=0
										else
											usr<<"This house is already owned by [src.Owner]."
											usr.HouseMenuOpened=0
									if("No")
										usr.HouseMenuOpened=0
										return
							else
								usr.HouseMenuOpened=0
								usr<<"You don't have enough ryo to buy this house."
						else
							usr.HouseMenuOpened=0
							usr<<"This house is already owned by [src.Owner]."

					Sell_House()
						set src in view()
						if(usr.HouseMenuOpened)return
						usr.HouseMenuOpened=1
						if(src.Owner==""||src.Owner=="None")
							usr<<"This house is not currently owned."
							usr.HouseMenuOpened=0
							return
						if(src.Owner=="[usr.key]")
							switch(alert("Are you sure you want to sell this house for [src.Price] ryo?","Sell this house?","Yes","No"))
								if("Yes")
									src.Owner="None"
									src.name="Unowned House"
									src.name="Unowned House"
									usr.HouseOwned-=1
									usr.Ryo+=src.Price
									usr.HouseMenuOpened=0
								if("No")
									usr.HouseMenuOpened=0
									return
						else
							usr.HouseMenuOpened=0
							usr<<"This house does not belong to you."
					Set_Guest_List()
						set src in view()
						if(src.Owner=="[usr.key]")
							switch(alert("Add or remove from the guest list","Guest List","Add","Remove"))
								if("Add")
									var/list/GUEST=new/list()
									for(var/mob/M in world)
										if(M.client)
											if(M in src.AllowedAccess)continue
											GUEST+=M
									var/mob/M=input("Who would you like to grant access to your house?","Guest List")as null|anything in GUEST
									if(!M)return
									if(M in src.AllowedAccess)return
									src.AllowedAccess+=M
									usr<<"You add [M] to the guest list."
									M<<"[usr] added you to their house guest list."
								if("Remove")
									var/mob/M=input("Who would you like to remove access from your house?","Guest List")as null|anything in src.AllowedAccess
									if(!M)return
									src.AllowedAccess-=M
									usr<<"You remove [M] to the guest list."
									M<<"[usr] removed you to their house guest list."
						else
							usr<<"This house does not belong to you."