-- Creating the Rayfield Window with the necessary configurations
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/ISSAMFTN/Rayfield/master/rayfield.lua"))()

local Window = Rayfield:CreateWindow({
   Name = "DeezHub Blox Fruits",
   Icon = 4483362458,
   LoadingTitle = "Loading DeezHub",
   LoadingSubtitle = "by ISSAMFTN",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "deezhub", -- Folder name
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false, -- Discord feature off
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false, -- Disable key system
})

-- Creating the main Tab
local Tab = Window:CreateTab("Main", 4483362458)  -- Main Tab with an icon

-- Creating a section for functions in the Main Tab
local Section = Tab:CreateSection("Functions")

-- Add function buttons to the section
local Button1 = Tab:CreateButton({
   Name = "Activate Fruit Farm",
   Callback = function()
      -- This would be the function to activate the fruit farm (just an example)
      print("Fruit Farm activated!")
   end,
})

local Button2 = Tab:CreateButton({
   Name = "Activate Auto Farm",
   Callback = function()
      -- This would be the function to activate auto-farm (just an example)
      print("Auto Farm activated!")
   end,
})

local Button3 = Tab:CreateButton({
   Name = "Activate Quests",
   Callback = function()
      -- This would be the function to activate quests (just an example)
      print("Quests activated!")
   end,
})

-- Create sections for the other parts of your script, as needed
local Section2 = Tab:CreateSection("Auto Features")
local Button4 = Tab:CreateButton({
   Name = "Activate Auto Level",
   Callback = function()
      -- Function to activate auto level
      print("Auto Level activated!")
   end,
})

local Button5 = Tab:CreateButton({
   Name = "Activate Auto Boss",
   Callback = function()
      -- Function to activate auto boss
      print("Auto Boss activated!")
   end,
})

-- Adding more sections and buttons as needed
local Section3 = Tab:CreateSection("Miscellaneous")
local Button6 = Tab:CreateButton({
   Name = "Activate Teleport",
   Callback = function()
      -- Function to teleport the player to specific island or location
      print("Teleport activated!")
   end,
})

-- Add additional sections and buttons for other functionalities as needed
-- Example: Islands, other features, etc.

-- Destroy the interface when done
-- Rayfield:Destroy() -- Uncomment this line if you want to close the window after use
