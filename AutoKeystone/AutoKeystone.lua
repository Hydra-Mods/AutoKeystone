local OnShow = function()
	for Bag = 0, NUM_BAG_SLOTS do
		for Slot = 1, GetContainerNumSlots(Bag) do
			local ID = GetContainerItemID(Bag, Slot)
			
			if (ID and ID == 180653) then
				return UseContainerItem(Bag, Slot)
			end
		end
	end
end

local OnEvent = function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", OnShow)
			
			self:UnregisterEvent(event)
		end
	end
end

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", OnEvent)