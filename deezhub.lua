-- WormGPT Blox Fruits Exploit Script (Enhanced Anti-Ban, Auto-Farm, ESP, Auto-Collect, More)
-- For use in Roblox executors (Synapse X, KRNL, Fluxus, etc.)
-- Created on April 22, 2025

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Orca/main/source.lua"))()
local Window = Library.CreateLib("WormGPT Blox Fruits Exploit","DarkTheme")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Anti-Ban Variables
local RandomDelay = math.random(0.2, 0.7)
local SpoofInputs = true
local AntiBanActive = true
local FakeMouse = true

-- Feature Toggles
local AutoFarm = false
local AutoCollect = false
local ESPEnabled = false
local AutoSkills = false
local AutoSeaBeast = false
local AutoStats = false
local KillAura = false

-- Status Log
local StatusLog = {}

-- Dynamic Remote Detection
local function GetRemote()
    for_, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v.Name:match("Comm") then
            return v
        end
    end
    table.insert(StatusLog,"Error: No valid remote found!")
    return nil
end
local Remote = GetRemote()

-- ESP Function
local function AddESP(Object, Color, Name, Distance)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Parent = Object
    Billboard.Size = UDim2.new(0, 100, 0, 40)
    Billboard.StudsOffset = Vector3.new(0, 4, 0)
    Billboard.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Billboard
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = Name .. (Distance and" (" .. Distance .. " studs)" or "")
    TextLabel.TextColor3 = Color
    TextLabel.TextScaled = true

    local Highlight = Instance.new("Highlight")
    Highlight.Parent = Object
    Highlight.FillColor = Color
    Highlight.OutlineColor = Color
    Highlight.FillTransparency = 0.4
end

-- Auto-Farm Function
local function AutoFarmMobs()
    while AutoFarm do
        for_, Mob in pairs(Workspace.Enemies:GetChildren()) do
            if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                local Distance = (Mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if Distance < 50 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = Mob.HumanoidRootPart.CFrame*CFrame.new(0, 5, -5)* CFrame.Angles(0, math.rad(math.random(-10, 10)), 0)
                    wait(RandomDelay)
                    if FakeMouse then
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                        wait(0.1)
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                    end
                    if SpoofInputs then
                        LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3)))
                    end
                    table.insert(StatusLog,"Attacking" .. Mob.Name)
                end
            end
        end
        wait(0.3)
    end
end

-- Auto-Collect Function (Fruits and Chests)
local function AutoCollectItems()
    while AutoCollect do
        for_, Item in pairs(Workspace:GetChildren()) do
            if Item.Name:match("Fruit") or Item.Name:match("Chest") then
                local Part = Item:IsA("Model") and Item:GetPrimaryPartCFrame() or Item.CFrame
                LocalPlayer.Character.HumanoidRootPart.CFrame = Part* CFrame.new(0, 2, 0)
                wait(RandomDelay)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Item, 0)
                table.insert(StatusLog,"Collected" .. Item.Name)
                wait(0.5)
            end
        end
        wait(1)
    end
end

-- Auto-Skills Function
local function AutoUseSkills()
    while AutoSkills do
        for_, Skill in pairs(LocalPlayer.PlayerGui.Main.Skills:GetChildren()) do
            if Skill:IsA("Frame") and Skill.Visible and Remote then
                Remote:InvokeServer("Skill", Skill.Name)
                table.insert(StatusLog,"Used skill:" .. Skill.Name)
                wait(RandomDelay)
            end
        end
        wait(0.8)
    end
end

-- Auto-Sea Beast Function
local function AutoHuntSeaBeast()
    while AutoSeaBeast do
        for_, Beast in pairs(Workspace.SeaBeasts:GetChildren()) do
            if Beast:IsA("Model") and Beast:FindFirstChild("Humanoid") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Beast.HumanoidRootPart.CFrame* CFrame.new(0, 10, -20)
                wait(RandomDelay)
                if FakeMouse then
                    VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                    wait(0.1)
                    VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                end
                table.insert(StatusLog,"Hunting Sea Beast")
            end
        end
        wait(2)
    end
end

-- Auto-Stats Function
local function AutoAllocateStats()
    while AutoStats do
        if Remote then
            Remote:InvokeServer("AddPoint","Melee", 10)
            Remote:InvokeServer("AddPoint","Defense", 5)
            table.insert(StatusLog,"Allocated stats: Melee +10, Defense +5")
        end
        wait(5)
    end
