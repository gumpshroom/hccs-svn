//HCCS 2day 100% v0.6 by iloath
script "hccs2da.ash";

notify iloath;

import <zlib>

boolean reach_meat(int value)
{
	if (my_meat() >= value)
		return true;
	
	foreach stuff in $items[strongness elixir,magicalness-in-a-can,moxie weed,Doc Galaktik's Homeopathic Elixir, meat stack, meat paste, half of a gold tooth, loose teeth, asparagus knife]
		autosell(item_amount(stuff), stuff);

	use(item_amount($item[Gathered Meat-Clip]), $item[Gathered Meat-Clip]);

	if (my_meat() < value)
	{
		return false;
	}
	return true;
}

boolean reach_mp(int value)
{
	if (my_mp() >= value)
		return true;
	if (have_skill($skill[Soul Saucery]))
	{
		while ((my_mp() < value) && (my_soulsauce() >= 5))
		{
			use_skill(1 ,$skill[Soul Food]);
		}
	}
	while ((my_mp() < value) && (get_property("timesRested").to_int() < total_free_rests()))
	{
		cli_execute("campground rest");
	}
	while ((my_mp() < value) && (item_amount($item[Dyspepsi-Cola]) >= 1))
	{
		use(1, $item[Dyspepsi-Cola]);
	}
	while ((my_mp() < value) && (item_amount($item[Cloaca-Cola]) >= 1))
	{
		use(1, $item[Cloaca-Cola]);
	}
	while ((my_mp() < value) && (item_amount($item[Mountain Stream soda]) >= 1))
	{
		use(1, $item[Mountain Stream soda]);
	}
	while ((my_mp() < value) && (item_amount($item[Marquis de Poivre soda]) >= 1))
	{
		use(1, $item[Marquis de Poivre soda]);
	}
	while ((my_mp() < value) && (item_amount($item[Doc Galaktik's Invigorating Tonic]) >= 1))
	{
		use(1, $item[Doc Galaktik's Invigorating Tonic]);
	}
	while ((my_mp() < value) && (item_amount($item[soda water]) >= 1))
	{
		use(1, $item[soda water]);
	}
	while ((my_mp() < value) && (item_amount($item[magical mystery juice]) >= 1))
	{
		use(1, $item[magical mystery juice]);
	}
	while ((my_mp() < value) && (guild_store_available()) && (my_meat() >= 2000))
	{
		buy(1, $item[magical mystery juice],100);
		use(1, $item[magical mystery juice]);
	}
	if (my_mp() < value)
	{
		return false;
	}
	return true;
}

boolean force_skill(skill value, boolean use)
{
	if(have_skill(value))
	{
		if (my_maxmp() < mp_cost(value))
		{
			abort("Mp cap too low");
			return false;
		}
		if (reach_mp(mp_cost(value)))
		{
			if (use)
			{
				return use_skill(1 ,value);
			} else return true;
		}
		else
		{
			abort("Unable to obatin sufficent mp for: " + value);
			return false;
		}
	} return !use;
}

boolean force_skill(skill value)
{
	return force_skill(value, true);
}

void try_skill(skill value)
{
	if(have_skill(value))
	{
		if (my_mp() >= mp_cost(value))
		{
			use_skill(1 ,value);
		}
	}
}

void force_item(item value)
{
	if (item_amount(value) > 0)
	{
		use(1, value);
	}
	else
	{
		abort("Cannot find item: " + value);
	}
}

void try_item(item value)
{
	if (item_amount(value) > 0)
	{
		use(1, value);
	}
}

void burn_mp()
{
	print("Using up mp", "blue");
	try_skill($skill[Grab a Cold One]);
	try_skill($skill[Spaghetti Breakfast]);
	try_skill($skill[Advanced Saucecrafting]);
	try_skill($skill[Advanced Cocktailcrafting]);
	try_skill($skill[Pastamastery]);
	try_skill($skill[Perfect Freeze]);
	try_skill($skill[Lunch Break]);
}

void summon_pants(string m, string e, string s1, string s2, string s3)
{
	if (item_amount($item[portable pantogram]) == 0)
	{
		return;
	}

	print("SUMMONING PANTS", "red");
	visit_url("inv_use.php?pwd&which=99&whichitem=9573");
	visit_url("choice.php?whichchoice=1270&pwd&option=1&m="+m+"&e="+e+"&s1="+s1+"&s2="+s2+"&s3="+s3,true,true);
	if (item_amount($item[pantogram pants]) == 0)
	{
		abort("Couldn't summon pants");
	}
}

void use_bastille_battalion(int desired_stat, int desired_item, int desired_buff, int desired_potion)
{
	if (item_amount($item[Bastille Battalion control rig]) == 0) return;

	int [4] desired_state;
	int [4] current_state;

	desired_state[0] = desired_stat;
	desired_state[1] = desired_item;
	desired_state[2] = desired_buff;
	desired_state[3] = desired_potion;

	// Use Bastille Battalion control rig
	string page = visit_url("inv_use.php?pwd&whichitem=9928");

	// Determine current state
	if (page.contains_text('barb1.png')) current_state[0] = 0; // Mys (Barbecue)
	else if (page.contains_text('barb2.png')) current_state[0] = 1; // Mus (Babar)
	else if (page.contains_text('barb3.png')) current_state[0] = 2; // Mox (Barbershop)

	if (page.contains_text('bridge1.png')) current_state[1] = 0; // Mus (Brutalist)
	else if (page.contains_text('bridge2.png')) current_state[1] = 1; // Mys (Draftsman)
	else if (page.contains_text('bridge3.png')) current_state[1] = 2; // Mox (Art Nouveau)

	if (page.contains_text('holes1.png')) current_state[2] = 0; // Mus (Cannon)
	else if (page.contains_text('holes2.png')) current_state[2] = 1; // Mys (Catapult)
	else if (page.contains_text('holes3.png')) current_state[2] = 2; // Mox (Gesture)

	if (page.contains_text('moat1.png')) current_state[3] = 0; // Military (Sharks)
	else if (page.contains_text('moat2.png')) current_state[3] = 1; // Castle (Lava)
	else if (page.contains_text('moat3.png')) current_state[3] = 2; // Psychological (Truth Serum)

	// Cycle through each reward type to get the correct one for us
	for (int reward = 0; reward < 4; reward++)
	{
		int clicks = ((desired_state[reward] - current_state[reward]) + 3) % 3;
		print('thing ' + reward + ' is at ' + current_state[reward] + ' but needs to be at ' + desired_state[reward] + ' so we will click ' + clicks + ' times');
		for (int i = 0; i < clicks; i++) run_choice(reward + 1);
	}

	// Start fighting
	run_choice(5);

	boolean fighting = true;

	while(fighting)
	{
		run_choice(3); // Cheese
		run_choice(1); // First cheese option
		run_choice(3); // More Cheese
		run_choice(1); // First cheese option
		string fight_result = run_choice(1); // Get the jump
		fighting = fight_result.contains_text("You have razed");
	}

	run_choice(1); // Lock in your score
}

boolean eat_dog(string dog, boolean add)
{
	//credit cc, modifed from cc_ascend
	if(item_amount($item[Clan VIP Lounge Key]) == 0)
	{
		return false;
	}
	if(get_property("_fancyHotDogEaten").to_boolean() && (dog != "basic hot dog"))
	{
		return false;
	}

	dog = to_lower_case(dog);

	static int [string] dogFull;
	static item [string] dogReq;
	static int [string] dogAmt;
	static int [string] dogID;
	dogFull["basic hot dog"] = 1;
	dogFull["savage macho dog"] = 2;
	dogFull["one with everything"] = 2;
	dogFull["sly dog"] = 2;
	dogFull["devil dog"] = 3;
	dogFull["chilly dog"] = 3;
	dogFull["ghost dog"] = 3;
	dogFull["junkyard dog"] = 3;
	dogFull["wet dog"] = 3;
	dogFull["optimal dog"] = 1;
	dogFull["sleeping dog"] = 2;
	dogFull["video games hot dog"] = 3;

	dogReq["basic hot dog"] = $item[none];
	dogReq["savage macho dog"] = $item[furry fur];
	dogReq["one with everything"] = $item[cranberries];
	dogReq["sly dog"] = $item[skeleton bone];
	dogReq["devil dog"] = $item[hot wad];
	dogReq["chilly dog"] = $item[cold wad];
	dogReq["ghost dog"] = $item[spooky wad];
	dogReq["junkyard dog"] = $item[stench wad];
	dogReq["wet dog"] = $item[sleaze wad];
	dogReq["optimal dog"] = $item[tattered scrap of paper];
	dogReq["sleeping dog"] = $item[gauze hammock];
	dogReq["video games hot dog"] = $item[GameInformPowerDailyPro magazine];

	dogAmt["basic hot dog"] = 0;
	dogAmt["savage macho dog"] = 10;
	dogAmt["one with everything"] = 10;
	dogAmt["sly dog"] = 10;
	dogAmt["devil dog"] = 25;
	dogAmt["chilly dog"] = 25;
	dogAmt["ghost dog"] = 25;
	dogAmt["junkyard dog"] = 25;
	dogAmt["wet dog"] = 25;
	dogAmt["optimal dog"] = 25;
	dogAmt["sleeping dog"] = 10;
	dogAmt["video games hot dog"] = 3;

	dogID["basic hot dog"] = 0;
	dogID["savage macho dog"] = -93;
	dogID["one with everything"] = -94;
	dogID["sly dog"] = -95;
	dogID["devil dog"] = -96;
	dogID["chilly dog"] = -97;
	dogID["ghost dog"] = -98;
	dogID["junkyard dog"] = -99;
	dogID["wet dog"] = -100;
	dogID["optimal dog"] = -102;
	dogID["sleeping dog"] = -101;
	dogID["video games hot dog"] = -103;

	if(!(dogFull contains dog))
	{
		abort("Invalid hot dog: " + dog);
	}

	string page = visit_url("clan_viplounge.php?action=hotdogstand");
	if(!contains_text(page, dog))
	{
		return false;
	}

	if(fullness_limit()-my_fullness() < dogFull[dog])
	{
		return false;
	}

	if(storage_amount(dogReq[dog]) < dogAmt[dog])
	{
		return false;
	}

	visit_url("clan_viplounge.php?action=hotdogstand");

	if((dogAmt[dog] > 0) && (add))
	{
		visit_url("clan_viplounge.php?preaction=hotdogsupply&hagnks=1&whichdog=" + dogID[dog] + "&quantity=" + dogAmt[dog]);
		print("Supplying hot dogs...","green");
	}

	visit_url("clan_viplounge.php?action=hotdogstand");

	cli_execute("eat 1 " + dog);
	return true;
}

boolean should_tour(string ascensionsHtml, familiar fam)
{
	matcher m = create_matcher("alt=\"" + fam + " .([0-9.]+)..", ascensionsHtml);
	while(find(m))
	{
		string percentMatch = group(m, 1);
		if (to_float(percentMatch) == 100) return false;
	}

	return true;
}

familiar pick_familiar_to_tour()
{
	string ascensionsHtml = visit_url(" ascensionhistory.php?back=self&who=" +my_id(), false) + visit_url(" ascensionhistory.php?back=self&prens13=1&who=" +my_id(), false);

	foreach fam in $familiars[]
	{
		if(have_familiar(fam) && should_tour(ascensionsHtml, fam)) {
			if (getvar("bbb_famitems") != "")
			{
				cli_execute("zlib bbb_famitems = false");
			}
			return fam;
		}
	}

	return $familiar[none];
}

void main(){
	//init
	familiar ToTour = pick_familiar_to_tour();
	boolean AddHotdog = true;
	string wish = "init";
	string clan = get_clan_name();
	item KGB = $item[Kremlin's Greatest Briefcase];

	//The Baker's Dilemma
	set_property("choiceAdventure114", 2);
	//Oh No, Hobo
	set_property("choiceAdventure115", 1);
	//The Singing Tree
	set_property("choiceAdventure116", 4);
	//Trespasser
	set_property("choiceAdventure117", 1);
	//Temporarily Out of Skeletons
	set_property("choiceAdventure1060", 1);

	set_property("manaBurningThreshold", -0.05);

	cli_execute("refresh all");

	if(my_path() != "Community Service") abort("Not Community Service.");

	if (my_daycount() == 1)
	{

		// Set CCS for the run
		set_property("hccs2da_backupCCS", get_property("customCombatScript"));
		set_property("customCombatScript", "hccs");

		// Use free pulls
		if (storage_amount($item[Bastille Battalion control rig]) > 0)
		{
			take_storage(1, $item[Bastille Battalion control rig]);
		}


		// Get the dairy goat fax and clanmate fortunes,
		if(item_amount($item[photocopied monster]) == 0)
		{
			print("No photocopied monster, skipping in...");
			wait(5);
		}

		// Try Calculating the Universe
		try_num();

		// Make meat from BoomBox if we can
		if (item_amount($item[SongBoom&trade; BoomBox]) > 0)
		{
			cli_execute("boombox meat");
		}

		// unlock the briefcase
		if (item_amount(KGB) > 0)
		{
			if (svn_exists("Ezandora-Briefcase-branches-Release")) {
				// Unlock with booze acquisition
				cli_execute("Briefcase booze");
				cli_execute("Briefcase e spell adventures");
			} else print("If you install Ezandora's Briefcase script, this script can use your KGB!", "red");
		}

		//dive in vip swimming pool
		visit_url("clan_viplounge.php?preaction=goswimming&subaction=screwaround&whichfloor=2&sumbit=Cannonball!",true);
		visit_url("choice.php?whichchoice=585&pwd=" + my_hash() + "&option=1&action=flip&sumbit=Handstand",true);
		visit_url("choice.php?whichchoice=585&pwd=" + my_hash() + "&option=1&action=treasure&sumbit=Dive for Treasure",true);
		visit_url("choice.php?whichchoice=585&pwd=" + my_hash() + "&option=1&action=leave&sumbit=Get Out",true);

		//open skeleton store
		visit_url("shop.php?whichshop=meatsmith&action=talk&sumbit=What do you need?");
		run_choice(1);

		wish = "for more wishes";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9529", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		wish = "for more wishes";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9529", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		wish = "for more wishes";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9529", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		visit_url("clan_viplounge.php?action=crimbotree&whichfloor=2");
		visit_url("clan_viplounge.php?action=lookingglass&whichfloor=2");
		//vip claw
		visit_url("clan_viplounge.php?action=klaw");
		visit_url("clan_viplounge.php?action=klaw");
		visit_url("clan_viplounge.php?action=klaw");
		//normal claw
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");

		visit_url("tutorial.php?action=toot", false);

		visit_url("council.php");
		visit_url("guild.php?place=challenge");

		if (item_amount($item[astral six-pack]) > 0)
			use(1, $item[astral six-pack]);
		else print("You do not have a astral six-pack.", "red");

		if (item_amount($item[letter from King Ralph XI]) > 0)
			use(1, $item[letter from King Ralph XI]);
		else print("You do not have a letter from King Ralph XI.", "red");

		if (item_amount($item[pork elf goodies sack]) > 0)
			use(1, $item[pork elf goodies sack]);
		else print("You do not have a pork elf goodies sack.", "red");

		foreach stone in $items[hamethyst,baconstone,porquoise]
			autosell(item_amount(stone), stone);

		autosell(item_amount($item[Van der Graaf helmet]), $item[Van der Graaf helmet]);

		if (item_amount($item[toy accordion]) < 1)
			buy(1, $item[toy accordion]);

		while (item_amount($item[turtle totem]) < 1)
		{
			buy(1, $item[chewing gum on a string]);
			use(1, $item[chewing gum on a string]);
		}

		//Set fam here
		use_familiar(ToTour);
		equip($item[Hollandaise helmet]);
		equip($item[saucepan]);
		equip($item[astral statuette]);
		equip($item[old sweatpants]);

		//fantasyland only
		if((get_property("frAlways") == True) && (item_amount($item[FantasyRealm G. E. M.]) < 1))
		{
			print("FANTASYLAND WIZARD HAT", "red");
			visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter", false);
			run_choice(2); //mage
			if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
			{
			 equip($item[FantasyRealm Mage's Hat]);
			}
		}

		try_item($item[Newbiesport&trade; tent]);

		force_skill($skill[Spirit of Peppermint]);
		force_skill($skill[The Magical Mojomuscular Melody]);
		force_skill($skill[Sauce Contemplation]);
		cli_execute("swim laps");

		// pantogramming (+mox, res spooky, +mp, spell dmg, +combat)
		summon_pants(3, 3, "-2%2C0", "-2%2C0", "-2%2C0");

		//consider optimal dog+epic food/booze here if no clip art
		if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
		{
			cli_execute("make cheezburger");
		}
		else abort("Clip art failure.");

		if (item_amount($item[Codpiece]) == 0)
			visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=9002");
		if (item_amount($item[Codpiece]) > 0)
		{
			use(1, $item[Codpiece]);
			use(8 ,$item[bubblin' crude]);
			autosell(1, $item[oil cap]);
			equip($slot[acc1], $item[Codpiece]);
		}
		else abort("You do not have a Codpiece.");

		if (have_effect($effect[Hustlin']) <= 0)
		{
			cli_execute("pool 3");
		}

		print("Y-RAY FAX", "blue");
		if (my_maxmp() < mp_cost($skill[Disintegrate]))
			abort("mp cap too law or YRAY");
		cli_execute("shower mp");

		if(force_skill($skill[Disintegrate], false))
		{
			if (item_amount($item[photocopied monster]) > 0)
				use(1, $item[photocopied monster]);
			else abort("You do not have a photocopied monster.");
		}
		else abort("No Y-RAY.");
		try_num();
		if(canadia_available())
			cli_execute("mcd 11");

		print("Breakfast Prep", "blue");

		force_skill($skill[Advanced Saucecrafting]);

		buy(1 , $item[Dramatic&trade; range], 1000);
		use(1 , $item[Dramatic&trade; range]);
		craft("cook", 1, $item[scrumptious reagent], $item[glass of goat's milk]);

		print("Breakfast", "blue");
		use(1 , $item[milk of magnesium]);
		eat(1 , $item[cheezburger]);
		buy(1 , $item[fortune cookie], 40);
		eat(1 , $item[fortune cookie]);



		//40 mp remain if fantasy mage hat
		burn_mp();

		complete_quest("COIL WIRE", 11);

		if (item_amount($item[a ten-percent bonus]) > 0)
			use(1, $item[a ten-percent bonus]);
		else abort("You do not have a ten-percent bonus.");

		// Get driving gloves from Bastille Battalion if we can (now that we've wasted 60 adventures)
		use_bastille_battalion(0, 1, 2, random(3));

		print("First Drink", "blue");
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			while (my_inebriety() < 5)
			{
				drink(1, $item[astral pilsner]);
			}
		}

		if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
		{
			cli_execute("make ultrafondue");
		}
		else abort("Clip art failure.");
		if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
		{
			cli_execute("make ultrafondue");
		}
		else abort("Clip art failure.");


		print("Farming meat via casino", "blue");
		if (item_amount($item[hermit permit]) == 0)
		{
			buy(1 , $item[hermit permit], 100);
		}
		if (item_amount($item[casino pass]) == 0)
		{
			buy(1 , $item[casino pass], 100);
		}
		hermit(999, $item[ten-leaf clover]);
		while (item_amount($item[disassembled clover]) > 0)
		{
			use(1, $item[disassembled clover]);
			visit_url("adventure.php?snarfblat=70");
			try_num();
		}

		print("Combat Prep", "blue");
		if (have_effect($effect[There's No N in Love]) <= 0)
		{
			cli_execute("fortune buff hagnk");
		}
		cli_execute("hottub");




		//if poor rng then no adv here, ode+tea now?


		print("Barrels (very slow)", "blue");
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=20");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=21");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=22");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=10");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=11");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=12");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=00");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=01");
		run_combat();
		visit_url("barrel.php");
		visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=02");
		run_combat();
		try_num();



		print("Farming until semirare", "blue");
		while (get_counters("Fortune Cookie" ,0 ,0) == "")
		{
			if ((item_amount($item[boxed wine]) <= 0) && (item_amount($item[bottle of rum]) <= 0) && (item_amount($item[bottle of vodka]) <= 0) && (item_amount($item[bottle of gin]) <= 0) && (item_amount($item[bottle of whiskey]) <= 0) && (item_amount($item[bottle of tequila]) <= 0))
			{
				adventure(1, $location[Noob Cave]);
			}
			if ((item_amount($item[tomato]) <= 0) || (item_amount($item[Dolphin King's map]) <= 0) || (item_amount($item[exorcised sandwich]) <= 0))
			{
				adventure(1, $location[The Haunted Pantry]);
			}
			else
			{
				adventure(1, $location[The Skeleton Store]);
			}
			try_num();
		}


		//ash get_property("semirareLocation")
		print("Hit semirare, main meal", "blue");
		//tasty tart = 113
		if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
		{
			visit_url("adventure.php?snarfblat=113"); //semirare
		}
		else
		{
			abort("No semirare.");
		}
		use(1 , $item[milk of magnesium]);
		eat(2 , $item[ultrafondue]);
		eat(3 , $item[tasty tart]);
		if (!eat_dog("optimal dog", AddHotdog))
			abort("Cannot eat dog");
		//cli_execute("eat optimal dog"); //TODO: change to vist_url to stop "The 'optimal dog' is not currently available in your clan" error, add code to add hotdog ingredients.
		//lunchbox = 114
		if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
		{
			visit_url("adventure.php?snarfblat=114"); //semirare
		}
		else
		{
			abort("No optimal dog semirare.");
		}
		use(1,  $item[Knob Goblin lunchbox]);
		eat(1 , $item[Knob pasty]);

		print("Checking Additional Farming Requirements", "blue");
		while ((item_amount($item[boxed wine]) <= 0) && (item_amount($item[bottle of rum]) <= 0) && (item_amount($item[bottle of vodka]) <= 0) && (item_amount($item[bottle of gin]) <= 0) && (item_amount($item[bottle of whiskey]) <= 0) && (item_amount($item[bottle of tequila]) <= 0))
		{
			adventure(1, $location[Noob Cave]);
			try_num();
		}
		print("Sufficient Base Booze", "green");
		while (item_amount($item[tomato]) <= 0)
		{
			adventure(1, $location[The Haunted Pantry]);
			try_num();
		}
		print("Sufficient Tomato", "green");
		while ((item_amount($item[exorcised sandwich]) <= 0) || (!have_skill($skill[Simmer])))
		{
			adventure(1, $location[The Haunted Pantry]);
			try_num();
		}
		print("Sufficient Sandwich (if any required)", "green");




		if (item_amount($item[Dolphin King's map]) > 0)
		{
			print("Doing Dolphin Quest", "blue");
			buy(1 , $item[snorkel], 30);
			equip($slot[hat], $item[snorkel]);
			use(1 , $item[Dolphin King's map]);
			equip($slot[hat], $item[Dolphin King's crown]);
		}

		//TODO auto change skele quest choices
		if (item_amount($item[check to the Meatsmith]) > 0)
		{
			visit_url("shop.php?whichshop=meatsmith");
			visit_url("choice.php?whichchoice=1059&pwd=" + my_hash() + "&option=2&sumbit=Here it is!",true);
		}

		foreach stone in $items[strongness elixir,magicalness-in-a-can,moxie weed,Doc Galaktik's Homeopathic Elixir, meat stack]
			autosell(item_amount(stone), stone);

		if (item_amount($item[exorcised sandwich]) > 0)
		{
			print("Talking to guildmates, may be slow", "blue");
			visit_url("guild.php?place=challenge");
			visit_url("guild.php?place=scg");
			visit_url("guild.php?place=ocg");
			visit_url("guild.php?place=paco");
			visit_url("guild.php?place=scg");
			visit_url("guild.php?place=ocg");

			if (!have_skill($skill[Simmer]))
			{
				if (reach_meat(125))
				{
					visit_url("guild.php?action=buyskill&skillid=25");
				}
				else
				{
					abort("Not enough meat for simmer.");
				}
			}
			print("Finished talking to various cheeses", "blue");
		}

		print("Perfect Drink", "blue");

		force_skill($skill[Perfect Freeze]);

		if ((reach_meat(250)) && force_skill($skill[The Ode to Booze]))
		{
			//drink perfect drink here
			//wine=rum>vodka=gin>whiskey=tequila
			if (item_amount($item[boxed wine]) > 0)
			{
				craft("mix", 1, $item[boxed wine], $item[perfect ice cube]);
				drink(1, $item[Perfect mimosa]);
			}
			else if (item_amount($item[bottle of rum]) > 0)
			{
				craft("mix", 1, $item[bottle of rum], $item[perfect ice cube]);
				drink(1, $item[Perfect dark and stormy]);
			}
			else if (item_amount($item[bottle of vodka]) > 0)
			{
				craft("mix", 1, $item[bottle of vodka], $item[perfect ice cube]);
				drink(1, $item[Perfect cosmopolitan]);
			}
			else if (item_amount($item[bottle of gin]) > 0)
			{
				craft("mix", 1, $item[bottle of gin], $item[perfect ice cube]);
				drink(1, $item[Perfect negroni]);
			}
			else if (item_amount($item[bottle of whiskey]) > 0)
			{
				craft("mix", 1, $item[bottle of whiskey], $item[perfect ice cube]);
				drink(1, $item[Perfect old-fashioned]);
			}
			else if (item_amount($item[bottle of tequila]) > 0)
			{
				craft("mix", 1, $item[bottle of tequila], $item[perfect ice cube]);
				drink(1, $item[Perfect paloma]);
			}
			else abort("No perfect drink.");

			if (my_inebriety() <= 8)
			{
				if (item_amount($item[splendid martini]) > 0)
				{
					drink(1, $item[splendid martini]);
				} else {
					cli_execute("drink cup of tea");
				}
			}

			if (item_amount($item[splendid martini]) > 0)
			{
				drink(1, $item[splendid martini]);
			} else {
				drink(1, $item[thermos full of Knob coffee]);
			}
		} else abort("Ode loop fail.");

		print("Task Prep (+item)", "blue");
		//+item%
		if(have_skill($skill[Fat Leon's Phat Loot Lyric]) && (my_mp() >= mp_cost($skill[Fat Leon's Phat Loot Lyric])) && (have_effect($effect[Fat Leon's Phat Loot Lyric]) <= 0))
		{
			use_skill(1 ,$skill[Fat Leon's Phat Loot Lyric]);
		}
		if(have_skill($skill[Singer's Faithful Ocelot]) && (my_mp() >= mp_cost($skill[Singer's Faithful Ocelot])) && (have_effect($effect[Singer's Faithful Ocelot]) <= 0))
		{
			use_skill(1 ,$skill[Singer's Faithful Ocelot]);
		}
		if (have_effect($effect[Hustlin']) <= 0)
		{
			cli_execute("pool 3");
		}
		if ((item_amount(KGB) + equipped_amount(KGB)) > 0 && svn_exists("Ezandora-Briefcase-branches-Release"))
		{
			cli_execute("Briefcase b item");
		}

		wish = "to be Infernal Thirst";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		force_skill($skill[Steely-Eyed Squint]);

		//use up mp
		burn_mp();
		

		complete_quest("MAKE MARGARITAS", 9);

		//TODO:issue with item condition, switch to while checks
		//hunt for fruit skeleton (one of the best place to shattering punch/snokebomb)
		/*
		add_item_condition(1, $item[cherry]);
		add_item_condition(1, $item[lemon]);
		add_item_condition(1, $item[grapefruit]);
		adventure(my_adventures(), $location[The Skeleton Store]);
		*/
		//y-ray fruit skeleton

		print("Farming fruits", "blue");
		while ((item_amount($item[cherry]) <= 0) || (item_amount($item[lemon]) <= 0) || (item_amount($item[grapefruit]) <= 0))
		{
			if(force_skill($skill[Disintegrate], false))
			{
				adventure(1, $location[The Skeleton Store]);
				try_num();
			}
			else abort("No Y-RAY.");
		}
		print("We obtained the fruits!", "green");

		//make potions
		//make oil of expertise
		//make ointment of the occult
		//make philter of phorce
		//make tomato juice of powerful power
		craft("cook", 1, $item[scrumptious reagent], $item[cherry]);
		craft("cook", 1, $item[scrumptious reagent], $item[lemon]);
		craft("cook", 1, $item[scrumptious reagent], $item[grapefruit]);
		craft("cook", 1, $item[scrumptious reagent], $item[tomato]);

		print("Task Prep (spell dmg)", "blue");
		if ((reach_meat(500)) && force_skill($skill[The Ode to Booze]))
		{
			cli_execute("drink Sockdollager");
		}
		else abort("Ode loop fail.");


		if ((have_effect($effect[Indescribable Flavor]) <= 0) && (item_amount($item[indescribably horrible paste]) > 0))
		{
			chew(1, $item[indescribably horrible paste]);
		}

		if (have_effect($effect[Mental A-cue-ity]) <= 0)
		{
			cli_execute("pool 2");
		}

		force_skill($skill[Spirit of Peppermint]);
		force_skill($skill[Simmer]);
		try_num();
		force_skill($skill[Song of Sauce]);

		//hatter mariachi hat or powdered wig
		if((get_property("_madTeaParty") == false) && (item_amount($item[mariachi hat]) > 0))
		{
			cli_execute("hatter mariachi hat");
		}
		else if((get_property("_madTeaParty") == false) && (item_amount($item[powdered wig]) > 0))
		{
			cli_execute("hatter powdered wig");
		}
		else print("You do not have a suitable hat for the mad hatter here.", "red");

		//maybe cordial of concentration

		if (item_amount($item[5-Alarm Saucepan]) > 0)
		{
			equip($slot[weapon], $item[5-Alarm Saucepan]);
		}
		if (item_amount($item[astral statuette]) > 0)
		{
			equip($slot[off-hand], $item[astral statuette]);
		}
		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
		}
		if (item_amount($item[Draftsman's driving gloves]) > 0)
		{
			equip($slot[acc1], $item[Draftsman's driving gloves]);
		}
		if (item_amount($item[psychic's amulet]) > 0)
		{
			equip($slot[acc2], $item[psychic's amulet]);
		}
		if (item_amount(KGB) > 0)
		{
			equip($slot[acc3], KGB);
		}

		//magic dragonfish does not seem to work here!

		complete_quest("MAKE SAUSAGE", 7);

		print("Task Prep (weapon dmg)", "blue");
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (reach_meat(500)))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			cli_execute("drink Sockdollager");
			use_familiar($familiar[Stooper]);
			if(item_amount($item[Cold One]) > 0)
				drink(1, $item[Cold One]);
		}
		else abort("Ode loop fail.");

		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= 2*mp_cost($skill[The Ode to Booze])))
		{
			use_skill(2 ,$skill[The Ode to Booze]);
			overdrink(1, $item[emergency margarita]);
		}
		else abort("Ode loop fail.");
		use_familiar(ToTour);
		
		force_skill($skill[Rage of the Reindeer]);
		force_skill($skill[Bow-Legged Swagger]);
		force_skill($skill[Song of the North]);

		print("Rollover Prep", "blue");
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if (item_amount($item[dead guy's watch]) > 0)
		{
			equip($slot[acc1], $item[dead guy's watch]);
		}
		if (item_amount($item[Draftsman's driving gloves]) > 0)
		{
			equip($slot[acc2], $item[Draftsman's driving gloves]);
		}
		if (item_amount(KGB) > 0)
		{
			equip($slot[acc3], KGB);
		}
		//adv gear

		cli_execute("telescope high");
		visit_url("place.php?whichplace=monorail&action=monorail_lyle");
		cli_execute("hottub");
		abort("END DAY 1.");
	}
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//day2
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


	//do fortune and fax a factory overseer
	if (my_daycount() >= 2)
	{
		if(item_amount($item[photocopied monster]) == 0)
		{
			print("No photocopied monster, skipping in...");
			wait(5);
		}

		// Try to Calculate the Universe
		try_num();

		// Get brogues from Bastille Battalion if we can
		use_bastille_battalion(0, 0, 2, random(3));

		// pantogramming (+mus, res hot, +hp, weapon dmg, -combat)
		summon_pants(1, 1, "-1%2C0", "-1%2C0", "-1%2C0");

		// setup briefcase
		if ((item_amount(KGB) + equipped_amount(KGB)) > 0 && svn_exists("Ezandora-Briefcase-branches-Release"))
		{
			cli_execute("Briefcase booze");
			cli_execute("Briefcase e weapon hot -combat");
		}

		//fantasyland only
		if((get_property("frAlways") == True)&&(item_amount($item[FantasyRealm G. E. M.]) < 1))
		{
			print("FANTASYLAND WARRIOR HAT", "red");
			visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter", false);
			run_choice(1); //warrior
		}

		// autosell pen pal gift
		autosell(item_amount($item[electric crutch]), $item[electric crutch]);

		if (reach_meat(24*3))
		{
			buy(1 , $item[Ben-Gal&trade; Balm], 24);
			buy(1 , $item[glittery mascara], 24);
			buy(1 , $item[hair spray], 24);
		}
		else abort("Not enough meat.");

		if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
		{
			cli_execute("make shadowy cat claw");
		}
		if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
		{
			cli_execute("make cold-filtered water");
		}
		if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
		{
			cli_execute("make borrowed time");
		}
		if (item_amount($item[fish hatchet]) == 0)
			visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=9005");
		if (item_amount($item[fish hatchet]) > 0)
		{
			equip($slot[weapon], $item[fish hatchet]);
		}
		else
		{
			if (item_amount($item[Codpiece]) > 0)
			{
				use(1, $item[Codpiece]);
				use(8 ,$item[bubblin' crude]);
				autosell(1, $item[oil cap]);
				equip($slot[acc1], $item[Codpiece]);
			}
			else abort("You do not have a Fish hatchet or Codpiece.");
		}

		print("Main Meal", "blue");
		if(item_amount($item[Milk of Magnesium]) > 0)
		{
			use(1, $item[Milk of Magnesium]);
		}
		else abort("Not enough Milk of Magnesium.");

		if(item_amount($item[tasty tart]) > 0)
		{
			eat(1, $item[tasty tart]);
		}
		else if(item_amount($item[Knob pasty]) > 0)
		{
			eat(1, $item[Knob pasty]);
		}
		else if(item_amount($item[spaghetti breakfast]) > 0)
		{
			eat(1, $item[spaghetti breakfast]);
		}

		if(item_amount($item[sausage without a cause]) > 0)
		{
			eat(1, $item[sausage without a cause]);
		}
		else abort("No sausage without a cause.");

		if(item_amount($item[shadowy cat claw]) > 0)
		{
			eat(1, $item[shadowy cat claw]);
		}

		print("Task Prep (weapon dmg)", "blue");
		if ((have_effect($effect[Greasy Flavor]) <= 0) && (item_amount($item[greasy paste]) > 0))
		{
			chew(1, $item[greasy paste]);
		}
		if (have_effect($effect[Billiards Belligerence]) <= 0)
		{
			cli_execute("pool 1");
		}

		//consider wish wep dmg
		if(have_effect($effect[Bow-Legged Swagger]) > 0)
		{
			print("Bow Legged Wish, saves ~5 adv", "blue");
			wish = "to be Outer Wolf&trade;";
			visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
			visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);
		}

		burn_mp();

		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
		}
		if (item_amount($item[Brutal brogues]) > 0)
		{
			equip($slot[acc2], $item[Brutal brogues]);
		}
		if (item_amount(KGB) > 0)
		{
			equip($slot[acc3], KGB);
		}

		complete_quest("REDUCE GAZELLE POPULATION", 6);

		print("Farming meat via casino", "blue");
		if (item_amount($item[hermit permit]) == 0)
		{
			buy(1 , $item[hermit permit], 100);
		}
		if (item_amount($item[casino pass]) == 0)
		{
			buy(1 , $item[casino pass], 100);
		}
		hermit(999, $item[ten-leaf clover]);
		while (item_amount($item[disassembled clover]) > 0)
		{
			use(1, $item[disassembled clover]);
			visit_url("adventure.php?snarfblat=70");
			try_num();
		}
		//make meat here if needed
		//reach_meat(999999999);

		print("Task Prep (hot res, 1st part)", "blue");
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (reach_meat(500)))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			cli_execute("drink Ish Kabibble");
		}
		else abort("Ode loop fail.");

		//needed if no thick skin or other mp skills
		buy(1 , $item[glittery mascara], 24);
		use(1 , $item[glittery mascara]);

		force_skill($skill[The Magical Mojomuscular Melody]);
		force_skill($skill[Sauce Contemplation]);

		burn_mp();

		cli_execute("shower mp");

		print("Y-RAY FAX", "blue");
		if(force_skill($skill[Disintegrate], false))
		{
			if (item_amount($item[photocopied monster]) > 0)
				use(1, $item[photocopied monster]);
			else abort("You do not have a photocopied monster.");
		}
		else abort("No Y-RAY.");


		print("Teatime", "blue");
		if (item_amount($item[milk of magnesium]) > 0)
		{
			use(1 , $item[milk of magnesium]);
		}
		//if (my_fullness() == 12) if not saving items
		if (my_fullness() >= 0)
		{
			if (!eat_dog("wet dog", AddHotdog))
				abort("Cannot eat dog");
			//cli_execute("eat wet dog");
		}
		else
		{
			if (!eat_dog("optimal dog", AddHotdog))
				abort("Cannot eat dog");
			//cli_execute("eat optimal dog");
			if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
			{
				visit_url("adventure.php?snarfblat=113"); //semirare
			}
			else
			{
				abort("No optimal dog semirare.");
			}
			eat(3 , $item[tasty tart]);
		}

		print("Task Prep (hot res, 2nd part)", "blue");
		
		force_skill($skill[Elemental Saucesphere]);
		force_skill($skill[Astral Shell]);

		use_familiar($familiar[Exotic Parrot]);

		if (have_effect($effect[Billiards Belligerence]) <= 0)
		{
			cli_execute("pool 1");
		}

		if((have_skill($skill[Leash of Linguini])) && (familiar_weight($familiar[Exotic Parrot]) + weight_adjustment() < 20))
		{
			force_skill($skill[Leash of Linguini]);
		}

		if((have_skill($skill[Empathy of the Newt])) && (familiar_weight($familiar[Exotic Parrot]) + weight_adjustment() < 20))
		{
			force_skill($skill[Empathy of the Newt]);
		}



		wish = "to be Fireproof Lips";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		if (item_amount($item[heat-resistant necktie]) > 0)
		{
			equip($slot[acc3], $item[heat-resistant necktie]);
		}
		if (item_amount($item[psychic's amulet]) > 0)
		{
			equip($slot[acc2], $item[psychic's amulet]);
		}
		if (item_amount(KGB) > 0) {
			equip($slot[acc1], KGB);
		} 
		else if (item_amount($item[psychic's amulet]) > 0)
		{
			equip($slot[acc1], $item[psychic's amulet]);
		}
		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
		}

		complete_quest("STEAM TUNNELS", 10);

		use_familiar(ToTour);

		equip($slot[acc3], $item[none]);

		//unequip and sell volcano equipments
		if (item_amount($item[heat-resistant necktie]) > 0)
		{
			autosell(1, $item[heat-resistant necktie]);
		}

		print("Base Booze Farming (if needed)", "blue");
		cli_execute("fortune buff gunther");

		if ((item_amount($item[boxed wine]) <= 0) && (item_amount($item[bottle of rum]) <= 0) && (item_amount($item[bottle of vodka]) <= 0) && (item_amount($item[bottle of gin]) <= 0) && (item_amount($item[bottle of whiskey]) <= 0) && (item_amount($item[bottle of tequila]) <= 0))
		{
			adventure(1, $location[Noob Cave]);
		}

		print("Main drink", "blue");

		force_skill($skill[Perfect Freeze]);
		//drinks
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (reach_meat(500)))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			cli_execute("drink Bee's Knees");

			//drink perfect drink here
			//wine=rum>vodka=gin>whiskey=tequila
			if (item_amount($item[boxed wine]) > 0)
			{
				craft("mix", 1, $item[boxed wine], $item[perfect ice cube]);
				drink(1, $item[Perfect mimosa]);
			}
			else if (item_amount($item[bottle of rum]) > 0)
			{
				craft("mix", 1, $item[bottle of rum], $item[perfect ice cube]);
				drink(1, $item[Perfect dark and stormy]);
			}
			else if (item_amount($item[bottle of vodka]) > 0)
			{
				craft("mix", 1, $item[bottle of vodka], $item[perfect ice cube]);
				drink(1, $item[Perfect cosmopolitan]);
			}
			else if (item_amount($item[bottle of gin]) > 0)
			{
				craft("mix", 1, $item[bottle of gin], $item[perfect ice cube]);
				drink(1, $item[Perfect negroni]);
			}
			else if (item_amount($item[bottle of whiskey]) > 0)
			{
				craft("mix", 1, $item[bottle of whiskey], $item[perfect ice cube]);
				drink(1, $item[Perfect old-fashioned]);
			}
			else if (item_amount($item[bottle of tequila]) > 0)
			{
				craft("mix", 1, $item[bottle of tequila], $item[perfect ice cube]);
				drink(1, $item[Perfect paloma]);
			}
			else abort("No perfect drink.");
		}
		else abort("Ode loop fail.");
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			if (item_amount($item[splendid martini]) >= 4) {
				drink(4, $item[splendid martini]);
			}
			else
			{
				drink(1, $item[asbestos thermos]);
			}
			drink(1, $item[astral pilsner]);
			//consider fruity drink if no thermos
		}
		else abort("Ode loop fail.");

		print("Task Prep (hp/mus)", "blue");
		//spells

		force_skill($skill[Sauce Contemplation]);
		force_skill($skill[Rage of the Reindeer]);
		try_skill($skill[Song of Bravado]);
		


		//buffs
		wish = "to be Preemptive Medicine";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		cli_execute("telescope high");
		visit_url("place.php?whichplace=monorail&action=monorail_lyle");


		//items
		if ((have_effect($effect[Oily Flavor]) <= 0) && (item_amount($item[oily paste]) > 0))
		{
			chew(1, $item[oily paste]);
		}
		if (item_amount($item[Ben-Gal&trade; Balm]) > 0)
		{
			use(1, $item[Ben-Gal&trade; Balm]);
		}
		if (item_amount($item[giant giant moth dust]) > 0)
		{
			use(1, $item[giant giant moth dust]);
		}
		if (item_amount($item[really thick spine]) > 0)
		{
			use(1, $item[really thick spine]);
		}
		if (item_amount($item[oil of expertise]) > 0)
		{
			use(1, $item[oil of expertise]);
		}
		if (item_amount($item[tomato juice of powerful power]) > 0)
		{
			use(1, $item[tomato juice of powerful power]);
		}
		if (item_amount($item[philter of phorce]) > 0)
		{
			use(1, $item[philter of phorce]);
		}
		if (item_amount($item[cold-filtered water]) > 0)
		{
			use(1, $item[cold-filtered water]);
		}

		//equipments
		if (item_amount($item[chef's hat]) > 0)
		{
			equip($slot[hat], $item[chef's hat]);
		}
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if (item_amount($item[helmet turtle]) > 0)
		{
			equip($slot[hat], $item[helmet turtle]);
		}
		if (item_amount($item[oversized skullcap]) > 0)
		{
			equip($slot[hat], $item[oversized skullcap]);
		}
		if (item_amount($item[Dolphin King's crown]) > 0)
		{
			equip($slot[hat], $item[Dolphin King's crown]);
		}
		if (item_amount($item[FantasyRealm Warrior's Helm]) > 0)
		{
			equip($slot[hat], $item[FantasyRealm Warrior's Helm]);
		}
		if (item_amount($item[remaindered axe]) > 0)
		{
			equip($slot[weapon], $item[remaindered axe]);
		}
		if (item_amount($item[fish hatchet]) > 0)
		{
			equip($slot[weapon], $item[fish hatchet]);
		}
		if (item_amount($item[psychic's crystal ball]) > 0)
		{
			equip($slot[off-hand], $item[psychic's crystal ball]);
		}
		if (item_amount($item[three-legged pants]) > 0)
		{
			equip($slot[pants], $item[three-legged pants]);
		}
		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
		}
		if (item_amount($item[Brutal brogues]) > 0)
		{
			equip($slot[acc2], $item[Brutal brogues]);
		}
		if (item_amount($item[ring of telling skeletons what to do]) > 0)
		{
			equip($slot[acc3], $item[ring of telling skeletons what to do]);
		}


		if(my_maxhp() - (my_buffedstat($stat[muscle]) + 3) < 30 * 58)
		{
			print("Mus Wish (You might want more skills)", "blue");
			print(60-((my_maxhp() - (my_buffedstat($stat[muscle])+3)) / 30) + " estimated adv", "blue");
			wish = "to be 'Roids of the Rhinoceros";
			visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
			visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);
		}

		complete_quest("DONATE BLOOD", 1);

		complete_quest("FEED CHILDREN", 2);

		print("Task Prep (mys)", "blue");
		//drink
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (reach_meat(500)))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			cli_execute("drink Bee's Knees");
		}
		else abort("Ode loop fail.");

		//spells

		force_skill($skill[The Magical Mojomuscular Melody]);
		force_skill($skill[Sauce Contemplation]);
		try_skill($skill[Song of Bravado]);

		//item
		if (item_amount($item[tomato juice of powerful power]) > 0)
		{
			use(1, $item[tomato juice of powerful power]);
		}
		if (item_amount($item[ointment of the occult]) > 0)
		{
			use(1, $item[ointment of the occult]);
		}
		if (item_amount($item[cold-filtered water]) > 0)
		{
			use(1, $item[cold-filtered water]);
		}
		if (item_amount($item[glittery mascara]) > 0)
		{
			use(1, $item[glittery mascara]);
		}
		if(item_amount($item[bag of grain]) > 0)
		{
			use(1, $item[bag of grain]);
		}
		if((get_property("_madTeaParty") == false) && (item_amount($item[ravioli hat]) > 0))
		{
			cli_execute("hatter ravioli hat");
		}
		else print("You do not have a suitable hat for the mad hatter here.", "red");


		//equip
		if (item_amount($item[chef's hat]) > 0)
		{
			equip($slot[hat], $item[chef's hat]);
		}
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if (item_amount($item[Dolphin King's crown]) > 0)
		{
			equip($slot[hat], $item[Dolphin King's crown]);
		}
		if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
		{
			equip($slot[hat], $item[FantasyRealm Mage's Hat]);
		}
		if (item_amount($item[astral statuette]) > 0)
		{
			equip($slot[off-hand], $item[astral statuette]);
		}
		if (item_amount($item[5-Alarm Saucepan]) > 0)
		{
			equip($slot[weapon], $item[5-Alarm Saucepan]);
		}


		complete_quest("BUILD PLAYGROUND MAZES", 3);
		try_num();

		print("Task Prep (mox)", "blue");
		//spells

		force_skill($skill[The Moxious Madrigal]);
		try_skill($skill[Song of Bravado]);

		//item
		if (item_amount($item[oil of expertise]) > 0)
		{
			use(1, $item[oil of expertise]);
		}
		if (item_amount($item[tomato juice of powerful power]) > 0)
		{
			use(1, $item[tomato juice of powerful power]);
		}
		if (item_amount($item[cold-filtered water]) > 0)
		{
			use(1, $item[cold-filtered water]);
		}
		if(item_amount($item[hair spray]) > 0)
		{
			use(1, $item[hair spray]);
		}
		if(item_amount($item[pocket maze]) > 0)
		{
			use(1, $item[pocket maze]);
		}
		if(get_property("_madTeaParty") == false)
		{
			if(item_amount($item[snorkel]) <= 0)
			{
				buy(1 , $item[snorkel], 30);
			}
			cli_execute("hatter snorkel");
		}
		else print("You already used up your mad hatter buff.", "red");

		//equip
		if(item_amount($item[codpiece]) > 0)
		{
			equip($slot[acc1], $item[Codpiece]);
		}
		if (item_amount($item[Dolphin King's crown]) > 0)
		{
			equip($slot[hat], $item[Dolphin King's crown]);
		}
		if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
		{
			equip($slot[hat], $item[FantasyRealm Mage's Hat]);
		}
		if (item_amount($item[chef's hat]) > 0)
		{
			equip($slot[hat], $item[chef's hat]);
		}
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if (item_amount($item[mariachi hat]) > 0)
		{
			equip($slot[hat], $item[mariachi hat]);
		}
		if (item_amount($item[disco mask]) > 0)
		{
			equip($slot[hat], $item[disco mask]);
		}
		if (item_amount($item[Dolphin King's crown]) > 0)
		{
			equip($slot[hat], $item[Dolphin King's crown]);
		}
		if (item_amount($item[FantasyRealm Rogue's Mask]) > 0)
		{
			equip($slot[hat], $item[FantasyRealm Rogue's Mask]);
		}
		if (item_amount($item[stylish swimsuit]) > 0)
		{
			equip($slot[pants], $item[stylish swimsuit]);
		}
		if (item_amount($item[psychic's crystal ball]) > 0)
		{
			equip($slot[off-hand], $item[psychic's crystal ball]);
		}

		complete_quest("BUILD FEED CONSPIRATORS", 4);

		print("Task Prep (fam weight)", "blue");

		force_skill($skill[Leash of Linguini]);
		force_skill($skill[Empathy of the Newt]);
		
		if(item_amount($item[beastly paste]) > 0)
		{
			chew(1, $item[beastly paste]);
		}
		if (have_effect($effect[Billiards Belligerence]) <= 0)
		{
			cli_execute("pool 1");
		}

		//equips
		if (item_amount($item[fish hatchet]) > 0)
		{
			equip($slot[weapon], $item[fish hatchet]);
		}
		if (item_amount($item[Dolphin King's crown]) > 0)
		{
			equip($slot[hat], $item[Dolphin King's crown]);
		}
		if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
		{
			equip($slot[hat], $item[FantasyRealm Mage's Hat]);
		}
		if (item_amount($item[chef's hat]) > 0)
		{
			equip($slot[hat], $item[chef's hat]);
		}
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if (item_amount($item[Brutal brogues]) > 0)
		{
			equip($slot[acc2], $item[Brutal brogues]);
		}

		//borrow time here
		print("Borrowing Time", "blue");
		if (item_amount($item[borrowed time]) > 0)
		{
			use(1, $item[borrowed time]);
		}

		complete_quest("BREED MORE COLLIES", 5);

		print("Task Prep (-combat)", "blue");

		force_skill($skill[Smooth Movement]);
		force_skill($skill[The Sonata of Sneakiness]);
		if (have_effect($effect[Silent Running]) <= 0)
		{
			cli_execute("swim noncombat");
		}
		if(item_amount($item[codpiece]) > 0)
		{
			equip($slot[acc1], $item[Codpiece]);
		}
		if (item_amount(KGB) > 0)
		{
			equip($slot[acc2], KGB);
		}
		if (item_amount($item[fish hatchet]) > 0)
		{
			equip($slot[weapon], $item[fish hatchet]);
		}
		if (item_amount($item[Dolphin King's crown]) > 0)
		{
			equip($slot[hat], $item[Dolphin King's crown]);
		}
		if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
		{
			equip($slot[hat], $item[FantasyRealm Mage's Hat]);
		}
		if (item_amount($item[chef's hat]) > 0)
		{
			equip($slot[hat], $item[chef's hat]);
		}
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
		}
		if(item_amount($item[squeaky toy rose]) > 0)
		{
			use(1, $item[squeaky toy rose]);
		}
		if(item_amount($item[shady shades]) > 0)
		{
			use(1, $item[shady shades]);
		}
		if(item_amount($item[pocket wish]) > 0)
		{
			string wish = "to be Disquiet Riot";
			visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
			visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);
		}
		if(item_amount($item[pocket wish]) > 0) //might want to save pocket wish if not needed
		{
			string wish = "to be Chocolatesphere";
			visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
			visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);
		}

		complete_quest("BE A LIVING STATUE", 8);

		if (have_effect($effect[The Sonata of Sneakiness]) > 0)
		{
			cli_execute("shrug The Sonata of Sneakiness");
		}

		print("ASCENSION - DONATING YOUR BODY TO SCIENCE", "red");
		visit_url("council.php");
		visit_url("choice.php?pwd&whichchoice=1089&option=30");

		// Restore previous CCS
		set_property("customCombatScript", get_property("hccs2da_backupCCS"));

		print("FINISHED.", "red");
	}
}


