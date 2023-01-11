getgenv().GetMousePosition = function()
    local playerMouse = game.Players.LocalPlayer:GetMouse()
    return playerMouse.X, playerMouse.Y
end

getgenv().GetMousePositionAsCFrame = function(isFloor)
    local playerMouse = game.Players.LocalPlayer:GetMouse()
    local vector = playerMouse.Hit.Position

    if isFloor then
        return Vector3.new(math.floor(vector.X), math.floor(vector.Y), math.floor(vector.Z))
    else
        return vector
    end
end

function getTextBounds(Text, Font, Size, Resolution)
	local Bounds = game:GetService("TextService"):GetTextSize(Text, Size, Font, Resolution or Vector2.new(1920, 1080))
	return Bounds.X, Bounds.Y
end

getgenv().IsPointing = getgenv().IsPointing or false

local ScreenGui = game.CoreGui:FindFirstChild("Get Mouse Position Library") or Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Get Mouse Position Library"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99

local TweenStyle = Enum.EasingStyle.Sine
local TweenDirection = Enum.EasingDirection.InOut
local TweenService = game:GetService("TweenService")

getgenv().PointLocation = function(callback)
    while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end

    local mouse = game.Players.LocalPlayer:GetMouse()
    local oldIcon = mouse.Icon

    mouse.Icon = "http://www.roblox.com/asset/?id=417446600"

    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local UIStroke = Instance.new("UIStroke")

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Size = UDim2.new(0, 265, 0, 35)

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 14.000

    UIStroke.Parent = Frame
    UIStroke.Color = Color3.fromRGB(0, 120, 215)

    spawn(function()
        while wait() do
            local X, Y = getgenv().GetMousePosition()

            TweenService:Create(Frame, TweenInfo.new(0.1), {Position = UDim2.new(0, X + 20, 0, Y + 50);}):Play()
            
            TextLabel.Text = tostring(getgenv().GetMousePositionAsCFrame())
            TweenService:Create(Frame, TweenInfo.new(0.1), {Size = UDim2.new(0, select(1, getTextBounds(TextLabel.Text, Enum.Font.Gotham, 14)) + 10, 0, 35)}):Play()
        end
    end)

    local Returned = false
    mouse.Button1Down:connect(function()
        if not Returned then
            Returned = true
            TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundTransparency = 1;}):Play()
            TweenService:Create(TextLabel, TweenInfo.new(0.1), {TextTransparency = 1;}):Play()
            TweenService:Create(UIStroke, TweenInfo.new(0.1), {Transparency = 1;}):Play()

            pcall(callback, getgenv().GetMousePositionAsCFrame())

            delay(5, function()
                Frame:Destroy()
            end)
        end
    end)
end

getgenv().PointLocation(function(Position)
    print(tostring(Position))
end)
