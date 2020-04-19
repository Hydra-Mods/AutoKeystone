local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemLink = GetContainerItemLink
local UseContainerItem = UseContainerItem

local GetKeystoneBagSlot = function()
	local KeystoneBag
	local KeystoneSlot
	
	for Bag = 0, 4 do
		for Slot = 1, GetContainerNumSlots(Bag) do
			local Link = GetContainerItemLink(Bag, Slot)
			
			if Link then
				if strfind(Link, "Keystone") then
					KeystoneBag = Bag
					KeystoneSlot = Slot
					
					break
				end
			end
		end
	end
	
	return KeystoneBag, KeystoneSlot
end

local KeyInput = CreateFrame("Frame")
KeyInput:RegisterEvent("ADDON_LOADED")
KeyInput:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", function(self)
				local Bag, Slot = GetKeystoneBagSlot()
				
				if (Bag and Slot) then
					UseContainerItem(Bag, Slot)
				end
			end)
		end
		
		self:UnregisterEvent(event)
	end
end)