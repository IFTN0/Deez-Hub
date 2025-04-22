-- WormGPT Blox Fruits Exploit Script (Enhanced Anti-Ban, Auto-Farm, ESP, Auto-Collect, More)
-- For use in Roblox executors (Synapse X, KRNL, Fluxus, etc.)
-- Created on April 22, 2025

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Check if Rayfield loaded successfully
if not Rayfield then
    warn("Rayfield failed to load.")
    return
end
print("Rayfield loaded successfully.")

-- Creating Rayfield Window
local Window = Rayfield:CreateWindow({
   Name = "Deez Hub",
   Icon = 0, -- No icon (default)
   LoadingTitle = "Loading Deez Hub",
   LoadingSubtitle = "by ISSAMFTN",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = deezhub, -- Custom folder for your hub/game
      FileName = "DeezHubConfig"
   },
   Discord = {
      Enabled = false, -- Discord integration is off
      Invite = "noinvitelink", -- No invite link
      RememberJoins = true -- Remember join state
   },
   KeySystem = true, -- Key system is on
   KeySettings = {
      Title = "Keysystem",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"DeezAdmin"} -- Accepts the key "DeezAdmin"
   }
})

-- Check if the window was created
if Window then
    print("Window created successfully.")
else
    warn("Failed to create the window.")
    return
end

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

-- Auto-Farm Function
local function AutoFarmMobs()
    while AutoFarm do
        for _, Mob in pairs(Workspace.Enemies:GetChildren()) do
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
                    table.insert(StatusLog, "Attacking " .. Mob.Name)
                end
            end
        end
        wait(0.3)
    end
end

-- Auto-Collect Function (Fruits and Chests)
local function AutoCollectItems()
    while AutoCollect do
        for _, Item in pairs(Workspace:GetChildren()) do
            if Item.Name:match("Fruit") or Item.Name:match("Chest") then
                local Part = Item:IsA("Model") and Item:GetPrimaryPartCFrame() or Item.CFrame
                LocalPlayer.Character.HumanoidRootPart.CFrame = Part*CFrame.new(0, 2, 0)
                wait(RandomDelay)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Item, 0)
                table.insert(StatusLog, "Collected " .. Item.Name)
                wait(0.5)
            end
        end
        wait(1)
    end
end

-- Auto-Skills Function
local function AutoUseSkills()
    while AutoSkills do
        for _, Skill in pairs(LocalPlayer.PlayerGui.Main.Skills:GetChildren()) do
            if Skill:IsA("Frame") and Skill.Visible and Remote then
                Remote:InvokeServer("Skill", Skill.Name)
                table.insert(StatusLog, "Used skill: " .. Skill.Name)
                wait(RandomDelay)
            end
        end
        wait(0.8)
    end
end

-- Auto-Sea Beast Function
local function AutoHuntSeaBeast()
    while AutoSeaBeast do
        for _, Beast in pairs(Workspace.SeaBeasts:GetChildren()) do
            if Beast:IsA("Model") and Beast:FindFirstChild("Humanoid") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Beast.HumanoidRootPart.CFrame*CFrame.new(0, 10, -20)
                wait(RandomDelay)
                if FakeMouse then
                    VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                    wait(0.1)
                    VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                end
                table.insert(StatusLog, "Hunting Sea Beast")
            end
        end
        wait(2)
    end
end

-- Auto-Stats Function
local function AutoAllocateStats()
    while AutoStats do
        if Remote then
            Remote:InvokeServer("AddPoint", "Melee", 10)
            Remote:InvokeServer("AddPoint", "Defense", 5)
            table.insert(StatusLog, "Allocated stats: Melee +10, Defense +5")
        end
        wait(5)
    end
end

