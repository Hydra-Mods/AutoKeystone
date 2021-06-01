local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			local Frame = ChallengesKeystoneFrame
			local ID

			Frame:HookScript("OnShow", function()
				for Bag = 0, NUM_BAG_SLOTS do
					for Slot = 1, GetContainerNumSlots(Bag) do
						ID = GetContainerItemID(Bag, Slot)

						if (ID and ID == 180653) then
							return UseContainerItem(Bag, Slot)
						end
					end
				end
			end)

			if (not Frame:IsMovable()) then
				Frame:SetMovable(true)
				Frame:RegisterForDrag("LeftButton")
				Frame:SetClampedToScreen(true)
				Frame:SetScript("OnDragStart", Frame.StartMoving)
				Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
			end

			self:UnregisterEvent(event)
		end
	end
end)