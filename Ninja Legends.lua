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

local autoSwingEnabled = false

Farm:AddToggle({ 
    Name = "Auto Swing", 
    Default = false,
    Callback = function(Value)
        autoSwingEnabled = Value

        if autoSwingEnabled then
            spawn(function()
                while autoSwingEnabled do
                    wait(0) 
                    local args = {
                        [1] = "swingKatana"
                    }

                    game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                end
            end)
        end
    end    

})

local position1 = Vector3.new(99, 91246, 111)
local position2 = Vector3.new(76, 91246, 120)
local currentPosition = position1
local teleporting = false

Farm:AddToggle({ 
    Name = "Auto Sell", 
    Default = false,
    Callback = function(Value)
        teleporting = Value
        while teleporting do
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(currentPosition))
            wait(0.1)
            if currentPosition == position1 then
                currentPosition = position2
            else
                currentPosition = position1
            end
        end
    end    
})

local ranks = {
    "Aether Genesis Master Ninja",
    "Ancient Battle Legend",
    "Ancient Battle Master",
    "Apprentice",
    "Assassin",
    "Awakened Scythe Legend",
    "Awakened Scythemaster",
    "Chaos Legend",
    "Chaos Sensei",
    "Comet Strike Lion",
    "Cybernetic Azure Sensei",
    "Cybernetic Electro Legend",
    "Cybernetic Electro Master",
    "Dark Elements Blademaster",
    "Dark Elements Guardian",
    "Dark Sun Samurai Legend",
    "Dragon Evolution Form I",
    "Dragon Evolution Form II",
    "Dragon Evolution Form III",
    "Dragon Evolution Form IV",
    "Dragon Evolution Form V",
    "Dragon Master",
    "Dragon Warrior",
    "Eclipse Series Soul Master",
    "Elemental Legend",
    "Elite Series Master Legend",
    "Eternity Hunter",
    "Evolved Series Master Ninja",
    "Golden Sun Shuriken Legend",
    "Golden Sun Shuriken Master",
    "Grasshopper",
    "Immortal Assassin",
    "Infinity Legend",
    "Infinity Sensei",
    "Infinity Shadows Master",
    "Legendary Shadow Duelist",
    "Legendary Shadowmaster",
    "Lightning Storm Sensei",
    "Master Elemental Hero",
    "Master Legend Assassin",
    "Master Legend Sensei Hunter",
    "Master Legend Zephyr",
    "Master Ninja",
    "Master Of Elements",
    "Master Of Shadows",
    "Master Sensei",
    "Mythic Shadowmaster",
    "Ninja",
    "Ninja Legend",
    "Rising Shadow Eternal Ninja",
    "Rookie",
    "Samurai",
    "Sensei",
    "Shadow",
    "Shadow Chaos Assassin",
    "Shadow Chaos Legend",
    "Shadow Legend",
    "Shadow Storm Sensei",
    "Skyblade Ninja Master",
    "Skystorm Series Samurai Legend",
    "Starstrike Master Sensei",
    "Ultra Genesis Shadow"
}

Farm:AddToggle({
    Name = "Auto Rank",
    Default = false,
    Callback = function(Value)
        if Value then
            spawn(function()
                while true do
                    wait(0.1)
                    
                    for _, rank in ipairs(ranks) do
                        local args = {
                            [1] = "buyRank",
                            [2] = rank
                        }
                        
                        game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    end

                    if not Value then
                        break
                    end
                end
            end)
        end
    end    
})

autoBuyBelt = false

Farm:AddToggle({
    Name = "Auto Buy Belt",
    Default = false,
    Callback = function(Value)
        autoBuyBelt = Value
        
        while autoBuyBelt do
            local ohString1 = "buyAllBelts"
            local ohString2 = "Blazing Vortex Island"
            
            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(ohString1, ohString2)
            
            wait(1)
        end
    end
})

Farm:AddToggle({
    Name = "Auto Buy Sword",
    Default = false,
    Callback = function(Value)
        autoBuyBelt = Value
        
        while autoBuyBelt do
                local ohString1 = "buyAllSwords"
                local ohString2 = "Blazing Vortex Island"

                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(ohString1, ohString2)            
            wait(1)
        end
    end
})

