obj
	BuildingSigns
		icon = 'Signs.dmi'
		layer=TURF_LAYER+3
		Dojo
			icon_state = "Dojo"
		Kage
			icon_state = "Kage"
		Exam
			icon_state = "Exam"
		Barber
			icon_state="Barber"
		Weapon
			icon_state="Weapons"
		Clothes
			icon_state="Clothes"
		Hotel
			icon_state="hotel"
	LeafVillage
		KHTop
			icon='KH.dmi'
			icon_state="top"
			layer=MOB_LAYER+1
	TallBuilding1
		icon = 'TallB1.dmi'
		icon_state = "1"
		New()
			src.overlays+=image('TallB1.dmi',icon_state = "2",pixel_y=233,layer=MOB_LAYER+1)
		density=1
turf
	LeafVillage
		name="Building"
		icon='GRND.dmi'
		PHQ
			icon='PoliceHQ.dmi'
		KH
			icon='KH.dmi'
		Hospital
			icon='Hospital.dmi'
			layer=TURF_LAYER+2
		KHBuilding
			layer=TURF_LAYER+2
			icon='KHB.dmi'
			One
				icon_state="1"
			Two
				icon_state="2"
			Three
				icon_state="3"
			Four
				icon_state="4"
			Five
				icon_state="5"
			Six
				icon_state="6"
		Generator
			icon='PS.dmi'
			layer=MOB_LAYER+1
		Concrete
			icon='Concrete.dmi'
			Entered(var/mob/U)
				if(istype(U,/mob))
					if(usr.stepcounter==3&&usr.speeddelay==2)
						usr.stepcounter=0
						if(U.foot=="Left")
							view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
							U.foot="Right"
						else
							if(U.foot=="Right")
								view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
								U.foot="Left"
					else
						if(usr.stepcounter==5&&usr.speeddelay==1.5)
							usr.stepcounter=0
							if(U.foot=="Left")
								view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
								U.foot="Right"
							else
								if(U.foot=="Right")
									view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
									U.foot="Left"
						else
							usr.stepcounter++
			SideWalk
				icon_state="SW"
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
			DecorationMiddle
				icon_state="decoM"
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
			StairMiddle
				icon_state="StairM"
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
			Middle
				icon_state="middle"
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
			Top
				icon_state="T"
				density=1
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
			Bottom
				icon_state="B"
				density=1
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
			BottomMiddle
				icon_state="BM"
				density=1
				New()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
		EntranceTop
			icon='EntranceT.dmi'
			//pixel_y=-1
			layer=MOB_LAYER+6
			ET0_0/icon_state = "0,0"
			ET1_0/icon_state = "1,0"
			ET2_0/icon_state = "2,0"
			ET3_0/icon_state = "3,0"
			ET4_0/icon_state = "4,0"
			ET5_0/icon_state = "5,0"
			ET10_0/icon_state = "10,0"
			ET11_0/icon_state = "11,0"
			ET12_0/icon_state = "12,0"
			ET13_0/icon_state = "13,0"
			ET14_0/icon_state = "14,0"
			ET15_0/icon_state = "15,0"
			ET16_0/icon_state = "16,0"
			ET0_1/icon_state = "0,1"
			ET1_1/icon_state = "1,1"
			ET2_1/icon_state = "2,1"
			ET3_1/icon_state = "3,1"
			ET4_1/icon_state = "4,1"
			ET5_1/icon_state = "5,1"
			ET6_1/icon_state = "6,1"
			ET7_1/icon_state = "7,1"
			ET8_1/icon_state = "8,1"
			ET9_1/icon_state = "9,1"
			ET10_1/icon_state = "10,1"
			ET11_1/icon_state = "11,1"
			ET12_1/icon_state = "12,1"
			ET13_1/icon_state = "13,1"
			ET14_1/icon_state = "14,1"
			ET15_1/icon_state = "15,1"
			ET16_1/icon_state = "16,1"
			ET0_2/icon_state = "0,2"
			ET1_2/icon_state = "1,2"
			ET2_2/icon_state = "2,2"
			ET3_2/icon_state = "3,2"
			ET4_2/icon_state = "4,2"
			ET5_2/icon_state = "5,2"
			ET6_2/icon_state = "6,2"
			ET7_2/icon_state = "7,2"
			ET8_2/icon_state = "8,2"
			ET9_2/icon_state = "9,2"
			ET10_2/icon_state = "10,2"
			ET11_2/icon_state = "11,2"
			ET12_2/icon_state = "12,2"
			ET13_2/icon_state = "13,2"
			ET14_2/icon_state = "14,2"
			ET15_2/icon_state = "15,2"
			ET16_2/icon_state = "16,2"
			ET0_3/icon_state = "0,3"
			ET1_3/icon_state = "1,3"
			ET2_3/icon_state = "2,3"
			ET3_3/icon_state = "3,3"
			ET4_3/icon_state = "4,3"
			ET5_3/icon_state = "5,3"
			ET6_3/icon_state = "6,3"
			ET7_3/icon_state = "7,3"
			ET8_3/icon_state = "8,3"
			ET9_3/icon_state = "9,3"
			ET10_3/icon_state = "10,3"
			ET11_3/icon_state = "11,3"
			ET12_3/icon_state = "12,3"
			ET13_3/icon_state = "13,3"
			ET14_3/icon_state = "14,3"
			ET15_3/icon_state = "15,3"
			ET16_3/icon_state = "16,3"
			ET2_4/icon_state = "2,4"
			ET3_4/icon_state = "3,4"
			ET4_4/icon_state = "4,4"
			ET5_4/icon_state = "5,4"
			ET6_4/icon_state = "6,4"
			ET7_4/icon_state = "7,4"
			ET8_4/icon_state = "8,4"
			ET9_4/icon_state = "9,4"
			ET10_4/icon_state = "10,4"
			ET11_4/icon_state = "11,4"
			ET12_4/icon_state = "12,4"
			ET13_4/icon_state = "13,4"
			ET2_5/icon_state = "2,5"
			ET3_5/icon_state = "3,5"
			ET4_5/icon_state = "4,5"
			ET5_5/icon_state = "5,5"
			ET6_5/icon_state = "6,5"
			ET7_5/icon_state = "7,5"
			ET8_5/icon_state = "8,5"
			ET9_5/icon_state = "9,5"
			ET10_5/icon_state = "10,5"
			ET11_5/icon_state = "11,5"
			ET12_5/icon_state = "12,5"
			ET13_5/icon_state = "13,5"
			Entered(var/mob/U)
				if(istype(U,/mob))
					if(usr.stepcounter==3&&usr.speeddelay==2)
						usr.stepcounter=0
						if(U.foot=="Left")
							view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
							U.foot="Right"
						else
							if(U.foot=="Right")
								view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
								U.foot="Left"
					else
						if(usr.stepcounter==5&&usr.speeddelay==1.5)
							usr.stepcounter=0
							if(U.foot=="Left")
								view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
								U.foot="Right"
							else
								if(U.foot=="Right")
									view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
									U.foot="Left"
						else
							usr.stepcounter++
		EntranceBottom
			density=1
			icon='EntranceB.dmi'
			EB3_0/icon_state = "3,0"
			EB4_0
				icon_state = "4,0"
				density=0
			EB5_0
				icon_state = "5,0"
				density=0
			EB6_0
				icon_state = "6,0"
				density=0
			EB7_0
				icon_state = "7,0"
				density=0
			EB8_0
				icon_state = "8,0"
				density=0
			EB9_0
				icon_state = "9,0"
				density=0
			EB10_0
				icon_state = "10,0"
				density=0
			EB11_0
				icon_state = "11,0"
				density=0
			EB12_0/icon_state = "12,0"
			EB0_1/icon_state = "0,1"
			EB1_1/icon_state = "1,1"
			EB2_1/icon_state = "2,1"
			EB3_1/icon_state = "3,1"
			EB4_1/icon_state = "4,1"
			EB5_1
				icon_state = "5,1"
				density=0
			EB6_1
				icon_state = "6,1"
				density=0
			EB7_1
				icon_state = "7,1"
				density=0
			EB8_1
				icon_state = "8,1"
				density=0
			EB9_1
				icon_state = "9,1"
				density=0
			EB10_1
				icon_state = "10,1"
				density=0
			EB11_1/icon_state = "11,1"
			EB12_1/icon_state = "12,1"
			EB13_1/icon_state = "13,1"
			EB14_1/icon_state = "14,1"
			EB15_1/icon_state = "15,1"
			EB16_1/icon_state = "16,1"
			EB0_2/icon_state = "0,2"
			EB1_2/icon_state = "1,2"
			EB2_2/icon_state = "2,2"
			EB3_2/icon_state = "3,2"
			EB4_2/icon_state = "4,2"
			EB5_2
				icon_state = "5,2"
				//layer=MOB_LAYER+6
			EB10_2
				icon_state = "10,2"
				//layer=MOB_LAYER+6

			EB11_2/icon_state = "11,2"
			EB12_2/icon_state = "12,2"
			EB13_2/icon_state = "13,2"
			EB14_2/icon_state = "14,2"
			EB15_2/icon_state = "15,2"
			EB16_2/icon_state = "16,2"
			EB0_3/icon_state = "0,3"
			EB1_3/icon_state = "1,3"
			EB2_3/icon_state = "2,3"
			EB3_3/icon_state = "3,3"
			EB4_3/icon_state = "4,3"
			EB5_3
				icon_state = "5,3"
				//layer=MOB_LAYER+6
			EB10_3
				icon_state = "10,3"
				//layer=MOB_LAYER+6
			EB11_3/icon_state = "11,3"
			EB12_3/icon_state = "12,3"
			EB13_3/icon_state = "13,3"
			EB14_3/icon_state = "14,3"
			EB15_3/icon_state = "15,3"
			EB16_3/icon_state = "16,3"
			EB0_4/icon_state = "0,4"
			EB1_4/icon_state = "1,4"
			EB2_4/icon_state = "2,4"
			EB3_4/icon_state = "3,4"
			EB4_4/icon_state = "4,4"
			EB5_4
				icon_state = "5,4"
				//layer=MOB_LAYER+6
			EB10_4
				icon_state = "10,4"
				//layer=MOB_LAYER+6
			EB11_4/icon_state = "11,4"
			EB12_4/icon_state = "12,4"
			EB13_4/icon_state = "13,4"
			EB14_4/icon_state = "14,4"
			EB15_4/icon_state = "15,4"
			EB16_4/icon_state = "16,4"
		WallBottom
			density=1
			icon='EntranceWallB.dmi'
			B00
				icon_state="00"
			B01
				icon_state="01"
			B02
				icon_state="02"
		WallEdgeBottom
			density=1
			icon='EntranceWallEdgeB.dmi'
			Left
				L00
					icon_state="L00"
				L01
					icon_state="L01"
				L02
					icon_state="L02"
			Right
				R00
					icon_state="R00"
				R01
					icon_state="R01"
				R02
					icon_state="R02"
		WallTop
			icon='EntranceWallT.dmi'
			layer=MOB_LAYER+6
			T00
				icon_state="00"
			T01
				icon_state="01"
			T02
				icon_state="02"
			T03
				icon_state="03"
			T04
				icon_state="04"
			Entered(var/mob/U)
				if(istype(U,/mob))
					if(usr.stepcounter==3&&usr.speeddelay==2)
						usr.stepcounter=0
						if(U.foot=="Left")
							view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
							U.foot="Right"
						else
							if(U.foot=="Right")
								view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
								U.foot="Left"
					else
						if(usr.stepcounter==5&&usr.speeddelay==1.5)
							usr.stepcounter=0
							if(U.foot=="Left")
								view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
								U.foot="Right"
							else
								if(U.foot=="Right")
									view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
									U.foot="Left"
						else
							usr.stepcounter++
		WallEdgeTop
			icon='EntranceWallEdgeT.dmi'
			layer=MOB_LAYER+6
			Entered(var/mob/U)
				if(istype(U,/mob))
					if(usr.stepcounter==3&&usr.speeddelay==2)
						usr.stepcounter=0
						if(U.foot=="Left")
							view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
							U.foot="Right"
						else
							if(U.foot=="Right")
								view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
								U.foot="Left"
					else
						if(usr.stepcounter==5&&usr.speeddelay==1.5)
							usr.stepcounter=0
							if(U.foot=="Left")
								view(U,6) << sound('Sounds/Walk/man_fs_l_mt_con.ogg',0,0,0,25)
								U.foot="Right"
							else
								if(U.foot=="Right")
									view(U,6) << sound('Sounds/Walk/man_fs_r_mt_con.ogg',0,0,0,25)
									U.foot="Left"
						else
							usr.stepcounter++
			Left
				L00
					icon_state="L00"
				L01
					icon_state="L01"
				L02
					icon_state="L02"
				L03
					icon_state="L03"
				L04
					icon_state="L04"
			Right
				R00
					icon_state="R00"
				R01
					icon_state="R01"
				R02
					icon_state="R02"
				R03
					icon_state="R03"
				R04
					icon_state="R04"
