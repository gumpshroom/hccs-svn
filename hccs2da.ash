//HCCS 2day 100% v0.4 by iloath

script "hccs2da.ash";
notify iloath;

void try_num()
{
	if (have_skill($skill[Calculate the Universe]))
	{
		if (get_property("_universeCalculated").to_int() == 0)
		{
			int [int] testcon;
			testcon = reverse_numberology();
			if (testcon contains 18)
			{
				cli_execute("numberology 18");
			}
			else if (testcon contains 44)
			{
				cli_execute("numberology 44");
			}
			else if (testcon contains 75)
			{
				cli_execute("numberology 75");
			}
			else if (testcon contains 99)
			{
				cli_execute("numberology 99");
			}
		}
		else if (get_property("_universeCalculated").to_int() < get_property("skillLevel144").to_int())
		{
			int [int] testcon;
			testcon = reverse_numberology();
			if (testcon contains 69)
			{
				cli_execute("numberology 69");
			}
		}
	}
}

void complete_quest(string questname, int choicenumber)
{
	int adv = 0;
	print("QUEST - "+questname, "red");
	adv = my_adventures();
	visit_url("council.php");
	visit_url("choice.php?pwd&whichchoice=1089&option="+choicenumber);
	adv = adv - my_adventures();
	if (adv == 0)
	{
		abort("Not enough adventures to complete quest");
	}
	print("USED " + adv + " ADV", "red");
	try_num();
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
	if (my_mp() < value)
	{
		return false;
	}
	return true;
}

