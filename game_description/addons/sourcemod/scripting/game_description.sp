#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Game Description Override",
	author = "Woobbie",
	description = "Overrides the game description shown in the server browser",
	version = "1.1.0",
	url = "https://github.com/Woobb1e"
};

char g_sGame_Description_Override[PLATFORM_MAX_PATH];

// OnPluginStart
public void OnPluginStart()
{
	ConVar cvar;

	cvar = CreateConVar("sm_game_description_override", "Counter Strike Source", "Set the game description when the server loads (maximum 64 characters)");

	cvar.AddChangeHook(Change_Game_Description_Override);

	cvar.GetString(g_sGame_Description_Override, sizeof(g_sGame_Description_Override));

	AutoExecConfig(true, "game_description_override");
}

// Change_Game_Description_Override
public void Change_Game_Description_Override(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	#pragma unused oldValue, newValue

	cvar.GetString(g_sGame_Description_Override, sizeof(g_sGame_Description_Override));
}

// OnGetGameDescription
public Action OnGetGameDescription(char gameDesc[64])
{
	if (StrEqual(g_sGame_Description_Override, ""))
	{
		LogError("Game description is not set, please set it in your launch options with +sm_game_description_override");
	}
	else
	{
		strcopy(gameDesc, sizeof(gameDesc), g_sGame_Description_Override);
	}

	return Plugin_Changed;
}

