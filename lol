print("ez")

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucas-Lua/ui/main/m"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/barlossxi/barlossxi/main/ZAZA.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/barlossxi/barlossxi/main/InterfaceManager.lua.txt"))()

local ScreenGui1 = Instance.new("ScreenGui")
local ImageButton1 = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

ScreenGui1.Name = "ImageButton"
ScreenGui1.Parent = game.CoreGui
ScreenGui1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton1.Parent = ScreenGui1
ImageButton1.BackgroundTransparency = 1
ImageButton1.BorderSizePixel = 0
ImageButton1.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
ImageButton1.Size = UDim2.new(0, 50, 0, 50)
ImageButton1.Draggable = true
ImageButton1.Image = "rbxassetid://10723396107"
ImageButton1.MouseButton1Down:Connect(function()
	game:GetService("VirtualInputManager"):SendKeyEvent(true,305,false,game)
	game:GetService("VirtualInputManager"):SendKeyEvent(false,305,false,game)
end)
UICorner.Parent = ImageButton1

local Window = Fluent:CreateWindow({
	Title = "Rock Fruit",
	SubTitle = "Savage Hub",
	TabWidth = 130,
	Size = UDim2.fromOffset(480, 400),
	Acrylic = false, 
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
	Setting = Window:AddTab({ Title = "Setting", Icon = "settings" }),
	General = Window:AddTab({ Title = "General", Icon = "cookie" })
}

local Set = Tabs.Setting:AddSection("|Setting") 

local Slider = Set:AddSlider("Distance Farm", {
	Title = "Distance Farm",
	Description = "Monster Farming Distance Let you choose to adjust the distance.",
	Default = 0,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Callback = function(Value)
		_G.DistanceMob = Value
	end
})

Set:AddDropdown("Select Method", {
	Title = "Select Method",
	Values = {"Upper","Behind","Below"},
	Multi = false,
	Default = 1,
	Callback = function(v)
		_G.Method = v
	end
})

local MethodFarm = nil

spawn(function()
	while wait() do 
		pcall(function()
			if _G.Method == "Behind" then
				MethodFarm = CFrame.new(0,0,_G.DistanceMob)
			elseif _G.Method == "Below" then
				MethodFarm = CFrame.new(0,-_G.DistanceMob,0) * CFrame.Angles(math.rad(90),0,0)
			elseif _G.Method == "Upper" then
				MethodFarm = CFrame.new(0,_G.DistanceMob,0)  * CFrame.Angles(math.rad(-90),0,0)
			else
				MethodFarm = CFrame.new(0,_G.DistanceMob,0)  * CFrame.Angles(math.rad(-90),0,0)
			end
		end)
	end
end)

_G.Weapon = {}

local MultiDropdown = Set:AddDropdown("Select Weapon", {
	Title = "Select Weapon",
	Values = {"Melee", "Sword", "DevilFruit", "Special"},
	Multi = true,
	Default = {},
	Callback = function(vd)
		_G.Weapon = vd
		end
})

MultiDropdown:OnChanged(function(vd)
	_G.Weapon = {}
	for ez, bro in pairs(vd) do
		if ez then
			table.insert(_G.Weapon, bro)
		end
	end
end)




Set:AddToggle("Automatic Equip", {
	Title = "Automatic Equip", 
	Default = false, 
	Callback = function(equip) 
		_G.equipez = equip
	end})


spawn(function()
	while task.wait() do
		if _G.equipez then
			pcall(function()
				for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
					if table.find(_G.Weapon, v:GetAttributes("Type")) then
						repeat task.wait()
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
						until game.Players.LocalPlayer.Character:FindFirstChild(v.Name)
					end
				end
			end)
		end
	end
end)