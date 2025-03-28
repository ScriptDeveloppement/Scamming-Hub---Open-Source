local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Scamming Hub - Bee Swarm Simulator", HidePremium = false, SaveConfig = true, ConfigFolder = "Scamming Hub - Bee Swarm Simulator"})

local autoFarm = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local autoFarmSection = autoFarm:AddSection({
    Name = "Auto Farm Section"
})

local hiveLocations = {
    [1] = Vector3.new(-5, 6, 331),
    [2] = Vector3.new(-39, 6, 333),
    [3] = Vector3.new(-76, 6, 332),
    [4] = Vector3.new(-114, 6, 329),
    [5] = Vector3.new(-149, 6, 332),
    [6] = Vector3.new(-187, 6, 329)
}

local player = game.Players.LocalPlayer

local function teleportToHive()
    for i = 1, 6 do
        local hive = workspace.Honeycombs:FindFirstChild("Hive" .. i)
        if hive and hive:FindFirstChild("Owner") then
            local ownerValue = hive.Owner
            if ownerValue then
                if ownerValue:IsA("StringValue") and ownerValue.Value == player.Name then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(hiveLocations[i])
                    return i
                elseif ownerValue:IsA("ObjectValue") and ownerValue.Value and ownerValue.Value:IsA("Player") then
                    if ownerValue.Value.Name == player.Name then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(hiveLocations[i])
                        return i
                    end
                end
            end
        end
    end
    return nil
end

local autoFarmHoney = false

autoFarm:AddToggle({
	Name = "Auto Farm Honey",
	Default = false,
	Callback = function(Value)
        -- If toggled on, teleport to the farming position
        if Value then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 5, 227)
        else
            -- If toggled off, teleport to the specified location
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115, 5, 272)
        end

        autoFarmHoney = Value

        if autoFarmHoney then
            spawn(function()
                while autoFarmHoney do
                    wait(0.1) 
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ToolCollect"):FireServer()
                end
            end)
        end
    end    
})


autoFarm:AddToggle({
    Name = "Auto Sell Honey",
    Default = false,
    Callback = function(Value)
        if Value then
            local hiveIndex = teleportToHive()
            if hiveIndex then

                wait(0.1)

                local args = { [1] = "ToggleHoneyMaking" }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerHiveCommand"):FireServer(unpack(args))
                print("ToggleHoneyMaking executed.")

                while Value do
                    wait(5)
                end

                if not Value then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(-115, 5, 272)
                end
            else
            end
        else
            player.Character.HumanoidRootPart.CFrame = CFrame.new(-115, 5, 272)
        end
    end    
})

autoFarm:AddButton({
	Name = "Auto Claim Hive",
	Callback = function()
        local freeHives = {}

        for i = 1, 6 do
            local hiveName = "Hive" .. i
            local hive = workspace.Honeycombs:FindFirstChild(hiveName)
            if hive and (not hive:FindFirstChild("Owner") or hive.Owner.Value == nil) then
                table.insert(freeHives, i)
                print("Hive " .. i .. " : Free")
            end
        end
        
        if #freeHives > 0 then
            local randomIndex = math.random(1, #freeHives)
            local randomHive = freeHives[randomIndex]
            local args = { [1] = randomHive }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ClaimHive"):FireServer(unpack(args))
            print("Claimed Hive " .. randomHive)
        else
            print("No free hives available.")
        end        
    end    
})

OrionLib:Init()
