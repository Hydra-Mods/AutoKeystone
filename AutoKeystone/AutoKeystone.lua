local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", function()
				for Bag = 0, NUM_BAG_SLOTS do
					for Slot = 1, GetContainerNumSlots(Bag) do
						local ID = GetContainerItemID(Bag, Slot)

						if (ID and ID == 180653) then
							return UseContainerItem(Bag, Slot)
						end
					end
				end
			end)

			if (not ChallengesKeystoneFrame:IsMovable()) then
				ChallengesKeystoneFrame:SetMovable(true)
				ChallengesKeystoneFrame:RegisterForDrag("LeftButton")
				ChallengesKeystoneFrame:SetClampedToScreen(true)
				ChallengesKeystoneFrame:SetScript("OnDragStart", ChallengesKeystoneFrame.StartMoving)
				ChallengesKeystoneFrame:SetScript("OnDragStop", ChallengesKeystoneFrame.StopMovingOrSizing)
			end

			self:UnregisterEvent(event)
		end
	end
end)