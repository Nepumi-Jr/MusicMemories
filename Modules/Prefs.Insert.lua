local RowOptions = LoadModule("Utils.GetModules.Class.lua")("RowOption")
local files = FILEMAN:GetDirListing(getThemeDir().."/Modules/",false,false)

return function()
    for i,v in pairs(RowOptions) do
		local thisData = LoadModule("RowOption."..v..".lua")()
        _G[v] = function()
            return {
				Name = thisData.Name,
				LayoutType = thisData.LayoutType,
				SelectType = thisData.SelectType,
				OneChoiceForAllPlayers = thisData.OneChoiceForAllPlayers,
				ExportOnChange = thisData.ExportOnChange,
				Choices = thisData.Choices,
				Values = thisData.Values or thisData.Choices,
				LoadSelections = function(self, list, pn)
					thisData.LoadSelections(self, list, pn)
					return
				end,
				NotifyOfSelection= function(self, list, pn)
                    if thisData.NotifyOfSelection then
					    thisData.NotifyOfSelection(self, list, pn)
                    end
					return
				end,
				SaveSelections = function(self, list, pn)
					thisData.SaveSelections(self, list, pn)
					return
				end,
				Reload = function() return "ReloadChanged_All" end,
				ReloadRowMessages= {v}
			}
		end
	end
end