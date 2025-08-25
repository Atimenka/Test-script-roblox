-- Ultimate Hub v10.0 - ПОЛНОСТЬЮ ГОТОВЫЙ
if _G.UltimateHub then return end
_G.UltimateHub = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 ULTIMATE HUB v10.0",
    LoadingTitle = "Загрузка готовых функций...",
    LoadingSubtitle = "Не нужно программировать!",
    ConfigurationSaving = {Enabled = true, FolderName = "UltimateHub_Config"}
})

-- Автоопределение игры
local GameDB = {
    [142823291] = "Murder Mystery 2",
    [4924922222] = "Brookhaven RP", 
    [286090429] = "Arsenal",
    [606849621] = "Jailbreak",
    [1962086868] = "Tower of Hell",
    [2788229376] = "Doors",
    [6447798030] = "Blox Fruits"
}

local CurrentGame = GameDB[game.GameId] or "Unknown Game"

-- 📦 УНИВЕРСАЛЬНЫЕ ФУНКЦИИ (работают везде)
local UniversalTab = Window:CreateTab("🌐 Универсальные", 13078580573)

UniversalTab:CreateSlider({
    Name = "🚀 Скорость передвижения",
    Range = {16, 200},
    Increment = 5,
    Suffix = "studs/s",
    CurrentValue = 16,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

UniversalTab:CreateButton({
    Name = "✨ Привет мир!",
    Callback = function()
        Rayfield:Notify({
            Title = "Привет мир!",
            Content = "Вы нажали кнопку!",
            Duration = 3
        })
    end
})

-- 🎮 ФУНКЦИИ ДЛЯ КОНКРЕТНЫХ ИГР
local GameTab = Window:CreateTab("🎮 " .. CurrentGame, 7733960981)

-- Автоматические функции для каждой игры
if CurrentGame == "Murder Mystery 2" then
    GameTab:CreateButton({
        Name = "🔪 Авто-поиск ножей",
        Callback = function()
            for _, tool in pairs(game:GetService("ReplicatedStorage").Items.Knives:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Clone().Parent = game.Players.LocalPlayer.Backpack
                end
            end
            Rayfield:Notify({Title = "Готово!", Content = "Ножи добавлены в инвентарь"})
        end
    })

elseif CurrentGame == "Brookhaven RP" then
    GameTab:CreateButton({
        Name = "🏠 Телепорт к дому",
        Callback = function()
            local house = workspace.Properties:FindFirstChild("House")
            if house then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = house.CFrame + Vector3.new(0, 5, 0)
            end
        end
    })

elseif CurrentGame == "Arsenal" then
    GameTab:CreateToggle({
        Name = "🎯 Простой прицел",
        CurrentValue = false,
        Callback = function(Value)
            if Value then
                -- Простой прицел
                local circle = Instance.new("Part")
                circle.Size = Vector3.new(1, 1, 1)
                circle.BrickColor = BrickColor.new("Bright red")
                circle.Anchored = true
                circle.Parent = workspace
                circle.Position = Vector3.new(0, 0, 0)
            end
        end
    })
end

-- ⚙️ НАСТРОЙКИ
local SettingsTab = Window:CreateTab("⚙️ Настройки", 7733960981)

SettingsTab:CreateKeybind({
    Name = "📱 Открыть/Закрыть меню",
    CurrentKeybind = "RightControl",
    Callback = function(Keybind)
        Window:Toggle(Keybind)
    end
})

-- 📢 УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ
Rayfield:Notify({
    Title = "✅ Хаб загружен!",
    Content = "Игра: " .. CurrentGame .. "\nНажми RightControl для меню",
    Duration = 6
})

-- 💾 АВТО-СОХРАНЕНИЕ
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    pcall(function()
        Rayfield:SaveConfiguration()
    end)
end)

-- 🛡️ ЗАЩИТА ОТ ОШИБОК
while true do
    task.wait(30)
    pcall(function()
        Rayfield:SaveConfiguration()
    end)
end
