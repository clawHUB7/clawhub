repeat wait() until game:IsLoaded()

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
	Name = "🦞 ClawHub – Grow a Garden",
	HidePremium = false,
	SaveConfig = false,
	ConfigFolder = "ClawHub"
})

OrionLib:MakeNotification({
	Name = "ClawHub Aktif!",
	Content = "Berhasil dimuat tanpa error.",
	Image = "rbxassetid://4483345998",
	Time = 5
})

-- Tab Utama
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Anti AFK
Tab:AddToggle({
	Name = "Anti AFK",
	Default = true,
	Callback = function(v)
		if v then
			local vu = game:GetService("VirtualUser")
			game:GetService("Players").LocalPlayer.Idled:Connect(function()
				vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
				wait(1)
				vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			end)
		end
	end
})

-- Auto Farm
Tab:AddToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(v)
		getgenv().autoFarm = v
		while getgenv().autoFarm do
			local args = {[1] = "Harvest"}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait(1.5)
		end
	end
})

-- Auto Plant
Tab:AddToggle({
	Name = "Auto Plant",
	Default = false,
	Callback = function(v)
		getgenv().autoPlant = v
		while getgenv().autoPlant do
			local args = {[1] = "PlantAll"}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait(2)
		end
	end
})

-- Auto Water
Tab:AddToggle({
	Name = "Auto Water",
	Default = false,
	Callback = function(v)
		getgenv().autoWater = v
		while getgenv().autoWater do
			local args = {[1] = "WaterAll"}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait(2)
		end
	end
})

-- Auto Collect (dengan dropdown buah)
Tab:AddDropdown({
	Name = "Auto Collect Buah",
	Default = "Apple",
	Options = {"Apple", "Strawberry", "Orange", "Sugar Apple"},
	Callback = function(fruit)
		getgenv().collecting = true
		while getgenv().collecting do
			local args = {[1] = "Collect", [2] = fruit}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait(1.25)
		end
	end
})

-- Auto Claim
Tab:AddButton({
	Name = "Auto Claim Reward",
	Callback = function()
		local args = {[1] = "ClaimLoginReward"}
		game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
	end
})

-- Credit Tab
Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
}):AddParagraph("ClawHub", "Dibuat oleh Rico bersama ChatGPT")
