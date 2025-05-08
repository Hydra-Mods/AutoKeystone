local ReagentClass, KeystoneClass = Enum.ItemClass.Reagent, Enum.ItemReagentSubclass.Keystone
local GetContainerItemID, GetContainerNumSlots, GetItemInfo = C_Container.GetContainerItemID, C_Container.GetContainerNumSlots, C_Item.GetItemInfo
local select = select

local SlotKeystone = function()
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local ID = GetContainerItemID(bag, slot)

			if ID then
				local Class, SubClass = select(12, GetItemInfo(ID))

				if Class == ReagentClass and SubClass == KeystoneClass then
					C_Container.PickupContainerItem(bag, slot)

					if C_Cursor.GetCursorItem() then
						C_ChallengeMode.SlotKeystone()
						return true
					end
				end
			end
		end
	end

	return false
end

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_ChallengesUI" then return end

	local Frame = ChallengesKeystoneFrame

	if not Frame then return end

	Frame:HookScript("OnShow", SlotKeystone)

	if not Frame:IsMovable() then
		Frame:SetMovable(true)
		Frame:SetClampedToScreen(true)
		Frame:RegisterForDrag("LeftButton")
		Frame:SetScript("OnDragStart", Frame.StartMoving)
		Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
	end

	self:UnregisterEvent(event)
end)

SLASH_AUTOKEYSTONE1 = "/ak"
SLASH_AUTOKEYSTONE2 = "/aks"
SlashCmdList["AUTOKEYSTONE"] = function()
	SlotKeystone()
end