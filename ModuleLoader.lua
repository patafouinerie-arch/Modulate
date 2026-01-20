--!optimize 2

--[[
	[Modulate]
	
	v1.0.1
	
	A simple experimental module loader class.
	
	================================================================================
	[LICENSE]
	
	MIT License

	Copyright (c) 2026 patafouinerie-arch

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
	================================================================================
	
	[Documentation] : https://patafouinerie-arch.github.io/Modulate
--]]

-- ========================================
-- TYPES
-- ========================================

export type Loader = {
	new: () -> Loader,

	getFolder: (Loader) -> Folder,
	getModules: (Loader) -> (),
	asyncRequire: (Loader) -> {}
}

-- ========================================
-- SERVICES
-- ========================================
local runService = game:GetService("RunService")
local serverScriptService = game:GetService("ServerScriptService")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- ========================================
-- VARIABLES
-- ========================================
local Loader = {}
Loader.__index = Loader

local LoadedModules = {}

-- ========================================
-- FUNCTIONS
-- ========================================
local function getRunning()
	if runService:IsServer() then
		return true
	elseif runService:IsClient() then
		return false
	end
end

function Loader.new(): Loader
	local self = setmetatable({}, Loader)
	
	self.IsServer = getRunning()
	self.Modules = self:getFolder()
	self:getModules()

	return self
end

function Loader:getFolder(): Folder
	if self.IsServer then
		return serverScriptService.Services
	else
		return replicatedStorage.Shared.Modules
	end
end

function Loader:getModules(): ()
	for _, module in self.Modules:GetChildren() do
		if not module:IsA("ModuleScript") or table.find(LoadedModules, module.Name) then continue end

		task.spawn(function()
			table.insert(LoadedModules, module.Name)
			local import = self:asyncRequire(module)

			if import ~= nil then
				import.Init()
			else
				print("Init function not found in imported module")
			end
		end)
	end
end

function Loader:asyncRequire(module: ModuleScript): {}
	local success, result = pcall(function()
		return require(module)
	end)

	if not success then
		warn(result)
	else
		print(result)
		return result
	end
end

return Loader
