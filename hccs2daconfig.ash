//HCCS 2day 100% CONFIG v1.0 by iloath



void main(){
	//SETTINGS
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
	
	//if true will fight god lobster and break 100% fam tour
	if (user_confirm("Be stingy and save 3 pocket wish per run?"))
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