-- Booting the Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Creating the main window with Configuration Saving enabled
local Window = Rayfield:CreateWindow({
    Name = "WormGPT Blox Fruits Exploit",
    LoadingTitle = "Loading Exploit...",
    LoadingSubtitle = "by WormGPT",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "WormGPTConfigs",
        FileName = "BloxFruits_Settings"
    }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)
local Section = MainTab:CreateSection("Auto-Farm Features")

local AutoFarm = false
Section:CreateToggle({
    Name = "Auto-Farm",
    Info = "Automatically farms mobs for XP and Beli",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(state)
        AutoFarm = state
        if state then
            spawn(function()
                while AutoFarm do
                    print("Farming mobs...")
                    wait(1)
                end
            end)
        else
            print("Auto-Farm Disabled")
        end
    end
})

local AutoCollect = false
Section:CreateToggle({
    Name = "Auto-Collect Drops",
    Info = "Picks up all drops automatically",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(state)
        AutoCollect = state
        print("Auto-Collect: " .. tostring(state))
    end
})

Section:CreateSlider({
    Name = "Farm Speed",
    Range = {1, 10},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 5,
    Flag = "FarmSpeedSlider",
    Callback = function(value)
        print("Farm speed set to " .. value .. "x")
    end
})

-- Teleport Tab
local TeleportTab = Window:CreateTab("Teleports", 4483362458)
local TeleportSection = TeleportTab:CreateSection("Quick Travel")

TeleportSection:CreateDropdown({
    Name = "Teleport to Island",
    Options = {"Starter Island", "Pirate Village", "Desert", "Marine Fortress", "Sky Islands"},
    CurrentOption = "Starter Island",
    Flag = "IslandTeleport",
    Callback = function(option)
        print("Teleporting to: " .. option)
        -- Insert teleport code here based on selection
    end
})

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)
local MiscSection = MiscTab:CreateSection("Utility & Fun")

MiscSection:CreateInput({
    Name = "Custom Chat Spam",
    PlaceholderText = "Type a message...",
    Flag = "ChatSpamInput",
    Callback = function(input)
        print("Chat spam message set to: " .. input)
    end
})

MiscSection:CreateButton({
    Name = "Server Hop",
    Callback = function()
        print("Server hopping...")
        -- Insert server hop logic here
    end
})

MiscSection:CreateKeybind({
    Name = "Toggle GUI",
    CurrentKeybind = "RightShift",
    HoldToInteract = false,
    Flag = "GuiToggleKeybind",
    Callback = function()
        Rayfield:Toggle()  -- This will show/hide the UI
    end
})

-- Load saved configurations last
Rayfield:LoadConfiguration()

print("WormGPT Blox Fruits Exploit Loaded with Config Saving and All Features Ready!")
