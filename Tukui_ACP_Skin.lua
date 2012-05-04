if IsAddOnLoaded("ElvUI") then return end
local T, C, L = unpack(Tukui)

local function cbResize(self, event, ...)
    for i=1,20,1 do
        local checkbox = _G["ACP_AddonListEntry" .. i .. "Enabled"]
        local collapse = _G["ACP_AddonListEntry" .. i .. "Collapse"]
        local security = _G["ACP_AddonListEntry" .. i .. "Security"]
        local curr_category = ""

            if curr_category == "" then
                checkbox:SetPoint("LEFT", 5, 0)
                    if collapse:IsShown() then
                        checkbox:SetWidth(26)
                        checkbox:SetHeight(26)
                    else
                        checkbox:SetPoint("LEFT", 15, 0)
                        checkbox:SetWidth(16)
                        checkbox:SetHeight(16)
                    end
            end
                    if security:IsShown() then
                        checkbox:SetPoint("LEFT", 5, 0)
                        checkbox:SetWidth(26)
                        checkbox:SetHeight(26)
                    end
   end
end 

local SkinACP = CreateFrame("Frame")
	SkinACP:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkinACP:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	if not IsAddOnLoaded("ACP") then return end
	
	local StripAllTextures = {
                "ACP_AddonList",
                "ACP_AddonList_ScrollFrame",
				}
				
	local SetTemplateD = { -- Default Texture
                "ACP_AddonList_ScrollFrame",
				}

	local SetTemplateT = {-- Transparent Texture
                "ACP_AddonList",
				}	
	
	local buttons = {
                "ACP_AddonListSetButton",
                "ACP_AddonListDisableAll",
                "ACP_AddonListEnableAll",
                "ACP_AddonList_ReloadUI",
				"ACP_AddonListBottomClose",
				}
				
	for _, object in pairs(StripAllTextures) do
				_G[object]:StripTextures()
	end	

	for _, object in pairs(SetTemplateD) do
				_G[object]:SetTemplate("Default")
	end	

	for _, object in pairs(SetTemplateT) do
				_G[object]:SetTemplate("Transparent")
	end			
		
-- Skin Buttons
	for _, button in pairs(buttons) do
		T.SkinButton(_G[button])
	end	
	for i = 1, 20 do
		T.SkinButton(_G["ACP_AddonListEntry"..i.."LoadNow"])
	end	
	
-- Skin the Close Button
	T.SkinCloseButton(ACP_AddonListCloseButton)

-- Resize Check Boxes
	for i=1,20,1 do
		local ACP_OnLoad = _G["ACP_AddonList"]
		ACP_OnLoad:SetScript("OnUpdate", cbResize)
	end

-- Skin Check Boxes
	for i = 1, 20 do
			T.SkinCheckBox(_G["ACP_AddonListEntry"..i.."Enabled"])
	end
			T.SkinCheckBox(ACP_AddonList_NoRecurse)

-- Skin Scrollbar
	T.SkinScrollBar(ACP_AddonList_ScrollFrameScrollBar)

-- Skin Dropdown box
	T.SkinDropDownBox(ACP_AddonListSortDropDown, 130)

-- Set Positons and sizes of some frames 
-- Updated to Elv's way.  It looks better IMO!
	ACP_AddonList_ScrollFrame:SetWidth(590)
	ACP_AddonList_ScrollFrame:SetHeight(412)
	ACP_AddonList:SetHeight(502)
	ACP_AddonListEntry1:Point("TOPLEFT", ACP_AddonList, "TOPLEFT", 47, -62)
	ACP_AddonList_ScrollFrame:Point("TOPLEFT", ACP_AddonList, "TOPLEFT", 20, -53)
	ACP_AddonListCloseButton:Point("TOPRIGHT", ACP_AddonList, "TOPRIGHT", 4, 5)
	ACP_AddonListSetButton:Point("BOTTOMLEFT", ACP_AddonList, "BOTTOMLEFT", 20, 8)
	ACP_AddonListSetButton:SetHeight(25)
	ACP_AddonListDisableAll:Point("BOTTOMLEFT", ACP_AddonList, "BOTTOMLEFT", 90, 8)
	ACP_AddonListDisableAll:SetHeight(25)
	ACP_AddonListEnableAll:Point("BOTTOMLEFT", ACP_AddonList, "BOTTOMLEFT", 175, 8)
	ACP_AddonListEnableAll:SetHeight(25)
	ACP_AddonList_ReloadUI:Point("BOTTOMRIGHT", ACP_AddonList, "BOTTOMRIGHT", -160, 8)
	ACP_AddonListBottomClose:Point("BOTTOMRIGHT", ACP_AddonList, "BOTTOMRIGHT", -50, 8)
	ACP_AddonListBottomClose:SetHeight(25)
	ACP_AddonList:SetParent(UIParent)
 end)