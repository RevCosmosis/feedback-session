#include <sourcemod>

public Plugin:myinfo = {
	name = "Feedback Session",
	author = "Idolon",
	description = "Enables Godmode/Noclip for everyone indefinitely",
	version = "1.0",
	url = "https://github.com/RevCosmosis/feedback-session"
};

public OnPluginStart () {
	RegAdminCmd("sm_fs_on", Fs_On, ADMFLAG_CHANGEMAP);
	RegAdminCmd("sm_fs_off", Fs_Off, ADMFLAG_CHANGEMAP);

	HookEvent("player_spawn", ClientSpawn);
	HookEvent("player_class", ClientSpawn);
	
	sm_fs_enabled = CreateConVar("sm_fs_enabled", "0", "Is a feedback session enabled?");
}

public Action:Fs_On () {
	for (new i = 1; i <= GetClientCount(true); i++) {
		EnableClient(i);
	}

	PrintChatAll("Feedback session enabled.");

	return Plugin_Handled;
}

public Action:Fs_Off () {
	for (new i = 1; i <= GetClientCount(true); i++) {
		DisableClient(i);
	}

	PrintChatAll("Feedback session disabled.");

	return Plugin_Handled;
}

ClientSpawn (Handle:event, const String:name[], bool:dontBroadcast) {
	if (GetConVarInt(sm_fs_enabled)) {
		new id = GetEventInt(event, "userid");
		new client = GetClientOfUserId(id);

		EnableClient(client);
	}
}

EnableClient (client) {
	SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
	SetEntProp(client, Prop_Send, "movetype", 2, 1);
}

DisableClient (client) {
	SetEntProp(client, Prop_Data, "m_takedamage", 1, 1);
	SetEntProp(client, Prop_Send, "movetype", 8, 1);
}