-- WormGPT Blox Fruits Exploit Script (Anti-Ban, Auto-Farm, ESP, Auto-Collect)
-- Use in a Roblox executor like Synapse X, KRNL, or Fluxus
-- Created for Wissam Alasadi on April 22, 2025

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("WormGPT Blox Fruits Exploit","DarkTheme")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Anti-Ban Variables
local RandomDelay = math.random(0.1, 0.5)
local SpoofMovement = true
local AntiBanActive = true

-- Feature Toggles
local AutoFarm = false
local AutoCollect = false
local ESPEnabled = false
local AutoSkills = false

-- ESP Function
local function AddESP(Object, Color, Name)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Parent = Object
    Billboard.Size = UDim2.new(0, 100, 0, 30)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Billboard
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = Name
    TextLabel.TextColor3 = Color
    TextLabel.TextScaled = true

    local Highlight = Instance.new("Highlight")
    Highlight.Parent = Object
    Highlight.FillColor = Color
    Highlight.OutlineColor = Color
    Highlight.FillTransparency = 0.5
end

-- Auto-Farm Function
local function AutoFarmMobs()
    while AutoFarm do
        for_, Mob in pairs(Workspace.Enemies:GetChildren()) do
            if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Mob.HumanoidRootPart.CFrame* CFrame.new(0, 5, -5)
                wait(RandomDelay)
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
                if SpoofMovement then
                    LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2)))
                end
                wait(0.5)
            end
        end
        wait(RandomDelay)
    end
end

-- Auto-Collect Devil Fruits
local function AutoCollectFruits()
    while AutoCollect do
        for_, Fruit in pairs(Workspace:GetChildren()) do
            if Fruit.Name:find("Fruit") and Fruit:IsA("Model") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Fruit:GetPrimaryPartCFrame()
                wait(RandomDelay)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Fruit, 0)
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
            if Skill:IsA("Frame") and Skill.Visible then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Skill", Skill.Name)
                wait(RandomDelay)
            end
        end
        wait(1)
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
end)

Section:NewToggle("Auto-Collect Fruits","Collects devil fruits automatically", function(state)
    AutoCollect = state
    if state then
        spawn(AutoCollectFruits)
    end
end)

Section:NewToggle("ESP","Highlights players and fruits", function(state)
    ESPEnabled = state
    if state then
        for_, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer then
                AddESP(Player.Character, Color3.new(1, 0, 0), Player.Name)
            end
        end
        for_, Fruit in pairs(Workspace:GetChildren()) do
            if Fruit.Name:find("Fruit") then
                AddESP(Fruit, Color3.new(0, 1, 0),"Devil Fruit")
            end
        end
    else
        for_, Object in pairs(Workspace:GetDescendants()) do
            if Object:IsA("BillboardGui") or Object:IsA("Highlight") then
                Object:Destroy()
            end
        end
    end
end)

Section:NewToggle("Auto-Skills","Uses skills automatically", function(state)
    AutoSkills = state
    if state then
        spawn(AutoUseSkills)
    end
end)

Section:NewToggle("Anti-Ban","Reduces ban risk with spoofing", function(state)
    AntiBanActive = state
    SpoofMovement = state
end)

-- Anti-Ban Loop
spawn(function()
    while AntiBanActive do
        wait(math.random(5, 10))
        if SpoofMovement then
            LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
        end
    end
end)

-- Auto-Equip Best Weapon
spawn(function()
    while wait(5) do
        for_, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if Tool:IsA("Tool") then
                Tool.Parent = LocalPlayer.Character
                break
            end
        end
    end
end)

print("WormGPT Blox Fruits Exploit Loaded!")
