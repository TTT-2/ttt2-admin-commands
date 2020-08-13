local materialIcon = Material("vgui/ttt/vskin/helpscreen/addons")

local function PopulateBotsPanel(parent)
	local form = CreateForm(parent, "header_bots")

	form:MakeCheckBox({
		label = "label_bot_zombie_enable",
		initial = admincmds.GetValue("bot_zombie"),
		OnChange = function(_, value)
			admincmds.SetValue("bot_zombie", value == true and 1 or 0)
		end,
		default = admincmds.GetDefaultValue("bot_zombie")
	})
end

hook.Add("TTT2ModifyMainMenu", "ttt2_admin_commands", function(helpData)
	local menuEntry = helpData:RegisterSubMenu("menu_admin_commands")

	menuEntry:SetTitle("menu_admin_commands_title")
	menuEntry:SetDescription("menu_admin_commands_description")
	menuEntry:SetIcon(materialIcon)

	menuEntry:AdminOnly(true)
end)

hook.Add("TTT2ModifySubMenu", "ttt2_admin_commands_sub", function(helpData, id)
	local subMenuBots = helpData:PopulateSubMenu(id .. "_bots")

	subMenuBots:SetTitle("submenu_admin_commands_bots_title")
	subMenuBots:PopulatePanel(PopulateBotsPanel)
end)
