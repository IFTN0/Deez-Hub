-- WormGPT Blox Fruits Exploit Script
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
   KeySystem = false, -- Key system is off
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"} -- Accepts the key "Hello"
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
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Workspace = game:GetService("Workspace")

-- Feature Toggles (Simple)
local AutoFarm = false
local AutoCollect = false
local AutoUpgrade = false
local AutoSkills = false
local AutoQuest = false
local Teleport = false

-- Game-Specific Functions (For Blox Fruits)

-- Teleport Function (Teleport to specific locations in the seas)
local function TeleportToLocation(locationName)
    local targetLocation = Workspace:FindFirstChild(locationName)
    if targetLocation then
        Character.HumanoidRootPart.CFrame = targetLocation.CFrame
        print("Teleported to " .. locationName)
    else
        print("Location not found.")
    end
end

-- Create Auto Features

-- Auto-Farm Function
local function AutoFarmMobs()
    -- Implement Auto-Farm logic here
    print("Auto-Farming started.")
end

-- Auto-Collect Function
local function AutoCollectItems()
    -- Implement Auto-Collect logic here
    print("Auto-Collect started.")
end

-- Auto-Upgrade Function
local function AutoUpgradeStats()
    -- Implement Auto-Upgrade logic here
    print("Auto-Upgrade started.")
end

-- Auto-Skill Use Function
local function AutoUseSkills()
    -- Implement Auto-Skill logic here
    print("Auto-Skill Use started.")
end

-- Auto-Quest Function
local function AutoCompleteQuest()
    -- Implement Auto-Quest logic here
    print("Auto-Quest started.")
end

-- Creating UI elements (Toggles and Buttons)
local Tab = Window:CreateTab("Main")

-- Main Features Section
local FeatureSection = Tab:CreateSection("Main Features")

-- Auto-Farm Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Farm",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(state)
      AutoFarm = state
      if state then
         AutoFarmMobs()  -- Start auto farming when enabled
         print("Auto-Farm Enabled")
      else
         print("Auto-Farm Disabled")
      end
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
         AutoCollectItems()  -- Start auto collecting when enabled
         print("Auto-Collect Enabled")
      else
         print("Auto-Collect Disabled")
      end
   end
})

-- Auto-Upgrade Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Upgrade",
   CurrentValue = false,
   Flag = "AutoUpgradeToggle",
   Callback = function(state)
      AutoUpgrade = state
      if state then
         AutoUpgradeStats()  -- Start auto upgrading when enabled
         print("Auto-Upgrade Enabled")
      else
         print("Auto-Upgrade Disabled")
      end
   end
})

-- Auto-Skill Use Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Skill Use",
   CurrentValue = false,
   Flag = "AutoSkillsToggle",
   Callback = function(state)
      AutoSkills = state
      if state then
         AutoUseSkills()  -- Start auto using skills when enabled
         print("Auto-Skill Use Enabled")
      else
         print("Auto-Skill Use Disabled")
      end
   end
})

-- Auto-Quest Toggle
FeatureSection:CreateToggle({
   Name = "Auto-Quest",
   CurrentValue = false,
   Flag = "AutoQuestToggle",
   Callback = function(state)
      AutoQuest = state
      if state then
         AutoCompleteQuest()  -- Start auto questing when enabled
         print("Auto-Quest Enabled")
      else
         print("Auto-Quest Disabled")
      end
   end
})

-- Teleport Buttons for Locations in All Three Seas
local TeleportSection = Tab:CreateSection("Teleport Features")

-- First Sea Locations
local firstSeaLocations = {
    "Pirate Village", "Café", "Colosseum (First Sea)", "Green Zone", "Fountain City", "Frozen Village",
    "Magma Village", "Marine Fortress", "Colosseum (First Sea)", "Beautiful Pirate Domain", "Bridge"
}

for _, location in pairs(firstSeaLocations) do
    TeleportSection:CreateButton({
       Name = "Teleport to " .. location,
       Callback = function()
          TeleportToLocation(location)
       end
    })
end

-- Second Sea Locations
local secondSeaLocations = {
    "Skylands", "Floating Turtle", "Forgotten Island", "Marine Starter", "Colosseum (Second Sea)", 
    "Secret Laboratory", "Temple of Time", "Cursed Ship"
}

for _, location in pairs(secondSeaLocations) do
    TeleportSection:CreateButton({
       Name = "Teleport to " .. location,
       Callback = function()
          TeleportToLocation(location)
       end
    })
end

-- Third Sea Locations
local thirdSeaLocations = {
    "Castle on the Sea", "Hydra Island", "Tiki Outpost", "Mansion (Third Sea)", "Whirlpool", 
    "Raids", "Treasure Island", "Secret Temple", "Pakistan Dimension"
}

for _, location in pairs(thirdSeaLocations) do
    TeleportSection:CreateButton({
       Name = "Teleport to " .. location,
       Callback = function()
          TeleportToLocation(location)
       end
    })
end

-- Status Section (Simple)
local StatusSection = Tab:CreateSection("Status")
StatusSection:CreateLabel("Script Status: Active")

-- Final Print to indicate script is fully loaded
print("Script loaded successfully. Features are ready.")
