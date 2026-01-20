---
layout: default
title: Getting Started
---

# Getting Started

Learn how to integrate Modulate into your Roblox project in minutes.

---

## Installation

1. Download or copy the `Modulate.lua` file
2. Place it in `ReplicatedStorage` or `ServerScriptService`
3. Create a `Services` folder in `ServerScriptService`
4. Create a `Shared/Modules` folder in `ReplicatedStorage`

---

## Project Structure

Organize your modules like this:
ServerScriptService/
└── Services/
├── DataService.lua
├── PlayerService.lua
└── GameService.lua
ReplicatedStorage/
└── Shared/
└── Modules/
├── UIController.lua
├── SoundManager.lua
└── Utilities.lua

---

## Basic Usage

### Server-Side Setup

Create a script in `ServerScriptService`:
```lua
-- ServerScriptService > MainScript
local Modulate = require(game.ReplicatedStorage.Modulate)

local loader = Modulate.new()
loader:getModules()

print("Server modules loaded!")
```

### Client-Side Setup

Create a script in `StarterPlayer > StarterPlayerScripts`:
```lua
-- StarterPlayer > StarterPlayerScripts > ClientInit
local Modulate = require(game.ReplicatedStorage.Modulate)

local loader = Modulate.new()
loader:getModules()

print("Client modules loaded!")
```

---

## Creating Your First Module

Modules must have an `Init` function to be loaded by Modulate:
```lua
-- DataService.lua
local DataService = {}

function DataService.Init()
    print("DataService initialized!")
    DataService:Setup()
end

function DataService:Setup()
    -- Your initialization logic here
end

function DataService:LoadPlayerData(player)
    -- Your data loading logic
end

return DataService
```

---

## Next Steps

- [API Reference](/docs/api-reference) - Learn about all available methods
- [Examples](/docs/examples) - See practical implementation patterns

---

[← Back to Home](/) | [API Reference →](/docs/api-reference)
