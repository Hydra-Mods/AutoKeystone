local OnShow = function()
	local ID

	for b = 0, NUM_BAG_SLOTS do
		for s = 1, GetContainerNumSlots(b) do
			ID = GetContainerItemID(b, s)

			if ID and ID == 180653 then
				return UseContainerItem(b, s)
			end
		end
	end
end

local OnEvent = function(self, event, addon)
	if addon ~= "Blizzard_ChallengesUI" then
		return
	end

	if ChallengesKeystoneFrame then
		local Frame = ChallengesKeystoneFrame
		Frame:HookScript("OnShow", OnShow)

		if not Frame:IsMovable() then
			Frame:SetMovable(true)
			Frame:RegisterForDrag("LeftButton")
			Frame:SetClampedToScreen(true)
			Frame:SetScript("OnDragStart", Frame.StartMoving)
			Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
		end

		self:UnregisterEvent(event)
	end
end

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", OnEvent)