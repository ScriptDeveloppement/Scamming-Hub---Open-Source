local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Scamming Hub - Ninja Legends", HidePremium = false, SaveConfig = true, ConfigFolder = "Scamming Hub - Ninja Legends"})

local Farm = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Misc = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Crystals = Window:MakeTab({
    Name = "Crystal",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


autoRep = false

Farm:AddToggle({
    Name = "Auto Rep (Equip ur tool)",
    Default = false,
    Callback = function(Value)
        autoRep = Value
        
        while autoRep do
                    local ohString1 = "rep"

                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer(ohString1)
            
            wait(0)
        end
    end
})

local originalAttackTime = 0.35

Farm:AddToggle({
    Name = "Fast Punch (Unequip punch and enable)",
    Default = false,
    Callback = function(Value)
        local player = game:GetService("Players").LocalPlayer
        local punch = player.Backpack:FindFirstChild("Punch")
        
        if punch then
            local attackTimeValue = punch:FindFirstChild("attackTime")
            if attackTimeValue then
                if Value then
                    attackTimeValue.Value = 0
                else
                    attackTimeValue.Value = originalAttackTime
                end
            end
        end
    end    
})


Misc:AddButton({
	Name = "Claim All Free Gifts",
	Callback = function()
        local ohString1 = "claimGift"

        for ohNumber2 = 1, 8 do
        game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(ohString1, ohNumber2)
  	end   
    end 
})

local Chests = {
    "Golden Chest",
    "Enchanted Chest",
    "Mythical Chest",
    "Magma Chest",
    "Legends Chest",
    "Jungle Chest"
}

Misc:AddButton({
    Name = "Claim All Chests",
    Callback = function()
        for _, chestName in ipairs(Chests) do
            game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(chestName)
        end
    end    
})

Misc:AddButton({
	Name = "Roll Fortune",
	Callback = function()
        local ohString1 = "openFortuneWheel"
        local ohInstance2 = game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"]

        game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer(ohString1, ohInstance2)
    end    
})

local sizeValue = 4  -- Default size value (you can set it dynamically based on the slider)
local speedValue = 4  -- Default speed value (you can set it dynamically based on the slider)

-- Apply Size Button
Misc:AddButton({
    Name = "Apply Size",
    Callback = function()
        local ohString1 = "changeSize"
        local ohNumber2 = sizeValue  -- Use the current sizeValue
        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer(ohString1, ohNumber2)
    end    
})

local sizeValue = 4
local speedValue = 4

Misc:AddButton({
    Name = "Apply Size",
    Callback = function()
        local ohString1 = "changeSize"
        local ohNumber2 = sizeValue
        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer(ohString1, ohNumber2)
    end    
})

Misc:AddSlider({
    Name = "Character Size",
    Min = 1,
    Max = 100,
    Default = 4,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Size",
    Callback = function(Value)
        sizeValue = Value
    end    
})

Misc:AddButton({
    Name = "Apply Speed",
    Callback = function()
        local ohString1 = "changeSpeed"
        local ohNumber2 = speedValue
        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer(ohString1, ohNumber2)
    end    
})

Misc:AddSlider({
    Name = "Character Speed",
    Min = 14,
    Max = 500,
    Default = 500,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        speedValue = Value
    end    
})

local crystalNames = {
    "Blue Crystal",
    "Frost Crystal",
    "Mythical Crystal",
    "Inferno Crystal",
    "Legends Crystal",
    "Muscle Elite Crystal",
    "Galaxy Oracle Crystal",
    "Jungle Crystal"
}

local autoBuyCrystal = false

Crystals:AddDropdown({
    Name = "Dropdown",
    Default = "Pick the Crystal you wish to buy",
    Options = crystalNames,
    Callback = function(Value)
        selectedCrystal = Value
        print("Selected crystal: " .. selectedCrystal)
    end    
})

Crystals:AddButton({
    Name = "Buy Crystal",
    Callback = function()
        if selectedCrystal == "" then
            print("No crystal selected!")
            return
        end
        local ohString1 = "openCrystal"
        local ohString2 = selectedCrystal

        game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(ohString1, ohString2)
    end    
})

Crystals:AddToggle({
    Name = "Mass Buy Crystal",
    Default = false,
    Callback = function(Value)
        autoBuyCrystal = Value
        if autoBuyCrystal then
            print("Mass buy enabled for: " .. selectedCrystal)
            while autoBuyCrystal do
                if selectedCrystal ~= "" then
                    local ohString1 = "openCrystal"
                    local ohString2 = selectedCrystal
                    game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(ohString1, ohString2)

                    print("Mass buying crystal: " .. selectedCrystal)
                end
                wait(0.1)
            end
        else
            print("Mass buy disabled.")
        end
    end    
})

OrionLib:Init()
