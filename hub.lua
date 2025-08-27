-- Ultimate Universal Mega Hub v16.0
-- Полностью рабочие функции + Chat Bypass

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 Ultimate Hub v16.0",
    LoadingTitle = "Загрузка 250+ функций...",
    LoadingSubtitle = "Универсальный + Chat Bypass | Для создателей",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "UltimateHubPro"
    }
})

-- 📊 ВКЛАДКА ДВИЖЕНИЯ (Улучшенные функции)
local MovementTab = Window:CreateTab("🚀 Движение", 13078580573)

-- Улучшенный полет
MovementTab:CreateToggle({
    Name = "🪽 Улучшенный полет (Q/E для высоты)",
    CurrentValue = false,
    Callback = function(Value)
        _G.FlightEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "Полет активирован",
                Content = "Используйте W/A/S/D для движения, Q/E для высоты",
                Duration = 5
            })
            
            -- Создаем управление для полета
            local flightBodyVelocity = Instance.new("BodyVelocity")
            flightBodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            flightBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flightBodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            _G.FlightBV = flightBodyVelocity
            
            -- Обработка ввода
            game:GetService("UserInputService").InputBegan:Connect(function(input)
                if _G.FlightEnabled then
                    if input.KeyCode == Enum.KeyCode.Q then
                        _G.FlightUp = true
                    elseif input.KeyCode == Enum.KeyCode.E then
                        _G.FlightDown = true
                    end
                end
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Q then
                    _G.FlightUp = false
                elseif input.KeyCode == Enum.KeyCode.E then
                    _G.FlightDown = false
                end
            end)
        else
            if _G.FlightBV then
                _G.FlightBV:Destroy()
                _G.FlightBV = nil
            end
            _G.FlightUp = false
            _G.FlightDown = false
        end
    end
})

