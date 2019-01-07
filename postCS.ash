boolean buy_coinmaster(int qty, item it) {
   coinmaster master = it.seller;
   if(master == $coinmaster[none]) {
      print("You do not need a coinmaster to purchase that", "red");
      return false;
   }
   if(!is_accessible(master)) {
      print(inaccessible_reason(master), "red");
      return false;
   }
   int coins = master.available_tokens;
   int price = sell_price(master, it);
   if(price > coins) {
      print("You only have "+coins+" "+master.token+", but it costs "+price+" "+master.token, "red");
      return false;
   }
   return buy(master, qty, it);
}

void main(){

	if (have_effect($effect[Cringle's Curative Carol]) <= 0)
	{
		abort("No buffs");
	}
	if (item_amount($item[Rain-Doh blue balls]) <= 0)
	{
		abort("No item");
	}
	if (my_spleen_use() < spleen_limit())
	{
		abort("Use your spleen");
	}
	
	set_property("customCombatScript", "default");
	
	if ( have_outfit( "fantasyLOW" ) ){
		outfit( "fantasyLOW" );
		use_familiar($familiar[None]);
	}
	else
	{
	   abort( "You don't have the outfit" );
	}
	if (item_amount($item[FantasyRealm key]) <= 0)
	{
		buy_coinmaster(1 , $item[FantasyRealm key]);
	}
	adventure(6 , $location[The Cursed Village]);//6
	adventure(2 , $location[The Putrid Swamp]);
	adventure(5 , $location[The Bandit Crossroads]);
	adventure(5 , $location[The Sprawling Cemetery]);
	adventure(5 , $location[The Towering Mountains]);
	adventure(6 , $location[The Mystic Wood]);
	adventure(1 , $location[The Putrid Swamp]);
	adventure(1 , $location[The Faerie Cyrkle]);
	use_skill(1 ,$skill[Cannelloni Cocoon]);
	adventure(1 , $location[The Faerie Cyrkle]);
	use_skill(1 ,$skill[Cannelloni Cocoon]);
	adventure(1 , $location[The Faerie Cyrkle]);
	use_skill(1 ,$skill[Cannelloni Cocoon]);
	adventure(1 , $location[The Faerie Cyrkle]);
	use_skill(1 ,$skill[Cannelloni Cocoon]);
	adventure(1 , $location[The Faerie Cyrkle]);
	use_skill(1 ,$skill[Cannelloni Cocoon]);
	adventure(1 , $location[The Faerie Cyrkle]);
	use_skill(1 ,$skill[Cannelloni Cocoon]);
	adventure(6 , $location[The Troll Fortress]);
	
	craft("cook", 1, $item[nasty haunch], $item[faerie dust]);
	put_shop(1000000 , 0, item_amount($item[denastified haunch]) , $item[denastified haunch]);

	
	if ( have_outfit( "itemLOW" ) ){
		outfit( "itemLOW" );
		use_familiar($familiar[Pair of Stomping Boots]);
	}
	else
	{
	   abort( "You don't have the outfit" );
	}
	use(1 , $item[The Legendary Beat]);
	use(1 , $item[Jackass Plumber home game]);
	visit_url("place.php?whichplace=canadia&action=lc_marty", false);
	
	//visit_url("adventure.php?snarfblat=330");
	boolean done1 = false;
	while (!done1) {
		string page = visit_url("adventure.php?snarfblat=330");

		// *** If we hit the fork, notify and stop looping.
		if (page.contains_text("Stick a Fork In It")) {
			run_choice(2);
			done1 = true;
		}
		// *** Combat
		else if (page.contains_text("You're fighting")) {
			run_combat();
		}
	}
	print("Finished Fork1", "blue");
	
	boolean done2 = false;
	while (!done2) {
		string page = visit_url("adventure.php?snarfblat=334");

		// *** If we hit the fork, notify and stop looping.
		if (page.contains_text("From Bad to Worst")) {
			run_choice(2);
			done2 = true;
		}
		// *** Combat
		else if (page.contains_text("You're fighting")) {
			run_combat();
		}
	}
	print("Finished Fork2", "blue");
	
	boolean done3 = false;
	while (!done3) {
		string page = visit_url("adventure.php?snarfblat=336");

		// *** If we hit swamp skunk, notify and stop looping.
		if (page.contains_text("swamp skunk")) {
			run_combat();
			done3 = true;
		}
		// *** Combat
		else if (page.contains_text("You're fighting")) {
			run_combat();
		}
	}
	print("Finished Pogo Stick Attempt", "blue");
	
	while (my_adventures() > 0) {
		//	More Combats
		string page = visit_url("adventure.php?snarfblat=336");
		run_combat();
	}
	print("Finished using up adv", "blue");
	
	if (have_effect($effect[Cringle's Curative Carol]) > 0)
	{
		cli_execute("shrug Cringle's Curative Carol");
	}
	use_skill(1 ,$skill[The Ode to Booze]);
	use_familiar($familiar[Stooper]);
	drink(1 , $item[Cold One]);
	equip($slot[acc3], $item[ring of Detect Boring Doors]);
	adventure(15 , $location[the daily dungeon]);
	use_skill(1 ,$skill[The Ode to Booze]);
	overdrink(1 , $item[Fog Murderer]);
	if ( have_outfit( "fantasyLOW" ) ){
		outfit( "fantasyLOW" );
		use_familiar($familiar[Pair of Stomping Boots]);
		print("1", "blue");
		use(1 , $item[Rain-Doh box full of monster]);
		print("2", "blue");
		use(1 , $item[Rain-Doh box full of monster]);
		print("3", "blue");
		use(1 , $item[Rain-Doh box full of monster]);
		print("4", "blue");
		use(1 , $item[Rain-Doh box full of monster]);
		print("done", "blue");
	}
	else
	{
	   abort( "You don't have the outfit" );
	}
	
	if ( have_outfit( "pvpLOW" ) ){
		outfit( "pvpLOW" );
	}
	else
	{
	   abort( "You don't have the outfit" );
	}
	boolean done4 = false;
	visit_url("clan_viplounge.php?action=hotdogstand", false);
	while (!done4) {
		string page = visit_url("clan_viplounge.php?preaction=eathotdog&whichdog=-92&sumbit=Eat",true);

		if (page.contains_text("feel up to eating")) {
			done4 = true;
		}
	}
	print("Finished Hot Dogs", "blue");
	
	while (my_adventures() >= 10) {
		//	Game Grid token
		visit_url("place.php?whichplace=arcade&action=arcade_fist", false);
		visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=486&option=5&sumbit=Finish from Memory",true);
	}
	print("Finished Game Grid", "blue");

	visit_url("peevpee.php?action=smashstone&pwd&confirm=on", true);
	use(1 , $item[confusing LED clock]);
	use(1 , $item[Meteorite-Ade]);
	use(1 , $item[Meteorite-Ade]);
	use(1 , $item[Meteorite-Ade]);
	use_skill(1 ,$skill[Inigo's Incantation of Inspiration]);
	visit_url("campground.php?action=rest", false);
	
	cli_execute("flowers");
	
	
	

	
}
