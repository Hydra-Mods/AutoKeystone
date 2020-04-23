local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemID = GetContainerItemID
local UseContainerItem = UseContainerItem

local GetKeystoneBagSlot = function()
	local KeystoneBag
	local KeystoneSlot
	
	for Bag = 0, 4 do
		for Slot = 1, GetContainerNumSlots(Bag) do
			local ID = GetContainerItemID(Bag, Slot)
			
			if (ID and ID == 158923) then
				KeystoneBag = Bag
				KeystoneSlot = Slot
				
				break
			end
		end
	end
	
	return KeystoneBag, KeystoneSlot
end

local OnShow = function(self)
	local Bag, Slot = GetKeystoneBagSlot()
	
	if (Bag and Slot) then
		UseContainerItem(Bag, Slot)
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