local ranks = {
    "Aether Genesis Master Ninja",
    "Ancient Battle Legend",
    "Ancient Battle Master",
    "Apprentice",
    "Assassin",
    "Awakened Scythe Legend",
    "Awakened Scythemaster",
    "Chaos Legend",
    "Chaos Sensei",
    "Comet Strike Lion",
    "Cybernetic Azure Sensei",
    "Cybernetic Electro Legend",
    "Cybernetic Electro Master",
    "Dark Elements Blademaster",
    "Dark Elements Guardian",
    "Dark Sun Samurai Legend",
    "Dragon Evolution Form I",
    "Dragon Evolution Form II",
    "Dragon Evolution Form III",
    "Dragon Evolution Form IV",
    "Dragon Evolution Form V",
    "Dragon Master",
    "Dragon Warrior",
    "Eclipse Series Soul Master",
    "Elemental Legend",
    "Elite Series Master Legend",
    "Eternity Hunter",
    "Evolved Series Master Ninja",
    "Golden Sun Shuriken Legend",
    "Golden Sun Shuriken Master",
    "Grasshopper",
    "Immortal Assassin",
    "Infinity Legend",
    "Infinity Sensei",
    "Infinity Shadows Master",
    "Legendary Shadow Duelist",
    "Legendary Shadowmaster",
    "Lightning Storm Sensei",
    "Master Elemental Hero",
    "Master Legend Assassin",
    "Master Legend Sensei Hunter",
    "Master Legend Zephyr",
    "Master Ninja",
    "Master Of Elements",
    "Master Of Shadows",
    "Master Sensei",
    "Mythic Shadowmaster",
    "Ninja",
    "Ninja Legend",
    "Rising Shadow Eternal Ninja",
    "Rookie",
    "Samurai",
    "Sensei",
    "Shadow",
    "Shadow Chaos Assassin",
    "Shadow Chaos Legend",
    "Shadow Legend",
    "Shadow Storm Sensei",
    "Skyblade Ninja Master",
    "Skystorm Series Samurai Legend",
    "Starstrike Master Sensei",
    "Ultra Genesis Shadow"
}

Farm:AddToggle({
    Name = "Auto Rank",
    Default = false,
    Callback = function(Value)
        if Value then
            spawn(function()
                while true do
                    wait(0.1)
                    
                    for _, rank in ipairs(ranks) do
                        local args = {
                            [1] = "buyRank",
                            [2] = rank
                        }
                        
                        game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    end

                    if not Value then
                        break
                    end
                end
            end)
        end
    end    
})

autoBuyBelt = false

Farm:AddToggle({
    Name = "Auto Buy Belt",
    Default = false,
    Callback = function(Value)
        autoBuyBelt = Value
        
        while autoBuyBelt do
            local ohString1 = "buyAllBelts"
            local ohString2 = "Blazing Vortex Island"
            
            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(ohString1, ohString2)
            
            wait(1)
        end
    end
})

autoBuySword = false

Farm:AddToggle({
    Name = "Auto Buy Sword",
    Default = false,
    Callback = function(Value)
        autoBuyBelt = Value
        
        while autoBuyBelt do
                local ohString1 = "buyAllSwords"
                local ohString2 = "Ground"

                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(ohString1, ohString2)            
            wait(1)
        end
    end
})


Misc:AddButton({
	Name = "Unlock Every Islands",
	Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80, 766, -188)

    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 39439, 173)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183, 46010, 36)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188, 59594, 24)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166, 52607, 34)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(180, 33206, 28)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80, 766, -118)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 2013, 331)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(165, 4047, 51)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186, 5656, 76)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(189, 9284, 31)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135, 17686, 61)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171, 28255, 39)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139, 13680, 74)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108, 24069, 84)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(175, 39317, 25)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226, 66669, 15)
    
    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(197, 70271, 7)

    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(121, 74461, 88)

    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(115, 79762, 61)

    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(102, 83199, 150)

    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133, 87050, 72)

    wait(0.001)
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(161, 91244, 39)
      	end    
})

local crystalNames = {
    "Astral Crystal",
    "Blue Crystal",
    "Enchanted Crystal",
    "Eternal Crystal",
    "Frozen Crystal",
    "Galaxy Crystal",
    "Golden Crystal",
    "Inferno Crystal",
    "Purple Crystal",
    "Secret Blades Crystal",
    "Storm Crystal",
    "Thunder Crystal",
    "Ultra Shockwave Crystal",
    "Infitnity Void Crystal"
}

local selectedCrystal = ""
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

Misc:AddButton({
	Name = "Open Fortune Wheel (x1)",
	Callback = function()
        local ohString1 = "openFortuneWheel"
        local ohInstance2 = workspace["Fortune Wheel"]

        game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer(ohString1, ohInstance2)
    end    
})

Misc:AddButton({
	Name = "Unlock Inferno Element!",
	Callback = function()
        local ohString1 = "Inferno"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

Misc:AddButton({
	Name = "Unlock Frost Element!",
	Callback = function()
        local ohString1 = "Frost"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

Misc:AddButton({
	Name = "Unlock Lightning Element!",
	Callback = function()
        local ohString1 = "Lightning"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

Misc:AddButton({
	Name = "Unlock Electral Chaos Element!",
	Callback = function()
        local ohString1 = "Electral Chaos"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

Misc:AddButton({
	Name = "Unlock Masterful Wrath Element!",
	Callback = function()
        local ohString1 = "Masterful Wrath"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

Misc:AddButton({
	Name = "Unlock Shadow Charge Element!",
	Callback = function()
        local ohString1 = "Shadow Charge"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

Misc:AddButton({
	Name = "Unlock Eternity Storm Element!",
	Callback = function()
        local ohString1 = "Eternity Storm"

        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(ohString1)
    end    
})

OrionLib:Init()
