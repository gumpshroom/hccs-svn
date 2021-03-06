//HCCS 2day 100% v1.0 by iloath
script "hccs2daexp.ash";
notify iloath;

//kmail iloath if you found any bugs

//TODO: burning cape
//TODO: settings do not revert when using step/multiple start

//Find Menu
//SETTINGS
//DAY1
//DAY2

//1DAY13QUEST1TASK000ADJUST

void show_help()
{
	print_html("iloath's HCCS 2day experimental");
	print_html("Usage: hccs2daexp [argument].");
	print_html("");
	print_html("Configuration options:");
	print_html("<b>help</b> - Show this help message.");
	print_html("<b>settings</b> - Allow you to set your script configuration.");
	print_html("<b>records</b> - Show this run's records and other statistics.");
	print_html("<b>warnings</b> - Show warnings for missing IoTMs and perms.");
	print_html("<b>consult</b> - Do your fortune consults.");
	print_html("<b>3adv</b> - Attempt to calculate the universe for 3adv.");
	print_html("<b>hotdog</b> - Stuff your self with basic hotdogs, use before ascending.");
	print_html("<b>revert</b> - Revert your setting to that before you ran script, used automatically when script donates your body, use this if you plan to finish run manually.");
	print_html("<b>test</b> - FOR TESTERS ONLY. test an unknown code snippet");
	print_html("<b>next</b> - NOT YET IMPLEMENTED. skip current step if script keep getting stuck on it");
	print_html("<b>load</b> - NOT YET IMPLEMENTED. start from a certain step");
	print_html("<b>resume</b> - NOT YET IMPLEMENTED. Resume script.");
	print_html("<b>start</b> - Run script, starting from the beginning of a day.");
	print_html("<b>step</b> - Run script, stopping when a quest a done.");
	
	print_html("");
	print_html("Example commands, type into kolmafia's CLI:");
	print_html("<b>\"hccs2daexp warnings\"</b> Show warnings for missing IoTMs and perms.");
	print_html("<b>\"hccs2daexp start\"</b> Run script.");
}

void revert_settings()
{
	//doc bag quest (dont work)
	//set_property("choiceAdventure1340", get_property("hccs2da_backup_choiceAdventure1340"));
	//remove_property("hccs2da_backup_choiceAdventure1340");

	//The Baker's Dilemma
	set_property("choiceAdventure114", get_property("hccs2da_backup_choiceAdventure114"));
	remove_property("hccs2da_backup_choiceAdventure114");
	//Oh No, Hobo
	set_property("choiceAdventure115", get_property("hccs2da_backup_choiceAdventure115"));
	remove_property("hccs2da_backup_choiceAdventure115");
	//The Singing Tree
	set_property("choiceAdventure116", get_property("hccs2da_backup_choiceAdventure116"));
	remove_property("hccs2da_backup_choiceAdventure116");
	//Trespasser
	set_property("choiceAdventure117", get_property("hccs2da_backup_choiceAdventure117"));
	remove_property("hccs2da_backup_choiceAdventure117");
	//Temporarily Out of Skeletons
	set_property("choiceAdventure1060", get_property("hccs2da_backup_choiceAdventure1060"));
	remove_property("hccs2da_backup_choiceAdventure1060");

	//Mana burning
	set_property("manaBurningThreshold", get_property("hccs2da_backup_manaBurningThreshold"));
	remove_property("hccs2da_backup_manaBurningThreshold");

	//Settings
	set_property("autoSatisfyWithNPCs", get_property("hccs2da_backup_autoSatisfyWithNPCs"));
	remove_property("hccs2da_backup_autoSatisfyWithNPCs");
	set_property("autoSatisfyWithCoinmasters", get_property("hccs2da_backup_autoSatisfyWithCoinmasters"));
	remove_property("hccs2da_backup_autoSatisfyWithCoinmasters");
	set_property("dontStopForCounters", get_property("hccs2da_backup_dontStopForCounters"));
	remove_property("hccs2da_backup_dontStopForCounters");

	//CCS
	set_property("customCombatScript", get_property("hccs2da_backup_customCombatScript"));
	remove_property("hccs2da_backup_customCombatScript");
	
	//progress
	set_property("hccs2da_progress" ,0 );
	remove_property("hccs2da_progress");
}

void set_settings()
{
	//if true will do pvp
	if (user_confirm("Perform PVP?"))
	{
		set_property("hccs2da_dopvp" ,true );
	}
	else
	{
		set_property("hccs2da_dopvp" ,false );
	}
	
	//if true will fight god lobster and break 100% fam tour
	if (user_confirm("Abandon 100% Familiar Run for God Lobster Fights?"))
	{
		set_property("hccs2da_notour" ,true );
	}
	else
	{
		set_property("hccs2da_notour" ,false );
	}
	
	//if true will not fight scaling monsters
	if (user_confirm("Avoid scaling monsters and the risk of being beaten up?"))
	{
		set_property("hccs2da_noscale" ,true );
	}
	else
	{
		set_property("hccs2da_noscale" ,false );
	}
	
	//if true save pocket wishes
	if (user_confirm("Be stingy and save bunch of pocket wishes per run?"))
	{
		set_property("hccs2da_stingy" ,true );
	}
	else
	{
		set_property("hccs2da_stingy" ,false );
	}
	
	//if true will do barrels
	if (user_confirm("Do barrels for meat?"))
	{
		set_property("hccs2da_barrels" ,true );
	}
	else
	{
		set_property("hccs2da_barrels" ,false );
	}
	
	//if true will do fortune consults in BAFH
	if (user_confirm("Do fortune consults in BAFH?"))
	{
		set_property("hccs2da_consults" ,true );
	}
	else
	{
		set_property("hccs2da_consults" ,false );
	}
}

void show_records()
{
	//RECORDS
	//Print quest completion speed
	print("QUEST RECORDS", "purple");
	print("COIL WIRE: " + get_property( "hccs2da_questrecord11" ), "blue");
	print("MAKE MARGARITAS: " + get_property( "hccs2da_questrecord9" ), "blue");
	print("MAKE SAUSAGE: " + get_property( "hccs2da_questrecord7" ), "blue");
	print("REDUCE GAZELLE POPULATION: " + get_property( "hccs2da_questrecord6" ), "blue");
	print("STEAM TUNNELS: " + get_property( "hccs2da_questrecord10" ), "blue");
	print("DONATE BLOOD: " + get_property( "hccs2da_questrecord1" ), "blue");
	print("FEED CHILDREN: " + get_property( "hccs2da_questrecord2" ), "blue");
	print("BUILD PLAYGROUND MAZES: " + get_property( "hccs2da_questrecord3" ), "blue");
	print("FEED CONSPIRATORS: " + get_property( "hccs2da_questrecord4" ), "blue");
	print("BREED MORE COLLIES: " + get_property( "hccs2da_questrecord5" ), "blue");
	print("BE A LIVING STATUE: " + get_property( "hccs2da_questrecord8" ), "blue");
	print(" ", "purple");
	print("OTHER INFO", "purple");
	print("TURN COUNT: " + my_turncount(), "blue");
	print("REMAINING ADV: " + my_adventures(), "blue");
	print("MARZIPAN ITEM%: " + get_property( "hccs2da_marzipanhard" ), "blue");
	print("MARZIPAN CANDY%: " + get_property( "hccs2da_marzipaneasy" ), "blue");
	print("MOXIE AT FACTORY: " + get_property( "hccs2da_factorymox" ), "blue");
	print("PVP ENABLED: " + get_property( "hccs2da_dopvp" ), "blue");
	print("TOUR DISABLED: " + get_property( "hccs2da_notour" ), "blue");
	print("SCALING MOBS DISABLED: " + get_property( "hccs2da_noscale" ), "blue");
	print("STINGY MODE: " + get_property( "hccs2da_stingy" ), "blue");
	print("DO BARRELS: " + get_property( "hccs2da_barrels" ), "blue");
	print("DO CONSULTS: " + get_property( "hccs2da_consults" ), "blue");
}

void show_warnings()
{
	//WARNINGS
	if (to_string(my_class()) == "Astral Spirit")
	{
		print("Cannot detect skills and items as Astral Spirit", "red");
	}
	else
	{
		if (have_skill($skill[Summon Clip Art]))
		{
			print("Clip art detected, will run route 1", "blue");
			if (item_amount($item[Clan VIP Lounge key]) <= 0)
			{
				print("WARNING: VIP Key not detected", "red");
			}
			if (item_amount($item[genie bottle]) <= 0)
			{
				print("WARNING: Genie bottle not detected", "red");
			}
			if (!have_familiar($familiar[Stooper]))
			{
				print("WARNING: Stooper not detected", "red");
			}
			if (!have_skill($skill[The Ode to Booze]))
			{
				print("WARNING: Ode to Booze not detected", "red");
			}
			if (!have_skill($skill[Advanced Saucecrafting]))
			{
				print("WARNING: Advanced Saucecrafting not detected", "red");
			}
			if (!have_skill($skill[Disintegrate]))
			{
				print("WARNING: Disintegrate not detected", "red");
			}
			if (!have_skill($skill[The Magical Mojomuscular Melody]))
			{
				print("WARNING: Magical Mojomuscular Melody not detected", "red");
			}
			if (!have_skill($skill[Wisdom of the Elder Tortoises]))
			{
				print("WARNING: Wisdom of the Elder Tortoises not detected", "red");
			}
			if (!have_skill($skill[Perfect Freeze]))
			{
				print("WARNING: Perfect Freeze not detected", "red");
			}
			if (!have_skill($skill[Inner Sauce]))
			{
				print("WARNING: Inner Sauce not detected", "red");
			}
		}
		else
		{
			print("Clip art not detected, will run route 2", "red");
			if (item_amount($item[Clan VIP Lounge key]) <= 0)
			{
				print("WARNING: VIP Key not detected", "red");
			}
			if (item_amount($item[genie bottle]) <= 0)
			{
				print("WARNING: Genie bottle not detected", "red");
			}
			if (!have_familiar($familiar[Stooper]))
			{
				print("WARNING: Stooper not detected", "red");
			}
			if (!have_skill($skill[The Ode to Booze]))
			{
				print("WARNING: Ode to Booze not detected", "red");
			}
			if (!have_skill($skill[Advanced Saucecrafting]))
			{
				print("WARNING: Advanced Saucecrafting not detected", "red");
			}
			if (!have_skill($skill[Pastamastery]))
			{
				print("WARNING: Pastamastery not detected", "red");
			}
			if (!have_skill($skill[Saucemaven]))
			{
				print("WARNING: Saucemaven not detected", "red");
			}
			if (!have_skill($skill[Bow-Legged Swagger]))
			{
				print("WARNING: Bow-Legged Swagger not detected", "red");
			}
			if (!have_skill($skill[Disintegrate]))
			{
				print("WARNING: Disintegrate not detected", "red");
			}
			if (!have_skill($skill[The Magical Mojomuscular Melody]))
			{
				print("WARNING: Magical Mojomuscular Melody not detected", "red");
			}
			if (!have_skill($skill[Wisdom of the Elder Tortoises]))
			{
				print("WARNING: Wisdom of the Elder Tortoises not detected", "red");
			}
			if (!have_skill($skill[Perfect Freeze]))
			{
				print("WARNING: Perfect Freeze not detected", "red");
			}
			if (!have_skill($skill[Inner Sauce]))
			{
				print("WARNING: Inner Sauce not detected", "red");
			}
		}
		
		if(my_class() != $class[Sauceror]) print("Not Sauceror, not recommanded!","red");
		if(!in_hardcore()) print("Not Hardcore, not recommanded!","red");
		if(my_path() != "Community Service") abort("Not Community Service! Will abort!");
	}
}

int make_sausage(int count_lim, int paste_lim)
{
	if ((item_amount($item[Kramco Sausage-o-Matic&trade;]) <= 0) && !(have_equipped($item[Kramco Sausage-o-Matic&trade;])))
	{
		print("No grinder");
		return -1;
	}
	int highestICanAfford = floor(paste_lim / 111) - get_property("_sausagesMade").to_int();
	int amountToMake = min(count_lim, highestICanAfford);
	cli_execute("make " + amountToMake + " magical sausage");
	return amountToMake;
}

void use_telescope()
{
	if(get_property("telescopeUpgrades").to_int() > 0 && get_property("telescopeLookedHigh").to_boolean() == false)
	{
		cli_execute("telescope high");
	}
}

boolean try_pillkeeper(string pill_name)
{
	// Uses the Eight Days a Week Pill Keeper to get the desired effect
	if(available_amount($item[Eight Days a Week Pill Keeper ]) == 0)
	{
		return false;
	} else if((my_spleen_use() >= spleen_limit()-2) && get_property("_freePillKeeperUsed").to_boolean() == true)
	{
		print("Not enough spleen to consume a pill", "red");
		return false;
	}

	cli_execute("pillkeeper " + pill_name);
	return true;
}

int adv1_NEP()
{
	//return 10 if boss
	if (my_adventures() == 0) abort("No adventures.");
	if (get_counters("Fortune Cookie",0,0) != "") {
		abort("Semirare! LastLoc: " + get_property("semirareLocation"));
	}
	if (have_effect($effect[Beaten Up]) > 0)
	{
		abort("Beaten up");
	}
	string page = visit_url("adventure.php?snarfblat=528");
	if (page.contains_text("You're fighting")) {
		run_combat();
		return 0;
	}
	else if (page.contains_text("Just Paused")) {
		run_choice(5);
		run_combat();
		return 0;
	}
	else if (page.contains_text("The Beginning of the Neverend")) {
		if (page.contains_text("DJ")) {
			print("Rejecting NEP DJ quest", "green");
			run_choice(2); //reject DJ quest to get more meat from NEP
		}
		else
		{
			print("Getting NEP quest", "green");
			run_choice(1); //accept
		}
		adv1_NEP();
	} 
	return -1;
}

skill get_free_run_skill() {
	boolean [skill] free_run_skills;
	free_run_skills[$skill[Reflex Hammer]] = have_skill($skill[Reflex Hammer]) && get_property("_reflexHammerUsed").to_int() < 3;
	free_run_skills[$skill[Chest X-Ray]] = have_skill($skill[Chest X-Ray]) && get_property("_chestXRayUsed").to_int() < 3;
	free_run_skills[$skill[Snokebomb]] = have_skill($skill[Snokebomb]) && get_property("_snokebombUsed").to_int() < 3;
	free_run_skills[$skill[Shattering Punch]] = have_skill($skill[Shattering Punch]) && get_property("_shatteringPunchUsed").to_int() < 3;
	foreach skill_name in free_run_skills
	{
		if (free_run_skills[skill_name] == true)
		{
			return skill_name;
		}
	}
	print("No free run skill", "red");
	return $skill[none];
}

int combat_buff(skill value, skill free_run_skill)
{
	//Become a Bat (day1) 3.33 adv
	//Become a Cloud of Mist (day2) 2adv
	//Become a Wolf (day2) 0.67 adv
	//Giant Growth x3 (day2) 4adv x 3
	//DO NOT USE Meteor shower (MUST USE LIGHTSABER)
	
	if (my_adventures() == 0) abort("No adventures.");
	if (get_counters("Fortune Cookie",0,0) != "") {
		abort("Semirare! LastLoc: " + get_property("semirareLocation"));
	}
	if (have_effect($effect[Beaten Up]) > 0)
	{
		abort("Beaten up");
	}
	string page = visit_url("adventure.php?snarfblat=240");
	if (page.contains_text("You're fighting")) {
		use_skill(value);
		use_skill(free_run_skill);
		return 0;
	}
	else
	{
		abort("NC");
	}
	return -1;
}

