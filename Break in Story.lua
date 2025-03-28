
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Scamming Hub - Break In Story", HidePremium = false, SaveConfig = false, ConfigFolder = "Scamming Hub - Break In Story"})

-- Farm
local Farm = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local AutoApple = false  -- Initialize the variable to track the toggle state

Farm:AddToggle({ 
    Name = "Auto Apple", 
    Default = false,
    Callback = function(Value)
        AutoApple = Value  -- Update the toggle state

        -- Start or stop the loop based on toggle state
        if AutoApple then
            spawn(function()
                while AutoApple do
                    wait(0)  -- Add a short delay to prevent the loop from running too fast
                    local args = {
                        [1] = "Apple"
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("GiveTool"):FireServer(unpack(args))                    
                end
            end)
        end
    end    
})

local AutoCookie = false  -- Initialize the variable to track the toggle state

Farm:AddToggle({ 
    Name = "Auto Cookie", 
    Default = false,
    Callback = function(Value)
        AutoCookie = Value  -- Update the toggle state

        -- Start or stop the loop based on toggle state
        if AutoCookie then
            spawn(function()
                while AutoCookie do
                    wait(0)  -- Add a short delay to prevent the loop from running too fast
                    local args = {
                        [1] = "Cookie"
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("GiveTool"):FireServer(unpack(args))
                    
                end
            end)
        end
    end    
})

local GodMode = false  -- Initialize the variable to track the toggle state

Farm:AddToggle({ 
    Name = "God Mode", 
    Default = false,
    Callback = function(Value)
        GodMode = Value  -- Update the toggle state

        -- Start or stop the loop based on toggle state
        if GodMode then
            spawn(function()
                while GodMode do
                    wait(0)  -- Add a short delay to prevent the loop from running too fast
                    local args = {
                        [1] = 15,
                        [2] = "Cookie"
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Energy"):FireServer(unpack(args))                    
                end
            end)
        end
    end    
})

Farm:AddToggle({ 
    Name = "Mele Aura", 
    Default = false,
    Callback = function(Value)
        GodMode = Value  -- Update the toggle state

        -- Start or stop the loop based on toggle state
        if GodMode then
            spawn(function()
                while GodMode do
                    wait(0)  -- Add a short delay to prevent the loop from running too fast
                    local args = {
                        [1] = workspace:WaitForChild("BadGuys"):WaitForChild(" "),
                        [2] = 10
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("HitBadguy"):FireServer(unpack(args)) 
                end
            end)
        end
    end    
})

local AutoAttic = false  -- Initialize the variable to track the toggle state

Farm:AddToggle({ 
    Name = "Auto open attic (troll)", 
    Default = false,
    Callback = function(Value)
        AutoAttic = Value  -- Update the toggle state

        -- Start or stop the loop based on toggle state
        if AutoAttic then
            spawn(function()
                while AutoAttic do
                    wait(0)  -- Add a short delay to prevent the loop from running too fast
                    local args = {
                        [1] = "Attic"
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Door"):FireServer(unpack(args))                    
                end
            end)
        end
    end    
})
