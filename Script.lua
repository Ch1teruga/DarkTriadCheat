local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()

local Window = Library.CreateLib("DarkTrial", "RJTheme3")

local Tab = Window:NewTab("Передвижение")
local Section = Tab:NewSection("Скорость")

local Speed = 16
local Enabled = false

-- ввод скорости
Section:NewTextBox("Скорость", "Укажите скорость", function(speed)
    local num = tonumber(speed)
    if num then
        Speed = num
    end
end)

-- toggle (переключатель)
Section:NewToggle("Обход замедления", "Вкл/Выкл фиксацию скорости", function(state)
    Enabled = state

    local char = game.Players.LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")

    if humanoid then
        if Enabled then
            humanoid.WalkSpeed = Speed
        else
            humanoid.WalkSpeed = 16
        end
    end
end)

-- цикл поддержки скорости
task.spawn(function()
    while task.wait(0.1) do
        if Enabled then
            local char = game.Players.LocalPlayer.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = Speed
            end
        end
    end
end
