util.AddNetworkString("ttt2_admin_commands_initialized_cvar")
util.AddNetworkString("ttt2_admin_commands_updated_cvar")
util.AddNetworkString("ttt2_admin_commands_update_cvar")

admincmds = admincmds or {}

function admincmds.AddServerCVar(name, ply)
	net.Start("ttt2_admin_commands_initialized_cvar")
	net.WriteString(name)
	net.WriteString(GetConVar(name):GetDefault())
	net.WriteString(GetConVar(name):GetString())
	net.Send(ply)

	cvars.AddChangeCallback(name, function(cvar, old, new)
		if not IsValid(ply) then return end

		net.Start("ttt2_admin_commands_updated_cvar")
		net.WriteString(name)
		net.WriteString(new)
		net.Send(ply)
	end)
end

net.Receive("ttt2_admin_commands_update_cvar", function()
	RunConsoleCommand(net.ReadString(), net.ReadString())
end)

hook.Add("TTT2PlayerReady", "register_convars", function(ply)
	admincmds.AddServerCVar("bot_zombie", ply)
end)
