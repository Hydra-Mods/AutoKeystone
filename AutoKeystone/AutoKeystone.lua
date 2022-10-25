local OnShow = function()
	local ID, ClassID, SubClassID

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			ID = C_Container.GetContainerItemID(bag, slot)

			if ID then
				ClassID, SubClassID = select(12, GetItemInfo(ID))

				if (ClassID == 5 and SubClassID == 1) or (ID == 180653) then
					return C_Container.UseContainerItem(bag, slot)
				end
			end
		end
	end
end

local OnEvent = function(self, event, addon)
	if (addon ~= "Blizzard_ChallengesUI") then
		return
	end

	if ChallengesKeystoneFrame then
		local Frame = ChallengesKeystoneFrame

		Frame:HookScript("OnShow", OnShow)

		if (not Frame:IsMovable()) then
			Frame:SetMovable(true)
			Frame:SetClampedToScreen(true)
			Frame:RegisterForDrag("LeftButton")
			Frame:SetScript("OnDragStart", Frame.StartMoving)
			Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
		end

		self:UnregisterEvent(event)
	end
end

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", OnEvent)