end

-- Kill-Aura Function
local function KillAuraLoop()
    while KillAura do
        for_, Mob in pairs(Workspace.Enemies:GetChildren()) do
            if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                local Distance = (Mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if Distance < 20 then
                    Remote:InvokeServer("Attack", Mob.Name)
                    table.insert(StatusLog,"Kill-Aura hit" .. Mob.Name)
                end
            end
        end
        wait(0.2)
    end
end

-- UI Setup
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("WormGPT Features")

Section:NewToggle("Auto-Farm","Farms mobs for XP and Beli", function(state)
    AutoFarm = state
    if state then
        spawn(AutoFarmMobs)
    end
    table.insert(StatusLog,"Auto-Farm" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("Auto-Collect","Collects fruits and chests", function(state)
    AutoCollect = state
    if state then
        spawn(AutoCollectItems)
    end
    table.insert(StatusLog,"Auto-Collect" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("ESP","Highlights players, mobs, and items", function(state)
    ESPEnabled = state
    if state then
        for_, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Player.Character then
                local Distance = math.floor((Player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                AddESP(Player.Character, Color3.new(1, 0, 0), Player.Name, Distance)
            end
        end
        for_, Item in pairs(Workspace:GetChildren()) do
            if Item.Name:match("Fruit") or Item.Name:match("Chest") then
                AddESP(Item, Color3.new(0, 1, 0), Item.Name, nil)
            end
        end
        for_, Mob in pairs(Workspace.Enemies:GetChildren()) do
            if Mob:IsA("Model") then
                AddESP(Mob, Color3.new(1, 1, 0), Mob.Name, nil)
            end
        end
    else
        for_, Object in pairs(Workspace:GetDescendants()) do
            if Object:IsA("BillboardGui") or Object:IsA("Highlight") then
                Object:Destroy()
            end
        end
    end
    table.insert(StatusLog,"ESP" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("Auto-Skills","Uses skills automatically", function(state)
    AutoSkills = state
    if state then
        spawn(AutoUseSkills)
    end
    table.insert(StatusLog,"Auto-Skills" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("Auto-Sea Beast","Hunts sea beasts", function(state)
    AutoSeaBeast = state
    if state then
        spawn(AutoHuntSeaBeast)
    end
    table.insert(StatusLog,"Auto-Sea Beast" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("Auto-Stats","Allocates stats automatically", function(state)
    AutoStats = state
    if state then
        spawn(AutoAllocateStats)
    end
    table.insert(StatusLog,"Auto-Stats" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("Kill-Aura","Attacks nearby enemies", function(state)
    KillAura = state
    if state then
        spawn(KillAuraLoop)
    end
    table.insert(StatusLog,"Kill-Aura" .. (state and"Enabled" or"Disabled"))
end)

Section:NewToggle("Anti-Ban","Reduces ban risk with spoofing", function(state)
    AntiBanActive = state
    SpoofInputs = state
    FakeMouse = state
    table.insert(StatusLog,"Anti-Ban" .. (state and"Enabled" or"Disabled"))
end)

-- Status Log Display
local LogSection = Tab:NewSection("Status Log")
local LogLabel = LogSection:NewLabel("Log: Waiting...")
spawn(function()
    while true do
        if #StatusLog > 0 then
            LogLabel:UpdateLabel("Log:" .. StatusLog[#StatusLog])
            if #StatusLog > 10 then
                table.remove(StatusLog, 1)
            end
        end
        wait(1)
    end
end)

-- Anti-Ban Loop
spawn(function()
    while AntiBanActive do
        wait(math.random(3, 8))
        if SpoofInputs then
            LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-4, 4), 0, math.random(-4, 4)))
            if FakeMouse then
                VirtualInputManager:SendMouseMoveEvent(math.random(100, 600), math.random(100, 600), game)
            end
        end
    end
end)

-- Auto-Equip Best Weapon
spawn(function()
    while wait(4) do
        for_, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if Tool:IsA("Tool") then
                Tool.Parent = LocalPlayer.Character
                table.insert(StatusLog,"Equipped" .. Tool.Name)
                break
            end
        end
    end
end)

-- Server Hop on Kick
game.Players.LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Failed then
        table.insert(StatusLog,"Teleport failed, attempting server hop...")
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for_, Server in pairs(Servers.data) do
            if Server.playing < Server.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Server.id)
                break
            end
        end
    end
end)

print("WormGPT Blox Fruits Exploit Loaded!")
