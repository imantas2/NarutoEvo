mob/var/list/HotSlotSave=list("HotSlot1"=null,"HotSlot2"=null,"HotSlot3"=null,"HotSlot4"=null,"HotSlot5"=null,"HotSlot6"=null,"HotSlot7"=null,"HotSlot8"=null,"HotSlot9"=null,"HotSlot10"=null)
mob/var/XView
mob/var/YView
mob
	var/tmp/BOW
obj
	HotSlotNumber
		icon='Letters.dmi'
		layer=9999
proc/GetScreenResolution(mob/M) // Yay dynamic HUDS?!
	var/POS = "[winget(M, "label","pos")]"
	var/COMA = findtext(POS,",",1,0)
	var/X = text2num(copytext(POS,1,COMA))
	var/Y = text2num(copytext(POS,COMA+1,0))
	M.client.view="[round(X/32)]x[round(Y/32)]"
	M.XView=round(X/32)
	M.YView=round(Y/32)
obj/Titlescreen/Logo
	name="Logo"
	layer=100
	icon = 'NarutoEvoHUD.png'
	screen_loc = "CENTER-5,CENTER+2"
atom
	proc
		HotSlotNumber(text as text)
			if(length(text)>=21)
				text=copytext(text,1,21)
				text+="..."
			var/list/letters=list()
			var/CX
			var/OOE=(lentext(text))
			if(OOE%2==0) CX+=11-((lentext(text))/2*5)
			else CX+=12-((lentext(text))/2*5)
			for(var/a=1, a<lentext(text)+1, a++) letters+=copytext(text,a,a+1)
			for(var/X in letters)
				var/obj/HotSlotNumber/O=new/obj/HotSlotNumber
				O.icon_state=X
				O.pixel_x=CX
				O.pixel_y=-10
				O.pixel_x-=5
				O.icon=O.icon-src.color
				CX+=6
				src.overlays+=O
obj
	HotSlots
		Hengable=0
		HotSlot1
			name="1"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				screen_loc = "[round((M.XView/2)-3)],3"
				M.client.screen+=src
				src.loc=locate(0,0,0)
				HotSlotNumber("F1")
				..()
		HotSlot2
			name="2"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round(M.XView/2)-1],3"
				HotSlotNumber("F2")
				src.loc=locate(0,0,0)
				..()
		HotSlot3
			name="3"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+1)],3"
				HotSlotNumber("F3")
				src.loc=locate(0,0,0)
				..()
		HotSlot4
			name="4"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+3)],3"
				HotSlotNumber("F4")
				src.loc=locate(0,0,0)
				..()
		HotSlot5
			name="5"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+5)],3"
				HotSlotNumber("F5")
				src.loc=locate(0,0,0)
				..()
		HotSlot6
			name="6"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)-3)],4"
				HotSlotNumber("F6")
				src.loc=locate(0,0,0)
				..()
		HotSlot7
			name="7"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round(M.XView/2)-1],4"
				HotSlotNumber("F7")
				src.loc=locate(0,0,0)
				..()
		HotSlot8
			name="8"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+1)],4"
				HotSlotNumber("F8")
				src.loc=locate(0,0,0)
				..()
		HotSlot9
			name="9"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+3)],4"
				HotSlotNumber("F9")
				src.loc=locate(0,0,0)
				..()
		HotSlot10
			name="10"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+5)],4"
				HotSlotNumber("F10")
				src.loc=locate(0,0,0)
				..()
