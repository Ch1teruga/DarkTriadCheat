-- =========================
-- Библиотека
-- =========================

local Library = local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ch1teruga/DarkTriadCheat/main/Library.lua"))()
local Window = Library.CreateLib("DarkTriad", "RJTheme3")

-- =========================
-- Сервисы
-- =========================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- Функции
-- =========================

local function GetHumanoid()
local Character = LocalPlayer.Character
return Character and Character:FindFirstChildOfClass("Humanoid")
end

-- =========================
-- Переменные
-- =========================

local Speed = 16
local JumpPower = 50
local JumpHeight = 7.2

local SpeedEnabled = false
local JumpPowerEnabled = false
local JumpHeightEnabled = false

-- =========================
-- Меню
-- =========================

local MenuTab = Window:NewTab("Меню")

-- Информация

local InfoSection = MenuTab:NewSection("Информация")

InfoSection:NewText("DarkTriad v1.0")
InfoSection:NewText("Создатель: Ch1teruga")

-- Статус

local StatusSection = MenuTab:NewSection("Статус")

StatusSection:NewText("Тема: RJTheme3")

-- Кредиты

local CreditsSection = MenuTab:NewSection("Credits")

CreditsSection:NewText("Спасибо за использование DarkTriad")

-- =========================
-- Передвижение
-- =========================

local Tab = Window:NewTab("Передвижение")

-- Скорость

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

-- JumpPower

local JumpPowerSection = Tab:NewSection("Сила прыжка")

JumpPowerSection:NewTextBox("Сила прыжка", "Укажите силу прыжка (деф. 50)", function(value)
local num = tonumber(value)


if num then
    JumpPower = num
end


end)

JumpPowerSection:NewToggle("Применить силу прыжка", "Вкл/Выкл силу прыжка указаную выше", function(state)
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

-- JumpHeight

local JumpHeightSection = Tab:NewSection("Высота прыжка")

JumpHeightSection:NewTextBox("Высота прыжка", "Укажите высоту прыжка (деф. 7.2)", function(value)
local num = tonumber(value)


if num then
    JumpHeight = num
end


end)

JumpHeightSection:NewToggle("Применить высоту прыжка", "Вкл/Выкл силу прыжка указаную выше", function(state)
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

-- =========================
-- Основной цикл
-- =========================

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


end)    else
        Humanoid.JumpPower = 50
    end
end


end)

local JumpHeightSection = Tab:NewSection("Сила прыжка")

JumpHeightSection:NewTextBox("Сила прыжка", "Укажите высоту прыжка (деф. 7.2)", function(value)
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
