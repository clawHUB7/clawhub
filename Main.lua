-- ClawHub v2.0 – GUI (OrionLib) + Fitur Lengkap & Anti-Ban
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "🦀 ClawHub - Grow a Garden",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ClawHub"
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer

-- Settings
_G.settings = {
    autoCollect = false,
    targetFruit = nil,
    autoFarm = false,
    autoPlant = false,
    autoWater = false,
    autoSell = false,
    autoUpgrade = false,
    autoDaily = false
}

-- 🛡 Anti-Kick
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end)

-- 🕒 Anti-AFK
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    while true do
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(60)
    end
end)

-- 🔀 Utility: random delay
local function safeWait(min, max)
    task.wait(math.random(min, max) + math.random())
end

-- 🤖 Auto Collect
task.spawn(function()
    while true do
        if _G.settings.autoCollect and _G.settings.targetFruit then
            for _, obj in pairs(Workspace.Plants:GetChildren()) do
                if obj:FindFirstChild("Fruit") and obj.Fruit.Name == _G.settings.targetFruit then
                    safeWait(1,3)
                    pcall(function()
                        ReplicatedStorage.Remotes.CollectFruit:FireServer(obj)
                    end)
                end
            end
        end
        task.wait(2)
    end
end)

-- 🌾 Auto Farm
task.spawn(function()
    while true do
        if _G.settings.autoFarm then
            for _, plant in pairs(Workspace.Plants:GetChildren()) do
                if plant:FindFirstChild("Ready") then
                    safeWait(1,2)
                    pcall(function()
                        ReplicatedStorage.Remotes.HarvestRemote:FireServer(plant)
                    end)
                end
            end
        end
        task.wait(1)
    end
end)

-- 🌱 Auto Plant
task.spawn(function()
    while true do
        if _G.settings.autoPlant then
            safeWait(2,4)
            pcall(function()
                ReplicatedStorage.Remotes.PlantSeed:FireServer()
            end)
        end
        task.wait(1)
    end
end)

-- 💧 Auto Water
task.spawn(function()
    while true do
        if _G.settings.autoWater then
            safeWait(2,4)
            pcall(function()
                ReplicatedStorage.Remotes.WaterPlant:FireServer()
            end)
        end
        task.wait(1)
    end
end)

-- 💰 Auto Sell
task.spawn(function()
    while true do
        if _G.settings.autoSell then
            safeWait(3,6)
            pcall(function()
                ReplicatedStorage.Remotes.SellAll:FireServer()
            end)
        end
        task.wait(2)
    end
end)

-- 🆙 Auto Upgrade
task.spawn(function()
    while true do
        if _G.settings.autoUpgrade then
            safeWait(4,8)
            pcall(function()
                ReplicatedStorage.Remotes.UpgradeSeed:FireServer()
            end)
        end
        task.wait(5)
    end
end)

-- 🎁 Auto Claim Daily
task.spawn(function()
    while true do
        if _G.settings.autoDaily then
            safeWait(10,20)
            pcall(function()
                ReplicatedStorage.Remotes.ClaimDaily:FireServer()
            end)
        end
        task.wait(60)
    end
end)

-- 🎛 GUI Setup
local Tab = Window:MakeTab({Name = "Fitur", Icon = "rbxassetid://4483345998"})
Tab:AddDropdown({
    Name = "Pilih Buah (Auto Collect)",
    Options = {"Apple", "Banana", "Orange", "Strawberry"},
    Default = nil,
    Callback = function(val) _G.settings.targetFruit = val end
})
Tab:AddToggle({Name = "Auto Collect", Default = false, Callback = function(v) _G.settings.autoCollect = v end})
Tab:AddToggle({Name = "Auto Farm", Default = false, Callback = function(v) _G.settings.autoFarm = v end})
Tab:AddToggle({Name = "Auto Plant", Default = false, Callback = function(v) _G.settings.autoPlant = v end})
Tab:AddToggle({Name = "Auto Water", Default = false, Callback = function(v) _G.settings.autoWater = v end})
Tab:AddToggle({Name = "Auto Sell", Default = false, Callback = function(v) _G.settings.autoSell = v end})
Tab:AddToggle({Name = "Auto Upgrade", Default = false, Callback = function(v) _G.settings.autoUpgrade = v end})
Tab:AddToggle({Name = "Auto Daily Reward", Default = false, Callback = function(v) _G.settings.autoDaily = v end})

Window:OnClose(function()
    for k in pairs(_G.settings) do _G.settings[k] = false end
end)

OrionLib:Init()
