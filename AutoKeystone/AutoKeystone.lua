local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemID = GetContainerItemID
local UseContainerItem = UseContainerItem

-- Temporary during DF prepatch
if C_Container and C_Container.GetContainerNumSlots then GetContainerNumSlots = C_Container.GetContainerNumSlots end
if C_Container and C_Container.GetContainerItemID then GetContainerItemID = C_Container.GetContainerItemID end
if C_Container and C_Container.UseContainerItem then UseContainerItem = C_Container.UseContainerItem end

local OnShow = function()
	local ID, ClassID, SubClassID

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			ID = GetContainerItemID(bag, slot)

			if ID then
				ClassID, SubClassID = select(12, GetItemInfo(ID))

				if (ClassID == 5 and SubClassID == 1) or (ID == 180653) then
					return UseContainerItem(bag, slot)
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