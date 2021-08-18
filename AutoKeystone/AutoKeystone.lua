local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_ChallengesUI" then
		if ChallengesKeystoneFrame then
			local F = ChallengesKeystoneFrame
			local ID

			F:HookScript("OnShow", function()
				for Bag = 0, NUM_BAG_SLOTS do
					for Slot = 1, GetContainerNumSlots(Bag) do
						ID = GetContainerItemID(Bag, Slot)

						if ID and ID == 180653 then
							return UseContainerItem(Bag, Slot)
						end
					end
				end
			end)

			if not F:IsMovable() then
				F:SetMovable(true)
				F:RegisterForDrag("LeftButton")
				F:SetClampedToScreen(true)
				F:SetScript("OnDragStart", F.StartMoving)
				F:SetScript("OnDragStop", F.StopMovingOrSizing)
			end

			self:UnregisterEvent(event)
		end
	end
end)