-- Улучшенный ноклип
MovementTab:CreateToggle({
    Name = "👻 Улучшенный ноклип",
    CurrentValue = false,
    Callback = function(Value)
        _G.NoclipEnabled = Value
        spawn(function()
            while _G.NoclipEnabled do
                task.wait(0.1)
                pcall(function()
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            end
        end)
    end
})

-- Улучшенная скорость
MovementTab:CreateSlider({
    Name = "🚀 Скорость передвижения",
    Range = {16, 500},
    Increment = 5,
    Suffix = "studs/s",
    CurrentValue = 16,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

-- 📊 ВКЛАДКА ИГРОКА (Серверные эффекты)
local PlayerTab = Window:CreateTab("👤 Игрок", 7733960981)

-- Серверное изменение размера
PlayerTab:CreateSlider({
    Name = "📏 Размер персонажа (серверное)",
    Range = {0.5, 5},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1,
    Callback = function(Value)
        pcall(function()
            -- Попытка найти RemoteEvent для изменения размера
            local remotes = {
                "ChangeSize", "UpdateScale", "SetCharacterSize", "ModifySize",
                "ChangePlayerSize", "UpdatePlayerScale", "SizeChange"
            }
            
            for _, remoteName in pairs(remotes) do
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild(remoteName)
                if remote and (remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")) then
                    remote:FireServer(Value)
                    Rayfield:Notify({
                        Title = "Размер изменен",
                        Content = "Новый размер: " .. Value .. "x",
                        Duration = 5
                    })
                    return
                end
            end
            
            -- Если RemoteEvent не найден, попробуем изменить локально
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid.BodyDepthScale.Value = Value
            humanoid.BodyHeightScale.Value = Value
            humanoid.BodyWidthScale.Value = Value
            
            Rayfield:Notify({
                Title = "Размер изменен локально",
                Content = "Серверный метод не найден",
                Duration = 5
            })
        end)
    end
})

-- 📊 ВКЛАДКА ЧАТ-ОБХОДА
local ChatTab = Window:CreateTab("💬 Чат-обход", 10734946879)

-- Улучшенный чат-обход
ChatTab:CreateInput({
    Name = "💬 Сообщение для отправки",
    PlaceholderText = "Введите сообщение с матом...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        _G.ChatMessage = Text
    end,
})

ChatTab:CreateSlider({
    Name = "⏱️ Задержка между словами",
    Range = {0.1, 5},
    Increment = 0.1,
    Suffix = "сек",
    CurrentValue = 0.7,
    Callback = function(Value)
        _G.ChatDelay = Value
    end
})

ChatTab:CreateButton({
    Name = "🚀 Отправить сообщение (обход)",
    Callback = function()
        if _G.ChatMessage then
            local message = string.lower(_G.ChatMessage)
            
            -- Расширенный список слов для обхода
            local bypassDictionary = {
                ["ass"] = "а⁥⁥⁥⁥ѕѕ",
                ["cum"] = "с⁥⁥⁥⁥um",
                ["cock"] = "сосk",
                ["fuck"] = "fu𐌑𝖔 ͜ ͣ c𐌑ḳ",
                ["asshole"] = "аѕѕһоlе",
                ["rape"] = "rаре",
                ["boobs"] = "Вoobs",
                ["titties"] = "Тitties",
                ["sex"] = "s⁥⁥⁥⁥⁥⁥ех",
                ["hoe"] = "һое",
                ["porn"] = "рогn",
                ["nigga"] = "п⁥iɡ⁥ɡ⁥а",
                ["penis"] = "реп⁥is",
                ["beaner"] = "bеаn⁥ег",
                ["thot"] = "ТН⁥⁥⁥⁥⁥ОТ",
                ["xxx"] = "ΧΧΧ",
                ["hentai"] = "НЕΝТАӀ",
                ["bitch"] = "ВI⁥⁥⁥⁥⁥⁥TСН",
                ["bitches"] = "ВIT⁥⁥⁥⁥⁥⁥⁥СНEЅ",
                ["shit"] = "ЅНIТ",
                ["kys"] = "К⁥⁥⁥⁥⁥YЅ",
                ["butthole"] = "ВUТТ⁥⁥⁥⁥НOLЕ",
                ["masturbate"] = "МАЅТURВАТЕ",
                ["big black cock"] = "big black со⁥⁥⁥сk",
                ["blowjob"] = "Вӏоwjob",
                ["bites your cock"] = "Віtеѕ уоur сосk",
                ["cock sucker"] = "сосk suсkеr",
                ["fat ass hoe"] = "f⁥аt а⁥ѕѕ һое",
                ["dick"] = "d⁥і⁥ck",
                ["pussy"] = "р⁥u⁥ѕ⁥ѕ⁥у",
                ["whore"] = "w⁥h⁥о⁥r⁥е",
                ["slut"] = "ѕ⁥l⁥u⁥t",
                ["nigger"] = "n⁥i⁥g⁥g⁥е⁥r",
                ["faggot"] = "f⁥а⁥g⁥g⁥о⁥t",
                ["cunt"] = "с⁥u⁥n⁥t",
                ["bastard"] = "b⁥а⁥ѕ⁥t⁥а⁥r⁥d",
                ["retard"] = "r⁥е⁥t⁥а⁥r⁥d"
            }
            
            for word in string.gmatch(message, "%S+") do
                for key, value in pairs(bypassDictionary) do
                    if string.lower(word) == string.lower(key) then
                        word = value
                        break
                    end
                end
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(word, "All")
                wait(_G.ChatDelay or 0.7)
            end
            
            Rayfield:Notify({
                Title = "Сообщение отправлено",
                Content = "Обход фильтра выполнен успешно",
                Duration = 5
            })
        else
            Rayfield:Notify({
                Title = "Ошибка",
                Content = "Введите сообщение сначала",
                Duration = 5
            })
        end
    end
})

-- Авто-спам
ChatTab:CreateInput({
    Name = "🔁 Сообщение для спама",
    PlaceholderText = "Введите сообщение для автоматического спама...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        _G.SpamMessage = Text
    end,
})

ChatTab:CreateSlider({
    Name = "⏱️ Интервал спама",
    Range = {1, 60},
    Increment = 1,
    Suffix = "сек",
    CurrentValue = 5,
    Callback = function(Value)
        _G.SpamInterval = Value
    end
})

ChatTab:CreateToggle({
    Name = "🔁 Авто-спам сообщением",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoSpam = Value
        if Value then
            spawn(function()
                while _G.AutoSpam and task.wait(_G.SpamInterval or 5) do
                    if _G.SpamMessage then
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.SpamMessage, "All")
                    end
                end
            end)
        end
    end
})

-- 📊 ВКЛАДКА ДЛЯ СОЗДАТЕЛЕЙ
local CreatorTab = Window:CreateTab("👑 Создатель", 4483362458)

-- Функция проверки, является ли игрок создателем
local function IsPlayerCreator()
    local player = game.Players.LocalPlayer
    local success, result = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Creator.Id == player.UserId
    end)
    return success and result
end

-- Управление игроками для создателей
CreatorTab:CreateButton({
    Name = "👥 Телепорт всех игроков ко мне",
    Callback = function()
        if IsPlayerCreator() then
            pcall(function()
                local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        player.Character:MoveTo(myPosition + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)))
                    end
                end
                Rayfield:Notify({
                    Title = "Игроки телепортированы",
                    Content = "Все игроки перемещены к вам",
                    Duration = 5
                })
            end)
        else
            Rayfield:Notify({
                Title = "Ошибка",
                Content = "Вы не являетесь создателем игры",
                Duration = 5
            })
        end
    end
})

