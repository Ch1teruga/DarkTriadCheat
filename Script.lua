-- =========================
-- Лицензия
-- =========================

print("===== LICENSE =====")
print(game:HttpGet("https://raw.githubusercontent.com/Ch1teruga/DarkTriadCheat/main/LICENSE"))
print("===================")

print("Лицензия загружена...")

-- =========================
-- Библиотека
-- =========================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ch1teruga/DarkTriadCheat/main/Library.lua"))()
local Window = Library.CreateLib("DarkTriad", "RJTheme3")

print("Библиотека загружена...")

-- =========================
-- Переменные
-- =========================

-- Сервисы
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Параметры
local Speed = 16
local JumpPower = 50
local JumpHeight = 7.2

local SpeedEnabled = false
local JumpPowerEnabled = false
local JumpHeightEnabled = false

print("Переменые загружены...")

-- =========================
-- Функции
-- =========================

local function GetHumanoid()
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function ApplySettings()
    local Humanoid = GetHumanoid()
    if not Humanoid then return end

    if SpeedEnabled then
        Humanoid.WalkSpeed = Speed
    else
        Humanoid.WalkSpeed = 16
    end

    if JumpPowerEnabled then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = JumpPower
    elseif JumpHeightEnabled then
        Humanoid.UseJumpPower = false
        Humanoid.JumpHeight = JumpHeight
    else
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50
        Humanoid.JumpHeight = 7.2
    end
end

print("Функции загружены...")

-- =========================
-- Меню
-- =========================

local MenuTab = Window:NewTab("Меню")

-- Информация
local InfoSection = MenuTab:NewSection("Информация")
InfoSection:NewText("DarkTriad v1.0")
InfoSection:NewText("Создатель: Ch1teruga")

-- Примечание
local NoteSection = MenuTab:NewSection("Примечание")
NoteSection:NewText("После ввода значения скорости, силы прыжка и т.д нажимайте Enter")
NoteSection:NewText("Не используйте одновременно силу прыжка и высоту прыжка")
NoteSection:NewText("Лицензия проекта: https://github.com/Ch1teruga/DarkTriadCheat/blob/main/LICENSE")

-- Статус
local StatusSection = MenuTab:NewSection("Статус")
StatusSection:NewText("Тема: RJTheme3")

-- Кредиты
local CreditsSection = MenuTab:NewSection("Credits")
CreditsSection:NewText("Спасибо за использование DarkTriad")

print("Меню загружено...")

-- =========================
-- Передвижение
-- =========================

local Tab = Window:NewTab("Передвижение")

-- Скорость
local SpeedSection = Tab:NewSection("Скорость")
SpeedSection:NewTextBox("Скорость", "Укажите скорость (деф. 16)", function(value)
    local num = tonumber(value)
    if num then Speed = num; ApplySettings() end
end)
SpeedSection:NewToggle("Применить скорость", "Вкл/Выкл скорость", function(state)
    SpeedEnabled = state
    ApplySettings()
end)

-- Сила прыжка
local JumpPowerSection = Tab:NewSection("Сила прыжка")
JumpPowerSection:NewTextBox("Сила прыжка", "Укажите силу прыжка (деф. 50)", function(value)
    local num = tonumber(value)
    if num then JumpPower = num; ApplySettings() end
end)
JumpPowerSection:NewToggle("Применить силу прыжка", "Вкл/Выкл силу прыжка", function(state)
    JumpPowerEnabled = state
    if state then JumpHeightEnabled = false end
    ApplySettings()
end)

-- Высота прыжка
local JumpHeightSection = Tab:NewSection("Высота прыжка")
JumpHeightSection:NewTextBox("Высота прыжка", "Укажите высоту прыжка (деф. 7.2)", function(value)
    local num = tonumber(value)
    if num then JumpHeight = num; ApplySettings() end
end)
JumpHeightSection:NewToggle("Применить высоту прыжка", "Вкл/Выкл высоту прыжка", function(state)
    JumpHeightEnabled = state
    if state then JumpPowerEnabled = false end
    ApplySettings()
end)

print("Передвижение загружено...")

-- =========================
-- Автоприменение после смерти
-- =========================

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    ApplySettings()
end)

print("Автоприменение после смерти загружено...")

-- =========================
-- Основной цикл
-- =========================

task.spawn(function()
    while task.wait(0.1) do
        ApplySettings()
    end
end)

print("Основной цикл загружен...")

print("Скрипт загружен.")
