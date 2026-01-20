---
layout: default
title: Examples
---

# Examples

Practical examples to get you started quickly.

---

## Creating a Simple Service

Create a service that will be auto-loaded by Modulate:
```lua
-- DataService.lua
local DataService = {}

function DataService.Init()
    print("DataService initialized!")
    DataService:LoadPlayerData()
end

function DataService:LoadPlayerData()
    -- Your data loading logic
end

function DataService:SavePlayerData(player, data)
    -- Your data saving logic
end

return DataService
```

---

## Module with Dependencies

Create a module that depends on other modules:
```lua
-- PlayerService.lua
local PlayerService = {}

local DataService -- Will be set in Init

function PlayerService.Init()
    -- Load dependency
    DataService = require(script.Parent.DataService)
    
    -- Connect events
    game.Players.PlayerAdded:Connect(PlayerService.OnPlayerAdded)
    game.Players.PlayerRemoving:Connect(PlayerService.OnPlayerRemoving)
    
    print("PlayerService initialized!")
end

function PlayerService.OnPlayerAdded(player)
    local data = DataService:LoadPlayerData(player)
    -- Handle player join
end

function PlayerService.OnPlayerRemoving(player)
    DataService:SavePlayerData(player)
    -- Handle player leave
end

return PlayerService
```

---

## Client-Side UI Module

Example of a client-side module:
```lua
-- UIController.lua (in ReplicatedStorage/Shared/Modules)
local UIController = {}

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

function UIController.Init()
    print("UIController initialized!")
    UIController:SetupUI()
end

function UIController:SetupUI()
    -- Create and setup UI elements
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainUI"
    screenGui.Parent = playerGui
    
    -- Add UI elements...
end

function UIController:ShowNotification(message)
    -- Display notification
    print("Notification:", message)
end

return UIController
```

---

## Game Manager Pattern

Coordinate multiple services:
```lua
-- GameManager.lua
local GameManager = {}

local DataService
local PlayerService
local CombatService

function GameManager.Init()
    -- Load all dependencies
    DataService = require(script.Parent.DataService)
    PlayerService = require(script.Parent.PlayerService)
    CombatService = require(script.Parent.CombatService)
    
    GameManager:StartGame()
    print("GameManager initialized!")
end

function GameManager:StartGame()
    -- Initialize game state
    print("Game starting...")
end

function GameManager:EndRound()
    -- Handle round end
    print("Round ended!")
end

return GameManager
```

---

## Module Without Auto-Loading

If you have a utility module that shouldn't auto-load, simply don't include an `Init` function:
```lua
-- Utilities.lua
local Utilities = {}

function Utilities.FormatNumber(num)
    return string.format("%d", num)
end

function Utilities.Lerp(a, b, t)
    return a + (b - a) * t
end

-- No Init function - won't be auto-loaded
-- Require this module manually when needed

return Utilities
```

---

[← API Reference](/docs/api-reference) | [Back to Home](/)
