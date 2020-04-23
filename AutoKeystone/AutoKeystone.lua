local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemID = GetContainerItemID
local UseContainerItem = UseContainerItem

local OnShow = function(self)
	local ID
	
	for Bag = 0, 4 do
		for Slot = 1, GetContainerNumSlots(Bag) do
			ID = GetContainerItemID(Bag, Slot)
			
			if (ID and ID == 158923) then
				UseContainerItem(Bag, Slot)
				
				break
			end
		end
	end
end

local AutoKeystone = CreateFrame("Frame")
AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", OnShow)
			
			self:UnregisterEvent(event)
		end
	end
end)