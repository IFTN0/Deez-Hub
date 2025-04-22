local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Ensure Rayfield is loaded correctly
if not Rayfield then
    warn("Rayfield library not loaded correctly!")
    return
end

local Window = Rayfield.CreateWindow("Deez Hub") -- Create the window

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
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v.Name:match("Comm") then
            return v
        end
    end
    table.insert(StatusLog, "Error: No valid remote found!")
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
    TextLabel.Text = Name .. (Distance and " (" .. Distance .. " studs)" or "")
    TextLabel.TextColor3 = Color
    TextLabel.TextScaled = true

    local Highlight = Instance.new("Highlight")
    Highlight.Parent = Object
    Highlight.FillColor = Color
    Highlight.OutlineColor = Color
    Highlight.FillTransparency = 0.4
end

-- UI Setup with Rayfield
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("WormGPT Features")

-- Auto-Farm Toggle
Section:NewToggle("Auto-Farm", "Farms mobs for XP and Beli", function(state)
    AutoFarm = state
    if state then
        spawn(AutoFarmMobs)
    end
    table.insert(StatusLog, "Auto-Farm " .. (state and "Enabled" or "Disabled"))
end)

-- Auto-Collect Toggle
Section:NewToggle("Auto-Collect", "Collects fruits and chests", function(state)
    AutoCollect = state
    if state then
        spawn(AutoCollectItems)
    end
    table.insert(StatusLog, "Auto-Collect " .. (state and "Enabled" or "Disabled"))
end)

-- ESP Toggle
Section:NewToggle("ESP", "Highlights players, mobs, and items", function(state)
    ESPEnabled = state
    if state then
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Player.Character then
                local Distance = math.floor((Player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                AddESP(Player.Character, Color3.new(1, 0, 0), Player.Name, Distance)
            end
        end
        for _, Item in pairs(Workspace:GetChildren()) do
            if Item.Name:match("Fruit") or Item.Name:match("Chest") then
                AddESP(Item, Color3.new(0, 1, 0), Item.Name, nil)
            end
        end
        for _, Mob in pairs(Workspace.Enemies:GetChildren()) do
            if Mob:IsA("Model") then
                AddESP(Mob, Color3.new(1, 1, 0), Mob.Name, nil)
            end
        end
    else
        -- Remove ESP elements
        for _, Object in pairs(Workspace:GetDescendants()) do
            if Object:IsA("BillboardGui") or Object:IsA("Highlight") then
                Object:Destroy()
            end
        end
    end
    table.insert(StatusLog, "ESP " .. (state and "Enabled" or "Disabled"))
end)

-- Auto-Skills Toggle
Section:NewToggle("Auto-Skills", "Uses skills automatically", function(state)
    AutoSkills = state
    if state then
        spawn(AutoUseSkills)
    end
    table.insert(StatusLog, "Auto-Skills " .. (state and "Enabled" or "Disabled"))
end)

-- Auto-Sea Beast Toggle
Section:NewToggle("Auto-Sea Beast", "Hunts sea beasts", function(state)
    AutoSeaBeast = state
    if state then
        spawn(AutoHuntSeaBeast)
    end
    table.insert(StatusLog, "Auto-Sea Beast " .. (state and "Enabled" or "Disabled"))
end)

-- Auto-Stats Toggle
Section:NewToggle("Auto-Stats", "Allocates stats automatically", function(state)
    AutoStats = state
    if state then
        spawn(AutoAllocateStats)
    end
    table.insert(StatusLog, "Auto-Stats " .. (state and "Enabled" or "Disabled"))
end)

-- Kill-Aura Toggle
Section:NewToggle("Kill-Aura", "Attacks nearby enemies", function(state)
    KillAura = state
    if state then
        spawn(KillAuraLoop)
    end
    table.insert(StatusLog, "Kill-Aura " .. (state and "Enabled" or "Disabled"))
end)

-- Anti-Ban Toggle
Section:NewToggle("Anti-Ban", "Reduces ban risk with spoofing", function(state)
    AntiBanActive = state
    SpoofInputs = state
    FakeMouse = state
    table.insert(StatusLog, "Anti-Ban " .. (state and "Enabled" or "Disabled"))
end)

-- Status Log Display
local LogSection = Tab:NewSection("Status Log")
local LogLabel = LogSection:NewLabel("Log: Waiting...")
spawn(function()
    while true do
        if #StatusLog > 0 then
            LogLabel:UpdateLabel("Log: " .. StatusLog[#StatusLog])
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
        for _, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if Tool:IsA("Tool") then
                Tool.Parent = LocalPlayer.Character
                table.insert(StatusLog, "Equipped " .. Tool.Name)
                break
            end
        end
    end
end)

-- Server Hop on Kick
game.Players.LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Failed then
        table.insert(StatusLog, "Teleport failed, attempting server hop...")
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, Server in pairs(Servers.data) do
            if Server.playing < Server.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Server.id)
                break
            end
        end
    end
end)

-- Final Debug Print
print("Deez Hub Loaded successfully!")

-- Load Configuration
Rayfield:LoadConfiguration()
