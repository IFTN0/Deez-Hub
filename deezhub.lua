-- Rayfield UI Script for Blox Fruits
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/siriusmenu/Rayfield/main/Rayfield.lua"))()

-- Creating the window
local Window = Rayfield:CreateWindow({
   Name = "Blox Fruits Exploit Hub",
   Icon = 4483362458, 
   LoadingTitle = "Blox Fruits Exploit",
   LoadingSubtitle = "by ISSAMFTN",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "deezhub", 
      FileName = "BloxFruitsExploit"
   }
})

-- Creating Tabs for Sea and Miscellaneous Features
local FirstSeaTab = Window:CreateTab("First Sea", "wrench")
local SecondSeaTab = Window:CreateTab("Second Sea", "cloud")
local ThirdSeaTab = Window:CreateTab("Third Sea", "sun")
local MiscTab = Window:CreateTab("Miscellaneous", "settings")

-- Create Sections for each sea and the Misc tab
local FirstSeaSection = FirstSeaTab:CreateSection("First Sea Islands")
local SecondSeaSection = SecondSeaTab:CreateSection("Second Sea Islands")
local ThirdSeaSection = ThirdSeaTab:CreateSection("Third Sea Islands")
local MiscSection = MiscTab:CreateSection("Miscellaneous Features")

-- Button to teleport to First Sea islands
FirstSeaSection:CreateButton({
    Name = "Teleport to Green Zone",
    Callback = function()
        -- Your teleport function for Green Zone in First Sea
        print("Teleporting to Green Zone")
    end,
})

FirstSeaSection:CreateButton({
    Name = "Teleport to Pirate Village",
    Callback = function()
        -- Your teleport function for Pirate Village in First Sea
        print("Teleporting to Pirate Village")
    end,
})

-- Second Sea Islands Button
SecondSeaSection:CreateButton({
    Name = "Teleport to Skylands",
    Callback = function()
        -- Your teleport function for Skylands in Second Sea
        print("Teleporting to Skylands")
    end,
})

SecondSeaSection:CreateButton({
    Name = "Teleport to Secret Laboratory",
    Callback = function()
        -- Your teleport function for Secret Laboratory in Second Sea
        print("Teleporting to Secret Laboratory")
    end,
})

-- Third Sea Islands Button
ThirdSeaSection:CreateButton({
    Name = "Teleport to Temple of Time",
    Callback = function()
        -- Your teleport function for Temple of Time in Third Sea
        print("Teleporting to Temple of Time")
    end,
})

ThirdSeaSection:CreateButton({
    Name = "Teleport to Tiki Outpost",
    Callback = function()
        -- Your teleport function for Tiki Outpost in Third Sea
        print("Teleporting to Tiki Outpost")
    end,
})

-- Miscellaneous Features Section
MiscSection:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle", 
    Callback = function(value)
        -- Enable or disable Auto Farm functionality
        if value then
            print("Auto Farm Enabled")
        else
            print("Auto Farm Disabled")
        end
    end,
})

MiscSection:CreateToggle({
    Name = "Auto Raid",
    CurrentValue = false,
    Flag = "AutoRaidToggle",
    Callback = function(value)
        -- Enable or disable Auto Raid functionality
        if value then
            print("Auto Raid Enabled")
        else
            print("Auto Raid Disabled")
        end
    end,
})

MiscSection:CreateButton({
    Name = "Notification Example",
    Callback = function()
        Rayfield:Notify({
            Title = "Action Completed",
            Content = "You have completed an action successfully!",
            Duration = 5,
            Image = "check-circle",
        })
    end,
})

MiscSection:CreateSlider({
    Name = "Farm Speed",
    Range = {1, 100},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "FarmSpeedSlider", 
    Callback = function(value)
        -- Use this value to adjust farm speed
        print("Farm Speed set to: " .. value)
    end,
})

-- Notifications for successful setup
Rayfield:Notify({
    Title = "Welcome to the Blox Fruits Hub",
    Content = "Everything is set up and ready to go!",
    Duration = 6.5,
    Image = "check-circle",
})

-- Finalizing and showing the Rayfield UI
Rayfield:Init()

