local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "Blizzard_ChallengesUI") then return end

	if ChallengesKeystoneFrame then
		local Frame = ChallengesKeystoneFrame
		Frame:HookScript("OnShow", function()
			local ID

			for bag = 0, NUM_BAG_SLOTS do
				for slot = 1, GetContainerNumSlots(bag) do
					ID = GetContainerItemID(bag, slot)

					if ID then
						local Type, SubType = select(6, GetItemInfo(ID))

						if (Type == "Reagent" and SubType == "Keystone") then
							return UseContainerItem(bag, slot)
						end
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
end)