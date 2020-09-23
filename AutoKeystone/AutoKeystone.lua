local AutoKeystone = CreateFrame("Frame")
AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", function()
				for Bag = 0, NUM_BAG_SLOTS do
					for Slot = 1, GetContainerNumSlots(Bag) do
						local ID = GetContainerItemID(Bag, Slot)
						
						if (ID and (ID == 158923 or ID == 151086)) then
							return UseContainerItem(Bag, Slot)
						end
					end
				end
			end)
			
			self:UnregisterEvent(event)
		end
	end
end)