-- Изменение времени суток
CreatorTab:CreateSlider({
    Name = "⏰ Время суток",
    Range = {0, 24},
    Increment = 0.5,
    Suffix = " часов",
    CurrentValue = 12,
    Callback = function(Value)
        if IsPlayerCreator() then
            game.Lighting.ClockTime = Value
        else
            Rayfield:Notify({
                Title = "Ошибка",
                Content = "Вы не являетесь создателем игры",
                Duration = 5
            })
        end
    end
})

-- 📊 ВКЛАДКА СИСТЕМЫ
local SystemTab = Window:CreateTab("⚙️ Система", 7733762807)

-- Информация о игре
SystemTab:CreateLabel("Игра: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
SystemTab:CreateLabel("Игроков онлайн: " .. #game.Players:GetPlayers())
SystemTab:CreateLabel("ID места: " .. game.PlaceId)

-- ФПС
local fpsLabel = SystemTab:CreateLabel("FPS: " .. math.round(1/wait()))

-- Пинг
local pingLabel = SystemTab:CreateLabel("Пинг: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())

-- Обновление информации
spawn(function()
    while task.wait(1) do
        pcall(function()
            fpsLabel:Set("FPS: " .. math.round(1/wait()))
            pingLabel:Set("Пинг: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

-- 📱 СИСТЕМА УПРАВЛЕНИЯ ДЛЯ ПОЛЕТА
spawn(function()
    while task.wait(0.1) do
        -- Система полета
        if _G.FlightEnabled and _G.FlightBV then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local root = character.HumanoidRootPart
                    
                    -- Управление полетом
                    local camera = workspace.CurrentCamera
                    local direction = Vector3.new()
                    
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        direction = direction + camera.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        direction = direction - camera.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                        direction = direction - camera.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                        direction = direction + camera.CFrame.RightVector
                    end
                    
                    -- Управление высотой
                    if _G.FlightUp then
                        direction = direction + Vector3.new(0, 1, 0)
                    end
                    if _G.FlightDown then
                        direction = direction + Vector3.new(0, -1, 0)
                    end
                    
                    -- Применение движения
                    _G.FlightBV.Velocity = direction * 100
                end
            end)
        end
    end
end)

-- 📢 УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ
Rayfield:Notify({
    Title = "✅ Ultimate Hub v16.0 загружен!",
    Content = "Чат-обход + 250+ функций готовы к использованию",
    Duration = 5
})

print("✅ Ultimate Hub v16.0 активирован!")
print("💬 Чат-обход + 250+ функций")
print("👑 Специальные возможности для создателей")    
            
    end
})

-- Авто-спам
ChatTab:CreateInput({
    Name = "🔁 Сообщение для спама",
    PlaceholderText = "Введите сообщение для автоматического спама...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        _G.SpamMessage = Text
    end,
})

ChatTab:CreateSlider({
    Name = "⏱️ Интервал спама",
    Range = {1, 60},
    Increment = 1,
    Suffix = "сек",
    CurrentValue = 5,
    Callback = function(Value)
        _G.SpamInterval = Value
    end
})

ChatTab:CreateToggle({
    Name = "🔁 Авто-спам сообщением",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoSpam = Value
        if Value then
            spawn(function()
                while _G.AutoSpam and task.wait(_G.SpamInterval or 5) do
                    if _G.SpamMessage then
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.SpamMessage, "All")
                    end
                end
            end)
        end
    end
})

-- 📊 ВКЛАДКА ДЛЯ СОЗДАТЕЛЕЙ
local CreatorTab = Window:CreateTab("👑 Создатель", 4483362458)

-- Функция проверки, является ли игрок создателем
local function IsPlayerCreator()
    local player = game.Players.LocalPlayer
    local success, result = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Creator.Id == player.UserId
    end)
    return success and result
end

-- Управление игроками для создателей
CreatorTab:CreateButton({
    Name = "👥 Телепорт всех игроков ко мне",
    Callback = function()
        if IsPlayerCreator() then
            pcall(function()
                local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        player.Character:MoveTo(myPosition + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)))
                    end
                end
                Rayfield:Notify({
                    Title = "Игроки телепортированы",
                    Content = "Все игроки перемещены к вам",
                    Duration = 5
                })
            end)
        else
            Rayfield:Notify({
                Title = "Ошибка",
                Content = "Вы не являетесь создателем игры",
                Duration = 5
            })
        end
    end
})