mob
	var
		hotslot
		hotslot1
		hotslot2
		hotslot3
		hotslot4
		hotslot5
		hotslot6
		hotslot7
		hotslot8
		hotslot9
		hotslot10
	proc
		UpdateSlots()
			for(var/obj/HotSlots/h in src.client.screen)
				if(istype(h,/obj/HotSlots/HotSlot1))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot1"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F1")
				if(istype(h,/obj/HotSlots/HotSlot2))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot2"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F2")
				if(istype(h,/obj/HotSlots/HotSlot3))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot3"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F3")
				if(istype(h,/obj/HotSlots/HotSlot4))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot4"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F4")
				if(istype(h,/obj/HotSlots/HotSlot5))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot5"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F5")
				if(istype(h,/obj/HotSlots/HotSlot6))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot6"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F6")
				if(istype(h,/obj/HotSlots/HotSlot7))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot7"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F7")
				if(istype(h,/obj/HotSlots/HotSlot8))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot8"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F8")

				if(istype(h,/obj/HotSlots/HotSlot9))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot9"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F9")
				if(istype(h,/obj/HotSlots/HotSlot10))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot10"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F10")
			/*for(var/obj/Jutsus/J in world)
				if(J.name==hotslot1)
					for(var/obj/HotSlots/HotSlot1/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F1")
				if(J.name==hotslot2)
					for(var/obj/HotSlots/HotSlot2/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F2")
				if(J.name==hotslot3)
					for(var/obj/HotSlots/HotSlot3/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F3")
				if(J.name==hotslot4)
					for(var/obj/HotSlots/HotSlot4/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F4")
				if(J.name==hotslot5)
					for(var/obj/HotSlots/HotSlot5/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F5")*/
		doslot(txt)
			if(txt=="Gravity Divergence: Almighty Push")usr.AlmightyPush()
			if(txt=="Temple of Nirvana")usr.Temple_Of_Nirvana()
			if(txt=="Bone Sensation")usr.Bone_Sensation()
			if(txt=="Bone Pulse")usr.Bone_Pulse()
			if(txt=="Bone Tip")usr.Bone_Tip()
			if(txt=="Shadow Choke")usr.Shadow_Choke()
			if(txt=="Shadow Stab")usr.Shadow_Stab()
			if(txt=="Shadow Bind")usr.Shadow_Extension()
			if(txt=="Water Clone")usr.MizuClone_Jutsu()
			if(txt=="Water Prison")usr.WaterPrison()
			if(txt=="Rasenshuriken")usr.Rasenshuriken()
			if(txt=="Water Shark Projectile")usr.WaterShark()
			if(txt=="Tsukiyomi")usr.Tsukiyomi()
			if(txt=="Wind Sheild")usr.Wind_Sheild()
			if(txt=="Earth Release: Mud River")usr.Earth_Release_Mud_River()
			if(txt=="Earth Disruption")usr.Earth_Disruption()
			if(txt=="Mystical Palms")usr.Mystical_Palms()
			if(txt=="Amaterasu")usr.Amaterasu()
			if(txt=="Demonic Illusion: Tree Binding Death")usr.TreeBinding()
			if(txt=="Susanoo")usr.Susanoo()
			if(txt=="Chidori Jinrai")usr.Chidori_Jinrai()
			if(txt=="Kirin")usr.Kirin()
			if(txt=="Chidori Needles")usr.Chidori_Needles()
			if(txt=="Rasengan")usr.Rasengan()
			if(txt=="Chidori")usr.Chidori()
			if(txt=="Sickle Weasel Technique")usr.Sickle_Weasel_Technique()
			if(txt=="Morning Peacock")usr.Morning_Peacock()
			if(txt=="Leaf Whirlwind")usr.Leaf_Whirlwind()
			if(txt=="Meteor Punch")usr.Meteor_Punch()
			if(txt=="Clone Jutsu")usr.Clone_Jutsu()
			if(txt=="Chakra Release")usr.Chakra_Release()
			if(txt=="Sharingan")usr.Sharingan()
			if(txt=="Advanced Body Replacement Jutsu")usr.Advanced_Body_Replacement_Technique()
			if(txt=="Chakra Control")usr.Chakra_Control()
			if(txt=="Body Replacement Jutsu")usr.Body_Replacement_Technique()
			if(txt=="Transformation Jutsu")usr.Transformation_Jutsu()
			if(txt=="Clone Destroy")usr.Clone_Jutsu_Destroy()
			if(txt=="Fire Release: Fire Ball")usr.Fire_Ball()
			if(txt=="Fire Release: Blazing Sun")usr.AFire_Ball()
			if(txt=="Fire Release: Phoenix Immortal Fire Technique")usr.Phoenix_Immortal_Fire_Technique()
			if(txt=="Fire Release: Fire Dragon Projectile")usr.Fire_Dragon_Projectile()
			if(txt=="Gravity Divergence: Induction")usr.Induction()
			if(txt=="Gravity Divergence: Repulsion")usr.Repulsion()
			if(txt=="Body Flicker Technique")usr.Shunshin()
			if(txt=="Byakugan")usr.Byakugan()
			if(txt=="Eight Trigrams: 64 Palms")usr.Eight_Trigrams_64_Palms()
			if(txt=="Earth Release: Earth Cage")usr.Earth_Release_Earth_Cage()
			if(txt=="Multiple Shadow Clone Jutsu")usr.MultipleShadowClone_Jutsu()
			if(txt=="Eight Trigrams Palm: Heavenly Spin")usr.Kaiten()
			if(txt=="Sensatsu Suishou")usr.Sensatsu_Suisho()
			if(txt=="Water Release: Exploding Water Colliding Wave")usr.Water_Release_Exploding_Water_Colliding_Wave()
			if(txt=="Fire Release: Ash Pile Burning")usr.Fire_Release_Ash_Pile_Burning()
			if(txt=="Demonic Ice Mirrors")usr.Demonic_Ice_Mirrors()
			if(txt=="Heal")usr.Heal()
			if(txt=="Chakra Control")usr.Chakra_Control()
			if(txt=="Opening Gate")usr.Gate_1()
			if(txt=="Energy Gate")usr.Gate_2()
			if(txt=="Life Gate")usr.Gate_3()
			if(txt=="Pain Gate")usr.Gate_4()
			if(txt=="Limiter Gate")usr.Gate_5()
			if(txt=="Young Bracken Dance")usr.Young_Bracken_Dance()
			if(txt=="Eight Trigrams: Empty Palm")usr.Eight_Trigrams_Empty_Palm()
			if(txt=="First Puppet Summoning")usr.First_Puppet_Summoning()
			if(txt=="Second Puppet Summoning")usr.Second_Puppet_Summoning()
			if(txt=="Puppet Dash")usr.Puppet_Dash()
			if(txt=="Puppet Shoot")usr.Puppet_Shoot()
			if(txt=="Puppet Grab")usr.Puppet_Grab()
			if(txt=="Puppet Transform")usr.Puppet_Transform()
			if(txt=="Angel Wings")usr.Angel_Wings()
			if(txt=="C2")usr.C2()
			if(txt=="C3")usr.C3()
			if(txt=="C1: Tracking Birds")usr.ClayBirds()
			if(txt=="C1: Spider Swarm")usr.ClaySpiders()
			if(findtext(txt,"Sharingan"))usr.Sharingan()
			if(txt=="Shukakku Spear")usr.Shukakku_Spear()
			if(txt=="Desert Coffin")usr.Desert_Coffin()
			if(txt=="Sand Shuriken")usr.Sand_Shuriken()
			if(txt=="Insect Clone")usr.InsectClone()
			if(txt=="Destruction Bug Swarm")usr.Destruction_Bug_Swarm()
			if(txt=="Stealth Bug")usr.Stealth_Bug()
			if(txt=="Crow Clone")usr.Crow_Clone()
			if(txt=="Shikigami Spear")usr.Shikigami_Spear()
			if(txt=="Paper Chakram")usr.Paper_Chakram()
			if(txt=="Shikigami Dance")usr.Shikigami_Dance()
			if(txt=="Sand Funeral")usr.Sand_Funeral()
			if(txt=="Sand Sheild")usr.Sand_Sheild()
			if(txt=="Sharingan Copy")usr.Sharingan_Copy()
			if(txt=="Chakra Leech")usr.Chakra_Leech()
			if(txt=="Camellia Dance")usr.Camellia_Dance()
			if(txt=="Sorcery: Death Ruling Possesion Blood")usr.Death_Ruling_Possesion_Blood()
			if(txt=="Sacrifice to Jashin")usr.Immortality()
			if(txt=="Immortal") src.Immortal()
			if(txt=="Destruction Bug Neurotoxin")usr.Bug_Neurotoxin()
			if(txt=="Destruction Bug Hunter Scarabs")usr.Hunter_Scarabs()
			if(txt=="Insect Coccoon")usr.Insect_Coccoon()
			if(txt=="Earth Release: Dark Swamp")usr.Earth_Style_Dark_Swamp()
			if(txt=="Eight Trigrams: Mountain Crusher")usr.Eight_Trigrams_Mountain_Crusher()
			if(txt=="Last Resort: Eight Gates Assault")usr.Eight_Gates_Assault()
			if(txt=="Bone Drill")usr.Bone_Drill()
			if(txt=="Bringer of Darkness Technique")usr.Bringer_of_Darkness_Technique()
			if(txt=="Blade of Wind")usr.Blade_of_Wind()
			if(txt=="Raikiri")usr.Raikiri()
			if(txt=="Leaf Hidden Finger Jutsu: One Thousand Years of Death")usr.One_Thousand_Years_of_Death()
			if(txt=="One's Own Life Reincarnation")usr.Ones_Own_Life_Reincarnation()
			if(txt=="Achiever of Nirvana Fist")usr.Achiever_of_Nirvana_Fist()
			if(txt=="Poison Mist")usr.Poison_Mist()
			if(txt=="Cherry Blossom Impact")usr.Cherry_Blossom_Impact()
			if(txt=="Blade Manipulation Jutsu")usr.Blade_Manipulation_Jutsu()
			if(txt=="Water Dragon Projectile")usr.Water_Dragon_Projectile()
			if(txt=="Fire Dragon Projectile")usr.Fire_Dragon_Projectile()
			if(txt=="Mud Dragon Projectile")usr.Mud_Dragon_Projectile()
			if(txt=="Curse Seal of Heaven")usr.CS()

			//MINEEEEEE yea i like to brag bout shit ive made... XD - Viktorian

			if(txt=="Summoning Jutsu: Snake")usr.Summoning_Snake()
			if(txt=="Sage Mode")usr.SageMode()
			if(txt=="Curse Seal")usr.CurseSeal()
			if(txt=="RedPill")usr.RedPill()
			if(txt=="YellowPill")usr.YellowPill()
			if(txt=="GreenPill")usr.GreenPill()
			if(txt=="Human Bullet Tank")usr.HumanBulletTank()
			if(txt=="Calorie Control")usr.CalorieControl()
			if(txt=="Earth Mask")usr.EarthMask()
			if(txt=="Fire Mask")usr.FireMask()
			if(txt=="Wind Mask")usr.WindMask()
			if(txt=="Lightning Mask")usr.LightningMask()
			if(txt=="Earth Release: Mud Wall")usr.MudWall()
			if(txt=="Weapon Manipulation Jutsu")usr.Weapon_Manipulation_Jutsu()
			if(txt=="Twin Dragons")usr.TwinDragons()
			if(txt=="C1: Exploding Snake")usr.C1Snake()
			if(txt=="Curse Dragon")usr.Curse_Dragon()
			if(txt=="Hidden Snake Stab")usr.HiddenSnakeStab()
			if(txt=="Wood Release: Wood Fortress")usr.WoodStyleFortress()
			if(txt=="Wood Release: Wooden Balvan")usr.Wood_Balvan()
			if(txt=="Wood Release: Root Stab")usr.Root_Stab()
			if(txt=="Wood Release: Root Strangle")usr.Root_Strangle()
			if(txt=="Crystal Release: Crystal Shards")usr.Crystal_Shards()
			if(txt=="Crystal Release: Crystal Needles")usr.Crystal_Needles()
			if(txt=="Crystal Release: Crystal Explosion")usr.Crystal_Explosion()
			if(txt=="Crystal Release: Crystal Spikes")usr.Crystal_Spikes()
			if(txt=="Earth Release: Earth Boulder")usr.EarthBoulder()
			if(txt=="Lightning Pillars")usr.LightningPillars()
			if(txt=="Forbiden Tehnique: Kazekage Puppet")usr.Summon_Kazekage_Puppet()
			if(txt=="Rinnegan")usr.Rinnegan()
			if(txt=="Bug Tornado")usr.BugTornado()
			if(txt=="Spider Web Shoot")usr.WebShoot()
			if(txt=="Spider Arrow Shoot")usr.ArrowShoot()
			if(txt=="Summon Spider")usr.Summon_Spider()
			if(txt=="Wind Tornados")usr.Wind_Tornados()

		// Let the merge shine niggas.

		//Non-Clan

			if(txt=="ShiShi Rendan")usr.ShishiRendan()
			if(txt=="Sage Style Giant Rasengan")usr.Sage_Style_Giant_Rasengan()
			if(txt=="Demon Wind Shuriken")usr.Demon_Wind_Shuriken()
			if(txt=="Intangible")usr.Intangible_Jutsu()
			if(txt=="Rising Twin Dragons")usr.Rising_Twin_Dragons()

		//Ink

			if(txt=="Ink Style: Rats")usr.SaiRat()
			if(txt=="Ink Style: Snakes")usr.Sai_Snakes()
			if(txt=="Ink Style: Snake Rustle Jutsu")usr.Snake_Rustle_Jutsu()
			if(txt=="Ultimate Ink Style: Lions")usr.InkLions()
			if(txt=="Ultimate Ink Bird")usr.Ultimate_Ink_Bird()

		//Bubble

			if(txt=="Bubble Barrage")usr.BubbleBarrage()
			if(txt=="Bubble Spreader")usr.BubbleSpreader()
			if(txt=="Bubble Trouble")usr.Bubble_Trouble()
			if(txt=="Bubble Guardian")usr.Bubble_Guardian()

		//Senjuu

			if(txt=="Mokuton - Daijurin no Jutsu")usr.Daijurin()
			if(txt=="Mokuton - Jubaku Eisou")usr.JubakuEisou()
			if(txt=="Mokuton Hijutsu - Jukai Koutan")usr.JukaiKoutan()
		//	if(txt=="Wood Cage")usr.Wood_Style_Wood_Cage()
		//	if(txt=="Wood Drill")usr.Wood_Drill()

		//Akimichi

		//	if(txt=="Baika no Jutsu")usr.Baika()
		//	if(txt=="Nikudan Sensha")usr.Nikudan()

		//Earth

			if(txt=="Doton Doryuusou no Jutsu")usr.Doryuusou()
			if(txt=="Doton Doryo Dango")usr.Dango()

		//Wind

			if(txt=="Fuuton Daitoppa")usr.FuutonDaitoppa()
			if(txt=="Zankuuha")usr.Zankuuha()
			if(txt=="Wind Dragon Projectile")usr.Wind_Dragon_Projectile()
			if(txt=="Wind Cutter")usr.Wind_Cutter()
			if(txt=="Wind Balls")usr.Wind_Balls()

		//Inuzuka fukaaaaa

			if(txt=="Fang Over Fang")usr.Fang_Over_Fang()

		//Lightning

			if(txt=="Chidori Nagashi")usr.Chidori_Nagashi()

		//Water

			if(txt=="Suiton Suijinheki no Jutsu")usr.Suijinheki()
			if(txt=="Suiton Teppoudama")usr.Teppoudama()

		//Mixed Element (Magma)

			if(txt=="Magma Style: Magma Cage")usr.Magma_Crush()
			if(txt=="Magma Style: Magma Needles")usr.Magma_Needles()

		//Nara

			if(txt=="Shadow Punch")usr.Shadow_Punch()
			if(txt=="Shadow Explosion")usr.Shadow_Explosion()

		//Non-Clan

			if(txt=="Warp Rasengan")usr.Warp_Rasengan()

			if(txt=="Flying Thunder God")usr.Flying_Thunder_God()
			if(txt=="Multiple Chakra Kunai")usr.Multiple_Chakra_Kunai()

		//Uzumaki/Sealing Clan

			if(txt=="Reaper Death Seal")usr.Reaper_Death_Seal()
			if(txt=="Soul Devastator Seal")usr.Soul_Devastator_Seal()
			if(txt=="Sealing Technique: Seal of Terror")usr.Seal_of_Terror()
			if(txt=="Sealing Jutsu: Limb Paralyzis")usr.LimbParalyzeSeal()

		//Crystal Add-ons

			if(txt=="Crystal Pillar")usr.Crystal_Pillar()
			if(txt=="Crystal Mirrors")usr.Crystal_Mirrors()
			if(txt=="Crystal Arrow")usr.Crystal_Arrow()
		//	if(txt=="Crystal Drill")usr.Crystal_Drill()


		//Ice

			if(txt=="Iceball")usr.Iceball()
			if(txt=="Omega Ice Ball")usr.Omega_Ice_Ball()

		//Uchiha

			if(txt=="Kamui")usr.Kamui()

		//Special Jutsu (Ask Niti for how this will work niggaaaaas)

			if(txt=="Warp Dimension")usr.WarpDim()


		HotSlots()
			if(usr.hotslot=="1")usr.doslot(usr.hotslot1)
			if(usr.hotslot=="2")usr.doslot(usr.hotslot2)
			if(usr.hotslot=="3")usr.doslot(usr.hotslot3)
			if(usr.hotslot=="4")usr.doslot(usr.hotslot4)
			if(usr.hotslot=="5")usr.doslot(usr.hotslot5)
			if(usr.hotslot=="6")usr.doslot(usr.hotslot6)
			if(usr.hotslot=="7")usr.doslot(usr.hotslot7)
			if(usr.hotslot=="8")usr.doslot(usr.hotslot8)
			if(usr.hotslot=="9")usr.doslot(usr.hotslot9)
			if(usr.hotslot=="10")usr.doslot(usr.hotslot10)
mob
	verb
		HotSlot1()
			set hidden=1
			usr.hotslot="1"
			usr.HotSlots()
		HotSlot2()
			set hidden=1
			usr.hotslot="2"
			usr.HotSlots()
		HotSlot3()
			set hidden=1
			usr.hotslot="3"
			usr.HotSlots()
		HotSlot4()
			set hidden=1
			usr.hotslot="4"
			usr.HotSlots()
		HotSlot5()
			set hidden=1
			usr.hotslot="5"
			usr.HotSlots()
		HotSlot6()
			set hidden=1
			usr.hotslot="6"
			usr.HotSlots()
		HotSlot7()
			set hidden=1
			usr.hotslot="7"
			usr.HotSlots()
		HotSlot8()
			set hidden=1
			usr.hotslot="8"
			usr.HotSlots()
		HotSlot9()
			set hidden=1
			usr.hotslot="9"
			usr.HotSlots()
		HotSlot10()
			set hidden=1
			usr.hotslot="10"
			usr.HotSlots()
