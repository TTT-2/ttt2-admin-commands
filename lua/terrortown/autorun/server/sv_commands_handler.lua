util.AddNetworkString("ttt2_admin_commands_initialized_cvar")
util.AddNetworkString("ttt2_admin_commands_updated_cvar")
util.AddNetworkString("ttt2_admin_commands_update_cvar")

admincmds = admincmds or {}

function admincmds.AddServerCVar(name)
	net.Start("ttt2_admin_commands_initialized_cvar")
	net.WriteString(name)
	net.WriteString(GetConVar(name):GetDefault())
	net.WriteString(GetConVar(name):GetString())
	net.Broadcast()

	cvars.AddChangeCallback(name, function(cvar, old, new)
		net.Start("ttt2_admin_commands_updated_cvar")
		net.WriteString(name)
		net.WriteString(new)
		net.Broadcast()
	end)
end

net.Receive("ttt2_admin_commands_update_cvar", function()
	RunConsoleCommand(net.ReadString(), net.ReadString())
end)

hook.Add("Initialize", "register_convars", function()
	admincmds.AddServerCVar("bot_zombie")
end)