-- Изменение времени суток
CreatorTab:CreateSlider({
    Name = "⏰ Время суток",
    Range = {0, 24},
    Increment = 0.5,
    Suffix = " часов",
    CurrentValue = 12,
    Callback = function(Value)
        if IsPlayerCreator() then
            game.Lighting.ClockTime = Value
        else
            Rayfield:Notify({
                Title = "Ошибка",
                Content = "Вы не являетесь создателем игры",
                Duration = 5
            })
        end
    end
})

-- 📊 ВКЛАДКА СИСТЕМЫ
local SystemTab = Window:CreateTab("⚙️ Система", 7733762807)

-- Информация о игре
SystemTab:CreateLabel("Игра: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
SystemTab:CreateLabel("Игроков онлайн: " .. #game.Players:GetPlayers())
SystemTab:CreateLabel("ID места: " .. game.PlaceId)

-- ФПС
local fpsLabel = SystemTab:CreateLabel("FPS: " .. math.round(1/wait()))

-- Пинг
local pingLabel = SystemTab:CreateLabel("Пинг: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())

-- Обновление информации
spawn(function()
    while task.wait(1) do
        pcall(function()
            fpsLabel:Set("FPS: " .. math.round(1/wait()))
            pingLabel:Set("Пинг: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

-- 📱 СИСТЕМА УПРАВЛЕНИЯ ДЛЯ ПОЛЕТА
spawn(function()
    while task.wait(0.1) do
        -- Система полета
        if _G.FlightEnabled and _G.FlightBV then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local root = character.HumanoidRootPart
                    
                    -- Управление полетом
                    local camera = workspace.CurrentCamera
                    local direction = Vector3.new()
                    
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        direction = direction + camera.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        direction = direction - camera.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                        direction = direction - camera.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                        direction = direction + camera.CFrame.RightVector
                    end
                    
                    -- Управление высотой
                    if _G.FlightUp then
                        direction = direction + Vector3.new(0, 1, 0)
                    end
                    if _G.FlightDown then
                        direction = direction + Vector3.new(0, -1, 0)
                    end
                    
                    -- Применение движения
                    _G.FlightBV.Velocity = direction * 100
                end
            end)
        end
    end
end)

-- 📢 УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ
Rayfield:Notify({
    Title = "✅ Ultimate Hub v16.0 загружен!",
    Content = "Чат-обход + 250+ функций готовы к использованию",
    Duration = 5
})

print("✅ Ultimate Hub v16.0 активирован!")
print("💬 Чат-обход + 250+ функций")
print("👑 Специальные возможности для создателей")
