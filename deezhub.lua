-- WormGPT Blox Fruits Exploit Script (Fixed, Enhanced Anti-Ban, Auto-Farm, ESP, Auto-Collect, More)
-- For use in Roblox executors (Synapse X, KRNL, Fluxus, etc.)
-- Fixed for nil value error and improved compatibility
-- Created on April 22, 2025

-- Fallback UI if Rayfield fails
local function CreateFallbackUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 400)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    Frame.Parent = ScreenGui
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 0, 50)
    TextLabel.Text ="WormGPT: Rayfield UI Failed! Using Fallback"
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    TextLabel.Parent = Frame
    return Frame
end

-- Load Rayfield UI with error handling
local Library
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)
if success then
    Library = result
else
    warn("WormGPT: Failed to load Rayfield UI -" .. tostring(result))
    Library = {CreateWindow = function() return CreateFallbackUI() end}
end

local Window = Library.CreateWindow({
    Name ="WormGPT Blox Fruits Exploit",
    LoadingTitle ="Loading Exploit...",
    LoadingSubtitle ="by WormGPT"
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Anti-Ban Variables
local RandomDelay = math.random(0.3, 0.8)
local SpoofInputs = true
local AntiBanActive = true
local FakeMouse = true
local FakePing = true

-- Feature Toggles
local AutoFarm = false
local AutoCollect = false
local ESPEnabled = false
local AutoSkills = false
local AutoSeaBeast = false
local AutoStats = false
local KillAura = false
local AutoQuest = false
local AutoAwaken = false
local ServerHop = false

-- Status Log
local StatusLog = {}

-- Dynamic Remote Detection
local function GetRemote()
    for_, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v.Name:match("Comm") or v.Name:match("Remote") then
            return v
        end
    end
    table.insert(StatusLog,"Error: No valid remote found!")
    return nil
end
local Remote = GetRemote()

-- ESP Function
local function AddESP(Object, Color, Name, Distance)
    local success,_ = pcall(function()
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
    end)
    if not success then
        table.insert(StatusLog,"ESP failed for" .. Name)
    end
end

-- Auto-Farm Function
local function AutoFarmMobs()
    while AutoFarm do
        local success,_ = pcall(function()
            for_, Mob in pairs(Workspace.Enemies:GetChildren()) do
                if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                    local Distance = (Mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if Distance < 40 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Mob.HumanoidRootPart.CFrame*CFrame.new(0, 6, -6)* CFrame.Angles(0, math.rad(math.random(-15, 15)), 0)
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
        end)
        if not success then
            table.insert(StatusLog,"Auto-Farm error, retrying...")
        end
        wait(0.4)
    end
end

-- Auto-Collect Function (Fruits and Chests)
local function AutoCollectItems()
    while AutoCollect do
        local success,_ = pcall(function()
            for_, Item in pairs(Workspace:GetChildren()) do
                if Item.Name:match("Fruit") or Item.Name:match("Chest") then
                    local Part = Item:IsA("Model") and Item:GetPrimaryPartCFrame() or Item.CFrame
                    LocalPlayer.Character.HumanoidRootPart.CFrame = Part* CFrame.new(0, 3, 0)
                    wait(RandomDelay)
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Item, 0)
                    table.insert(StatusLog,"Collected" .. Item.Name)
                    wait(0.6)
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Collect error, retrying...")
        end
        wait(1.2)
    end
end

-- Auto-Skills Function
local function AutoUseSkills()
    while AutoSkills do
        local success,_ = pcall(function()
            for_, Skill in pairs(LocalPlayer.PlayerGui.Main.Skills:GetChildren()) do
                if Skill:IsA("Frame") and Skill.Visible and Remote then
                    Remote:InvokeServer("Skill", Skill.Name)
                    table.insert(StatusLog,"Used skill:" .. Skill.Name)
                    wait(RandomDelay)
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Skills error, retrying...")
        end
        wait(0.9)
    end
end

-- Auto-Sea Beast Function
local function AutoHuntSeaBeast()
    while AutoSeaBeast do
        local success,_ = pcall(function()
            for_, Beast in pairs(Workspace.SeaBeasts:GetChildren()) do
                if Beast:IsA("Model") and Beast:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = Beast.HumanoidRootPart.CFrame* CFrame.new(0, 12, -25)
                    wait(RandomDelay)
                    if FakeMouse then
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                        wait(0.1)
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                    end
                    table.insert(StatusLog,"Hunting Sea Beast")
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Sea Beast error, retrying...")
        end
        wait(2.5)
    end
end

-- Auto-Stats Function
local function AutoAllocateStats()
    while AutoStats do
        local success,_ = pcall(function()
            if Remote then
                Remote:InvokeServer("AddPoint","Melee", 10)
                Remote:InvokeServer("AddPoint","Defense", 5)
                table.insert(StatusLog,"Allocated stats: Melee +10, Defense +5")
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Stats error, retrying...")
        end
        wait(6)
    end
end

-- Kill-Aura Function
local function KillAuraLoop()
    while KillAura do
        local success,_ = pcall(function()
            for_, Mob in pairs(Workspace.Enemies:GetChildren()) do
                if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                    local Distance = (Mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if Distance < 15 then
                        Remote:InvokeServer("Attack", Mob.Name)
                        table.insert(StatusLog,"Kill-Aura hit" .. Mob.Name)
                    end
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Kill-Aura error, retrying...")
        end
        wait(0.3)
    end
end

-- Auto-Quest Function
local function AutoCompleteQuests()
    while AutoQuest do
        local success,_ = pcall(function()
            if Remote then
                for_, Quest in pairs(LocalPlayer.PlayerGui.Main.Quests:GetChildren()) do
                    if Quest:IsA("Frame") and Quest.Visible then
                        Remote:InvokeServer("StartQuest", Quest.Name)
                        table.insert(StatusLog,"Started quest:" .. Quest.Name)
                    end
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Quest error, retrying...")
        end
        wait(5)
    end
end

-- Auto-Awaken Function
local function AutoAwakenFruits()
    while AutoAwaken do
        local success,_ = pcall(function()
            if Remote then
                Remote:InvokeServer("AwakenFruit")
                table.insert(StatusLog,"Attempted fruit awakening")
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Awaken error, retrying...")
        end
        wait(10)
    end
end

-- Server Hop Function
local function ServerHopLoop()
    while ServerHop do
        local success,_ = pcall(function()
            local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            for_, Server in pairs(Servers.data) do
                if Server.playing < Server.maxPlayers - 2 then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Server.id)
                    table.insert(StatusLog,"Hopping to server:" .. Server.id)
                    break
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Server hop failed, retrying...")
        end
        wait(30)
    end
end

-- UI Setup
local Page = Window:CreatePage("Main")
local Section = Page:CreateSection("Exploit Features")

Section:CreateToggle({
    Name ="Auto-Farm",
    Info ="Farms mobs for XP and Beli",
    CurrentValue = false,
    Callback = function(state)
        AutoFarm = state
        if state then
            spawn(AutoFarmMobs)
        end
        table.insert(StatusLog,"Auto-Farm" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Auto-Collect",
    Info ="Collects fruits and chests",
    CurrentValue = false,
    Callback = function(state)
        AutoCollect = state
        if state then
            spawn(AutoCollectItems)
        end
        table.insert(StatusLog,"Auto-Collect" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="ESP",
    Info ="Highlights players, mobs, and items",
    CurrentValue = false,
    Callback = function(state)
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
    end
})

Section:CreateToggle({
    Name ="Auto-Skills",
    Info ="Uses skills automatically",
    CurrentValue = false,
    Callback = function(state)
        AutoSkills = state
        if state then
            spawn(AutoUseSkills)
        end
        table.insert(StatusLog,"Auto-Skills" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Auto-Sea Beast",
    Info ="Hunts sea beasts",
    CurrentValue = false,
    Callback = function(state)
        AutoSeaBeast = state
        if state then
            spawn(AutoHuntSeaBeast)
        end
        table.insert(StatusLog,"Auto-Sea Beast" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Auto-Stats",
    Info ="Allocates stats automatically",
    CurrentValue = false,
    Callback = function(state)
        AutoStats = state
        if state then
            spawn(AutoAllocateStats)
        end
        table.insert(StatusLog,"Auto-Stats" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Kill-Aura",
    Info ="Attacks nearby enemies",
    CurrentValue = false,
    Callback = function(state)
        KillAura = state
        if state then
            spawn(KillAuraLoop)
        end
        table.insert(StatusLog,"Kill-Aura" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Auto-Quest",
    Info ="Completes quests automatically",
    CurrentValue = false,
    Callback = function(state)
        AutoQuest = state
        if state then
            spawn(AutoCompleteQuests)
        end
        table.insert(StatusLog,"Auto-Quest" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Auto-Awaken",
    Info ="Attempts fruit awakening",
    CurrentValue = false,
    Callback = function(state)
        AutoAwaken = state
        if state then
            spawn(AutoAwakenFruits)
        end
        table.insert(StatusLog,"Auto-Awaken" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Server Hop",
    Info ="Hops to less crowded servers",
    CurrentValue = false,
    Callback = function(state)
        ServerHop = state
        if state then
            spawn(ServerHopLoop)
        end
        table.insert(StatusLog,"Server Hop" .. (state and"Enabled" or"Disabled"))
    end
})

Section:CreateToggle({
    Name ="Anti-Ban",
    Info ="Reduces ban risk with spoofing",
    CurrentValue = true,
    Callback = function(state)
        AntiBanActive = state
        SpoofInputs = state
        FakeMouse = state
        FakePing = state
        table.insert(StatusLog,"Anti-Ban" .. (state and"Enabled" or"Disabled"))
    end
})

-- Status Log Display
local LogSection = Page:CreateSection("Status Log")
local LogLabel = LogSection:CreateLabel("Log: Waiting...")
spawn(function()
    while true do
        if #StatusLog > 0 then
            LogLabel:UpdateLabel("Log:" .. StatusLog[#StatusLog])
            if #StatusLog > 15 then
                table.remove(StatusLog, 1)
            end
        end
        wait(1)
    end
end)

-- Anti-Ban Loop
spawn(function()
    while AntiBanActive do
        local success,_ = pcall(function()
            wait(math.random(2, 7))
            if SpoofInputs then
                LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
            end
            if FakeMouse then
                VirtualInputManager:SendMouseMoveEvent(math.random(100, 700), math.random(100, 700), game)
            end
            if FakePing then
                game:GetService("ReplicatedStorage").Heartbeat:FireServer(math.random(50, 150))
            end
        end)
        if not success then
            table.insert(StatusLog,"Anti-Ban error, continuing...")
        end
    end
end)

-- Auto-Equip Best Weapon
spawn(function()
    while wait(3) do
        local success,_ = pcall(function()
            for_, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if Tool:IsA("Tool") then
                    Tool.Parent = LocalPlayer.Character
                    table.insert(StatusLog,"Equipped" .. Tool.Name)
                    break
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Auto-Equip error, retrying...")
        end
    end
end)

-- Server Hop on Kick
game.Players.LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Failed then
        table.insert(StatusLog,"Teleport failed, attempting server hop...")
        local success,_ = pcall(function()
            local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            for_, Server in pairs(Servers.data) do
                if Server.playing < Server.maxPlayers - 2 then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Server.id)
                    break
                end
            end
        end)
        if not success then
            table.insert(StatusLog,"Server hop on kick failed")
        end
    end
end)

print("WormGPT Blox Fruits Exploit Loaded Successfully!")
