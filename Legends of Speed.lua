local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Scamming Hub - Legend of Speed", HidePremium = false, SaveConfig = true, ConfigFolder = "Scamming Hub - Legend of Speed"})

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

local Pets = Window:MakeTab({
	Name = "Pets",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Crystals = Window:MakeTab({
	Name = "Crystals",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local XpFarmEnabled = false
local ohString1 = "collectOrb"
local ohString2 = "Yellow Orb"
local ohString3 = "City"

Farm:AddToggle({ 
    Name = "Farm EXP", 
    Default = false,
    Callback = function(Value)
        autoSwingEnabled = Value

        if autoSwingEnabled then
            spawn(function()
                while autoSwingEnabled do
                    for i = 1, 100 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})

local OPXpFarmEnabled = false
local ohString1 = "collectOrb"
local ohString2 = "Yellow Orb"
local ohString3 = "City"

Farm:AddToggle({ 
    Name = "Farm EXP (STRONGER)", 
    Default = false,
    Callback = function(Value)
        autoSwingEnabled = Value

        if autoSwingEnabled then
            spawn(function()
                while autoSwingEnabled do
                    for i = 1, 200 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})

local GemFarmEnabled = false
local ohString1 = "collectOrb"
local ohString2 = "Infernal Gem"
local ohString3 = "City"

Farm:AddToggle({ 
    Name = "Farm Gems", 
    Default = false,
    Callback = function(Value)
        GemFarmEnabled = Value

        if GemFarmEnabled then
            spawn(function()
                while GemFarmEnabled do
                    for i = 1, 100 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})

local OPGemFarmEnabled = false
local ohString1 = "collectOrb"
local ohString2 = "Infernal Gem"
local ohString3 = "City"

Farm:AddToggle({ 
    Name = "Farm Gems (STRONGER)", 
    Default = false,
    Callback = function(Value)
        GemFarmEnabled = Value

        if OPGemFarmEnabled then
            spawn(function()
                while OPGemFarmEnabled do
                    for i = 1, 200 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})

local StepFarmEnabled = false
local ohString1 = "collectOrb"
local ohString2 = "Ethereal Orb"
local ohString3 = "City"

Farm:AddToggle({ 
    Name = "Farm Steps", 
    Default = false,
    Callback = function(Value)
        StepFarmEnabled = Value

        if StepFarmEnabled then
            spawn(function()
                while StepFarmEnabled do
                    for i = 1, 100 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})

Farm:AddToggle({ 
    Name = "Farm Steps", 
    Default = false,
    Callback = function(Value)
        StepFarmEnabled = Value

        if StepFarmEnabled then
            spawn(function()
                while StepFarmEnabled do
                    for i = 1, 100 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})

Farm:AddToggle({ 
    Name = "Farm Steps (STRONGER)", 
    Default = false,
    Callback = function(Value)
        StepFarmEnabled = Value

        if StepFarmEnabled then
            spawn(function()
                while StepFarmEnabled do
                    for i = 1, 200 do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(ohString1, ohString2, ohString3)
                    end
                    
                    wait(0.1)
                end
            end)
        end
    end    
})
local GemFarmEnabled = false
local ohString1 = "collectOrb"
local ohString2 = "Infernal Gem"
local ohString3 = "City"

local AutoRebirthEnabled = false
local ohString1 = "rebirthRequest"

Farm:AddToggle({
    Name = "Auto Rebirth",
    Default = false,
    Callback = function(Value)
        AutoRebirthEnabled = Value
        if AutoRebirthEnabled then
            while AutoRebirthEnabled do
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(ohString1)
                wait(0.1)
            end
        end
    end    
})

local petNames = {
    "Red Bunny",
    "Red Kitty",
    "Green Vampy",
    "Blue Bunny",
    "Dark Golem",
    "Silver Dog",
    "Pink Butterfly",
    "Purple Pegasus",
    "Yellow Squeak",
    "Yellow Butterfly",
    "Green Golem",
    "Golden Angel",
    "Orange Pegasus",
    "Divine Pegasus",
    "Golden Phoenix",
    "Orange Falcon",
    "Green Firecaster",
    "Blue Firecaster",
    "White Phoenix",
    "Red Phoenix",
    "Golden Viking",
    "Speedy Sensei",
    "Maestro Dog",
    "Red Firecaster",
    "Flaming Hedgehog",
    "Soul Fusion Dog",
    "Hypersonic Pegasus",
    "Dark Soul Birdie",
    "Eternal Nebula Dragon",
    "Shadow Edge Kitty",
    "Ultimate Overdrive Bunny"
}

local crystalNames = {
    "Red Crystal",
    "Blue Crystal",
    "Purple Crystal",
    "Lightning Crystal",
    "Snow Crystal",
    "Lava Crystal",
    "Inferno Crystal",
    "Electro Legends Crystal",
    "Jungle Crystal"
}

local selectedPet = ""
local selectedCrystal = ""

local autoDupe = false
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
        print("Buy Crystal button pressed for: " .. selectedCrystal)
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

Pets:AddDropdown({
    Name = "Dropdown",
    Default = "Pick the pet you wish to dupe",
    Options = petNames,
    Callback = function(Value)
        selectedPet = Value
        print("Selected pet: " .. selectedPet)
    end    
})

Pets:AddButton({
    Name = "Dupe Pet",
    Callback = function()
        if selectedPet == "" then
            print("No pet selected!")
            return
        end

        local ohInstance1 = game:GetService("ReplicatedStorage").cPetShopFolder[selectedPet]
        
        if ohInstance1 then
            game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(ohInstance1)
            print("Dupe Pet button pressed for: " .. selectedPet)
        else
            print("Pet not found in Pet Shop folder.")
        end
    end    
})

Pets:AddToggle({
    Name = "Mass Dupe",
    Default = false,
    Callback = function(Value)
        autoDupe = Value
        if autoDupe then
            print("Mass dupe enabled for: " .. selectedPet)
            while autoDupe do
                if selectedPet ~= "" then
                    local ohInstance1 = game:GetService("ReplicatedStorage").cPetShopFolder[selectedPet]
                    if ohInstance1 then
                        game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(ohInstance1)
                        print("Mass duping pet: " .. selectedPet)
                    end
                end
                wait(0.1)
            end
        else
            print("Mass dupe disabled.")
        end
    end    
})

Misc:AddButton({
	Name = "Get Chaos Strengh Quest!",
	Callback = function()
        local ohString1 = "createNewStoryQuest"
        local ohInstance2 = game:GetService("ReplicatedStorage").Quests["Story Quests"]["Chaos Strength"].Quests["1"]

        game:GetService("ReplicatedStorage").rEvents.questsEvent:FireServer(ohString1, ohInstance2)
    end    
})

Misc:AddButton({
	Name = "Get Swift Hopper Quest!",
	Callback = function()
    local ohString1 = "createNewStoryQuest"
    local ohInstance2 = game:GetService("ReplicatedStorage").Quests["Story Quests"]["Swift Hopper"].Quests["1"]

    game:GetService("ReplicatedStorage").rEvents.questsEvent:FireServer(ohString1, ohInstance2)
    end    
})

Misc:AddButton({
	Name = "Claim All codes",
	Callback = function()
        local codes = {
            "speedchampion000",
            "racer300",
            "SPRINT250",
            "hyper250",
            "legends500",
            "sparkles300",
            "Launch200",
            "jungleracer5000",
            "junglesecrets7500",
            "speedchampion0"
        }
        
        -- Loop through the codes and invoke the server for each one
        for _, code in ipairs(codes) do
            game:GetService("ReplicatedStorage").rEvents.codeRemote:InvokeServer(code)
        end        
    end    
})

Misc:AddButton({
	Name = "Claim All Free Gifts",
	Callback = function()
        local ohString1 = "claimGift"

        for ohNumber2 = 1, 7 do
            game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(ohString1, ohNumber2)
        end        
    end    
})

OrionLib:Init()