-- Kill-Aura Function
local function KillAuraLoop()
    while KillAura do
        for _, Mob in pairs(Workspace.Enemies:GetChildren()) do
            if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                local Distance = (Mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if Distance < 20 then
                    Remote:InvokeServer("Attack", Mob.Name)
                    table.insert(StatusLog, "Kill-Aura hit " .. Mob.Name)
                end
            end
        end
        wait(0.2)
    end
end

-- UI Setup with Rayfield
local Tab = Window:CreateTab("Main")

-- Features Section
local FeatureSection = Tab:CreateSection("Main Features")

-- Auto-Farm Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Farm",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(state)
      AutoFarm = state
      if state then
         spawn(AutoFarmMobs)
         Rayfield:Notify({
            Title = "Auto-Farm Activated",
            Content = "Auto-Farming is now enabled.",
            Duration = 3,
            Image = "play"
         })
      end
      table.insert(StatusLog, "Auto-Farm " .. (state and "Enabled" or "Disabled"))
   end
})

-- Auto-Collect Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Collect",
   CurrentValue = false,
   Flag = "AutoCollectToggle",
   Callback = function(state)
      AutoCollect = state
      if state then
         spawn(AutoCollectItems)
         Rayfield:Notify({
            Title = "Auto-Collect Activated",
            Content = "Auto-Collecting items is now enabled.",
            Duration = 3,
            Image = "shopping-cart"
         })
      end
      table.insert(StatusLog, "Auto-Collect " .. (state and "Enabled" or "Disabled"))
   end
})

-- ESP Toggle
FeatureSection:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(state)
      ESPEnabled = state
      if state then
         -- Start ESP
         Rayfield:Notify({
            Title = "ESP Activated",
            Content = "ESP is now enabled.",
            Duration = 3,
            Image = "eye"
         })
      end
      table.insert(StatusLog, "ESP " .. (state and "Enabled" or "Disabled"))
   end
})

-- Auto-Skills Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Skills",
   CurrentValue = false,
   Flag = "AutoSkillsToggle",
   Callback = function(state)
      AutoSkills = state
      if state then
         spawn(AutoUseSkills)
         Rayfield:Notify({
            Title = "Auto-Skills Activated",
            Content = "Auto-Skills is now enabled.",
            Duration = 3,
            Image = "zap"
         })
      end
      table.insert(StatusLog, "Auto-Skills " .. (state and "Enabled" or "Disabled"))
   end
})

-- Auto-SeaBeast Toggle
FeatureSection:CreateToggle({
   Name = "Auto-SeaBeast",
   CurrentValue = false,
   Flag = "AutoSeaBeastToggle",
   Callback = function(state)
      AutoSeaBeast = state
      if state then
         spawn(AutoHuntSeaBeast)
         Rayfield:Notify({
            Title = "Auto-SeaBeast Activated",
            Content = "Auto-SeaBeast is now enabled.",
            Duration = 3,
            Image = "ocean"
         })
      end
      table.insert(StatusLog, "Auto-SeaBeast " .. (state and "Enabled" or "Disabled"))
   end
})

-- Auto-Stats Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Stats",
   CurrentValue = false,
   Flag = "AutoStatsToggle",
   Callback = function(state)
      AutoStats = state
      if state then
         spawn(AutoAllocateStats)
         Rayfield:Notify({
            Title = "Auto-Stats Activated",
            Content = "Auto-Stats is now enabled.",
            Duration = 3,
            Image = "chart-bar"
         })
      end
      table.insert(StatusLog, "Auto-Stats " .. (state and "Enabled" or "Disabled"))
   end
})

-- Kill-Aura Toggle
FeatureSection:CreateToggle({
   Name = "Kill-Aura",
   CurrentValue = false,
   Flag = "KillAuraToggle",
   Callback = function(state)
      KillAura = state
      if state then
         spawn(KillAuraLoop)
         Rayfield:Notify({
            Title = "Kill-Aura Activated",
            Content = "Kill-Aura is now enabled.",
            Duration = 3,
            Image = "skull"
         })
      end
      table.insert(StatusLog, "Kill-Aura " .. (state and "Enabled" or "Disabled"))
   end
})

-- Status Section
local StatusSection = Tab:CreateSection("Status")
StatusSection:CreateLabel("Script Status: Active")
StatusSection:CreateTextBox({
   Name = "Logs",
   PlaceholderText = "Latest Status Log...",
   Text = table.concat(StatusLog, "\n"),
   IsTextSelectable = true
})

-- End of script setup
