-- Ultimate Loader - исправленная версия
local function LoadHub()
    print("🔄 Загрузка хаба...")
    
    -- Проверка исполнителя
    local executorExists = (syn and true) or (issirhurtclosure and true) or (is_sirhurt_closure and true) or (iskrnl and true) or (getexecutorname and true)
    
    if not executorExists then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ Ошибка",
            Text = "Требуется исполнитель (KRNL/Synapse)",
            Duration = 5
        })
        return false
    end

    -- Пробуем разные возможные пути
    local possiblePaths = {
        "https://raw.githubusercontent.com/Atimenka/Test-script-roblox/main/loader.lua",
        "https://raw.githubusercontent.com/Atimenka/Test-script-roblox/main/hub.lua",
        "https://raw.githubusercontent.com/Atimenka/Test-script-roblox/main/main.lua"
    }

    for _, path in ipairs(possiblePaths) do
        local success, response = pcall(function()
            return game:HttpGet(path .. "?t=" .. os.time(), true)
        end)
        
        if success then
            local loaded, err = pcall(function()
                loadstring(response)()
            end)
            
            if loaded then
                print("✅ Хаб успешно загружен!")
                return true
            else
                warn("❌ Ошибка выполнения: " .. tostring(err))
            end
        else
            warn("❌ Ошибка загрузки: " .. tostring(response))
        end
    end

    -- Если ни один путь не сработал
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Файл не найден",
        Text = "Проверьте наличие hub.lua в репозитории",
        Duration = 5
    })
    
    return false
end

-- Запускаем загрузку
LoadHub()