boolean reach_meat(int value)
{
	if (my_meat() >= value)
		return true;
	foreach stone in $items[strongness elixir,magicalness-in-a-can,moxie weed,Doc Galaktik's Homeopathic Elixir, meat stack]
		autosell(item_amount(stone), stone);
	if (my_meat() < value)
	{
		return false;
	}
	return true;
}

void force_skill(skill value)
{
	if(have_skill(value))
	{
		if (my_maxmp() < mp_cost(value))
		{
			abort("Mp cap too low");
		}
		if (reach_mp(mp_cost(value)))
		{
			use_skill(1 ,value);
		}
		else
		{
			abort("Unable to obatin sufficent mp for: " + value);
		}
	}
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
	/*
	if(have_skill($skill[Grab a Cold One]) && (my_mp() >= mp_cost($skill[Grab a Cold One])))
	{
		use_skill(1 ,$skill[Grab a Cold One]);
	}
	if(have_skill($skill[Spaghetti Breakfast]) && (my_mp() >= mp_cost($skill[Spaghetti Breakfast])))
	{
		use_skill(1 ,$skill[Spaghetti Breakfast]);
	}
	if(have_skill($skill[Advanced Saucecrafting]) && (my_mp() >= mp_cost($skill[Advanced Saucecrafting])))
	{
		use_skill(1 ,$skill[Advanced Saucecrafting]);
	}
	if(have_skill($skill[Advanced Cocktailcrafting]) && (my_mp() >= mp_cost($skill[Advanced Cocktailcrafting])))
	{
		use_skill(1 ,$skill[Advanced Cocktailcrafting]);
	}
	if(have_skill($skill[Pastamastery]) && (my_mp() >= mp_cost($skill[Pastamastery])))
	{
		use_skill(1 ,$skill[Pastamastery]);
	}
	if(have_skill($skill[Perfect Freeze]) && (my_mp() >= mp_cost($skill[Perfect Freeze])))
	{
		use_skill(1 ,$skill[Perfect Freeze]);
	}
	if(have_skill($skill[Lunch Break]) && (my_mp() >= mp_cost($skill[Lunch Break])))
	{
		use_skill(1 ,$skill[Lunch Break]);
	}
	*/
}

void summon_pants(string m, string e, string s1, string s2, string s3)
{
	if (item_amount($item[portable pantogram]) == 0)
	{
		return;
	}

	print("SUMMONING PANTS", "red");
	visit_url("choice.php?whichchoice=1270&pwd&option=1&m="+m+"&e="+e+"&s1="+s1+"&s2="+s2+"&s3="+s3,true,true);
	if (item_amount($item[pantogram pants]) == 0)
	{
		abort("Couldn't summon pants");
	}
}

void main(){

	//info
	//_aprilShower
	//_bootStomps
	//_borrowedTimeUsed
	//_clipartSummons
	//_deluxeKlawSummons
	//_demandSandwich
	//_discoKnife
	//_hotTubSoaks
	//_klawSummons
	//_lookingGlass
	//_lunchBreak
	//_madTeaParty
	//_poolGames
	//_spaghettiBreakfast
	//_spaghettiBreakfastEaten
	//_speakeasyDrinksDrunk
	//bootsCharged
	//lastBarrelSmashed
	//telescopeLookedHigh
	//TODO: use variables
	//wait(5);



	//snorkel 7  	Moxie +10
	//disco mask 9  	Weapon Damage +15
	//ravioli hat 	10  Mysticality +10
	//mariachi hat 11 Spell Damage +30%
	//helmet turtle 12  	Maximum HP +50
	//coconut shell 12 	Maximum HP +50
	//seal-skull helmet 16  	+10 Cold Damage
	//Hollandaise 17  	+10 Spooky Damage
	//Dolphin King's crown 18  	+10 Stench Damage
	//Kentucky-style derby 19 +10 hot Damage
	//mage hat 22? +40% Meat from Monsters
	//rogue mask 23?  	Mysticality +20%
	//war hat 25? +3 Stat Gains from Fights

	//init
	skill ToCast = $skill[Spirit of Peppermint];
	familiar ToTour = $familiar[Origami Towel Crane]; //set this, TODO: auto this
	boolean AddHotdog = false; //TODO
	string wish = "init";
	string clan = get_clan_name();
	//Oh No, Hobo
	//115
	//1
	//The Singing Tree
	//116
	//4?
	//Trespasser
	//117
	//1?
	//The Baker's Dilemma
	//114
	//2?
	//Temporarily Out of Skeletons
	//1060
	//1 then 4 then maybe 2
	set_property("choiceAdventure115", 1);
	set_property("choiceAdventure116", 4);
	set_property("choiceAdventure117", 1);
	set_property("choiceAdventure114", 2);
	set_property("choiceAdventure1060", 1);

	set_property("manaBurningThreshold", -0.05);

	set_property("customCombatScript", "hccs");
	//customCombatScript=hccs

	cli_execute("refresh all");

	if(my_path() != "Community Service")
	{
		abort("Not Community Service.");
	}

	if (my_daycount() == 1)
	{
		//first get the dairy goat fax and clanmate fortunes,

		if(item_amount($item[photocopied monster]) == 0)
		{
			print("No photocopied monster, skipping in...");
			wait(5);
		}


		//dont always work :(
		/*
		cli_execute("/w cheesefax dairy goat");
		print("Poking Cheesefax for goat");
		if (item_amount($item[photocopied monster]) <= 0)
		repeat {wait(5); refresh_status();}
		until (item_amount($item[photocopied monster]) > 0);
		print("Done Fax");

		cli_execute("/whitelist Bonus Adventures from Hell"); //bugged
		if (get_clan_name() == "Bonus Adventures from Hell")
		{
			cli_execute("fortune cheesefax");
			print("Poking Cheesefax for fortune");
		}
		else
		{
			abort("Wrong Clan");
		}
		int prev = item_amount($item[genie's turbane])+item_amount($item[genie's scimitar])+item_amount($item[genie's pants])+item_amount($item[genie's bracers])+item_amount($item[psychic's circlet])+item_amount($item[psychic's crystal ball])+item_amount($item[psychic's pslacks])+item_amount($item[psychic's amulet]);
		if (item_amount($item[genie's turbane])+item_amount($item[genie's scimitar])+item_amount($item[genie's pants])+item_amount($item[genie's bracers])+item_amount($item[psychic's circlet])+item_amount($item[psychic's crystal ball])+item_amount($item[psychic's pslacks])+item_amount($item[psychic's amulet]) <= prev)
			repeat {wait(5); refresh_status();}
		until (item_amount($item[genie's turbane])+item_amount($item[genie's scimitar])+item_amount($item[genie's pants])+item_amount($item[genie's bracers])+item_amount($item[psychic's circlet])+item_amount($item[psychic's crystal ball])+item_amount($item[psychic's pslacks])+item_amount($item[psychic's amulet]) > prev);
		print("Done Fortune");
		cli_execute("/whitelist "+clan);//bugged
		*/

		try_num();

		// Make meat from BoomBox if we can
		if (item_amount($item[SongBoom&trade; BoomBox]) > 0)
		{
			cli_execute("boombox meat");
		}

		// unlock the briefcase
		if (item_amount($item[Kremlin's Greatest Briefcase]) > 0)
		{
			if (svn_exists("Ezandora-Briefcase-branches-Release")) {
				cli_execute("Briefcase unlock");
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


		//use(1, $item[Newbiesport&trade; tent]);
		try_item($item[Newbiesport&trade; tent]);

		ToCast = $skill[Spirit of Peppermint];

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

		ToCast = $skill[Disintegrate];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				if (item_amount($item[photocopied monster]) > 0)
					use(1, $item[photocopied monster]);
				else abort("You do not have a photocopied monster.");
			}
			else abort("Not enough mp.");
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
		cli_execute("eat optimal dog"); //TODO: change to vist_url to stop "The 'optimal dog' is not currently available in your clan" error, add code to add hotdog ingredients.
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
				if (my_meat() >= 125)
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
		/*
		if(have_skill($skill[Perfect Freeze]) && (my_mp() >= mp_cost($skill[Perfect Freeze])))
		{
			use_skill(1 ,$skill[Perfect Freeze]);
		}
		*/
		force_skill($skill[Perfect Freeze]);

		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (my_meat() >= 250))
		{
			use_skill(1 ,$skill[The Ode to Booze]);

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
				cli_execute("drink cup of tea");
			}

			drink(1, $item[thermos full of Knob coffee]);
		}
		else abort("Ode loop fail.");

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
		if (item_amount($item[Kremlin's Greatest Briefcase]) > 0 && if (svn_exists("Ezandora-Briefcase-branches-Release")) {
			cli_execute("Briefcase b item");
		}

		wish = "to be Infernal Thirst";
		visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9537", false);
		visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

		force_skill($skill[Steely-Eyed Squint]);

		//use up mp
		print("Using up mp", "blue");
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
			ToCast = $skill[Disintegrate];
			if(have_skill(ToCast))
			{
				if (my_mp() >= mp_cost(ToCast))
				{
					adventure(1, $location[The Skeleton Store]);
					try_num();
				}
				else abort("Not enough mp.");
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
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (my_meat() >= 500))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
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
		if (item_amount($item[psychic's amulet]) > 0)
		{
			equip($slot[acc2], $item[psychic's amulet]);
		}
		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
		}
		if (item_amount($item[Kremlin's Greatest Briefcase]) > 0)
		{
			equip($slot[acc3], $item[Kremlin's Greatest Briefcase]);
		}

		//magic dragonfish does not seem to work here!

		complete_quest("MAKE SAUSAGE", 7);

		print("Task Prep (weapon dmg)", "blue");
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (my_meat() >= 500))
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
		if (item_amount($item[Kremlin's Greatest Briefcase]) > 0)
		{
			equip($slot[acc3], $item[Kremlin's Greatest Briefcase]);
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

		//TODO check if success
		try_num();

		// pantogramming (+mus, res hot, +hp, weapon dmg, -combat)
		summon_pants(1, 1, "-1%2C0", "-1%2C0", "-1%2C0");

		// setup briefcase
		if (item_amount($item[Kremlin's Greatest Briefcase]) > 0 && if (svn_exists("Ezandora-Briefcase-branches-Release")) {
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

		if (my_meat() >= 24*3)
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

		print("Using up mp", "blue");
		if(have_skill($skill[Grab a Cold One]) && (my_mp() >= mp_cost($skill[Grab a Cold One])))
		{
			use_skill(1 ,$skill[Grab a Cold One]);
		}
		if(have_skill($skill[Spaghetti Breakfast]) && (my_mp() >= mp_cost($skill[Spaghetti Breakfast])))
		{
			use_skill(1 ,$skill[Spaghetti Breakfast]);
		}
		if(have_skill($skill[Advanced Saucecrafting]) && (my_mp() >= mp_cost($skill[Advanced Saucecrafting])))
		{
			use_skill(1 ,$skill[Advanced Saucecrafting]);
		}
		if(have_skill($skill[Advanced Cocktailcrafting]) && (my_mp() >= mp_cost($skill[Advanced Cocktailcrafting])))
		{
			use_skill(1 ,$skill[Advanced Cocktailcrafting]);
		}
		if(have_skill($skill[Pastamastery]) && (my_mp() >= mp_cost($skill[Pastamastery])))
		{
			use_skill(1 ,$skill[Pastamastery]);
		}
		if(have_skill($skill[Perfect Freeze]) && (my_mp() >= mp_cost($skill[Perfect Freeze])))
		{
			use_skill(1 ,$skill[Perfect Freeze]);
		}
		if(have_skill($skill[Lunch Break]) && (my_mp() >= mp_cost($skill[Lunch Break])))
		{
			use_skill(1 ,$skill[Lunch Break]);
		}

		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
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
		foreach stone in $items[moxie weed,magicalness-in-a-can,strongness elixir,fine wine, meat stack, casino pass, hermit permit, half of a gold tooth]
			autosell(item_amount(stone), stone);

		use(item_amount($item[Gathered Meat-Clip]), $item[Gathered Meat-Clip]);

		print("Task Prep (hot res, 1st part)", "blue");
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (my_meat() >= 500))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			cli_execute("drink Ish Kabibble");
		}
		else abort("Ode loop fail.");

		//needed if no thick skin or other mp skills
		buy(1 , $item[glittery mascara], 24);
		use(1 , $item[glittery mascara]);

		ToCast = $skill[The Magical Mojomuscular Melody];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}

		ToCast = $skill[Sauce Contemplation];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}

		print("Using up mp", "blue");
		if(have_skill($skill[Grab a Cold One]) && (my_mp() >= mp_cost($skill[Grab a Cold One])))
		{
			use_skill(1 ,$skill[Grab a Cold One]);
		}
		if(have_skill($skill[Spaghetti Breakfast]) && (my_mp() >= mp_cost($skill[Spaghetti Breakfast])))
		{
			use_skill(1 ,$skill[Spaghetti Breakfast]);
		}
		if(have_skill($skill[Advanced Saucecrafting]) && (my_mp() >= mp_cost($skill[Advanced Saucecrafting])))
		{
			use_skill(1 ,$skill[Advanced Saucecrafting]);
		}
		if(have_skill($skill[Advanced Cocktailcrafting]) && (my_mp() >= mp_cost($skill[Advanced Cocktailcrafting])))
		{
			use_skill(1 ,$skill[Advanced Cocktailcrafting]);
		}
		if(have_skill($skill[Pastamastery]) && (my_mp() >= mp_cost($skill[Pastamastery])))
		{
			use_skill(1 ,$skill[Pastamastery]);
		}
		if(have_skill($skill[Perfect Freeze]) && (my_mp() >= mp_cost($skill[Perfect Freeze])))
		{
			use_skill(1 ,$skill[Perfect Freeze]);
		}
		if(have_skill($skill[Lunch Break]) && (my_mp() >= mp_cost($skill[Lunch Break])))
		{
			use_skill(1 ,$skill[Lunch Break]);
		}

		cli_execute("shower mp");

		print("Y-RAY FAX", "blue");
		ToCast = $skill[Disintegrate];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				if (item_amount($item[photocopied monster]) > 0)
					use(1, $item[photocopied monster]);
				else abort("You do not have a photocopied monster.");
			}
			else abort("Not enough mp.");
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
			cli_execute("eat wet dog");
		}
		else
		{
			cli_execute("eat optimal dog");
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
		ToCast = $skill[Elemental Saucesphere];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}

		ToCast = $skill[Astral Shell];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}

		use_familiar($familiar[Exotic Parrot]);

		if (have_effect($effect[Billiards Belligerence]) <= 0)
		{
			cli_execute("pool 1");
		}

		ToCast = $skill[Leash of Linguini];
		if((have_skill(ToCast)) && (familiar_weight($familiar[Exotic Parrot]) + weight_adjustment() < 20))
		{
			while ((my_mp() < mp_cost(ToCast)) && (my_soulsauce() >= 5))
			{
				use_skill(1 ,$skill[Soul Food]);
			}
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}

		ToCast = $skill[Empathy of the Newt];
		if((have_skill(ToCast)) && (familiar_weight($familiar[Exotic Parrot]) + weight_adjustment() < 20))
		{
			while ((my_mp() < mp_cost(ToCast)) && (my_soulsauce() >= 5))
			{
				use_skill(1 ,$skill[Soul Food]);
			}
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
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
		if (item_amount($item[psychic's amulet]) > 0)
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
		if(have_skill($skill[Perfect Freeze]) && (my_mp() >= mp_cost($skill[Perfect Freeze])))
		{
			use_skill(1 ,$skill[Perfect Freeze]);
		}
		//drinks
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (my_meat() >= 500))
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
			drink(1, $item[asbestos thermos]);
			drink(1, $item[astral pilsner]);
			//consider fruity drink if no thermos
		}
		else abort("Ode loop fail.");

		print("Task Prep (hp/mus)", "blue");
		//spells
		ToCast = $skill[Sauce Contemplation];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[Rage of the Reindeer];
		if(have_skill(ToCast))
		{
			while ((my_mp() < mp_cost(ToCast)) && (my_soulsauce() >= 5))
			{
				use_skill(1 ,$skill[Soul Food]);
			}
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[Song of Bravado];
		if(have_skill(ToCast) && (my_mp() >= mp_cost(ToCast)))
		{
			use_skill(1 ,ToCast);
		}
		ToCast = $skill[Song of Starch];
		if(have_skill(ToCast) && (my_mp() >= mp_cost(ToCast)))
		{
			use_skill(1 ,ToCast);
		}


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
		if (item_amount($item[ring of telling skeletons what to do]) > 0)
		{
			equip($slot[acc3], $item[ring of telling skeletons what to do]);
		}
		if (item_amount($item[three-legged pants]) > 0)
		{
			equip($slot[pants], $item[three-legged pants]);
		}
		if (item_amount($item[pantogram pants]) > 0)
		{
			equip($slot[pants], $item[pantogram pants]);
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
		if ((have_skill($skill[The Ode to Booze])) && (my_mp() >= mp_cost($skill[The Ode to Booze])) && (my_meat() >= 500))
		{
			use_skill(1 ,$skill[The Ode to Booze]);
			cli_execute("drink Bee's Knees");
		}
		else abort("Ode loop fail.");

		//spells
		ToCast = $skill[The Magical Mojomuscular Melody];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[Sauce Contemplation];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[Song of Bravado];
		if(have_skill(ToCast) && (my_mp() >= mp_cost(ToCast)))
		{
			use_skill(1 ,ToCast);
		}

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
		ToCast = $skill[The Moxious Madrigal];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[Song of Bravado];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}

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
		ToCast = $skill[Leash of Linguini];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[Empathy of the Newt];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
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

		//borrow time here
		print("Borrowing Time", "blue");
		if (item_amount($item[borrowed time]) > 0)
		{
			use(1, $item[borrowed time]);
		}

		complete_quest("BREED MORE COLLIES", 5);

		print("Task Prep (-combat)", "blue");
		ToCast = $skill[Smooth Movement];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		ToCast = $skill[The Sonata of Sneakiness];
		if(have_skill(ToCast))
		{
			if (my_mp() >= mp_cost(ToCast))
			{
				use_skill(1 ,ToCast);
			}
			else abort("Not enough mp.");
		}
		if (have_effect($effect[Silent Running]) <= 0)
		{
			cli_execute("swim noncombat");
		}
		if(item_amount($item[codpiece]) > 0)
		{
			equip($slot[acc1], $item[Codpiece]);
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

		print("FINISHED.", "red");
	}

	//paste list
	//any,any,clown,gnoll in gym,crate,fluffy bunny in dire warren

	//fortune list
	//hangk, gunther

	//speakeasy
	//tea, in a lather, in a lather
	//all res, stats100%, stats100%



	/*
	foreach stone in $items[moxie weed,strongness elixir,concentrated magicalness pill,giant moxie weed,haunted battery,extra-strength strongness elixir,enchanted barbell,jug-o-magicalness,suntan lotion of moxiousness,synthetic marrow,the funk,meat stack,dense meat stack]
		autosell(item_amount(stone), stone);
	*/


	//string wish = "for more wishes";
	//string page = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9529", false);
	//page = visit_url("choice.php?pwd=&whichchoice=1267&option=1&wish=" + wish);

}

