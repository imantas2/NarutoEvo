var/SandLevel=1
var/LeafLevel=1
var/SoundLevel=1
var/SandExp=0
var/LeafExp=0
var/SoundExp=0
var/SandExpmax=10
var/LeafExpmax=10
var/SoundExpmax=10
var/Expboosts="Hidden Leaf"
mob
	proc/IncreaseExp()
		if(src.village == "Hidden Leaf")
			global.LeafExp++
			if(global.LeafExp > global.LeafExpmax)
				global.LeafLevel++
				global.LeafExp=0
				global.LeafExpmax*=1.5
				world << output("The Hidden Leaf is now level [global.LeafLevel].","actionoutput")
				if(global.LeafLevel>global.SandLevel)
					if(global.Expboosts == "Hidden Sand")
						world << output("<b><i>The Hidden Leaf Village now recieves the experience boost!</b></i>","actionoutput")
					global.Expboosts = "Hidden Leaf"
		if(src.village == "Hidden Sand")
			global.SandExp++
			if(global.SandExp > global.SandExpmax)
				global.SandLevel++
				global.SandExp=0
				global.SandExpmax*=1.5
				world << output("The Hidden Sand is now level [global.SandLevel].","actionoutput")
				if(global.SandLevel>global.LeafLevel)
					if(global.Expboosts == "Hidden Leaf")
						world << output("<b><i>The Hidden Sand Village now recieves the experience boost!</b></i>","actionoutput")
					global.Expboosts = "Hidden Sand"
		if(src.village == "Hidden Sound")
			global.SoundExp++
			if(global.SoundExp > global.SoundExpmax)
				global.SoundLevel++
				global.SoundExp=0
				global.SoundExpmax*=1.5
				world << output("The Hidden Sound is now level [global.SoundLevel].","actionoutput")
				if(global.SoundLevel>global.LeafLevel)
					if(global.Expboosts == "Hidden Sound")
						world << output("<b><i>The Hidden Sound Village now recieves the experience boost!</b></i>","actionoutput")
					global.Expboosts = "Hidden Sound"