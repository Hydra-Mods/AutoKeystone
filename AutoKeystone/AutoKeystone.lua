local AutoKeystone = CreateFrame("Frame")

local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemID = GetContainerItemID

function AutoKeystone:OnEvent(event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", function()
				for Bag = 0, NUM_BAG_SLOTS do
					for Slot = 1, GetContainerNumSlots(Bag) do
						local ID = GetContainerItemID(Bag, Slot)
						
						if (ID and ID == 158923) then
							return UseContainerItem(Bag, Slot)
						end
					end
				end
			end)
			
			self:UnregisterEvent(event)
		end
	end
end

AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", AutoKeystone.OnEvent)