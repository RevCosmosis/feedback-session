#include <sourcemod>

public Plugin:myinfo = {
	name = "Feedback Session",
	author = "Idolon",
	description = "Enables Godmode/Noclip for everyone indefinitely",
	version = "1.0",
	url = "https://github.com/RevCosmosis/feedback-session"
};

ConVar g_cvarEnabled;

public OnPluginStart () {
	RegAdminCmd("sm_fs_on", Fs_On, ADMFLAG_CHANGEMAP);
	RegAdminCmd("sm_fs_off", Fs_Off, ADMFLAG_CHANGEMAP);

	HookEvent("player_spawn", ClientSpawn);
	HookEvent("player_class", ClientSpawn);
	
	g_cvarEnabled = CreateConVar("sm_fs_enabled", "0", "Is a feedback session enabled?");
}

public Action:Fs_On (int executingClient, int args) {
	for(new client = 1; client <= MaxClients; client++)
	{
		if (IsClientInGame(client) && !IsFakeClient(client))
			EnableClient(client);
	}
	g_cvarEnabled.BoolValue = true;
	PrintToChatAll("Feedback session enabled.");

	return Plugin_Handled;
}

public Action:Fs_Off (int executingClient, int args) {
	for(new client = 1; client <= MaxClients; client++)
	{
		if (IsClientInGame(client) && !IsFakeClient(client))
			DisableClient(client);
	}
	g_cvarEnabled.BoolValue = false;
	PrintToChatAll("Feedback session disabled.");

	return Plugin_Handled;
}

public Action:ClientSpawn (Handle:event, const String:name[], bool:dontBroadcast) {
	if (g_cvarEnabled.BoolValue) {
		new id = GetEventInt(event, "userid");
		new client = GetClientOfUserId(id);
		if (IsClientInGame(client) && !IsFakeClient(client))
			EnableClient(client);
	}
	return Plugin_Continue;
}

EnableClient (client) {
	SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
	SetEntProp(client, Prop_Send, "movetype", 2, 1);
}

DisableClient (client) {
	SetEntProp(client, Prop_Data, "m_takedamage", 1, 1);
	SetEntProp(client, Prop_Send, "movetype", 8, 1);
}