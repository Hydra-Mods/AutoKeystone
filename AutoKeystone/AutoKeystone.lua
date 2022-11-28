local IDs = {[138019] = true, [151086] = true, [158923] = true, [180653] = true}
local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "Blizzard_ChallengesUI") then return end
	if ChallengesKeystoneFrame then
		local Frame = ChallengesKeystoneFrame
		Frame:HookScript("OnShow", function()
			local ID, Class, SubClass
			for bag = 0, NUM_BAG_FRAMES do
				for slot = 1, C_Container.GetContainerNumSlots(bag) do
					ID = C_Container.GetContainerItemID(bag, slot)
					if ID then
						Class, SubClass = select(12, GetItemInfo(ID))
						if (Class == 5 and SubClass == 1) or IDs[ID] then
							return C_Container.UseContainerItem(bag, slot)
						end
					end
				end
			end
		end)
		if (not Frame:IsMovable()) then
			Frame:SetMovable(true)
			Frame:SetClampedToScreen(true)
			Frame:RegisterForDrag("LeftButton")
			Frame:SetScript("OnDragStart", Frame.StartMoving)
			Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
		end
		self:UnregisterEvent(event)
	end
end)