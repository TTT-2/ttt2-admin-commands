admincmds = admincmds or {}

admincmds.cvars = admincmds.cvars or {}

function admincmds.GetValue(name)
	return admincmds.cvars[name].value
end

function admincmds.GetDefaultValue(name)
	return admincmds.cvars[name].default
end

function admincmds.SetValue(name, value)
	net.Start("ttt2_admin_commands_update_cvar")
	net.WriteString(name)
	net.WriteString(tostring(value))
	net.SendToServer()
end

net.Receive("ttt2_admin_commands_initialized_cvar", function()
	admincmds.cvars[net.ReadString()] = {
		default = net.ReadString(),
		value = net.ReadString()
	}
end)

net.Receive("ttt2_admin_commands_updated_cvar", function()
	admincmds.cvars[net.ReadString()].value = net.ReadString()
end)
