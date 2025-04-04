local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Scamming Hub - Ninja Legends 2", HidePremium = false, SaveConfig = true, ConfigFolder = "Scamming Hub - Ninja Legends 2"})

local Farm = Window:MakeTab({
	Name = "Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local autoSwingEnabled = false
local autoBuySword = false
local autoBuyBelt = false

Farm:AddToggle({ 
    Name = "Auto Swing", 
    Default = false,
    Callback = function(Value)
        autoSwingEnabled = Value

        if autoSwingEnabled then
            spawn(function()
                while autoSwingEnabled do
                    wait(0) 
                    local ohString1 = "swingBlade"

                    game:GetService("Players").LocalPlayer.saberEvent:FireServer(ohString1)
                end
            end)
        end
    end    

})

local position1 = Vector3.new(-78, 113, 143)
local position2 = Vector3.new(-75, 113, 145)
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


Farm:AddToggle({
    Name = "Auto Buy Sword",
    Default = false,
    Callback = function(Value)
        autoBuySword = Value
        
        while autoBuySword do
                    local ohString1 = "buyAllItems"
                    local ohTable2 = {
                        ["whichPlanet"] = "Planet Chaos",
                        ["whichItems"] = "Swords"
                    }

                    game:GetService("Players").LocalPlayer.saberEvent:FireServer(ohString1, ohTable2)
            wait(1)
        end
    end
})


Farm:AddToggle({
    Name = "Auto Buy Belt",
    Default = false,
    Callback = function(Value)
        autoBuyBelt = Value
        
        while autoBuyBelt do
            local ohString1 = "buyAllItems"
            local ohTable2 = {
                ["whichPlanet"] = "Planet Chaos",
                ["whichItems"] = "Crystals"
            }

            game:GetService("Players").LocalPlayer.saberEvent:FireServer(ohString1, ohTable2)
            wait(1)
        end
    end
})

OrionLib:Init()
