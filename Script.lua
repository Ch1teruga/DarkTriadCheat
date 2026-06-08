-- =========================
-- Библиотека
-- =========================

local LibraryUrl = "https://raw.githubusercontent.com/Ch1teruga/DarkTriadCheat/main/Library.lua"
local Library = nil

-- Безопасная загрузка библиотеки с авто-обходом блокировок GitHub
local success, result = pcall(function()
    return game:HttpGet(LibraryUrl)
end)

if success and result then
    Library = loadstring(result)()
else
    warn("Прямой доступ к GitHub заблокирован, используем зеркало для обхода...")
    -- Если оригинальная ссылка выдает ошибку DnsResolve, скрипт автоматически качает через githack
    local FallbackUrl = "https://rawcdn.githack.com/Ch1teruga/DarkTriadCheat/refs/heads/main/Library.lua"
    Library = loadstring(game:HttpGet(FallbackUrl))()
end

print("Библиотека загружена...")

local Window = Library.CreateLib("DarkTriad", "RJTheme3")

-- =========================
-- Переменные
-- =========================

-- Сервисы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Передвижение
local Speed = 16
local JumpPower = 50
local JumpHeight = 7.2
local FlySpeed = 50

local SpeedEnabled = false
local JumpPowerEnabled = false
local JumpHeightEnabled = false
local FlyEnabled = false
local FlyConnection = nil
local InfiniteJumpEnabled = false

-- Игрок
local AntiAfkEnabled = false

-- =========================
-- Функции
-- =========================

local function GetHumanoid()
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart()
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

-- Функция управления физикой полета (С изменением высоты по камере)
local function UpdateFlightPhysics()
    local RootPart = GetRootPart()
    local Humanoid = GetHumanoid()
    if not RootPart or not Humanoid then return end

    if FlyEnabled then
        local BodyVelocity = RootPart:FindFirstChild("FlightVelocity") or Instance.new("BodyVelocity")
        if not RootPart:FindFirstChild("FlightVelocity") then
            BodyVelocity.Name = "FlightVelocity"
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Parent = RootPart
        end

        local BodyGyro = RootPart:FindFirstChild("FlightGyro") or Instance.new("BodyGyro")
        if not RootPart:FindFirstChild("FlightGyro") then
            BodyGyro.Name = "FlightGyro"
            BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.P = 10000
            BodyGyro.Parent = RootPart
        end

        if not FlyConnection then
            FlyConnection = RunService.RenderStepped:Connect(function()
                local CurrentRoot = GetRootPart()
                local CurrentHumanoid = GetHumanoid()
                if not CurrentRoot or not CurrentHumanoid then return end

                local Camera = workspace.CurrentCamera
                local Gym = CurrentRoot:FindFirstChild("FlightGyro")
                local Vel = CurrentRoot:FindFirstChild("FlightVelocity")

                if Gym then Gym.CFrame = Camera.CFrame end
                if Vel then
                    local MoveDirection = CurrentHumanoid.MoveDirection
                    
                    if MoveDirection.Magnitude > 0 then
                        local CameraCFrame = Camera.CFrame
                        local LookVector = CameraCFrame.LookVector
                        local RightVector = CameraCFrame.RightVector
                        
                        local ForwardComponent = MoveDirection:Dot(CameraCFrame.LookVector)
                        local RightComponent = MoveDirection:Dot(CameraCFrame.RightVector)
                        
                        local FinalDirection = (LookVector * ForwardComponent + RightVector * RightComponent).Unit
                        Vel.Velocity = FinalDirection * FlySpeed
                    else
                        Vel.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    else
        if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
        if RootPart:FindFirstChild("FlightVelocity") then RootPart.FlightVelocity:Destroy() end
        if RootPart:FindFirstChild("FlightGyro") then RootPart.FlightGyro:Destroy() end
        if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end

local function ApplySettings()
    local Humanoid = GetHumanoid()
    if not Humanoid then return end

    if FlyEnabled then
        Humanoid.WalkSpeed = 0
    else
        if SpeedEnabled then
            Humanoid.WalkSpeed = Speed
        else
            Humanoid.WalkSpeed = 16
        end
    end
    
    -- Что то про силу прыжка
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

-- Логика бесконечного прыжка
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Humanoid = GetHumanoid()
        if Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Логика Анти-АФК
LocalPlayer.Idled:Connect(function()
    if AntiAfkEnabled then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end
end)

-- =========================
-- Меню
-- =========================

local MenuTab = Window:NewTab("Меню")

-- Информация
local InfoSection = MenuTab:NewSection("Информация")
InfoSection:NewText("DarkTriad v1.0")
InfoSection:NewText("Создатель: Ch1teruga")
InfoSection:NewText("Помощь: ChatGPT & Gemini")

-- Примечание
local NoteSection = MenuTab:NewSection("Примечание")
NoteSection:NewText("После ввода значения скорости, силы прыжка")
NoteSection:NewText("и т.д нажимайте Enter")
NoteSection:NewText("Не используйте одновременно силу прыжка и высоту прыжка")
NoteSection:NewText("Лицензия проекта: https://github.com")

-- Статус
local StatusSection = MenuTab:NewSection("Статус")
StatusSection:NewText("Тема: RJTheme3")

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

-- Полёт
local FlySection = Tab:NewSection("Полёт")

FlySection:NewTextBox("Скорость полета", "Укажите скорость полета (деф. 50)", function(value)
    local num = tonumber(value)
    if num then 
        FlySpeed = num 
        if FlyEnabled then UpdateFlightPhysics() end
    end
end)

FlySection:NewToggle("Применить полет", "Вкл/Выкл полет на любой платформе", function(state)
    FlyEnabled = state
    UpdateFlightPhysics()
    ApplySettings()
end)

FlySection:NewKeybind("Клавиша полета", "Быстрое переключение (ПК)", Enum.KeyCode.F, function()
    FlyEnabled = not FlyEnabled
    UpdateFlightPhysics()
    ApplySettings()
end)

-- Бесконечный прыжок
local InfJumpSection = Tab:NewSection("Бесконечный прыжок")

InfJumpSection:NewToggle("Включить инф. прыжок", "Позволяет прыгать бесконечно в воздухе", function(state)
    InfiniteJumpEnabled = state
end)

-- =========================
-- Игрок
-- =========================

local PlayerTab = Window:NewTab("Игрок")

-- Анти-АФК
local AfkSection = PlayerTab:NewSection("Анти-АФК")

AfkSection:NewToggle("Включить Анти-АФК", "Защищает от вылета из игры за АФК", function(state)
    AntiAfkEnabled = state
end)

-- =========================
-- Автоприменение после смерти
-- =========================

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    UpdateFlightPhysics()
    ApplySettings()
end)


-- =========================
-- Основной цикл
-- =========================

task.spawn(function()
    while task.wait(0.1) do
        ApplySettings()
    end
end)
