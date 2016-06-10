#pragma semicolon 1
#include <SteamWorks>
#pragma newdecls required

#define CSGO_APPID 730

public Plugin myinfo =
{
    author = "Hejter",
    name = "Steam checker",
    version = "0.01",
};

public void OnPluginStart()
{
    RegAdminCmd("sm_steamchecker", Cmd_SteamChecker, ADMFLAG_ROOT);
}

public Action Cmd_SteamChecker(int client, int args)
{
    for (int i = 1; i <= MaxClients; i++)
    {
        if (IsClientInGame(i) && !IsFakeClient(i))
        {
            switch (SteamWorks_HasLicenseForApp(i, CSGO_APPID))
            {
                case k_EUserHasLicenseResultHasLicense: // HasLicense [Игрок имеет steam]
                {
                    PrintToConsole(client, "Steam = %N", i);
                }
               
                case k_EUserHasLicenseResultDoesNotHaveLicense: // DoesNotHaveLicense [Игрок имеет nosteam]
                {
                    PrintToConsole(client, "Non-Steam = %N", i);
                }
               
                case k_EUserHasLicenseResultNoAuth: // NoAuth [Игрок не авторизовался]
                {
                    PrintToConsole(client, "No auth = %N", i);
                }
            }
        }
    }
    return Plugin_Handled;
}
