local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ch1teruga/DarkTriadCheat/main/Library.lua"))()

local Window = Library.CreateLib("DarkTriad", "RJTheme3")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetHumanoid()
local Character = LocalPlayer.Character
return Character and Character:FindFirstChildOfClass("Humanoid")
end

local Speed = 16
local JumpPower = 50
local JumpHeight = 7.2

local SpeedEnabled = false
local JumpPowerEnabled = false
local JumpHeightEnabled = false

local Tab = Window:NewTab("Передвижение")

local SpeedSection = Tab:NewSection("Скорость")

SpeedSection:NewTextBox("Скорость", "Укажите скорость (деф. 16)", function(value)
local num = tonumber(value)


if num then
    Speed = num
end


end)

SpeedSection:NewToggle("Применить скорость", "Вкл/Выкл скорость", function(state)
SpeedEnabled = state


local Humanoid = GetHumanoid()

if Humanoid then
    if state then
        Humanoid.WalkSpeed = Speed
    else
        Humanoid.WalkSpeed = 16
    end
end


end)

local JumpPowerSection = Tab:NewSection("JumpPower")

JumpPowerSection:NewTextBox("Сила прыжка", "Укажите силу прыжка (деф. 50)", function(value)
local num = tonumber(value)


if num then
    JumpPower = num
end


end)

JumpPowerSection:NewToggle("Применить силу прыжка", "Вкл/Выкл JumpPower", function(state)
JumpPowerEnabled = state


if state then
    JumpHeightEnabled = false
end

local Humanoid = GetHumanoid()

if Humanoid then
    Humanoid.UseJumpPower = true

    if state then
        Humanoid.JumpPower = JumpPower
    else
        Humanoid.JumpPower = 50
    end
end


end)

local JumpHeightSection = Tab:NewSection("JumpHeight")

JumpHeightSection:NewTextBox("Высота прыжка", "Укажите высоту прыжка (деф. 7.2)", function(value)
local num = tonumber(value)


if num then
    JumpHeight = num
end


end)

JumpHeightSection:NewToggle("Применить высоту прыжка", "Вкл/Выкл JumpHeight", function(state)
JumpHeightEnabled = state


if state then
    JumpPowerEnabled = false
end

local Humanoid = GetHumanoid()

if Humanoid then
    Humanoid.UseJumpPower = false

    if state then
        Humanoid.JumpHeight = JumpHeight
    else
        Humanoid.JumpHeight = 7.2
    end
end


end)

task.spawn(function()
while task.wait(0.1) do
local Humanoid = GetHumanoid()


    if Humanoid then
        if SpeedEnabled then
            Humanoid.WalkSpeed = Speed
        end

        if JumpPowerEnabled then
            Humanoid.UseJumpPower = true
            Humanoid.JumpPower = JumpPower
        end

        if JumpHeightEnabled then
            Humanoid.UseJumpPower = false
            Humanoid.JumpHeight = JumpHeight
        end
    end
end


end)
