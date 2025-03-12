--Felip's Autoclick Script

local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local UICornerFrame = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local SpeedBox = Instance.new("TextBox")
local UICornerSpeedBox = Instance.new("UICorner")
local ApplyButton = Instance.new("TextButton")
local UICornerApplyButton = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local SpeedLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0, 10, 0.5, 0)
OpenButton.Size = UDim2.new(0, 120, 0, 50)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Text = "Autoclick V4"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextScaled = true
OpenButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
end)

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

UICornerFrame.Parent = MainFrame
UICornerFrame.CornerRadius = UDim.new(0, 10)

CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(0.88, 0, 0.05, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Configurar ⚡"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true

SpeedBox.Parent = MainFrame
SpeedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedBox.Position = UDim2.new(0.1, 0, 0.3, 0)
SpeedBox.Size = UDim2.new(0, 200, 0, 30)
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.PlaceholderText = "Velocidad (ej: 50)"
SpeedBox.Text = "50"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextScaled = true

UICornerSpeedBox.Parent = SpeedBox
UICornerSpeedBox.CornerRadius = UDim.new(0, 8)

ApplyButton.Parent = MainFrame
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ApplyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
ApplyButton.Size = UDim2.new(0, 200, 0, 30)
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Text = "Aplicar Velocidad"
ApplyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ApplyButton.TextScaled = true

UICornerApplyButton.Parent = ApplyButton
UICornerApplyButton.CornerRadius = UDim.new(0, 8)

SpeedLabel.Parent = MainFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.1, 0, 0.8, 0)
SpeedLabel.Size = UDim2.new(0, 200, 0, 20)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Text = "Velocidad actual: 50"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextScaled = true

local player = game:GetService("Players").LocalPlayer
local autoClickSpeed = 1 / 50
local autoClickEnabled = true

local shiftPressed = false
spawn(function()
    task.wait(0.5)
    
    if not shiftPressed then
        local virtualInput = game:GetService("VirtualInputManager")
        virtualInput:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, nil)
        task.wait(0.1)
        virtualInput:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, nil)
        shiftPressed = true
    end
end)

local function autoClickLoop()
	while true do
		if autoClickEnabled then
			local character = player.Character
			if character then
				local tool = character:FindFirstChildOfClass("Tool")
				if tool and tool:FindFirstChild("Handle") then
					tool:Activate()
				end
			end
		end
		task.wait(autoClickSpeed)
	end
end

task.spawn(autoClickLoop)

ApplyButton.MouseButton1Click:Connect(function()
	local newSpeed = tonumber(SpeedBox.Text)
	if newSpeed and newSpeed > 0 then
		autoClickSpeed = 1 / newSpeed
		SpeedLabel.Text = "Velocidad actual: " .. newSpeed
	else
		SpeedLabel.Text = "Velocidad actual: Inválida"
	end
end)

player.CharacterAdded:Connect(function()
	autoClickEnabled = true
end)

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Loaded",
        Text = "Made by Felipe",
        Duration = 6
    })
end)