local UseContainerItem
local GetContainerItemID
local GetContainerNumSlots
local NUM_BAG_SLOTS

if C_Container then
	NUM_BAG_SLOTS = NUM_BAG_FRAMES
	UseContainerItem = C_Container.UseContainerItem
	GetContainerItemID = C_Container.GetContainerItemID
	GetContainerNumSlots = C_Container.GetContainerNumSlots
else
	NUM_BAG_SLOTS = NUM_BAG_SLOTS
	UseContainerItem = UseContainerItem
	GetContainerItemID = GetContainerItemID
	GetContainerNumSlots = GetContainerNumSlots
end

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_ChallengesUI" then
		return
	end
	
	if ChallengesKeystoneFrame then
		local Frame = ChallengesKeystoneFrame
		Frame:HookScript("OnShow", function()
			local ID, ClassID, SubClassID
			
			for bag = 0, NUM_BAG_SLOTS do
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
		end)
		
		if not Frame:IsMovable() then
			Frame:SetMovable(true)
			Frame:SetClampedToScreen(true)
			Frame:RegisterForDrag("LeftButton")
			Frame:SetScript("OnDragStart", Frame.StartMoving)
			Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
		end
		
		self:UnregisterEvent(event)
	end
end)