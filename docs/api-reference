---
layout: default
title: API Reference
---

# API Reference

Complete API documentation for Modulate.

---

## Types
```lua
export type Loader = {
    new: () -> Loader,
    getFolder: (Loader) -> Folder,
    getModules: (Loader) -> (),
    asyncRequire: (Loader) -> {}
}
```

---

## Constructor

### `Loader.new()`

Creates a new Loader instance.

**Returns:** `Loader` - A new loader instance

**Example:**
```lua
local loader = Modulate.new()
```

---

## Methods

### `getFolder()`

Returns the appropriate folder based on the current context (server or client).

**Returns:** `Folder`
- `ServerScriptService.Services` on the server
- `ReplicatedStorage.Shared.Modules` on the client

**Example:**
```lua
local folder = loader:getFolder()
print(folder.Name) -- "Services" or "Modules"
```

---

### `getModules()`

Loads all modules in the designated folder that have an `Init` function.

**Behavior:**
- Skips non-ModuleScript instances
- Only loads modules with an `Init` function
- Prevents duplicate loading
- Calls `Init()` on successfully loaded modules

**Example:**
```lua
loader:getModules()
-- All modules with Init() are now loaded and initialized
```

---

### `asyncRequire(module)`

Safely requires a module with error handling.

**Parameters:**
- `module: ModuleScript` - The module to require

**Returns:** `table | nil`
- The required module on success
- `nil` on error (error is printed to output)

**Example:**
```lua
local myModule = loader:asyncRequire(moduleScript)
if myModule then
    myModule.DoSomething()
end
```

---

## Internal Properties

### `IsServer`

**Type:** `boolean`

Indicates whether the loader is running on the server (`true`) or client (`false`).

### `Modules`

**Type:** `Folder`

Reference to the folder containing modules to load.

---

[← Getting Started](/docs/getting-started) | [Examples →](/docs/examples)
