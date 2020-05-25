local AutoKeystone = CreateFrame("Frame")
AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", function()
				for Bag = 0, 4 do
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
end)