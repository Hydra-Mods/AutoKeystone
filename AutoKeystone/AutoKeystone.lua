local ReagentClass = Enum.ItemClass.Reagent
local KeystoneClass = Enum.ItemClass.Keystone

local GetContainerItemID = C_Container.GetContainerItemID
local GetContainerNumSlots = C_Container.GetContainerNumSlots

local OnShow = function()
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local ID = GetContainerItemID(bag, slot)

			if ID then
				local Class, SubClass = select(12, GetItemInfo(ID))

				if (Class == ReagentClass and SubClass == KeystoneClass) then
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

	local Frame = ChallengesKeystoneFrame

	if (not Frame) then
		return
	end

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

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", OnEvent)