int lightsaber_buff(skill value)
{
	//Become a Bat (day1) 3.33 adv
	//Become a Cloud of Mist (day2) 2adv
	//Become a Wolf (day2) 0.67 adv
	//Giant Growth x3 (day2) 4adv x 3
	//Meteor shower (MUST USE LIGHTSABER)
	print("TEST1");
	if (!have_skill(value))
	{
		print("TEST2");
		return -1;
	}
	print("TEST3");
	if (item_amount($item[Fourth of May Cosplay Saber]) > 0)
	{
		print("TEST4");
		equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
	}
	print("TEST5");
	if (have_equipped($item[Fourth of May Cosplay Saber]))
	{
		print("TEST6");
		if (my_adventures() == 0) abort("No adventures.");
		print("TEST7");
		if (get_counters("Fortune Cookie",0,0) != "") {
			abort("Semirare! LastLoc: " + get_property("semirareLocation"));
		}
		print("TEST8");
		if (have_effect($effect[Beaten Up]) > 0)
		{
			abort("Beaten up");
		}
		print("TEST9");
		string page = visit_url("adventure.php?snarfblat=240");
		print("TEST10");
		if (page.contains_text("You're fighting")) {
			print("TEST11");
			use_skill(value);
			print("TEST12");
			use_skill(to_skill(7311)); //use the force
			print("TEST13");
			visit_url("choice.php?whichchoice=1387&pwd=" + my_hash() + "&option=3",true); //drop stuff
			print("TEST14");
			visit_url("main.php"); //refresh, not sure if needed
			print("TEST15");
			return 0;
		}
		else
		{
			print("TEST17");
			abort("NC");
		}
	}
	print("TEST18");
	return -1;
}

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
	{
		return true;
	}
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
	//TODO: add check for sausage limits.
	while ((my_mp() < value) && (item_amount($item[Magical sausage]) >= 1))
	{
		eat(1, $item[Magical sausage]);
	}
	while ((my_mp() < value) && (item_amount($item[magical sausage casing]) > 0) && ((item_amount($item[Kramco Sausage-o-Matic&trade;]) > 0) || (have_equipped($item[Kramco Sausage-o-Matic&trade;]))))
	{
		if (make_sausage(1, my_meat() - 500) > 0)
		{
			eat(1, $item[Magical sausage]);
		}
	}
	while ((my_mp() < value) && ((my_class() == $class[pastamancer]) || (my_class() == $class[sauceror])) && (guild_store_available()) && (my_meat() >= 500))
	{
		buy(1, $item[magical mystery juice], 100);
		use(1, $item[magical mystery juice]);
	}
	while ((my_mp() < value) && (my_meat() >= 500))
	{
		buy(1, $item[Doc Galaktik's Invigorating Tonic], 90);
		use(1, $item[Doc Galaktik's Invigorating Tonic]);
	}
	if (my_mp() < value)
	{
		return false;
	}
	return true;
}

boolean reach_hp(int value)
{
	if (my_hp() >= value)
	{
		return true;
	}
	while ((my_hp() < value) && (get_property("_hotTubSoaks").to_int() < 5))
	{
		cli_execute("hottub");
	}
	if ((my_hp() < value) && (have_skill($skill[Cannelloni Cocoon])) && (my_mp() >= mp_cost($skill[Cannelloni Cocoon])))
	{
		use_skill(1 ,$skill[Cannelloni Cocoon]); //all
	}
	while ((my_hp() < value) && (have_skill($skill[Tongue of the Walrus])) && (my_mp() >= mp_cost($skill[Tongue of the Walrus])))
	{
		use_skill(1 ,$skill[Tongue of the Walrus]); //30-40
	}
	while ((my_hp() < value) && (have_skill($skill[Lasagna Bandages])) && (my_mp() >= mp_cost($skill[Lasagna Bandages])))
	{
		use_skill(1 ,$skill[Lasagna Bandages]); //10-30
	}
	while ((my_hp() < value) && (have_skill($skill[Disco Nap])) && (my_mp() >= mp_cost($skill[Disco Nap])))
	{
		use_skill(1 ,$skill[Disco Nap]); //20
	}
	if ((my_hp() < value) && ((my_class() == $class[seal clubber]) || (my_class() == $class[turtle tamer])) && (guild_store_available()) && (my_meat() >= 500))
	{
		buy(1, $item[Medicinal Herb's medicinal herbs], 100);
		chew(1, $item[Medicinal Herb's medicinal herbs]);
	}
	while ((my_hp() < value) && (get_property("timesRested").to_int() < total_free_rests()))
	{
		cli_execute("campground rest");
	}
	if (my_hp() < value)
	{
		return false;
	}
	return true;
}

boolean try_cloake_buff(skill buff_name)
{
	// Uses a Vampyric Cloake skill if available and we have a free kill/run skill
	// Returns true if the buff was successful, false otherwise
	skill free_run_skill = get_free_run_skill();
	if (item_amount($item[Vampyric cloake]) > 0)
	{
		equip($slot[back], $item[Vampyric cloake]);
	}
	if (equipped_item($slot[back]) == $item[Vampyric cloake] && free_run_skill != $skill[none])
	{
		reach_mp(50);
		return combat_buff(buff_name, free_run_skill) == 0;
	}
	return false;
}

boolean force_skill(int casts, skill value, boolean use)
{
	if(have_skill(value))
	{
		if (my_maxmp() < casts*mp_cost(value))
		{
			abort("Mp cap too low");
			return false;
		}
		if (reach_mp(casts*mp_cost(value)))
		{
			if (use) return use_skill(casts, value);
			else return true;
		}
		else
		{
			abort("Unable to obatin sufficent mp for: " + value);
			return false;
		}
	} return !use;
}

boolean force_skill(int casts, skill value)
{
	return force_skill(casts, value, true);
}

boolean force_skill(skill value)
{
	return force_skill(1, value, true);
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

boolean try_effect(effect value)
{
	if (have_effect(value) > 0)
	{
		print("Confirmed: "+value, "green");
		return true;
	}
	else
	{
		if (cli_execute(value.default))
		{
			print("Applied: "+value, "green");
			return true;
		}
		else
		{
			print("Failure: "+value, "green");
			return false;
		}
	}
}

void burn_mp()
{
	print("Using up mp", "blue");
	try_skill($skill[Advanced Saucecrafting]);
	try_skill($skill[Advanced Cocktailcrafting]);
	try_skill($skill[Pastamastery]);
	try_skill($skill[Perfect Freeze]);
	try_skill($skill[Prevent Scurvy and Sobriety]);
	try_skill($skill[Grab a Cold One]);
	try_skill($skill[Spaghetti Breakfast]);
	try_skill($skill[Summon Crimbo Candy]);
	try_skill($skill[Love Mixology]);
	try_skill($skill[Acquire Rhinestones]);
	try_skill($skill[Lunch Break]);
	try_skill($skill[Request Sandwich]);
}

void ode_drink(int quantity, item booze)
{
	int need = booze.inebriety;
	int curr = have_effect($effect[Ode to Booze]);
	int casts = ceil((need.to_float() - curr.to_float()) / 5);
	if (need > curr)
	{
		boolean result = force_skill(casts, $skill[The Ode to Booze]);
		if (!result) abort("Ode failed");
	}

	cli_execute("overdrink " + quantity + " " + booze.name);
}

void drink_to(int inebriety)
{
	while (item_amount($item[bunch of sea grapes]) > 0)
	{
		use(item_amount($item[bunch of sea grapes]), $item[bunch of sea grapes]);
	}

	while (my_inebriety() < inebriety)
	{
		if (item_amount($item[punch-drunk punch]) > 0) ode_drink(1, $item[punch-drunk punch]); //6.5adv
		else if (item_amount($item[meadeorite]) > 0) ode_drink(1, $item[meadeorite]); //6.5adv
		else if (item_amount($item[iced plum wine]) > 0) ode_drink(1, $item[iced plum wine]); //6.5adv
		else if (item_amount($item[splendid martini]) > 0) ode_drink(1, $item[splendid martini]); //6adv
		else if (item_amount($item[Ambitious Turkey]) > 0) ode_drink(1, $item[Ambitious Turkey]); //6adv
		else if (item_amount($item[thermos full of Knob coffee]) > 0) ode_drink(1, $item[thermos full of Knob coffee]); //5.5adv
		else if (item_amount($item[distilled fortified wine]) > 0) ode_drink(1, $item[distilled fortified wine]); //5.5adv
		else if (item_amount($item[pumpkin beer]) > 0) ode_drink(1, $item[pumpkin beer]); //5.5adv
		else if (item_amount($item[Sacramento wine]) > 1) ode_drink(1, $item[Sacramento wine]); //5.5adv
		else if (item_amount($item[Agitated Turkey]) > 1) ode_drink(1, $item[Agitated Turkey]); //5.5adv
		else if (item_amount($item[Friendly Turkey]) > 1) ode_drink(1, $item[Friendly Turkey]); //5.0adv
		else if (item_amount($item[bottle of sea wine]) > 1) ode_drink(1, $item[bottle of sea wine]); //4.0adv
		else if (item_amount($item[astral pilsner]) > 0) ode_drink(1, $item[astral pilsner]); //adv = level*0.5+0.5
		else if (item_amount($item[Cold One]) > 0) ode_drink(1, $item[Cold One]); //adv = max(level,3.0)
		//6.16adv per drunk perfect drink
		//3.87adv per drunk asbestos thermos
		else if (((my_inebriety()+2) <= inebriety)&&(item_amount($item[Middle of the Road&trade; brand whiskey]) > 0)) ode_drink(1, $item[Middle of the Road&trade; brand whiskey]); //2.0adv per drunk
		else if (item_amount($item[Shot of grapefruit schnapps]) > 0) ode_drink(1, $item[Shot of grapefruit schnapps]); //2.0adv
		else if (item_amount($item[Shot of tomato schnapps]) > 0) ode_drink(1, $item[Shot of tomato schnapps]); //2.0adv
		else if (item_amount($item[Shot of orange schnapps]) > 0) ode_drink(1, $item[Shot of orange schnapps]); //2.0adv
		else if (item_amount($item[Fine wine]) > 0) ode_drink(1, $item[Fine wine]); //2.0adv
		else break;
	}
}

void try_num()
{
	if (have_skill($skill[Calculate the Universe]))
	{
		//get 3 adv in day 2 if no clip arts
		if ((get_property("_universeCalculated").to_int() == 0)&&(!((my_daycount() >= 2)&&(!have_skill($skill[Summon Clip Art])))))
		{
			int [int] testcon;
			testcon = reverse_numberology();
			if (testcon contains 18)
			{
				reach_mp(1);
				cli_execute("numberology 18");
			}
			else if (testcon contains 44)
			{
				reach_mp(1);
				cli_execute("numberology 44");
			}
			else if (testcon contains 75)
			{
				reach_mp(1);
				cli_execute("numberology 75");
			}
			else if (testcon contains 99)
			{
				reach_mp(1);
				cli_execute("numberology 99");
			}
		}
		else if (get_property("_universeCalculated").to_int() < get_property("skillLevel144").to_int())
		{
			int [int] testcon;
			testcon = reverse_numberology();
			if (testcon contains 69)
			{
				reach_mp(1);
				cli_execute("numberology 69");
			}
		}
	}
}

void complete_quest(string questname, int choicenumber)
{
	int adv = 0;
	print("QUEST - "+questname, "purple");
	adv = my_adventures();
	visit_url("council.php");
	visit_url("choice.php?pwd&whichchoice=1089&option="+choicenumber);
	adv = adv - my_adventures();
	//TODO: DOES THE FOLLOWING BLOCK EVEN WORKS?
	if (adv == 0)
	{
		abort("Not enough adventures to complete quest");
	}
	print("USED " + adv + " ADV", "purple");
	set_property("hccs2da_questrecord" + choicenumber ,adv );
	reach_hp(1);
	try_num();
}

boolean check_quest(string questname, int choicenumber)
{
	//in council the order is:
	//Donate Blood
	//Feed The Children (But Not Too Much)
	//Build Playground Mazes
	//Feed Conspirators
	//Breed More Collies
	//Reduce Gazelle Population
	//Make Sausage
	//Be a Living Statue
	//Make Margaritas
	//Clean Steam Tunnels
	//Coil Wire
	string page = visit_url("council.php");
	page = visit_url("council.php");
	if (page.contains_text(questname)) {
		print(questname + " quest not done", "blue");
		return false;
	} else {
		print(questname + " quest already done", "blue");
		return true;
	}
}

void summon_pants(string m, string e, string s1, string s2, string s3)
{
	if (item_amount($item[portable pantogram]) == 0)
	{
		return;
	}

	print("SUMMONING PANTS", "red");
	visit_url("inv_use.php?pwd&which=99&whichitem=9573");
	visit_url("choice.php?whichchoice=1270&pwd&option=1&m="+m+"&e="+e+"&s1="+url_encode(s1)+"&s2="+url_encode(s2)+"&s3="+url_encode(s3),true,true);
	if (item_amount($item[pantogram pants]) == 0)
	{
		abort("Couldn't summon pants");
	}
}

void use_bastille_battalion(int desired_stat, int desired_item, int desired_buff, int desired_potion)
{
	if (item_amount($item[Bastille Battalion control rig]) == 0) return;
	if ((item_amount($item[Brutal brogues]) > 0) || (have_equipped($item[Brutal brogues]))) return;
	if ((item_amount($item[Draftsman's driving gloves]) > 0) || (have_equipped($item[Draftsman's driving gloves]))) return;
	if ((item_amount($item[Nouveau nosering]) > 0) || (have_equipped($item[Nouveau nosering]))) return;

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

boolean lovepot(float thershold, stat test)
{
	if (item_amount(to_item(9745)) > 0)
	{
		//https://pastebin.com/EyzeE8A2
		//it is assumed that you do test in order of mus->mys->mox
		//getting these value requires some of the most annoying math in kol scripting ever
		//thersholds
		//7 rerolls 132.8
		//6 rerolls 129.8
		//5 rerolls 126.1
		//4 rerolls 121.4
		//3 rerolls 114.9
		//2 rerolls 105.2
		//1 rerolls 86.5
		//love potion stats
		int lovepot_mus = 0;
		int lovepot_mys = 0;
		int lovepot_mox = 0;
		float lovepot_value = 0.0;
		string page = visit_url("desc_effect.php?whicheffect=75c1c2a807f9e12f6c9e3e9954586d08");
		matcher match_lovepot_mus = create_matcher("Muscle\\ \\+?(\\-?\\d+)" , page);
		if(match_lovepot_mus.find()) {
			lovepot_mus = match_lovepot_mus.group(1).to_int();
			print("LOVEPOT MUS: "+lovepot_mus,"green");
		}
		matcher match_lovepot_mys = create_matcher("Mysticality\\ \\+?(\\-?\\d+)" , page);
		if(match_lovepot_mys.find()) {
			lovepot_mys = match_lovepot_mys.group(1).to_int();
			print("LOVEPOT MYS: "+lovepot_mys,"green");
		}
		matcher match_lovepot_mox = create_matcher("Moxie\\ \\+?(\\-?\\d+)" , page);
		if(match_lovepot_mox.find()) {
			lovepot_mox = match_lovepot_mox.group(1).to_int();
			print("LOVEPOT MOX: "+lovepot_mox,"green");
		}
		
		lovepot_value = max(max(to_float(lovepot_mus)+56.5,to_float(lovepot_mys)+27.5),max(to_float(lovepot_mox),0.0));
		print("LOVEPOT VALUE: "+lovepot_value,"green");
		print("LOVEPOT THERSHOLD: "+thershold,"green");
		//love potion use logic
		if (test == $stat[none])
		{
			if (lovepot_value < thershold)
			{
				print("Use up love potion here to reroll", "green");
				return true; //use up potion to reroll
			}
			else
			{
				print("Your love potion is good enough, keep it", "green");
				return false; //keep potion
			}
		}
		else if (test == $stat[muscle])
		{
			if ((to_float(lovepot_mus)+56.5)==max(max(to_float(lovepot_mus)+56.5,to_float(lovepot_mys)+27.5),max(to_float(lovepot_mox),0.0)))
			{
				print("Use up love potion here", "green");
				return true; //use up potion for test
			}
			else
			{
				print("Keep love potion for next tests", "green");
				return false; //keep potion
			}
		}
		else if (test == $stat[mysticality])
		{
			if ((to_float(lovepot_mys)+27.5)==max(to_float(lovepot_mys)+27.5,max(to_float(lovepot_mox),0.0)))
			{
				print("Use up love potion here", "green");
				return true; //use up potion for test
			}
			else
			{
				print("Keep love potion for next test", "green");
				return false; //keep potion
			}
		}
		else if (test == $stat[moxie])
		{
			if ((to_float(lovepot_mox))==max(to_float(lovepot_mox),0.0))
			{
				print("Use up love potion here", "green");
				return true; //use up potion for test
			}
			else
			{
				print("Skip love potion, too negative", "green");
				return false; //keep potion
			}
		}
		abort("error with love potion function, you should not reach this");
	}
	return false; //no potion
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
		boolean bought = buy_using_storage(dogAmt[dog], dogReq[dog]);
		if (bought == false) return false;
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
			if (svn_exists("zlib")) {
				cli_execute("zlib bbb_famitems = false");
			}
			return fam;
		}
	}

	return $familiar[none];
}

familiar pick_fairy_to_tour()
{
	string ascensionsHtml = visit_url(" ascensionhistory.php?back=self&who=" +my_id(), false) + visit_url(" ascensionhistory.php?back=self&prens13=1&who=" +my_id(), false);

	foreach fam in $familiars[Baby Gravy Fairy,Coffee Pixie,Crimbo Elf,Flaming Gravy Fairy,Frozen Gravy Fairy,Stinky Gravy Fairy,Spooky Gravy Fairy,Attention-Deficit Demon,Sleazy Gravy Fairy,Jitterbug,Dandy Lion,Jumpsuited Hound Dog,Green Pixie,Casagnova Gnome,Psychedelic Bear,Sugar Fruit Fairy,Syncopated Turtle,Slimeling,Grouper Groupie,Dancing Frog,Hippo Ballerina,Piano Cat,Obtuse Angel,Pair of Stomping Boots,Blavious Kloop,Peppermint Rhino,Steam-Powered Cheerleader,Reagnimated Gnome,Angry Jung Man,Gelatinous Cubeling,Mechanical Songbird,Grimstone Golem,Fist Turkey,Adventurous Spelunker,Rockin' Robin,Intergnat,Chocolate Lab,Optimistic Candle,Bowlet,Cat Burglar]
	{
		if(have_familiar(fam) && should_tour(ascensionsHtml, fam)) {
			if (svn_exists("zlib")) {
				cli_execute("zlib bbb_famitems = false");
			}
			return fam;
		}
	}

	return $familiar[Peppermint Rhino];
}

boolean try_fax(string m)
{
	if ($item[photocopied monster].item_amount() > 0) return true;

	cli_execute("chat"); // apparently chat has to be open to receive a fax
	waitq(5); // 5 seconds for chat to open
	if (cli_execute("faxbot " + m))
	{
		if ($item[photocopied monster].item_amount() > 0) return true;
	}
	abort("Could not fax " + m);
	return false;
}

boolean try_join_clan(int clan_id)
{
	//@TODO check you're whitelisted to the current clan
	string url = visit_url("showclan.php?recruiter=1&whichclan="+ clan_id +"&pwd&whichclan=" + clan_id + "&action=joinclan&apply=Apply+to+this+Clan&confirm=on");
	// Successful
	if(contains_text(url, "clanhalltop.gif")) return true;
	// Already in BAFH
	else if(contains_text(url, "You can't apply to a clan you're already in.")) return true;
	// Failed
	else return false;
}

void try_consult()
{
	int bafh = 90485;
	int initial_clan = get_clan_id();

	boolean joined = try_join_clan(bafh);

	if (!joined)
	{
		print("Unable to join BAFH to collect our Fortune Teller Equipment from Cheesefax. Consider getting whitelisted to automate this step");
		return;
	}

	// @TODO Replace this with a less spammy direct solution
	while (get_property("_clanFortuneConsultUses") < 3)
	{
		cli_execute("fortune cheesefax pizza batman thick");
		waitq(1);
	}

	boolean returned = try_join_clan(initial_clan);

	if (!returned) abort("Couldn't get back into original clan");
}

void voteInVotingBooth()
{
	if (get_property("voteAlways") == false)
	{
		return;
	}
	
	//print_html("VotingBooth v" + __voting_version + ".");
	buffer page_text = visit_url("place.php?whichplace=town_right&action=townright_vote");
	
	if (page_text.contains_text("Here is the impact of your local ballot initiatives"))
	{
		print("Already voted today.");
		return;
	}
	
	
	
	
	//Here's where the script decides which initiatives are best.
	//I spent like ten seconds on it, so feel free to change it.
	//Larger numbers are the best initiatives.
	float [string] initiative_priorities;
	initiative_priorities["State-mandated bed time of 8PM."] = 100; //+1 Adventure(s) per day
	initiative_priorities["Repeal leash laws."] = 75; //+2 Familiar Experience Per Combat
	initiative_priorities["Institute GBLI (Guaranteed Basic Loot Income.)"] = 50; //+15% Item Drops from Monsters
	initiative_priorities["Reduced taxes at all income levels."] = 45; //+30% Meat from Monsters
	initiative_priorities["Mandatory morning calisthenics for all citizens."] = 42; //Muscle +25%
	initiative_priorities["Compulsory dance lessons every weekend."] = 41; //Moxie +25%
	initiative_priorities["Replace all street signs with instructions for arcane rituals."] = 40; //Mysticality +25%
	initiative_priorities["Addition of 37 letters to end of alphabet so existing names are all earlier in queues."] = 35; //+25% Combat Initiative
	initiative_priorities["Subsidies for health potion manufacturers."] = 32; //Maximum HP +30%
	initiative_priorities["Open a local portal to a dimension of pure arcane power."] = 31; //Spell Damage +20%
	initiative_priorities["Free civic weapon sharpening program."] = 31; //Weapon Damage +100%
	initiative_priorities["Require all garments to be fleece-lined."] = 30; //Serious Cold Resistance (+3)
	initiative_priorities["Make all new clothes out of asbestos."] = 30; //Serious Hot Resistance (+3)
	initiative_priorities["Widespread distribution of \"CENSORED\" bars."] = 30; //Serious Sleaze Resistance (+3)
	initiative_priorities["Outlaw black clothing and white makeup."] = 30; //Serious Spooky Resistance (+3)
	initiative_priorities["Free public nose-plug dispensers."] = 30; //Serious Stench Resistance (+3)
	initiative_priorities["A chicken in every pot!"] = 25; //+30% Food Drops from Monsters
	initiative_priorities["Carbonate the water supply."] = 20; //Maximum MP +30%
	initiative_priorities["Kingdomwide air-conditioning subsidies."] = 20; //+10 Cold Damage
	initiative_priorities["Pocket flamethrowers issued to all citizens."] = 20; //+10 Hot Damage
	initiative_priorities["Artificial butter flavoring dispensers on every street corner."] = 20; //+10 Sleaze Damage
	initiative_priorities["All forms of deodorant are now illegal."] = 20; //+10 Stench Damage
	initiative_priorities["Compulsory firearm and musical instrument safety training for all citizens."] = 20; //Ranged Damage +100%
	initiative_priorities["Emergency eye make-up stations installed in all public places."] = 15; //+4 Moxie Stats Per Fight
	initiative_priorities["Require boxing videos to be played on all bar televisions."] = 15; //+4 Muscle Stats Per Fight
	initiative_priorities["Deployment of a network of aerial mana-enhancement drones."] = 15; //+4 Mysticality Stats Per Fight
	initiative_priorities["Municipal journaling initiative."] = 15; //+3 Stats Per Fight
	initiative_priorities["Happy Hour extended by 23 additional hours."] = 10; //+30% Booze Drops from Monsters
	initiative_priorities["Subsidies for dentists."] = 10; //+30% Candy Drops from Monsters
	initiative_priorities["Sales tax free weekend for back-to-school shopping."] = 10; //+30% Gear Drops from Monsters
	initiative_priorities["Ban belts."] = 10; //+30% Pants Drops from Monsters
	initiative_priorities["Mandatory martial arts classes for all citizens."] = 0; //+20 Damage to Unarmed Attacks
	initiative_priorities["\"Song that Never Ends\" pumped throughout speakers in all of Kingdom."] = -100; //+10 to Monster Level
	
	
	initiative_priorities["Add sedatives to the water supply."] = -100; // = "-10 to Monster Level";
	initiative_priorities["Distracting noises broadcast through compulsory teeth-mounted radio receivers."] = -100; // = "-3 Stats Per Fight";
	initiative_priorities["Emissions cap on all magic-based combustion."] = -100; // = "Spell Damage -50%";
	initiative_priorities["Exercise ban."] = -100; // = "Muscle -20";
	initiative_priorities["Mandatory 6pm curfew."] = -100; // = "+-2 Adventure(s) per day";
	initiative_priorities["Requirement that all weapon handles be buttered."] = -100; // = "-10% chance of Critical Hit";
	initiative_priorities["Safety features added to all melee weapons."] = -100; // = "Weapon Damage -50%";
	initiative_priorities["Shut down all local dog parks."] = -100; // = "-2 Familiar Experience Per Combat";
	initiative_priorities["State nudity initiative."] = -100; // = "-50% Gear Drops from Monsters";
	initiative_priorities["Vaccination reversals for all citizens."] = -100; // = "Maximum HP -50%";
	initiative_priorities["All bedsheets replaced with giant dryer sheets."] = -100; // = "Maximum MP -50%";
	initiative_priorities["All citizens required to look <i>all four</i> ways before crossing the street."] = -100; // = "-30% Combat Initiative";
	initiative_priorities["Ban on petroleum-based gels and pomades."] = -100; // = "Moxie -20";
	initiative_priorities["Increased taxes at all income levels."] = -100; // = "-30% Meat from Monsters";
	initiative_priorities["Mandatory item tithing."] = -100; // = "-20% Item Drops from Monsters";
	initiative_priorities["Reduced public education spending."] = -100; // = "Mysticality -20";
	
	
	//Alter priorities depending on state:
	
	initiative_priorities["Repeal leash laws."] = 1025; //+2 Familiar Experience Per Combat
	initiative_priorities["Deployment of a network of aerial mana-enhancement drones."] = 1015; //+4 Mysticality Stats Per Fight
	initiative_priorities["Municipal journaling initiative."] = 1014; //+3 Stats Per Fight
	initiative_priorities["Require boxing videos to be played on all bar televisions."] = 1013; //+4 Muscle Stats Per Fight
	initiative_priorities["Emergency eye make-up stations installed in all public places."] = 1012; //+4 Moxie Stats Per Fight
	initiative_priorities["Subsidies for health potion manufacturers."] = 1009; //Maximum HP +30%
	initiative_priorities["Carbonate the water supply."] = 1008; //Maximum MP +30%
	initiative_priorities["Subsidies for dentists."] = 1004; //+30% Candy Drops from Monsters
	
	
	if (my_daycount() == 1)
	{
		initiative_priorities["State-mandated bed time of 8PM."] = 1100; //+1 Adventure(s) per day
		initiative_priorities["Happy Hour extended by 23 additional hours."] = 1100; //+30% Booze Drops from Monsters
		initiative_priorities["Institute GBLI (Guaranteed Basic Loot Income.)"] = 1075; //+15% Item Drops from Monsters
		initiative_priorities["Open a local portal to a dimension of pure arcane power."] = 1040; //Spell Damage +20%
		initiative_priorities["Subsidies for dentists."] = 1020; //+30% Candy Drops from Monsters

	}
	else
	{
		initiative_priorities["Free civic weapon sharpening program."] = 1400; //Weapon Damage +100%
		initiative_priorities["Make all new clothes out of asbestos."] = 1300; //Serious Hot Resistance (+3)
		initiative_priorities["Replace all street signs with instructions for arcane rituals."] = 1035; //Mysticality +25%
		initiative_priorities["Mandatory morning calisthenics for all citizens."] = 1033; //Muscle +25%
		initiative_priorities["Compulsory dance lessons every weekend."] = 1032; //Moxie +25%
	}





	string [string] initiative_descriptions;
	initiative_descriptions["State-mandated bed time of 8PM."] = "+1 Adventure(s) per day";
	initiative_descriptions["Repeal leash laws."] = "+2 Familiar Experience Per Combat";
	initiative_descriptions["Emergency eye make-up stations installed in all public places."] = "+4 Moxie Stats Per Fight";
	initiative_descriptions["Require boxing videos to be played on all bar televisions."] = "+4 Muscle Stats Per Fight";
	initiative_descriptions["Deployment of a network of aerial mana-enhancement drones."] = "+4 Mysticality Stats Per Fight";
	initiative_descriptions["\"Song that Never Ends\" pumped throughout speakers in all of Kingdom."] = "+10 to Monster Level";
	initiative_descriptions["Institute GBLI (Guaranteed Basic Loot Income.)"] = "+15% Item Drops from Monsters";
	initiative_descriptions["Municipal journaling initiative."] = "+3 Stats Per Fight";
	initiative_descriptions["Reduced taxes at all income levels."] = "+30% Meat from Monsters";
	initiative_descriptions["Compulsory dance lessons every weekend."] = "Moxie +25%";
	initiative_descriptions["Mandatory morning calisthenics for all citizens."] = "Muscle +25%";
	initiative_descriptions["Replace all street signs with instructions for arcane rituals."] = "Mysticality +25%";
	initiative_descriptions["Open a local portal to a dimension of pure arcane power."] = "Spell Damage +20%";
	initiative_descriptions["Subsidies for health potion manufacturers."] = "Maximum HP +30%";
	initiative_descriptions["Require all garments to be fleece-lined."] = "Serious Cold Resistance (+3)";
	initiative_descriptions["Make all new clothes out of asbestos."] = "Serious Hot Resistance (+3)";
	initiative_descriptions["Widespread distribution of \"CENSORED\" bars."] = "Serious Sleaze Resistance (+3)";
	initiative_descriptions["Outlaw black clothing and white makeup."] = "Serious Spooky Resistance (+3)";
	initiative_descriptions["Free public nose-plug dispensers."] = "Serious Stench Resistance (+3)";
	initiative_descriptions["Free civic weapon sharpening program."] = "Weapon Damage +100%";
	initiative_descriptions["Addition of 37 letters to end of alphabet so existing names are all earlier in queues."] = "+25% Combat Initiative";
	initiative_descriptions["A chicken in every pot!"] = "+30% Food Drops from Monsters";
	initiative_descriptions["Carbonate the water supply."] = "Maximum MP +30%";
	initiative_descriptions["Kingdomwide air-conditioning subsidies."] = "+10 Cold Damage";
	initiative_descriptions["Pocket flamethrowers issued to all citizens."] = "+10 Hot Damage";
	initiative_descriptions["Artificial butter flavoring dispensers on every street corner."] = "+10 Sleaze Damage";
	initiative_descriptions["All forms of deodorant are now illegal."] = "+10 Stench Damage";
	initiative_descriptions["Compulsory firearm and musical instrument safety training for all citizens."] = "Ranged Damage +100%";
	initiative_descriptions["Happy Hour extended by 23 additional hours."] = "+30% Booze Drops from Monsters";
	initiative_descriptions["Subsidies for dentists."] = "+30% Candy Drops from Monsters";
	initiative_descriptions["Sales tax free weekend for back-to-school shopping."] = "+30% Gear Drops from Monsters";
	initiative_descriptions["Ban belts."] = "+30% Pants Drops from Monsters";
	initiative_descriptions["Mandatory martial arts classes for all citizens."] = "+20 Damage to Unarmed Attacks";

	initiative_descriptions["Add sedatives to the water supply."] = "-10 to Monster Level";
	initiative_descriptions["Distracting noises broadcast through compulsory teeth-mounted radio receivers."] = "-3 Stats Per Fight";
	initiative_descriptions["Emissions cap on all magic-based combustion."] = "Spell Damage -50%";
	initiative_descriptions["Exercise ban."] = "Muscle -20";
	initiative_descriptions["Mandatory 6pm curfew."] = "+-2 Adventure(s) per day";
	initiative_descriptions["Requirement that all weapon handles be buttered."] = "-10% chance of Critical Hit";
	initiative_descriptions["Safety features added to all melee weapons."] = "Weapon Damage -50%";
	initiative_descriptions["Shut down all local dog parks."] = "-2 Familiar Experience Per Combat";
	initiative_descriptions["State nudity initiative."] = "-50% Gear Drops from Monsters";
	initiative_descriptions["Vaccination reversals for all citizens."] = "Maximum HP -50%";
	initiative_descriptions["All bedsheets replaced with giant dryer sheets."] = "Maximum MP -50%";
	initiative_descriptions["All citizens required to look <i>all four</i> ways before crossing the street."] = "-30% Combat Initiative";
	initiative_descriptions["Ban on petroleum-based gels and pomades."] = "Moxie -20";
	initiative_descriptions["Increased taxes at all income levels."] = "-30% Meat from Monsters";
	initiative_descriptions["Mandatory item tithing."] = "-20% Item Drops from Monsters";
	initiative_descriptions["Reduced public education spending."] = "Mysticality -20";
	
	string [int][int] platform_matches = page_text.group_string("<blockquote>(.*?)</blockquote>");
	
	int desired_g = random(2) + 1;
	
	//Bias the global votes towards ghosts:
	if (platform_matches.count() == 2)
	{
		foreach key in platform_matches
		{
			string platform = platform_matches[key][1];
			boolean zoinks = false;
			//print_html(key + ": " + platform);
			
			foreach s in $strings[seance to summon their ancient spirits,you like to see your deceased loved ones again,don't think I need to tell you that graveyards are a terribly inefficient use of space,is possible that this might displace and anger your,How could you possibly vote against kindness energy] //'
			{
				if (platform.contains_text(s))
				{
					zoinks = true;
					break;
				}
			}
			
			
			if (zoinks)
			{
				print("Voting for ghosts.");
				desired_g = key + 1;
				break;
			}
		}
	}

	string [int][int] local_initiative_matches = page_text.group_string("<input type=\"checkbox\".*?value=\"([0-9])\".*?> (.*?)<br");
	
	string [int] initiative_names;
	int [string] initiative_values;
	string log_delimiter = "•";
	
	buffer log;
	log.append("VOTING_BOOTH_LOG");
	log.append(log_delimiter);
	log.append(my_daycount());
	log.append(log_delimiter);
	log.append(my_class());
	log.append(log_delimiter);
	log.append(my_path());
	print_html("<strong>Available initiatives:</strong>");
	foreach key in local_initiative_matches
	{
		int initaitive_value = local_initiative_matches[key][1].to_int();
		string initiative_name = local_initiative_matches[key][2];
		
		
		log.append(log_delimiter);
		log.append(initiative_name);
		
		//print_html("\"" + initiative_name + "\": " + initaitive_value + " (" + initiative_descriptions[initiative_name] + ")");
		print_html("&nbsp;&nbsp;&nbsp;&nbsp;" + initiative_descriptions[initiative_name]);
		//if (__voting_negative_effects contains initiative_name) continue;
		
		
		initiative_names[initiative_names.count()] = initiative_name;
		initiative_values[initiative_name] = initaitive_value;
		
		if (!(initiative_priorities contains initiative_name))
			abort("Unknown initiative \"" + initiative_name + "\". Tell Ezandora about it, there's probably some one-character typo somewhere.");
		float priority = initiative_priorities[initiative_name];
		
	}
	print_html("");
	logprint(log);
	sort initiative_names by -initiative_priorities[value];
	if (initiative_names.count() < 2)
	{
		print_html("Internal error: Not enough local initiatives.");
		visit_url("choice.php?option=2&whichchoice=1331"); //cancel out
		return;
	}
	print_html("<strong>Chosen initiatives:</strong>");
	foreach key, name in initiative_names
	{
		if (key > 1) continue;
		print_html("&nbsp;&nbsp;&nbsp;&nbsp;" + initiative_descriptions[name]);
	}

	//print_html("initiative_names = " + initiative_names.to_json());
	visit_url("choice.php?option=1&whichchoice=1331&g=" + desired_g + "&local[]=" + initiative_values[initiative_names[0]] + "&local[]=" + initiative_values[initiative_names[1]]);
	
	//https://www.kingdomofloathing.com/choice.php?pwd&option=1&whichchoice=1331&g=1&local[]=0&local[]=2
	//pwd&option=1&whichchoice=1331&g=1&local%5B%5D=0&local%5B%5D=2
	//option=1&whichchoice=1331&g=
	//g - 1 or 2, depending on the global vote
}

void main(string arguments){
	int stepmode = 0;
	if (arguments == "" || arguments.to_lower_case() == "help")
	{
		print("Help message here", "blue");
		show_help();
		return;
	}
	else if (arguments.to_lower_case() == "settings")
	{
		print("Entering settings", "blue");
		set_settings();
		return;
	}
	else if (arguments.to_lower_case() == "records")
	{
		print("Showing records", "blue");
		show_records();
		return;
	}
	else if (arguments.to_lower_case() == "warnings")
	{
		print("Showing warnings", "blue");
		show_warnings();
		return;
	}
	else if (arguments.to_lower_case() == "revert")
	{
		print("Reverting settings", "blue");
		revert_settings();
		return;
	}
	else if (arguments.to_lower_case() == "next")
	{
		print("Skipping current step when resuming", "blue");
		set_property("hccs2da_progress", to_int(get_property("hccs2da_progress"))+1);
		return;
	}
	else if (arguments.to_lower_case() == "test")
	{
		print("Testing a code snippet here", "blue");
		//in council the order is:
		//Donate Blood
		//Feed The Children (But Not Too Much)
		//Build Playground Mazes
		//Feed Conspirators
		//Breed More Collies
		//Reduce Gazelle Population
		//Make Sausage
		//Be a Living Statue
		//Make Margaritas
		//Clean Steam Tunnels
		//Coil Wire
		string page = visit_url("council.php");
		page = visit_url("council.php");
		if (page.contains_text("Donate Blood")) {
			print("Donate Blood quest not done", "blue");
		} else {
			print("Donate Blood quest done", "blue");
		}
		if (page.contains_text("Feed The Children")) {
			print("Feed The Children quest not done", "blue");
		} else {
			print("Feed The Children quest done", "blue");
		}
		if (page.contains_text("Build Playground Mazes")) {
			print("Build Playground Mazes quest not done", "blue");
		} else {
			print("Build Playground Mazes quest done", "blue");
		}
		if (page.contains_text("Feed Conspirators")) {
			print("Feed Conspirators quest not done", "blue");
		} else {
			print("Feed Conspirators quest done", "blue");
		}
		if (page.contains_text("Breed More Collies")) {
			print("Breed More Collies quest not done", "blue");
		} else {
			print("Breed More Collies quest done", "blue");
		}
		if (page.contains_text("Reduce Gazelle Population")) {
			print("Reduce Gazelle Population quest not done", "blue");
		} else {
			print("Reduce Gazelle Population quest done", "blue");
		}
		if (page.contains_text("Make Sausage")) {
			print("Make Sausage quest not done", "blue");
		} else {
			print("Make Sausage quest done", "blue");
		}
		if (page.contains_text("Be a Living Statue")) {
			print("Be a Living Statue quest not done", "blue");
		} else {
			print("Be a Living Statue quest done", "blue");
		}
		if (page.contains_text("Make Margaritas")) {
			print("Make Margaritas quest not done", "blue");
		} else {
			print("Make Margaritas quest done", "blue");
		}
		if (page.contains_text("Clean Steam Tunnels")) {
			print("Clean Steam Tunnels quest not done", "blue");
		} else {
			print("Clean Steam Tunnels quest done", "blue");
		}
		if (page.contains_text("Coil Wire")) {
			print("Coil wire quest not done", "blue");
		} else {
			print("Coil wire quest done", "blue");
		}
		matcher match_progress = create_matcher("<b>Donate Blood</b>.+Perform Service \\((\\d+).+<b>blood-drive sticker</b>" , page);
		//matcher match_progress = create_matcher("<b>Feed The Children.+Perform Service \\((\\d+).+<b>bag of grain</b>" , page);
		if(match_progress.find()) {
			print("tent: "+match_progress.group(1));
		}
		print("Finished test", "blue");
		return;
	}
	else if (arguments.to_lower_case() == "test2")
	{
		print("Testing a code snippet here", "blue");
		string page = visit_url("clan_viplounge.php?action=floundry");
		if (page.contains_text("Top 10 Favorite Clans")) {
			abort("You don't have a clan.");
		}
		matcher match_progress = create_matcher("(\\d+\\,?\\d+) carp" , page);
		if(match_progress.find()) {
			print("tent: "+match_progress.group(1));
		}
		print("Finished test", "blue");
		return;
	}
	else if (arguments.to_lower_case() == "hotdog" || arguments.to_lower_case() == "hotdogs")
	{
		//use before ascend
		print("Stuffing down basic hotdogs", "blue");
		boolean done4 = false;
		visit_url("clan_viplounge.php?action=hotdogstand", false);
		while (!done4) {
			string page = visit_url("clan_viplounge.php?preaction=eathotdog&whichdog=-92&sumbit=Eat",true);

			if (page.contains_text("feel up to eating")) {
				done4 = true;
			}
		}
		print("Finished Hot Dogs", "blue");
		return;
	}
	else if (arguments.to_lower_case() == "3adv" || arguments.to_lower_case() == "calculate")
	{
		print("Attempt to calculate the universe for adv.", "blue");
		try_num();
		return;
	}
	else if (arguments.to_lower_case() == "consult" || arguments.to_lower_case() == "fortune")
	{
		print("Consulting fortune.", "blue");
		try_consult();
		return;
	}
	else if (arguments.to_lower_case() != "load" && arguments.to_lower_case() != "resume" && arguments.to_lower_case() != "start" && arguments.to_lower_case() != "step")
	{
		print("Unknown argument", "red");
		print("Try refering to help page, type:", "red");
		print("hccs2dexp help", "red");
		print("into kolmafia's CLI", "red");
		return;
	}
	
	if (arguments.to_lower_case() == "load")
	{
		print("TODO: start from certain step number", "red");
		set_property("hccs2da_progress" ,999999 );
	}
	else if (arguments.to_lower_case() == "resume")
	{
		print("Resuming run", "blue");
		set_property("hccs2da_progress" ,0 );
		stepmode = 0;
	}
	else if (arguments.to_lower_case() == "start")
	{
		print("Starting new run", "blue");
		set_property("hccs2da_progress" ,0 );
		stepmode = -1;
	}
	else if (arguments.to_lower_case() == "step")
	{
		print("Will abort upon finishing 1 quest", "blue");
		set_property("hccs2da_progress" ,0 );
		stepmode = 1;
	}
	//init
	//START
	
	int progresscheck = 0;
	
	//SETTINGS
	//if true will do pvp
	if (get_property("hccs2da_dopvp") == "")
	{
		if (user_confirm("Perform PVP?"))
		{
			set_property("hccs2da_dopvp" ,true );
		}
		else
		{
			set_property("hccs2da_dopvp" ,false );
		}
	}
	
	//if true will fight god lobster and break 100% fam tour
	if (get_property("hccs2da_notour") == "")
	{
		if (user_confirm("Abandon 100% Familiar Run for God Lobster Fights?"))
		{
			set_property("hccs2da_notour" ,true );
		}
		else
		{
			set_property("hccs2da_notour" ,false );
		}
	}
	
	//if true will not fight scaling monsters
	if (get_property("hccs2da_noscale") == "")
	{
		if (user_confirm("Avoid scaling monsters and the risk of being beaten up?"))
		{
			set_property("hccs2da_noscale" ,true );
		}
		else
		{
			set_property("hccs2da_noscale" ,false );
		}
	}
	
	//if true save pocket wishes
	if (get_property("hccs2da_stingy") == "")
	{
		if (user_confirm("Be stingy and save bunch of pocket wishes per run?"))
		{
			set_property("hccs2da_stingy" ,true );
		}
		else
		{
			set_property("hccs2da_stingy" ,false );
		}
	}
	
	//if true will do barrels
	if (get_property("hccs2da_barrels") == "")
	{
		if (user_confirm("Do barrels for meat?"))
		{
			set_property("hccs2da_barrels" ,true );
		}
		else
		{
			set_property("hccs2da_barrels" ,false );
		}
	}
	
	//if true will do fortune consults in BAFH
	if (get_property("hccs2da_consults") == "")
	{
		if (user_confirm("Do fortune consults in BAFH?"))
		{
			set_property("hccs2da_consults" ,true );
		}
		else
		{
			set_property("hccs2da_consults" ,false );
		}
	}
	
	//reset progress
	if (get_property("hccs2da_progress") == "")
	{
		set_property("hccs2da_progress" ,0 );
	}
	
	cli_execute("refresh all");
	
	if (to_string(my_class()) == "Astral Spirit")
	{
		print("AFTERLIFE SPEEDRUN", "blue");
		print("Grabbing booze", "green");
		visit_url("afterlife.php?action=buydeli&whichitem=5046&submit=Purchase (1 Karma)",true);
		print("Grabbing pet", "green");
		visit_url("afterlife.php?action=buyarmory&whichitem=5037&submit=Purchase (10 Karma)",true);
		print("Filling ascension form", "green");
		visit_url("afterlife.php?action=ascend&confirmascend=1&asctype=3&whichclass=4&gender=1&whichpath=25&whichsign=5&noskillsok=1&submit=Once More Unto the Breach",true);
		cli_execute("refresh all");
	}

	show_warnings();

	familiar ToTour = pick_familiar_to_tour();
	if (have_skill($skill[Summon Clip Art]))
	{
		set_property("hccs2da_route" ,1 );
	}
	else
	{
		set_property("hccs2da_route" ,2 );
		if (get_property("hccs2da_marzipanhard") >= 100.0)
		{
			ToTour = pick_fairy_to_tour();
		}
		else
		{
			if (have_familiar($familiar[Peppermint Rhino]))
			{
				ToTour = $familiar[Peppermint Rhino];
			}
			else
			{
				print("Script have not detected marzipan skull being capped in previous run, getting Peppermint Rhino recommanded next run", "red");
				ToTour = pick_fairy_to_tour();
			}
		}
	}
	if ((!(my_familiar() == $familiar[none])) && (!(my_familiar() == $familiar[Trick-or-Treating Tot])))
	{
		ToTour = my_familiar();
	}
	
	print("Touring familiar set to " + ToTour, "green");
	print("Script will generally try to find a new familiar to tour guide each time.", "green");
	print("Exception: Peppermint Rhino is set without clip arts until you can cap marzipan skull", "green");
	print("Set familiar before running script if you want a specific familiar", "green");
	set_property("hccs2da_tourfam" ,ToTour );
	boolean AddHotdog = true;
	string clan = get_clan_name();
	item KGB = $item[Kremlin's Greatest Briefcase];

	//TODO: reset these when script ascends
	
	
	//doc bag quest (dont work)
	//set_property("choiceAdventure1340", 1);

	set_property("manaBurningThreshold", -0.05);

//DAY1
	if (my_daycount() == 1)
	{
		//comment out from this point to the location where script breaks if needed
		print("BEGIN DAY 1", "blue");
		
		// Set CCS for the run
		progresscheck = 100000;
		if (stepmode == -1)
		{
			//set_property("hccs2da_progress" ,progresscheck );
			//print("hccs2da_progress: " + get_property("hccs2da_progress"), "green");
			
			print("Set up CSS and settings.", "green");
			
			//doc bag quest (dont work)
			//set_property("hccs2da_backup_choiceAdventure1340", get_property("choiceAdventure1340"));
			//set_property("choiceAdventure1340", 1);
			
			//The Baker's Dilemma
			set_property("hccs2da_backup_choiceAdventure114", get_property("choiceAdventure114"));
			set_property("choiceAdventure114", 2);
			//Oh No, Hobo
			set_property("hccs2da_backup_choiceAdventure115", get_property("choiceAdventure115"));
			set_property("choiceAdventure115", 1);
			//The Singing Tree
			set_property("hccs2da_backup_choiceAdventure116", get_property("choiceAdventure116"));
			set_property("choiceAdventure116", 4);
			//Trespasser
			set_property("hccs2da_backup_choiceAdventure117", get_property("choiceAdventure117"));
			set_property("choiceAdventure117", 1);
			//Temporarily Out of Skeletons
			set_property("hccs2da_backup_choiceAdventure1060", get_property("choiceAdventure1060"));
			set_property("choiceAdventure1060", 1);
			
			//Mana burning
			set_property("hccs2da_backup_manaBurningThreshold", get_property("manaBurningThreshold"));
			set_property("autoSatisfyWithNPCs", -0.05);
			
			//Settings
			set_property("hccs2da_backup_autoSatisfyWithNPCs", get_property("autoSatisfyWithNPCs"));
			set_property("autoSatisfyWithNPCs", true);
			set_property("hccs2da_backup_autoSatisfyWithCoinmasters", get_property("autoSatisfyWithNPCs"));
			set_property("autoSatisfyWithCoinmasters", true);
			set_property("hccs2da_backup_dontStopForCounters", get_property("dontStopForCounters"));
			set_property("dontStopForCounters", true);
			
			//CCS
			set_property("hccs2da_backup_customCombatScript", get_property("customCombatScript"));
			set_property("customCombatScript", "hccs");
		}
		
		// Collect your consults if you can
		progresscheck = 100010;
		if (stepmode == -1)
		{
			//set_property("hccs2da_progress" ,progresscheck );
			//print("hccs2da_progress: " + get_property("hccs2da_progress"), "green");
			
			print("Consulting fortune.", "green");
			if(to_boolean(get_property("hccs2da_consults")))
			{
				try_consult();
			}
		}


		// Get the dairy goat fax
		progresscheck = 100020;
		if (stepmode == -1)
		{
			//set_property("hccs2da_progress" ,progresscheck );
			print("Faxing in goat.", "green");
			try_fax("dairy goat");
		}



		// unlock the Detective School
		// This can be fun on day 1 to get the detective solver badge, which grants +hp/+mp/+item based on item level
		if (to_boolean(get_property("hasDetectiveSchool")))
		{
			if (svn_exists("Ezandora-Detective-Solver-branches-Release")) {
				print("Running Detective Solver Script", "green");
				cli_execute("detective solver.ash");
			} else print("If you install Ezandora's Detective Solver script, this script can use solve your mysteries!", "red");
		}

		// Try Calculating the Universe
		try_num();
		
		// Pull Your Cowboy Boots from LT&T
		// This is a day 1 (turn 0) activity to pull the "Your Cowboy Boots" from previous ascensions.
		// This has a base enhancement of +25hp/+25mp, and can have spurs + skin added for extra enhancements
		// see wiki: http://kol.coldfront.net/thekolwiki/index.php/Your_cowboy_boots 
		if (to_boolean(get_property("telegraphOfficeAvailable")))
		{
		visit_url("place.php?whichplace=town_right&action=townright_ltt");run_choice(13);
		}
		
		//Source Terminal Day 1 Init
		if (get_property("sourceTerminalSpam") > 0)
		{
			cli_execute("terminal educate extract.edu");
			cli_execute("terminal educate duplicate.edu");
			//cli_execute("terminal enhance items.enh");
			//cli_execute("terminal enhance meat.enh");
			//cli_execute("terminal enhance substats.enh");
			cli_execute("terminal enquiry stats.enq");
			//cli_execute("terminal extrude booze gibson");
			//asdonmartin drive ####
			//Asdonmartin drive observantly
		}
		
		// Get pocket wishes
		while (get_property("_genieWishesUsed") < 3)
		{
			cli_execute("genie item pocket");
		}
		
		//tea tree TODO
		if (false &&  (to_boolean(get_property("_pottedTeaTreeUsed")) == false))
		{
			cli_execute("teatree cuppa serendipi tea");
		}
		
		// Make meat from BoomBox if we can
		if (item_amount($item[SongBoom&trade; BoomBox]) > 0)
		{
			if (get_property("boomBoxSong") != "Total Eclipse of Your Meat")
			{
				print("Set BoomBox to meat.", "green");
				cli_execute("boombox meat");
			}
		}

		// unlock the briefcase
		if (item_amount(KGB) > 0)
		{
			if (svn_exists("Ezandora-Briefcase-branches-Release")) {
				// Unlock with booze acquisition
				print("Set up KGB briefcase.", "green");
				cli_execute("Briefcase booze");
				cli_execute("Briefcase e spell adventures");
			} else print("If you install Ezandora's Briefcase script, this script can use your KGB!", "red");
		}
		
		//Lightsaber 1(mp gen), 2(20ml),3(3res), 4(10fam wt)
		if ((item_amount($item[Fourth of May Cosplay Saber]) > 0) || (have_equipped($item[Fourth of May Cosplay Saber])))
		{
			print("Lightsaber regen", "green");
			visit_url("main.php?action=may4");
			visit_url("choice.php?whichchoice=1386&pwd=" + my_hash() + "&option=1",true);
		}

		//dive in vip swimming pool
		print("Looting VIP room.", "green");
		visit_url("clan_viplounge.php?preaction=goswimming&subaction=screwaround&whichfloor=2&sumbit=Cannonball!",true);
		visit_url("choice.php?whichchoice=585&pwd=" + my_hash() + "&option=1&action=flip&sumbit=Handstand",true);
		visit_url("choice.php?whichchoice=585&pwd=" + my_hash() + "&option=1&action=treasure&sumbit=Dive for Treasure",true);
		visit_url("choice.php?whichchoice=585&pwd=" + my_hash() + "&option=1&action=leave&sumbit=Get Out",true);
		
		visit_url("clan_viplounge.php?action=crimbotree&whichfloor=2");
		visit_url("clan_viplounge.php?action=lookingglass&whichfloor=2");
		
		print("Playing with claw machine.", "green");
		//vip claw
		visit_url("clan_viplounge.php?action=klaw");
		visit_url("clan_viplounge.php?action=klaw");
		visit_url("clan_viplounge.php?action=klaw");
		//normal claw
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");

		//unlock skeleton store
		print("Unlocking skeleton store.", "green");
		visit_url("shop.php?whichshop=meatsmith&action=talk&sumbit=What do you need?");
		run_choice(1);




		


		print("Getting quests.", "green");
		visit_url("tutorial.php?action=toot", false);
		visit_url("council.php");
		visit_url("guild.php?place=challenge");

		print("Unpacking and selling stuff.", "green");
		if (item_amount($item[astral six-pack]) > 0)
			use(1, $item[astral six-pack]);
		else print("You do not have a astral six-pack.", "green");

		if (item_amount($item[letter from King Ralph XI]) > 0)
			use(1, $item[letter from King Ralph XI]);
		else print("You do not have a letter from King Ralph XI.", "green");

		if (item_amount($item[pork elf goodies sack]) > 0)
			use(1, $item[pork elf goodies sack]);
		else print("You do not have a pork elf goodies sack.", "green");

		foreach stuff in $items[hamethyst,baconstone,porquoise]
			autosell(item_amount(stuff), stuff);

		autosell(item_amount($item[Van der Graaf helmet]), $item[Van der Graaf helmet]);
		
		if (item_amount($item[Codpiece]) == 0)
			visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=9002");
		if (item_amount($item[Codpiece]) > 0)
		{
			use(1, $item[Codpiece]);
			use(8 ,$item[bubblin' crude]);
			autosell(1, $item[oil cap]);
			equip($slot[acc3], $item[Codpiece]);
		}
		else abort("You do not have a Codpiece.");

		print("Obtaining buffing tools.", "green");
		if (item_amount($item[toy accordion]) < 1)
			buy(1, $item[toy accordion]);
		
		if ((have_skill($skill[Empathy of the Newt])) || (have_skill($skill[Astral Shell])) || (have_skill($skill[Tenacity of the Snapper])) || (have_skill($skill[Reptilian Fortitude])))
		{
			while (item_amount($item[turtle totem]) < 1)
			{
				buy(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}
		}

		print("Equiping.", "green");
		//Set fam here
		use_familiar(ToTour);
		equip($item[Hollandaise helmet]);
		equip($item[saucepan]);
		if (item_amount($item[Fourth of May Cosplay Saber]) > 0)
		{
			equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
		}
		if (item_amount($item[astral statuette]) > 0)
		{
			equip($slot[off-hand], $item[astral statuette]);
		}
		equip($item[old sweatpants]);
		try_item($item[Newbiesport&trade; tent]);
		if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[January's Garbage Tote]) > 0))
		{
			cli_execute("fold makeshift garbage shirt");
			equip($slot[shirt], $item[makeshift garbage shirt]);
		}
		if (item_amount(KGB) > 0)
		{
			equip($slot[acc2], KGB);
		}
		if (item_amount($item[vampyric cloake]) > 0)
		{
			equip($slot[back], $item[vampyric cloake]);
		}

		//fantasyland only
		if((get_property("frAlways") == True) && (item_amount($item[FantasyRealm G. E. M.]) < 1))
		{
			print("Getting fantasy hat", "green");
			visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter", false);
			run_choice(2); //mage
			if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
			{
				equip($item[FantasyRealm Mage's Hat]);
			}
		}
		if (!check_quest("Coil Wire", 11)) {
			print("Buffing.", "green");
			try_skill($skill[Communism!]);
			force_skill(1, $skill[Spirit of Peppermint]);
			if (have_effect($effect[[1458]Blood Sugar Sauce Magic]) == 0)
			{
				force_skill(1, $skill[Blood Sugar Sauce Magic]);
			}
			force_skill(1, $skill[The Magical Mojomuscular Melody]);
			force_skill(1, $skill[Sauce Contemplation]);
			
			voteInVotingBooth();
			
			if (item_amount($item[mumming trunk]) > 0)
			{
				print("mumming trunk mys", "green");
				visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9592");
				visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=1271&option=5",true); //Oliver Cromwell
			}
			

			// pantogramming (+mox, res spooky, +mp, spell dmg, +combat)
			summon_pants(3, 3, "-2%2C0", "-2%2C0", "-2%2C0");

			// clip art branch
			if (have_skill($skill[Summon Clip Art]))
			{
				reach_mp(2);
				if ((my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make cheezburger");
				}

				print("Y-RAY FAX", "blue");
				
				if (item_amount($item[January's Garbage Tote]) > 0)
				{
					//not sure enough mp to work
					//cli_execute("fold deceased crimbo tree");
					//equip($slot[off-hand], $item[deceased crimbo tree]);
					//buff used in ccs
					//buy(1 , $item[glittery mascara], 24);
					//use(1 , $item[glittery mascara]);
				}
			
				if (my_maxmp() < mp_cost($skill[Disintegrate]))
					abort("mp cap too law for YRAY");
				cli_execute("shower mp");

				if((force_skill(1, $skill[Disintegrate], false))||(item_amount($item[Fourth of May Cosplay Saber]) > 0)||(have_equipped($item[Fourth of May Cosplay Saber])))
				{
					if (item_amount($item[photocopied monster]) > 0)
					{
						if (have_effect($effect[Lapdog]) <= 0)
						{
							cli_execute("swim laps");
						}
						if (have_effect($effect[Hustlin']) <= 0)
						{
							cli_execute("pool 3");
						}
						if (item_amount($item[Fourth of May Cosplay Saber]) > 0)
						{
							equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
						}
						if (have_equipped($item[Fourth of May Cosplay Saber]))
						{
							visit_url("inventory.php?which=3",false);
							visit_url("inv_use.php?which=f0&whichitem=4873&pwd=" + my_hash(),false);
							use_skill(to_skill(7311)); //use the force
							visit_url("choice.php?whichchoice=1387&pwd=" + my_hash() + "&option=3",true); //drop stuff
							visit_url("main.php"); //refresh, not sure if needed
						}
						else
						{
							use(1, $item[photocopied monster]);
						}
					}
					else abort("You do not have a photocopied monster.");
				}
				else abort("No Y-RAY.");
				
				if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[January's Garbage Tote]) > 0))
				{
					cli_execute("fold makeshift garbage shirt");
					equip($slot[shirt], $item[makeshift garbage shirt]);
				}
				
				try_num();
				
				
				print("Breakfast Prep", "blue");

				force_skill(1, $skill[Advanced Saucecrafting]);

				buy(1 , $item[Dramatic&trade; range], 1000);
				use(1 , $item[Dramatic&trade; range]);
				craft("cook", 1, $item[scrumptious reagent], $item[glass of goat's milk]);

				print("Breakfast", "blue");
				use(1 , $item[milk of magnesium]); //first in clip art
				eat(1 , $item[cheezburger]);
				//(3/15)food
				buy(1 , $item[fortune cookie], 40);
				eat(1 , $item[fortune cookie]);
				//(4/15)food
			}
			else 
			{
				//no clip art
				buy(1 , $item[fortune cookie], 40);
				eat(1 , $item[fortune cookie]);
				//(1/15)food
				cli_execute("shower mp");
				ode_drink(1, $item[Bee's Knees]);
				ode_drink(1, $item[Bee's Knees]);
				//(4/15)drink
			}



			if(canadia_available())
			{
				cli_execute("mcd 11");
			}
			else
			{
				cli_execute("mcd 10");
			}



			
			if (my_adventures() < 60)
			{
				ode_drink(1, $item[cup of &quot;tea&quot;]);
			}

			try_skill($skill[Love Mixology]);
			if (lovepot(126.1,$stat[none]))
			{
				use(1, to_item(9745));
			}
			burn_mp();
			complete_quest("COIL WIRE", 11);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Make Margaritas", 9)) {
			force_skill(1, $skill[Inscrutable Gaze]);
			if (item_amount($item[a ten-percent bonus]) > 0)
				use(1, $item[a ten-percent bonus]);
			else abort("You do not have a ten-percent bonus.");
			
			try_effect($effect[Pomp & Circumsands]);
			try_effect($effect[Resting Beach Face]);
			try_effect($effect[Do I Know You From Somewhere?]);
			try_effect($effect[You Learned Something Maybe!]);
			
			//DAYCARE
			print("Boxing Daycare", "green");
			if ((get_property("daycareOpen") == true) && (get_property("_daycareNap") == false))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
				visit_url("choice.php?whichchoice=1334&pwd=" + my_hash() + "&option=1&sumbit=Have a Boxing Daydream",true);
			}
			if ((get_property("daycareOpen") == true) && (get_property("_daycareSpa") == false))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
				visit_url("choice.php?whichchoice=1334&pwd=" + my_hash() + "&option=2&sumbit=Visit the Boxing Day Spa",true);
				visit_url("choice.php?whichchoice=1335&pwd=" + my_hash() + "&option=3&sumbit=Get a Cucumber Eye Treatment",true);
			}
			if ((get_property("daycareOpen") == true) && (get_property("_daycareGymScavenges").to_int() == 0))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
				visit_url("choice.php?whichchoice=1334&pwd=" + my_hash() + "&option=3&sumbit=Enter the Boxing Daycare",true);
				visit_url("choice.php?whichchoice=1336&pwd=" + my_hash() + "&option=2&sumbit=Scavenge for gym equipment ",true);
			}


			// Get driving gloves from Bastille Battalion if we can (now that we've wasted 60 adventures)
			print("Battalion Game", "green");
			use_bastille_battalion(0, 1, 2, random(3));
			
			if (item_amount($item[Draftsman's driving gloves]) > 0)
			{
				equip($slot[acc1], $item[Draftsman's driving gloves]);
			}
			
			//Source Terminal Day 1 Combat
			if (get_property("sourceTerminalSpam") > 0)
			{
				cli_execute("terminal enhance meat.enh");
				cli_execute("terminal enhance substats.enh");
			}
			
			//use kramco before farming
			if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
			{
				//equip($slot[acc2], $item[Lil' Doctor&trade; bag]);
			}
			if ((item_amount($item[Kramco Sausage-o-Matic&trade;]) > 0) && (have_skill($skill[Soul Saucery])) && (my_soulsauce() >= 5) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
			}
			
			if (my_adventures() <= 0)
			{
				print("Unlucky Zeroth Drink", "blue");
				drink_to(1);
				if (!have_skill($skill[Summon Clip Art]))
				{
					print("THIS SHOULD NOT HAPPEN WITHOUT CLIP ARTS (MIN ADV:62)", "red");
				}
			}
			
			//GOD LOB
			if((have_familiar($familiar[God Lobster])) && (to_boolean(get_property("hccs2da_notour"))) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				use_familiar($familiar[God Lobster]);
				reach_hp(my_maxhp()-15);
				reach_mp(20);
				visit_url("main.php?fightgodlobster=1");
				run_combat();
				visit_url("main.php"); //refresh, i heard this works
				run_choice(1);//equip
				equip($slot[familiar], $item[God Lobster's Scepter]);
				reach_hp(my_maxhp()-15);
				reach_mp(20);
				visit_url("main.php?fightgodlobster=1");
				run_combat();
				visit_url("main.php"); //refresh, i heard this works
				run_choice(2);//buff
				use_familiar(ToTour);
			}

			// NEP FIGHT
			if ((get_property("neverendingPartyAlways") == true) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				print("NEP fights", "green");
				reach_mp(50);
				try_skill($skill[Carol of the Thrills]);
				if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[January's Garbage Tote]) > 0))
				{
					cli_execute("fold makeshift garbage shirt");
					equip($slot[shirt], $item[makeshift garbage shirt]);
				}
				while (get_property("_neverendingPartyFreeTurns").to_int() < 10)
				{
					reach_hp(my_maxhp()-15);
					reach_mp(20);
					adv1_NEP();
				}
			}
			//SKIP IF HAVE METEOR LORE
			//GOD LOB
			if ((!have_skill($skill[Meteor Lore])) || (guild_store_available() && knoll_available()))
			{
				if((have_familiar($familiar[God Lobster])) && (to_boolean(get_property("hccs2da_notour"))) && !(to_boolean(get_property("hccs2da_noscale"))))
				{
					use_familiar($familiar[God Lobster]);
					reach_hp(my_maxhp()-15);
					reach_mp(20);
					visit_url("main.php?fightgodlobster=1");
					run_combat();
					visit_url("main.php"); //refresh, i heard this works
					run_choice(3); //exp
					use_familiar(ToTour);
				}
			}
			
			if (get_property("sourceTerminalSpam") > 0)
			{
				if (item_amount($item[Source essence]) >= 10)
				{
					cli_execute("terminal extrude booze gibson");
				}
				if (item_amount($item[Source essence]) >= 10)
				{
					cli_execute("terminal extrude booze gibson");
				}
				if (item_amount($item[Source essence]) >= 10)
				{
					cli_execute("terminal extrude booze gibson");
				}
			}

			// clip art branch
			if (have_skill($skill[Summon Clip Art]))
			{
				print("First Drink", "blue");
				drink_to(5);
				reach_mp(4);
				if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make ultrafondue");
				}
				else abort("Clip art failure.");
				reach_mp(2);
				if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make ultrafondue");
				}
				else abort("Clip art failure.");
			}
			else
			{
				ode_drink(5, $item[Astral Pilsner]);
				//(9/15)drink
			}
			


			print("Farming meat via casino", "blue");
			reach_meat(100);
			if (item_amount($item[hermit permit]) == 0)
			{
				buy(1 , $item[hermit permit], 100);
			}
			reach_meat(100);
			if (item_amount($item[casino pass]) == 0)
			{
				buy(1 , $item[casino pass], 100);
			}
			reach_meat(1000);
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
				cli_execute("try; fortune buff hagnk");
			}
			reach_hp(my_maxhp());


			if (to_boolean(get_property("hccs2da_barrels")))
			{
				print("Barrels (very slow)", "blue");
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=20");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=21");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=22");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=10");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=11");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=12");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=00");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=01");
				wait(1);
				run_combat();
				visit_url("barrel.php");
				visit_url("choice.php?whichchoice=1099&pwd=" + my_hash() + "&option=1&slot=02");
				wait(1);
				run_combat();
				try_num();
			}

			print("Farming until semirare", "blue");
			while (get_counters("Fortune Cookie" ,0 ,0) == "")
			{
				if ((!have_skill($skill[Summon Clip Art])) && (item_amount($item[goat cheese]) <= 0) && ((force_skill(1, $skill[Disintegrate], false))||(item_amount($item[Fourth of May Cosplay Saber]) > 0)||(have_equipped($item[Fourth of May Cosplay Saber]))))
				{
					//no clip art branch
					cli_execute("mcd 0");
					if (item_amount($item[photocopied monster]) > 0)
					{
						if (have_effect($effect[Lapdog]) <= 0)
						{
							cli_execute("swim laps");
						}
						if (have_effect($effect[Hustlin']) <= 0)
						{
							cli_execute("pool 3");
						}
						if (item_amount($item[Fourth of May Cosplay Saber]) > 0)
						{
							equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
						}
						if (have_equipped($item[Fourth of May Cosplay Saber]))
						{
							visit_url("inventory.php?which=3",false);
							visit_url("inv_use.php?which=f0&whichitem=4873&pwd=" + my_hash(),false);
							use_skill(to_skill(7311)); //use the force
							visit_url("choice.php?whichchoice=1387&pwd=" + my_hash() + "&option=3",true); //drop stuff
							visit_url("main.php"); //refresh, not sure if needed
						}
						else
						{
							use(1, $item[photocopied monster]);
						}
						try_num();
						if(canadia_available())
						{
							cli_execute("mcd 11");
						}
						else
						{
							cli_execute("mcd 10");
						}
						reach_mp(20);
					}
					else abort("You do not have a photocopied monster.");
				}
				else if ((item_amount($item[boxed wine]) <= 0) && (item_amount($item[bottle of rum]) <= 0) && (item_amount($item[bottle of vodka]) <= 0) && (item_amount($item[bottle of gin]) <= 0) && (item_amount($item[bottle of whiskey]) <= 0) && (item_amount($item[bottle of tequila]) <= 0))
				{
					adventure(1, $location[Noob Cave]);
				}
				else if ((item_amount($item[tomato]) <= 0) || (item_amount($item[Dolphin King's map]) <= 0) || ((item_amount($item[exorcised sandwich]) <= 0) && (!have_skill($skill[Simmer]))))
				{
					adventure(1, $location[The Haunted Pantry]);
				}
				else
				{
					adventure(1, $location[The Skeleton Store]);
				}
				try_num();
			}



			
			// clip art branch
			if (have_skill($skill[Summon Clip Art]))
			{
				print("Hit semirare, main meal", "green");
				if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
				{
					while (item_amount($item[tasty tart]) == 0)
					{
						adventure(1, $location[The Haunted Pantry]);
					}
				}
				else
				{
					abort("No semirare.");
				}
				eat(2 , $item[ultrafondue]);
				eat(3 , $item[tasty tart]);
				//(13/15)food

				if(!try_pillkeeper("sem"))
				{
					if (!eat_dog("optimal dog", AddHotdog))
					{
						abort("Cannot eat dog");
					}
					//(14/15)food
				} // TODO: Eat something else if we used pillkeeper

				if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
				{
					while (item_amount($item[Knob Goblin lunchbox]) == 0)
					{
						adventure(1, $location[The Outskirts of Cobb's Knob]);
					}
				}
				else
				{
					abort("No optimal dog or pillkeeper semirare.");
				}
				use(1,  $item[Knob Goblin lunchbox]);
				eat(1 , $item[Knob pasty]);
				//(15/15)food
			}
			else
			{
				print("Hit semirare, main meal", "green");
				if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
				{
					while (item_amount($item[distilled fortified wine]) == 0)
					{
						adventure(1, $location[The Sleazy Back Alley]);
					}
				}
				else
				{
					abort("No semirare.");
				}

				if(!try_pillkeeper("sem"))
				{
					if (!eat_dog("optimal dog", AddHotdog))
					{
						abort("Cannot eat dog");
					}
					//(2/15)food
				} // TODO: Eat something else if we used pillkeeper

				if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
				{
					while (item_amount($item[Knob Goblin lunchbox]) == 0)
					{
						adventure(1, $location[The Outskirts of Cobb's Knob]);
					}
				}
				else
				{
					abort("No optimal dog or pillkeeper semirare.");
				}
			}

			
			
			// clip art branch
			if (have_skill($skill[Summon Clip Art]))
			{
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
				while ((item_amount($item[exorcised sandwich]) <= 0) && (!have_skill($skill[Simmer])))
				{
					adventure(1, $location[The Haunted Pantry]);
					try_num();
				}
				print("Sufficient Sandwich (if any required)", "green");
				
				if (item_amount($item[astral statuette]) > 0)
				{
					equip($slot[off-hand], $item[astral statuette]);
				}




				if (item_amount($item[Dolphin King's map]) > 0)
				{
					print("Doing Dolphin Quest", "green");
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

				if (item_amount($item[exorcised sandwich]) > 0)
				{
					print("Talking to guildmates, may be slow", "green");
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
					print("Finished talking to various cheeses", "green");
				}

				print("Perfect Drink", "green");

				force_skill(1, $skill[Perfect Freeze]);

				if ((reach_meat(250)) && force_skill(1, $skill[The Ode to Booze]))
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

					drink_to(10);
				} else abort("Ode loop fail.");
			}
			
			
			

			print("Task Prep (+item)", "blue");
			//+item%
			force_skill(1, $skill[Fat Leon's Phat Loot Lyric]);
			force_skill(1, $skill[Singer's Faithful Ocelot]);
			try_effect($effect[The Spirit of Taking]);
			try_effect($effect[Synthesis: Collection]);
			if (have_effect($effect[Hustlin']) <= 0)
			{
				cli_execute("pool 3");
			}
			if ((item_amount(KGB) + equipped_amount(KGB)) > 0 && svn_exists("Ezandora-Briefcase-branches-Release"))
			{
				cli_execute("Briefcase b item");
			}
			//Source Terminal Day 1 Item
			if (get_property("sourceTerminalSpam") > 0)
			{
				cli_execute("terminal enhance items.enh");
			}
			if (item_amount($item[cuppa Serendipi Tea]) > 0)
			{
				use(1, $item[cuppa Serendipi Tea]);
			}
			if (item_amount($item[chef's hat]) > 0)
			{
				equip($slot[hat], $item[chef's hat]);
			}
			if (item_amount($item[January's Garbage Tote]) > 0)
			{
				cli_execute("fold wad of used tape");
				equip($slot[hat], $item[wad of used tape]);
			}
			if (item_amount($item[mumming trunk]) > 0)
			{
				print("mumming trunk item", "green");
				visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9592");
				visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=1271&option=4",true); //Prince George
			}
			//use kramco before farming
			if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
			{
				//equip($slot[acc2], $item[Lil' Doctor&trade; bag]);
			}
			if ((item_amount($item[Kramco Sausage-o-Matic&trade;]) > 0) && (have_skill($skill[Soul Saucery])) && (my_soulsauce() >= 5) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
			}
			
			//DAY 1 LOV
			if ((get_property("loveTunnelAvailable") == true) && (get_property("_loveTunnelUsed") == false) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
				visit_url("choice.php?whichchoice=1222&option=1&pwd");
				visit_url("choice.php?whichchoice=1223&option=1&pwd");
				run_combat();
				visit_url("choice.php?whichchoice=1224&option=2&pwd");
				visit_url("choice.php?whichchoice=1225&option=1&pwd");
				run_combat();
				visit_url("choice.php?whichchoice=1226&option=3&pwd");
				visit_url("choice.php?whichchoice=1227&option=1&pwd");
				run_combat();
				visit_url("choice.php?whichchoice=1228&option=3&pwd");
				equip($slot[back], $item[LOV Epaulettes]);
				use(1 , $item[LOV Extraterrestrial Chocolate]);
			}
			if ((item_amount($item[pocket wish]) > 0) && (!to_boolean(get_property("hccs2da_stingy"))))
			{
				cli_execute("genie effect Infernal Thirst");
			}
			try_cloake_buff($skill[Become a Bat]);
			force_skill(1, $skill[Steely-Eyed Squint]);


			//no clip art branch
			if (!have_skill($skill[Summon Clip Art]))
			{
				force_skill(1, $skill[Leash of Linguini]);
				force_skill(1, $skill[Empathy of the Newt]);
				if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
				{
					equip($slot[acc2], $item[Lil' Doctor&trade; bag]);
				}
				print("Item%: " + item_drop_modifier(), "green");
				float candymod = item_drop_modifier();
				int candyweight = 0;
				float itemtest = 30.4*(1+item_drop_modifier()/100);
				print("Drop rate of marzipan skull without candy boost is " + itemtest + "%", "green");
				set_property("hccs2da_marzipaneasy" ,itemtest );
				set_property("hccs2da_marzipanhard" ,itemtest );
				if(my_familiar() == $familiar[Peppermint Rhino]) {
					if (itemtest >= 100.0) {
						print("You may use any fairy in place of peppermint rhino in the future for tour guided runs.", "blue");
					}
					candyweight = (familiar_weight($familiar[Peppermint Rhino]) + weight_adjustment());
					candymod = candymod - (square_root(55*candyweight) + candyweight - 3);
					candymod = candymod + (square_root(55*candyweight*2) + candyweight*2 - 3);
					print("Drop rate of marzipan skull with candy boost is " + 30.4*(1+candymod/100) + "%", "green");
					set_property("hccs2da_marzipaneasy" ,candymod );
				}
				//visit_url("inv_use.php?whichitem=9537");
				//visit_url("choice.php?whichchoice=1267&option=1&wish=to fight a mariachi calavera");
				
				cli_execute("genie monster mariachi calavera");
				visit_url("main.php");
				run_combat();
				
				//remove doc bag
				if (equipped_item($slot[acc1]) == $item[Lil' Doctor&trade; bag]) {
					equip($slot[acc1], $item[none]);
				}
				if (equipped_item($slot[acc2]) == $item[Lil' Doctor&trade; bag]) {
					equip($slot[acc2], $item[none]);
				}
				if (equipped_item($slot[acc3]) == $item[Lil' Doctor&trade; bag]) {
					equip($slot[acc3], $item[none]);
				}
				
				//cat burglar save
				if(my_familiar() == $familiar[Cat Burglar]) {
				//TODO:check heist availible
				//_catBurglarCharge=30    <- current+used charges?
				//_catBurglarHeistsComplete=3 <- used heist + 1?
					if (item_amount($item[marzipan skull]) <= 0)
					{
						print("Heist: marzipan skull", "green");
						visit_url("main.php?heist=1");
						visit_url("choice.php?pwd&whichchoice=1320&option=1&st:272:1163=marzipan skull", true);
					}
					if (item_amount($item[bottle of tequila]) <= 0)
					{
						print("Heist: bottle of tequila", "green");
						visit_url("main.php?heist=1");
						visit_url("choice.php?pwd&whichchoice=1320&option=1&st:272:1004=bottle of tequila", true);
					}
				}
				
				if (item_amount($item[marzipan skull]) > 0)
				{
					print("Dinner Prep", "blue");

					force_skill(1, $skill[Pastamastery]);
					force_skill(1, $skill[Advanced Saucecrafting]);

					buy(1 , $item[Dramatic&trade; range], 1000);
					use(1 , $item[Dramatic&trade; range]);
					craft("cook", 1, $item[scrumptious reagent], $item[marzipan skull]);
					craft("cook", 2, $item[Salsa de las Epocas], $item[dry noodles]);
					craft("cook", 1, $item[scrumptious reagent], $item[glass of goat's milk]);

					print("Dinner", "blue");
					use(1 , $item[milk of magnesium]); //first in non-clip
					eat(2 , $item[spaghetti con calaveras]);
					//(14/15)food
					use(1,  $item[Knob Goblin lunchbox]);
					eat(1 , $item[Knob pasty]);
					//(15/15)food
					
					print("Perfect Drink", "green");

					force_skill(1, $skill[Perfect Freeze]);

					if ((reach_meat(250)) && force_skill(1, $skill[The Ode to Booze]))
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
						else abort("No perfect drink. Continue Manually");

					} else abort("Ode loop fail.");
					//(12/15)drink
					
					print("Farm for Tomato (if needed)", "green");
					while (item_amount($item[tomato]) <= 0)
					{
						adventure(1, $location[The Haunted Pantry]);
						try_num();
					}
					print("Sufficient Tomato", "green");
					
					//do stuff that should have been done is clip art route
					if (item_amount($item[Dolphin King's map]) > 0)
					{
						print("Doing Dolphin Quest", "green");
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

					if (item_amount($item[exorcised sandwich]) > 0)
					{
						print("Talking to guildmates, may be slow", "green");
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
						print("Finished talking to various cheeses", "green");
					}
				}
				else
				{
					abort("marzipan skull failed to drop, failed run");
				}
			}






			
			try_skill($skill[Love Mixology]);
			if (lovepot(121.4,$stat[none]))
			{
				use(1, to_item(9745));
			}
			burn_mp();
			complete_quest("MAKE MARGARITAS", 9);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Make Sausage", 7)) {
			if (item_amount($item[astral statuette]) > 0)
			{
				equip($slot[off-hand], $item[astral statuette]);
			}
			if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
			{
				equip($slot[hat], $item[FantasyRealm Mage's Hat]);
			}

			//hunt for fruit skeleton (one of the best place to shattering punch/snokebomb)
			//y-ray fruit skeleton
			
			//use kramco before farming
			if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
			{
				//equip($slot[acc2], $item[Lil' Doctor&trade; bag]);
			}
			if ((item_amount($item[Kramco Sausage-o-Matic&trade;]) > 0) && (have_skill($skill[Soul Saucery])) && (my_soulsauce() >= 5) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
			}
			print("Farming fruits", "blue");
			
			while ((item_amount($item[cherry]) <= 0) || (item_amount($item[lemon]) <= 0) || (item_amount($item[grapefruit]) <= 0))
			{
				if(force_skill(1, $skill[Disintegrate], false))
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
			if (item_amount($item[cherry]) > 0)
			{
				craft("cook", 1, $item[scrumptious reagent], $item[cherry]);
			}
			if (item_amount($item[lemon]) > 0)
			{
				craft("cook", 1, $item[scrumptious reagent], $item[lemon]);
			}
			else
			{
				print("NO LEMON, lemon is fairly important to reduce blood test to  adv", "red");
			}
			//Cook now if have skill
			if (item_amount($item[scrumptious reagent]) >= 2)
			{
				if (item_amount($item[tomato]) > 0)
				{
					craft("cook", 1, $item[scrumptious reagent], $item[tomato]);
				}
				else
				{
					print("NO TOMATO, lemon is fairly important to reduce blood test to  adv", "red");
				}
				if (item_amount($item[grapefruit]) > 0)
				{
					craft("cook", 1, $item[scrumptious reagent], $item[grapefruit]);
				}
			}

			print("Task Prep (spell dmg)", "blue");
			
			//clip art branch
			if (have_skill($skill[Summon Clip Art]))
			{
				ode_drink(1, $item[Sockdollager]);
				//(12/15) drink
			}

			if ((have_effect($effect[Indescribable Flavor]) <= 0) && (item_amount($item[indescribably horrible paste]) > 0))
			{
				chew(1, $item[indescribably horrible paste]);
			}

			if (have_effect($effect[Mental A-cue-ity]) <= 0)
			{
				cli_execute("pool 2");
			}
			
			if (have_familiar($familiar[Grim Brother]))
			{
				cli_execute("grim damage");
			}
			
			if ((have_effect($effect[The Magic of LOV]) <= 0) && (item_amount($item[LOV Elixir #6]) > 0))
			{
				use(1, $item[LOV Elixir #6]);
			}

			lightsaber_buff($skill[Meteor Shower]);
			
			force_skill(1, $skill[Spirit of Peppermint]);
			force_skill(1, $skill[Simmer]);
			try_num();
			force_skill(1, $skill[Carol of the Hells]);
			force_skill(1, $skill[Song of Sauce]);
			force_skill(1, $skill[Arched Eyebrow of the Archmage]);
			try_effect($effect[We're All Made of Starfish]);
			//TODO: need 8 spooky res and 500hp, heal first
			//try_skill(1, $skill[Deep Dark Visions]);

			//hatter mariachi hat or powdered wig
			if((get_property("_madTeaParty") == false) && (item_amount($item[mariachi hat]) > 0) && (item_amount($item[&quot;DRINK ME&quot; potion]) > 0))
			{
				cli_execute("hatter mariachi hat");
			}
			else if((get_property("_madTeaParty") == false) && (item_amount($item[powdered wig]) > 0) && (item_amount($item[&quot;DRINK ME&quot; potion]) > 0))
			{
				cli_execute("hatter powdered wig");
			}
			else print("You do not have a suitable hat for the mad hatter here.", "green");

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
				equip($slot[acc2], KGB);
			}

			//magic dragonfish does not seem to work here!
			

			try_skill($skill[Love Mixology]);
			if (lovepot(114.9,$stat[none]))
			{
				use(1, to_item(9745));
			}
			complete_quest("MAKE SAUSAGE", 7);
			if (stepmode == 1) { abort("step done"); }
		}
		if (to_boolean(get_property("hccs2da_dopvp")))
		{
			print("PVP", "green");
			// Enable PVP (this is hardcore so why not do it on the first day and get 10 extra fights
			visit_url("peevpee.php?action=smashstone&pwd&confirm=on", true);
			visit_url("peevpee.php?action=pledge&place=fight&pwd", true);
		}
		print("Pvp step", "blue");
		//DO THIS BEFORE BUFFING
		if (hippy_stone_broken())
		{
			cli_execute("flowers"); 
		}

		print("Task Prep (weapon dmg)", "blue");
		//print("TESTA");
		lightsaber_buff($skill[Meteor Shower]);
		//print("TESTB");
		if (!force_skill(1, $skill[The Ode to Booze])) abort("Ode loop fail");

		if (reach_meat(500)) ode_drink(1, $item[Sockdollager]);

		if (have_familiar($familiar[Stooper]))
		{
			use_familiar($familiar[Stooper]);
		}
		//i suspect inebriety_limit don't count stooper or some perms
		drink_to(inebriety_limit());
		ode_drink(1, $item[emergency margarita]);
		use_familiar(ToTour);
		
		try_effect($effect[Frenzied, Bloody]);
		try_effect($effect[Lack of Body-Building]);
		force_skill(1, $skill[Rage of the Reindeer]);
		force_skill(1, $skill[Scowl of the Auk]);
		force_skill(1, $skill[Carol of the Bulls]);
		force_skill(1, $skill[Bow-Legged Swagger]);
		force_skill(1, $skill[Song of the North]);
		force_skill(1, $skill[Tenacity of the Snapper]);
		force_skill(1, $skill[Blessing of the War Snapper]);

		print("Rollover Prep", "blue");
		
		//This prevents a warning popup in day 2 when folding
		if (item_amount($item[January's Garbage Tote]) > 0)
		{
			cli_execute("fold tinsel tights");
		}
		
		if (item_amount($item[pentagram bandana]) > 0)
		{
			equip($slot[hat], $item[pentagram bandana]);
		}
		if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
		{
			equip($slot[hat], $item[psychic's circlet]);
		}
		if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[shoe ad T-shirt]) > 0))
		{
			equip($slot[shirt], $item[shoe ad T-shirt]);
		}
		if (item_amount($item[astral statuette]) > 0)
		{
			equip($slot[off-hand], $item[astral statuette]);
		}



		if (item_amount($item[Draftsman's driving gloves]) > 0)
		{
			equip($slot[acc1], $item[Draftsman's driving gloves]);
		}
		
		if (item_amount($item[metal meteoroid]) > 0) create(1, $item[meteorthopedic shoes]);
		if (item_amount($item[meteorthopedic shoes]) > 0)
		{
			equip($slot[acc2], $item[meteorthopedic shoes]);
		}
		else if (item_amount($item[dead guy's watch]) > 0)
		{
			equip($slot[acc2], $item[dead guy's watch]);
		}
		
		if (item_amount($item[codpiece]) > 0)
		{
			equip($slot[acc3], $item[codpiece]);
		}

		if (item_amount(KGB) > 0)
		{
			equip($slot[acc3], KGB);
		}

		if (have_familiar($familiar[Trick-or-Treating Tot]) && my_meat() > 1200)
		{
			use_familiar($familiar[Trick-or-Treating Tot]);
			buy(1, $item[li'l unicorn costume]);
			equip($item[li'l unicorn costume]);
		}
		
		use_telescope();
		visit_url("place.php?whichplace=monorail&action=monorail_lyle");
		while (((my_hp() < my_maxhp()) || (my_mp() < my_maxmp())) && (get_property("timesRested").to_int() < total_free_rests()))
		{
			cli_execute("campground rest");
		}
		if (get_property("_hotTubSoaks").to_int() < 5)
		{
			cli_execute("hottub");
		}
		print("TEST TEST 1", "green");
		while (make_sausage(1, my_meat() - 1500) > 0)
		{
			print("Made a sausage!", "green");
		}
		print("TEST TEST 2", "green");
		while (item_amount($item[Magical sausage]) >= 1)
		{
			eat(1, $item[Magical sausage]);
		}
		print("TEST TEST 3", "green");
		

		
		if((have_effect($effect[Meteor Showered]) <= 0) && (my_class() == $class[seal clubber]) && (have_skill($skill[Meteor Shower])) && (get_property("_sealsSummoned").to_int() < 10))
		{
			print("Experimental turn saving for seal clubber with meteor lore","blue");
			print("DO NOT FINISH COMBAT AND END DAY 1 WHEN ABORTED","blue");
			print("Run script again after rollover, combat should end without costing an adventure","blue");
			if (reach_meat(150+100))
			{
				buy(1 , $item[Figurine of a wretched-looking seal], 150);
				buy(1 , $item[Seal-blubber candle], 100);
				use(1 , $item[Figurine of a wretched-looking seal]);
			}
			else abort("Not enough meat.");
		}
		print("TEST TEST 4", "green");

		//GOD LOB meteor lore trick
		if (have_effect($effect[Meteor Showered]) <= 0)
		{
			if ((have_skill($skill[Meteor Shower])) || (knoll_available()))
			{
				if (guild_store_available() && knoll_available())
				{
					//make meatcar
					print("Experimental turn saving for knoll sign with meteor lore","blue");
					print("DO NOT FINISH COMBAT AND END DAY 1 WHEN ABORTED","blue");
					print("Run script again after rollover, combat should end without costing an adventure","blue");
					cli_execute("make bitchin' meatcar");
					visit_url("guild.php?place=paco"); //turn in meatcar quest
					visit_url("guild.php?place=paco"); //ask for white castle quest
					visit_url("choice.php?whichchoice=930&pwd=" + my_hash() + "&option=1",true); //accept white castle quest
					visit_url("place.php?whichplace=forestvillage&action=fv_scientist",false);
					visit_url("choice.php?whichchoice=1201&pwd=" + my_hash() + "&option=1",true); //fight tentacle
					use_skill($skill[Meteor Shower]); //meteor shower, not sure if auto or needed
				}
				else
				{
					if((have_familiar($familiar[God Lobster])) && (to_boolean(get_property("hccs2da_notour"))) && !(to_boolean(get_property("hccs2da_noscale"))))
					{
						print("Experimental turn saving for god lobster with meteor lore","blue");
						print("DO NOT FINISH COMBAT AND END DAY 1 WHEN ABORTED","blue");
						print("Run script again after rollover, combat should end without costing an adventure","blue");
						use_familiar($familiar[God Lobster]);
						reach_hp(my_maxhp()-15);
						reach_mp(20);
						visit_url("main.php?fightgodlobster=1");
						use_skill($skill[Meteor Shower]); //meteor shower
					}
				}
			}
		}
		abort("END DAY 1.");
	}
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//day2
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//DAY2
	if (my_daycount() >= 2)
	{
	
		print("BEGIN DAY 2", "blue");

		use_familiar(ToTour);

		// Collect your consults if you can
		if(to_boolean(get_property("hccs2da_consults")))
		{
			try_consult();
		}

		// Get the factory overseer/worker
		if (!check_quest("Clean Steam Tunnels", 10)) {
			if (get_property("hccs2da_factorymox") >= 35)
			{
				print("Sufficient mox in previous run: Faxing female worker", "green");
				try_fax("factory worker"); //should be FEMALE
			}
			else
			{
				print("Default fax: Faxing male overseer", "green");
				try_fax("factory overseer"); //should be MALE
			}
		}

		// unlock the Detective School
		// This can be fun on day 1 to get the detective solver badge, which grants +hp/+mp/+item based on item level
		if (to_boolean(get_property("hasDetectiveSchool")))
		{
			if (svn_exists("Ezandora-Detective-Solver-branches-Release")) {
				print("Running Detective Solver Script", "green");
				cli_execute("detective solver.ash");
			} else print("If you install Ezandora's Detective Solver script, this script can use solve your mysteries!", "red");
		}

		// Try to Calculate the Universe
		try_num();

		// Get pocket wishes (just in case)
		while (get_property("_genieWishesUsed") < 3)
		{
			cli_execute("genie item pocket");
		}
		
		//Source Terminal Day 2 Init
		if (get_property("sourceTerminalSpam") > 0)
		{
			cli_execute("terminal educate extract.edu");
			cli_execute("terminal educate duplicate.edu");
		}
		
		//tea tree TODO
		if (false && (to_boolean(get_property("_pottedTeaTreeUsed")) == false))
		{
			cli_execute("teatree cuppa frost tea");
		}
		
		// Make meat from BoomBox if we can
		if (item_amount($item[SongBoom&trade; BoomBox]) > 0)
		{
			if (get_property("boomBoxSong") != "Total Eclipse of Your Meat")
			{
				print("Set BoomBox to meat.", "green");
				cli_execute("boombox meat");
			}
		}

		// Get brogues from Bastille Battalion if we can
		print("Battalion Game", "green");
		use_bastille_battalion(0, 0, 2, random(3));
		
		voteInVotingBooth();
		
		if (item_amount($item[mumming trunk]) > 0)
		{
			print("mumming trunk mys", "green");
			visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9592");
			visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=1271&option=5",true); //Oliver Cromwell
		}

		// pantogramming (+mus, res hot, +hp, weapon dmg, -combat)
		summon_pants(1, 1, "-1%2C0", "-1%2C0", "-1%2C0");

		// setup briefcase
		if ((item_amount(KGB) + equipped_amount(KGB)) > 0 && svn_exists("Ezandora-Briefcase-branches-Release"))
		{
			cli_execute("Briefcase booze");
			cli_execute("Briefcase e weapon hot -combat");
		}
		
		//Lightsaber 1(mp gen), 2(20ml),3(3res), 4(10fam wt)
		if ((item_amount($item[Fourth of May Cosplay Saber]) > 0) || (have_equipped($item[Fourth of May Cosplay Saber])))
		{
			print("Lightsaber res", "green");
			visit_url("main.php?action=may4");
			visit_url("choice.php?whichchoice=1386&pwd=" + my_hash() + "&option=3",true);
		}

		//fantasyland only
		if((get_property("frAlways") == True)&&(item_amount($item[FantasyRealm G. E. M.]) < 1))
		{
			print("Getting fantasy hat", "green");
			visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter", false);
			run_choice(1); //warrior
		}

		// autosell pen pal gift
		autosell(item_amount($item[electric crutch]), $item[electric crutch]);
		if (!check_quest("Reduce Gazelle Population", 6)) {
			if (reach_meat(24*3))
			{
				buy(1 , $item[Ben-Gal&trade; Balm], 24);
				buy(1 , $item[glittery mascara], 24);
				buy(1 , $item[hair spray], 24);
			}
			else abort("Not enough meat.");

			if(have_skill($skill[Summon Clip Art]))
			{
				reach_mp(6);
				if((my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make shadowy cat claw");
				}
				if((my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make cold-filtered water");
				}
				if((my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make borrowed time");
				}
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
			
			if(item_amount($item[tasty tart]) > 0)
			{
				use(1 , $item[milk of magnesium]); //first 2nd day
			}
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
			if(item_amount($item[Punching Potion]) > 0)
			{
				use(1, $item[Punching Potion]);
			}
			if ((have_effect($effect[The Power of LOV]) <= 0) && (item_amount($item[LOV Elixir #3]) > 0))
			{
				use(1, $item[LOV Elixir #3]);
			}
			if ((have_effect($effect[Greasy Flavor]) <= 0) && (item_amount($item[greasy paste]) > 0))
			{
				chew(1, $item[greasy paste]);
			}
			if (have_effect($effect[Billiards Belligerence]) <= 0)
			{
				cli_execute("pool 1");
			}
			if (have_familiar($familiar[Grim Brother]))
			{
				cli_execute("grim damage");
			}

			if(have_effect($effect[Bow-Legged Swagger]) <= 0)
			{
				//just in case you lost it
				force_skill(1, $skill[Bow-Legged Swagger]);
			}
			//consider wish wep dmg
			if(have_effect($effect[Bow-Legged Swagger]) > 0)
			{
				if((item_amount($item[pocket wish]) > 0) && (!to_boolean(get_property("hccs2da_stingy"))))
				{
					print("Bow Legged Wish, saves ~5 adv", "blue");
					cli_execute("genie effect Outer Wolf&trade;");
				}
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
			if ((have_skill($skill[Double-Fisted Skull Smashing])) && (item_amount($item[January's Garbage Tote]) > 0))
			{
				cli_execute("fold broken champagne bottle");
				equip($slot[off-hand], $item[broken champagne bottle]);
			}
			
			try_skill($skill[Love Mixology]);
			if(have_effect($effect[Bow-Legged Swagger]) <= 0)
			{
				//only do if >20 adv quest
				if (lovepot(105.2,$stat[none]))
				{
					use(1, to_item(9745));
				}
			}
			
			// Not sure if works, notify me if you tested it
			if (item_amount($item[SongBoom&trade; BoomBox]) > 0)
			{
				if (get_property("boomBoxSong") != "These Fists Were Made for Punchin")
				{
					print("Set BoomBox to fists.", "green");
					cli_execute("boombox fists");
				}
			}
			
			complete_quest("REDUCE GAZELLE POPULATION", 6);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Clean Steam Tunnels", 10)) {
			// Make meat from BoomBox if we can (revert to normal behavior)
			if (item_amount($item[SongBoom&trade; BoomBox]) > 0)
			{
				if (get_property("boomBoxSong") != "Total Eclipse of Your Meat")
				{
					print("Set BoomBox to meat.", "green");
					cli_execute("boombox meat");
				}
			}
			
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[January's Garbage Tote]) > 0))
			{
				cli_execute("fold makeshift garbage shirt");
				equip($slot[shirt], $item[makeshift garbage shirt]);
			}

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

			force_skill(1, $skill[The Magical Mojomuscular Melody]);
			force_skill(1, $skill[Sauce Contemplation]);

			burn_mp();

			cli_execute("shower mp");

			set_property("hccs2da_factorymox",my_basestat($stat[moxie]));
			if (my_basestat($stat[moxie])>=35)
			{
				print("FAX FEMALE WORKER NEXT TIME", "blue");
			}
			print("Y-RAY FAX", "blue");
			if(force_skill(1, $skill[Disintegrate], false))
			{
				if (item_amount($item[photocopied monster]) > 0)
				{
					if (item_amount($item[Fourth of May Cosplay Saber]) > 0)
					{
						equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
					}
					if (have_equipped($item[Fourth of May Cosplay Saber]))
					{
						visit_url("inventory.php?which=3",false);
						visit_url("inv_use.php?which=f0&whichitem=4873&pwd=" + my_hash(),false);
						use_skill(to_skill(7311)); //use the force
						visit_url("choice.php?whichchoice=1387&pwd=" + my_hash() + "&option=3",true); //drop stuff
						visit_url("main.php"); //refresh, not sure if needed
					}
					else
					{
						use(1, $item[photocopied monster]);
					}
				}
				else abort("You do not have a photocopied monster.");
			}
			else abort("No Y-RAY.");

			print("Teatime", "blue");

			if (my_fullness() == 12)
			{
				if (!eat_dog("wet dog", AddHotdog))
					abort("Cannot eat wet dog");
				//cli_execute("eat wet dog");
			}
			else
			{
				if(!try_pillkeeper("sem"))
				{
					if (!eat_dog("optimal dog", AddHotdog))
					{
						abort("Cannot eat optimal dog");
					}
				} // TODO: Eat something else if we used pillkeeper

				if (get_counters("Fortune Cookie" ,0 ,0) == "Fortune Cookie")
				{
					while (item_amount($item[tasty tart]) == 0)
					{
						adventure(1, $location[The Haunted Pantry]);
					}
				}
				else
				{
					abort("No optimal dog or pillkeeper semirare.");
				}
				eat(3 , $item[tasty tart]);
			}

			print("Task Prep (hot res, 2nd part)", "blue");
			
			force_skill(1, $skill[Elemental Saucesphere]);
			force_skill(1, $skill[Astral Shell]);
			try_effect($effect[Synthesis: Hot]);
			try_effect($effect[Hot-Headed]);
			try_effect($effect[Too Cool for (Fish) School]);
			
			//DAY 2 LOV
			if ((get_property("loveTunnelAvailable") == true) && (get_property("_loveTunnelUsed") == false) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
				visit_url("choice.php?whichchoice=1222&option=1&pwd");
				visit_url("choice.php?whichchoice=1223&option=1&pwd");
				run_combat();
				visit_url("choice.php?whichchoice=1224&option=3&pwd");
				visit_url("choice.php?whichchoice=1225&option=1&pwd");
				run_combat();
				visit_url("choice.php?whichchoice=1226&option=2&pwd");
				visit_url("choice.php?whichchoice=1227&option=1&pwd");
				run_combat();
				visit_url("choice.php?whichchoice=1228&option=3&pwd");
				equip($slot[acc3], $item[LOV Earrings]);
				use(1 , $item[LOV Extraterrestrial Chocolate]);
			}



			if ((item_amount($item[pocket wish]) > 0) && (!to_boolean(get_property("hccs2da_stingy"))))
			{
				cli_execute("genie effect Fireproof Lips");
			}
			if (item_amount($item[cuppa Frost Tea]) > 0)
			{
				use(1, $item[cuppa Frost Tea]);
			}
			if ((item_amount($item[heat-resistant gloves]) > 0) && (my_basestat($stat[moxie])>=35))
			{
				equip($slot[acc3], $item[heat-resistant gloves]);
			}
			if (item_amount($item[heat-resistant necktie]) > 0)
			{
				equip($slot[acc3], $item[heat-resistant necktie]);
			}
			if (item_amount($item[psychic's amulet]) > 0)
			{
				equip($slot[acc2], $item[psychic's amulet]);
			}
			if (item_amount(KGB) > 0) {
				equip($slot[acc2], KGB);
			}
			if (item_amount($item[psychic's amulet]) > 0)
			{
				equip($slot[acc1], $item[psychic's amulet]);
			}
			if (item_amount($item[LOV Earrings]) > 0)
			{
				equip($slot[acc1], $item[LOV Earrings]);
			}
			if (item_amount($item[pantogram pants]) > 0)
			{
				equip($slot[pants], $item[pantogram pants]);
			}
			if ((item_amount($item[lava-proof pants]) > 0) && (my_basestat($stat[moxie])>=35))
			{
				equip($slot[pants], $item[lava-proof pants]);
			}
			if (item_amount($item[Glass pie plate]) > 0)
			{
				equip($slot[off-hand], $item[Glass pie plate]);
			}
			if (item_amount($item[Fourth of May Cosplay Saber]) > 0)
			{
				equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
			}
			try_cloake_buff($skill[Become a Cloud of Mist]);
			
			if (have_familiar($familiar[Exotic Parrot])) {
				use_familiar($familiar[Exotic Parrot]);
			}

			if (have_effect($effect[Billiards Belligerence]) <= 0)
			{
				cli_execute("pool 1");
			}

			if ((have_skill($skill[Leash of Linguini])) && (familiar_weight($familiar[Exotic Parrot]) + weight_adjustment() < 20))
			{
				force_skill(1, $skill[Leash of Linguini]);
			}

			if ((have_skill($skill[Empathy of the Newt])) && (familiar_weight($familiar[Exotic Parrot]) + weight_adjustment() < 20))
			{
				force_skill(1, $skill[Empathy of the Newt]);
			}
			
			try_skill($skill[Love Mixology]);
			try_pillkeeper("ele");
			if(elemental_resistance($element[hot]) < 94.93) {
				if (lovepot(86.5,$stat[none]))
				{
					use(1, to_item(9745));
				}
			}
			complete_quest("STEAM TUNNELS", 10);
			use_familiar(ToTour);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Donate Blood", 1)) {
			use_familiar(ToTour);

			equip($slot[acc3], $item[none]);

			//unequip and sell volcano equipments
			if (item_amount($item[heat-resistant necktie]) > 0)
			{
				autosell(1, $item[heat-resistant necktie]);
			}

			print("Base Booze Farming (if needed)", "blue");
			cli_execute("try; fortune buff gunther");
			
			//use kramco before farming
			if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
			{
				//equip($slot[acc2], $item[Lil' Doctor&trade; bag]);
			}
			
			if ((item_amount($item[Kramco Sausage-o-Matic&trade;]) > 0) && (have_skill($skill[Soul Saucery])) && (my_soulsauce() >= 5) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
			}

			while ((item_amount($item[boxed wine]) <= 0) && (item_amount($item[bottle of rum]) <= 0) && (item_amount($item[bottle of vodka]) <= 0) && (item_amount($item[bottle of gin]) <= 0) && (item_amount($item[bottle of whiskey]) <= 0) && (item_amount($item[bottle of tequila]) <= 0))
			{
				adventure(1, $location[Noob Cave]);
			}

			print("Main drink", "blue");

			force_skill(1, $skill[Perfect Freeze]);
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

			drink_to(12);
			if (item_amount($item[asbestos thermos]) > 0)
			{
				if (my_inebriety() < 9) ode_drink(1, $item[asbestos thermos]);
			}

			print("Task Prep (hp/mus)", "blue");
			
			//Cook now if you cannot in day 1
			if (item_amount($item[scrumptious reagent]) >= 2)
			{
				if (item_amount($item[tomato juice of powerful power]) == 0)
				{
					if (item_amount($item[tomato]) > 0)
					{
						craft("cook", 1, $item[scrumptious reagent], $item[tomato]);
					}
					else
					{
						print("NO TOMATO, lemon is fairly important to reduce blood test to 1 adv", "red");
					}
				}
				if (item_amount($item[ointment of the occult]) == 0)
				{
					if (item_amount($item[grapefruit]) > 0)
					{
						craft("cook", 1, $item[scrumptious reagent], $item[grapefruit]);
					}
				}
			}
			else
			{
				print("scrumptious reagent< 2, this should not happen", "red");
			}
			
			//spells
			force_skill(1, $skill[The Power Ballad of the Arrowsmith]);
			force_skill(1, $skill[Quiet Determination]);
			force_skill(1, $skill[Rage of the Reindeer]);
			force_skill(1, $skill[Get Big]);
			force_skill(1, $skill[Sauce Contemplation]);
			force_skill(1, $skill[Seal Clubbing Frenzy]);
			force_skill(1, $skill[Patience of the Tortoise]);
			force_skill(1, $skill[Moxie of the Mariachi]);
			try_skill($skill[Bind Undead Elbow Macaroni]);
			try_skill($skill[Song of Bravado]);
			try_skill($skill[Stevedave's Shanty of Superiority]);
			try_skill($skill[Reptilian Fortitude]);

			//buffs
			cli_execute("genie effect Preemptive Medicine");

			use_telescope();
			visit_url("place.php?whichplace=monorail&action=monorail_lyle");

			//items
			try_effect($effect[Synthesis: Strong]);
			if ((have_effect($effect[Oily Flavor]) <= 0) && (item_amount($item[oily paste]) > 0))
			{
				chew(1, $item[oily paste]);
			}
			if ((have_effect($effect[The Power of LOV]) <= 0) && (item_amount($item[LOV Elixir #3]) > 0))
			{
				use(1, $item[LOV Elixir #3]);
			}
			if (item_amount($item[Ben-Gal&trade; Balm]) > 0)
			{
				use(1, $item[Ben-Gal&trade; Balm]);
			}
			if (!have_skill($skill[Sweet Synthesis]))
			{
				if(item_amount($item[Crimbo peppermint bark]) > 0)
				{
					use(1, $item[Crimbo peppermint bark]);
				}
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
			if (((my_class() == $class[seal clubber]) || (my_class() == $class[turtle tamer])) && (guild_store_available()))
			{
				if ((item_amount($item[Blood of the Wereseal]) <= 0) && (my_meat() >= 1000))
				{
					buy(1, $item[Blood of the Wereseal], 500);
				}
			}
			if (item_amount($item[Blood of the Wereseal]) > 0)
			{
				use(1, $item[Blood of the Wereseal]);
			}
			try_effect($effect[Lack of Body-Building]);
			//-1 spleen
			try_effect($effect[Does a Body Good]);

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
			if (item_amount($item[cosmetic football]) > 0)
			{
				equip($slot[off-hand], $item[cosmetic football]);
			}
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[denim jacket]) > 0))
			{
				equip($slot[shirt], $item[denim jacket]);
			}
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[shoe ad T-shirt]) > 0))
			{
				equip($slot[shirt], $item[shoe ad T-shirt]);
			}
			if (item_amount($item[three-legged pants]) > 0)
			{
				equip($slot[pants], $item[three-legged pants]);
			}
			if (item_amount($item[pantogram pants]) > 0)
			{
				equip($slot[pants], $item[pantogram pants]);
			}
			if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
			{
				equip($slot[acc1], $item[Lil' Doctor&trade; bag]);
			}
			if (item_amount($item[Brutal brogues]) > 0)
			{
				equip($slot[acc2], $item[Brutal brogues]);
			}
			if (item_amount($item[ring of telling skeletons what to do]) > 0)
			{
				equip($slot[acc3], $item[ring of telling skeletons what to do]);
			}

			//Cancel max mp buff
			if (have_effect($effect[[1458]Blood Sugar Sauce Magic]) > 0)
			{
				force_skill(1, $skill[Blood Sugar Sauce Magic]);
			}
			
			try_cloake_buff($skill[Become a Wolf]);

			//check if wish required for donate blood
			if(my_maxhp() - (my_buffedstat($stat[muscle]) + 3) < 30 * 58)
			{
				print("Mus Wish (You might want more skills)", "green");
				print(60-((my_maxhp() - (my_buffedstat($stat[muscle])+3)) / 30) + " estimated adv", "blue");
				
				int gnine_stat = 0;
				float gnine_add = 0.0;
				matcher match_gnine_stat = create_matcher("Mysticality\\ \\+(\\d+)%" , visit_url("desc_effect.php?whicheffect=af64d06351a3097af52def8ec6a83d9b"));
				if(match_gnine_stat.find()) {
					gnine_stat = match_gnine_stat.group(1).to_int();
					gnine_add = my_basestat($stat[mysticality])*(gnine_stat*0.01);
					print("G9: "+gnine_stat+"%");
					print("Buff: "+gnine_add);
				}
				if (item_amount($item[pocket wish]) > 0)
				{
					if (gnine_add>100.0)
					{
						cli_execute("genie effect Experimental Effect G-9");
					}
					else
					{
						cli_execute("genie effect 'Roids of the Rhinoceros");
					}
				}
			}
			complete_quest("DONATE BLOOD", 1);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Feed The Children", 2)) {
			//Redo max mp buff
			if (have_effect($effect[[1458]Blood Sugar Sauce Magic]) == 0)
			{
				force_skill(1, $skill[Blood Sugar Sauce Magic]);
			}
		
			//remove doc bag
			if (equipped_item($slot[acc1]) == $item[Lil' Doctor&trade; bag]) {
				equip($slot[acc1], $item[none]);
			}
			if (equipped_item($slot[acc2]) == $item[Lil' Doctor&trade; bag]) {
				equip($slot[acc2], $item[none]);
			}
			if (equipped_item($slot[acc3]) == $item[Lil' Doctor&trade; bag]) {
				equip($slot[acc3], $item[none]);
			}
			
			
			try_skill($skill[Love Mixology]);
			try_pillkeeper("stats");
			if (lovepot(56.5,$stat[muscle]))
			{
				use(1, to_item(9745));
			}

			complete_quest("FEED CHILDREN", 2);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Build Playground Mazes", 3)) {
			print("Task Prep (mys)", "blue");

			// drink
			ode_drink(1, $item[Bee's Knees]);

			//spells
			force_skill(1, $skill[The Magical Mojomuscular Melody]);
			force_skill(1, $skill[Quiet Judgement]);
			force_skill(1, $skill[Get Big]);
			force_skill(1, $skill[Manicotti Meditation]);
			force_skill(1, $skill[Sauce Contemplation]);
			try_skill($skill[Blessing of She-Who-Was]);
			try_skill($skill[Song of Bravado]);
			try_skill($skill[Stevedave's Shanty of Superiority]);
			try_effect($effect[Synthesis: Smart]);
			//item
			if ((have_effect($effect[The Magic of LOV]) <= 0) && (item_amount($item[LOV Elixir #6]) > 0))
			{
				use(1, $item[LOV Elixir #6]);
			}
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
			if (!have_skill($skill[Sweet Synthesis]))
			{
				if(item_amount($item[Crimbo candied pecan]) > 0)
				{
					use(1, $item[Crimbo candied pecan]);
				}
			}
			try_effect($effect[We're All Made of Starfish]);
			if(item_amount($item[bag of grain]) > 0)
			{
				use(1, $item[bag of grain]);
			}
			if((get_property("_madTeaParty") == false) && (item_amount($item[ravioli hat]) > 0) && (item_amount($item[&quot;DRINK ME&quot; potion]) > 0))
			{
				cli_execute("hatter ravioli hat");
			}
			else print("You do not have a suitable hat for the mad hatter here.", "green");


			//equip
			if(item_amount($item[dorky glasses]) > 0)
			{
				equip($slot[acc2], $item[dorky glasses]);
			}
			if ((item_amount($item[psychic's circlet]) > 0) && (my_basestat($stat[moxie]) >= 35))
			{
				equip($slot[hat], $item[psychic's circlet]);
			}
			if (item_amount($item[chef's hat]) > 0)
			{
				equip($slot[hat], $item[chef's hat]);
			}
			if (item_amount($item[January's Garbage Tote]) > 0)
			{
				cli_execute("fold wad of used tape");
				equip($slot[hat], $item[wad of used tape]);
			}
			if (item_amount($item[Dolphin King's crown]) > 0)
			{
				equip($slot[hat], $item[Dolphin King's crown]);
			}
			if (item_amount($item[FantasyRealm Mage's Hat]) > 0)
			{
				equip($slot[hat], $item[FantasyRealm Mage's Hat]);
			}
			if (item_amount($item[pentagram bandana]) > 0)
			{
				equip($slot[hat], $item[pentagram bandana]);
			}
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[shoe ad T-shirt]) > 0))
			{
				equip($slot[shirt], $item[shoe ad T-shirt]);
			}
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[denim jacket]) > 0))
			{
				equip($slot[shirt], $item[denim jacket]);
			}
			if (item_amount($item[psychic's crystal ball]) > 0)
			{
				equip($slot[off-hand], $item[psychic's crystal ball]);
			}
			if (item_amount($item[astral statuette]) > 0)
			{
				equip($slot[off-hand], $item[astral statuette]);
			}
			if (item_amount($item[5-Alarm Saucepan]) > 0)
			{
				equip($slot[weapon], $item[5-Alarm Saucepan]);
			}
			
			//DAYCARE
			print("Boxing Daycare", "green");
			if ((get_property("daycareOpen") == true) && (get_property("_daycareNap") == false))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
				visit_url("choice.php?whichchoice=1334&pwd=" + my_hash() + "&option=1&sumbit=Have a Boxing Daydream",true);
			}
			if ((get_property("daycareOpen") == true) && (get_property("_daycareSpa") == false))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
				visit_url("choice.php?whichchoice=1334&pwd=" + my_hash() + "&option=2&sumbit=Visit the Boxing Day Spa",true);
				visit_url("choice.php?whichchoice=1335&pwd=" + my_hash() + "&option=3&sumbit=Get a Cucumber Eye Treatment",true);
			}
			if ((get_property("daycareOpen") == true) && (get_property("_daycareGymScavenges").to_int() == 0))
			{
				visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
				visit_url("choice.php?whichchoice=1334&pwd=" + my_hash() + "&option=3&sumbit=Enter the Boxing Daycare",true);
				visit_url("choice.php?whichchoice=1336&pwd=" + my_hash() + "&option=2&sumbit=Scavenge for gym equipment ",true);
			}
			
			//Source Terminal Day 2 Combat
			if (get_property("sourceTerminalSpam") > 0)
			{
				cli_execute("terminal enhance items.enh");
				cli_execute("terminal enhance meat.enh");
				cli_execute("terminal enhance substats.enh");
			}
			
			try_effect($effect[You Learned Something Maybe!]);
			try_effect($effect[Resting Beach Face]);
			//GOD LOB
			if((have_familiar($familiar[God Lobster])) && (to_boolean(get_property("hccs2da_notour"))) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				use_familiar($familiar[God Lobster]);
				equip($slot[familiar], $item[God Lobster's Scepter]);
				reach_hp(my_maxhp()-15);
				reach_mp(20);
				visit_url("main.php?fightgodlobster=1");
				run_combat();
				visit_url("main.php"); //refresh, i heard this works
				run_choice(2);//buff
				use_familiar(ToTour);
			}
			// NEP FIGHT
			if ((get_property("neverendingPartyAlways") == true) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				print("NEP fights", "green");
				reach_mp(50);
				try_skill($skill[Carol of the Thrills]);
				if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[January's Garbage Tote]) > 0))
				{
					cli_execute("fold makeshift garbage shirt");
					equip($slot[shirt], $item[makeshift garbage shirt]);
				}
				//use kramco before farming
				if (item_amount($item[Lil' Doctor&trade; bag]) > 0)
				{
					//equip($slot[acc2], $item[Lil' Doctor&trade; bag]);
				}
				if ((item_amount($item[Kramco Sausage-o-Matic&trade;]) > 0) && (have_skill($skill[Soul Saucery])) && (my_soulsauce() >= 5))
				{
					equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
				}
				while (get_property("_neverendingPartyFreeTurns").to_int() < 10)
				{
					reach_hp(my_maxhp()-15);
					reach_mp(20);
					adv1_NEP();
				}
				
				if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[shoe ad T-shirt]) > 0))
				{
					equip($slot[shirt], $item[shoe ad T-shirt]);
				}
				if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[denim jacket]) > 0))
				{
					equip($slot[shirt], $item[denim jacket]);
				}
				if (item_amount($item[psychic's crystal ball]) > 0)
				{
					equip($slot[off-hand], $item[psychic's crystal ball]);
				}
				if (item_amount($item[astral statuette]) > 0)
				{
					equip($slot[off-hand], $item[astral statuette]);
				}
			}
			//GOD LOB
			if((have_familiar($familiar[God Lobster])) && (to_boolean(get_property("hccs2da_notour"))) && !(to_boolean(get_property("hccs2da_noscale"))))
			{
				use_familiar($familiar[God Lobster]);
				reach_hp(my_maxhp()-15);
				reach_mp(20);
				visit_url("main.php?fightgodlobster=1");
				run_combat();
				visit_url("main.php"); //refresh, i heard this works
				run_choice(3); //exp
				reach_hp(my_maxhp()-15);
				reach_mp(20);
				visit_url("main.php?fightgodlobster=1");
				run_combat();
				visit_url("main.php"); //refresh, i heard this works
				run_choice(3); //exp
				use_familiar(ToTour);
			}
			
			if (get_property("sourceTerminalSpam") > 0)
			{
				if (item_amount($item[Source essence]) >= 10)
				{
					cli_execute("terminal extrude booze gibson");
				}
				if (item_amount($item[Source essence]) >= 10)
				{
					cli_execute("terminal extrude booze gibson");
				}
				if (item_amount($item[Source essence]) >= 10)
				{
					cli_execute("terminal extrude booze gibson");
				}
			}

			try_skill($skill[Love Mixology]);
			try_pillkeeper("stats");
			if (lovepot(27.5,$stat[mysticality]))
			{
				use(1, to_item(9745));
			}

			complete_quest("BUILD PLAYGROUND MAZES", 3);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Feed Conspirators", 4)) {
			print("Task Prep (mox)", "blue");
			//spells
			try_effect($effect[Synthesis: Cool]);
			force_skill(1, $skill[The Moxious Madrigal]);
			force_skill(1, $skill[Blubber Up]);
			if ((have_skill($skill[Quiet Desperation])) && (have_skill($skill[Disco Smirk])))
			{
				if (my_basestat($stat[mysticality])>40) //oil of expertise
				{
					force_skill(1, $skill[Quiet Desperation]);
				}
				else
				{
					force_skill(1, $skill[Disco Smirk]);
				}
			}
			else
			{
				force_skill(1, $skill[Quiet Desperation]);
				force_skill(1, $skill[Disco Smirk]);
			}
			force_skill(1, $skill[Get Big]);
			force_skill(1, $skill[Disco Fever]);
			force_skill(1, $skill[Disco Aerobics]);
			force_skill(1, $skill[Moxie of the Mariachi]);
			try_skill($skill[Song of Bravado]);
			try_skill($skill[Stevedave's Shanty of Superiority]);

			//item
			if ((have_effect($effect[The Moxie of LOV]) <= 0) && (item_amount($item[LOV Elixir #9]) > 0))
			{
				use(1, $item[LOV Elixir #9]);
			}
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
			//feel free to use crimbo candy here, since we are past all synthesis
			if(item_amount($item[Crimbo fudge]) > 0)
			{
				use(1, $item[Crimbo fudge]);
			}
			if (item_amount($item[runproof mascara]) > 0)
			{
				use(1, $item[runproof mascara]);
			}
			if(item_amount($item[pocket maze]) > 0)
			{
				use(1, $item[pocket maze]);
			}
			try_effect($effect[Pomp & Circumsands]);
			if((get_property("_madTeaParty") == false) && (item_amount($item[&quot;DRINK ME&quot; potion]) > 0))
			{
				if(item_amount($item[snorkel]) <= 0)
				{
					buy(1 , $item[snorkel], 30);
				}
				cli_execute("hatter snorkel");
			}
			else print("You already used up your mad hatter buff.", "green");

			//equip
			if(item_amount($item[codpiece]) > 0)
			{
				equip($slot[acc1], $item[Codpiece]);
			}
			if(item_amount($item[pump-up high-tops]) > 0)
			{
				equip($slot[acc2], $item[pump-up high-tops]);
			}
			if(item_amount($item[noticeable pumps]) > 0)
			{
				equip($slot[acc3], $item[noticeable pumps]);
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
			if (item_amount($item[January's Garbage Tote]) > 0)
			{
				cli_execute("fold wad of used tape");
				equip($slot[hat], $item[wad of used tape]);
			}
			if (item_amount($item[FantasyRealm Rogue's Mask]) > 0)
			{
				equip($slot[hat], $item[FantasyRealm Rogue's Mask]);
			}
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[denim jacket]) > 0))
			{
				equip($slot[shirt], $item[denim jacket]);
			}
			if ((have_skill($skill[Torso Awaregness])) && (item_amount($item[shoe ad T-shirt]) > 0))
			{
				equip($slot[shirt], $item[shoe ad T-shirt]);
			}
			if (item_amount($item[stylish swimsuit]) > 0)
			{
				equip($slot[pants], $item[stylish swimsuit]);
			}
			if (item_amount($item[psychic's crystal ball]) > 0)
			{
				equip($slot[off-hand], $item[psychic's crystal ball]);
			}
			
			try_skill($skill[Love Mixology]);
			try_pillkeeper("stats");
			if (lovepot(0.0,$stat[moxie]))
			{
				use(1, to_item(9745));
			}
			
			if(item_amount($item[Rhinestone]) > 0)
			{
				use(item_amount($item[Rhinestone]), $item[Rhinestone]);
			}

			complete_quest("FEED CONSPIRATORS", 4);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Breed More Collies", 5)) {
			print("Task Prep (fam weight)", "blue");

			force_skill(1, $skill[Leash of Linguini]);
			force_skill(1, $skill[Empathy of the Newt]);
			
			if(item_amount($item[beastly paste]) > 0)
			{
				//chew(1, $item[beastly paste]);
			}
			if (have_effect($effect[Billiards Belligerence]) <= 0)
			{
				//cli_execute("pool 1");
			}
			try_effect($effect[Leash of Linguini]);
			try_effect($effect[Empathy]);
			try_effect($effect[Beastly Flavor]);
			try_effect($effect[Billiards Belligerence]);
			try_effect($effect[Blood Bond]);
			try_effect($effect[Do I Know You From Somewhere?]);

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

			//borrow time here if needed
			if ((item_amount($item[borrowed time]) > 0) && (my_adventures() <= 60))
			{
				print("Borrowing Time", "green");
				use(1, $item[borrowed time]);
			}
			
			lightsaber_buff($skill[Meteor Shower]);
			try_pillkeeper("familiar");

			complete_quest("BREED MORE COLLIES", 5);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("Be a Living Statue", 8)) {
			print("Task Prep (-combat)", "blue");

			force_skill(1, $skill[Smooth Movement]);
			force_skill(1, $skill[The Sonata of Sneakiness]);
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
			if (item_amount($item[squeaky toy rose]) > 0)
			{
				use(1, $item[squeaky toy rose]);
			}
			if (item_amount($item[shady shades]) > 0)
			{
				use(1, $item[shady shades]);
			}
			if ((item_amount($item[pocket wish]) > 0) && (!to_boolean(get_property("hccs2da_stingy"))))
			{
				cli_execute("genie effect Disquiet Riot");
			}
			if ((item_amount($item[pocket wish]) > 0) && (!to_boolean(get_property("hccs2da_stingy"))))
			{
				cli_execute("genie effect Chocolatesphere");
			}
			//TODO: use stooper if barely not enough adv
			complete_quest("BE A LIVING STATUE", 8);
			if (stepmode == 1) { abort("step done"); }
		}
		if (!check_quest("this will end your run", 30)) {
			if (have_effect($effect[The Sonata of Sneakiness]) > 0)
			{
				cli_execute("shrug The Sonata of Sneakiness");
			}

			set_property("hccs2da_progress" ,0 );
			print("ASCENSION - DONATING YOUR BODY TO SCIENCE", "red");
			visit_url("council.php");
			visit_url("choice.php?pwd&whichchoice=1089&option=30");

			// Restore previous CCS and settings
			
			revert_settings();

			//DONT PULL WITH PVP
			//cli_execute("pull all");
			if (hippy_stone_broken())
			{
				cli_execute("flowers"); 
			}
			cli_execute("breakfast");
			
			//RECORDS
			//Print quest completion speed
			print("QUEST RECORDS", "purple");
			print("COIL WIRE: " + get_property( "hccs2da_questrecord11" ), "blue");
			remove_property( "hccs2da_questrecord11" );
			print("MAKE MARGARITAS: " + get_property( "hccs2da_questrecord9" ), "blue");
			remove_property( "hccs2da_questrecord9" );
			print("MAKE SAUSAGE: " + get_property( "hccs2da_questrecord7" ), "blue");
			remove_property( "hccs2da_questrecord7" );
			print("REDUCE GAZELLE POPULATION: " + get_property( "hccs2da_questrecord6" ), "blue");
			remove_property( "hccs2da_questrecord6" );
			print("STEAM TUNNELS: " + get_property( "hccs2da_questrecord10" ), "blue");
			remove_property( "hccs2da_questrecord10" );
			print("DONATE BLOOD: " + get_property( "hccs2da_questrecord1" ), "blue");
			remove_property( "hccs2da_questrecord1" );
			print("FEED CHILDREN: " + get_property( "hccs2da_questrecord2" ), "blue");
			remove_property( "hccs2da_questrecord2" );
			print("BUILD PLAYGROUND MAZES: " + get_property( "hccs2da_questrecord3" ), "blue");
			remove_property( "hccs2da_questrecord3" );
			print("FEED CONSPIRATORS: " + get_property( "hccs2da_questrecord4" ), "blue");
			remove_property( "hccs2da_questrecord4" );
			print("BREED MORE COLLIES: " + get_property( "hccs2da_questrecord5" ), "blue");
			remove_property( "hccs2da_questrecord5" );
			print("BE A LIVING STATUE: " + get_property( "hccs2da_questrecord8" ), "blue");
			remove_property( "hccs2da_questrecord8" );
			print(" ", "purple");
			print("OTHER INFO", "purple");
			print("TURN COUNT: " + my_turncount(), "blue");
			print("REMAINING ADV: " + my_adventures(), "blue");
			print("MARZIPAN ITEM%: " + get_property( "hccs2da_marzipanhard" ), "blue");
			print("MARZIPAN CANDY%: " + get_property( "hccs2da_marzipaneasy" ), "blue");
			print("MOXIE AT FACTORY: " + get_property( "hccs2da_factorymox" ), "blue");
			print("PVP ENABLED: " + get_property( "hccs2da_dopvp" ), "blue");
			print("TOUR DISABLED: " + get_property( "hccs2da_notour" ), "blue");
			print("SCALING MOBS DISABLED: " + get_property( "hccs2da_noscale" ), "blue");
			print("STINGY MODE: " + get_property( "hccs2da_stingy" ), "blue");
			print("DO BARRELS: " + get_property( "hccs2da_barrels" ), "blue");
			print("DO CONSULTS: " + get_property( "hccs2da_consults" ), "blue");
			
			
			print("FINISHED.", "red");
		}
	}
}