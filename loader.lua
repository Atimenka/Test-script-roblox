local GitHu-- Universal Loader - работает на любом исполнителе
local function IsExecutor()
    return (syn and true) or (issirhurtclosure and true) or (is_sirhurt_closure and true) or (iskrnl and true) or (getexecutorname and true)
end

if not IsExecutor() then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "❌ Требуется исполнитель",
        Text = "Используйте KRNL/Synapse/SirHurt",
        Duration = 5
    })
    return
end

-- Загрузка хаба
local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/ВАШ_USERNAME/KRNL-Ultimate-Hub/main/hub.lua?v=" .. os.time(), true)
end)

if success then
    local loaded, err = pcall(function()
        loadstring(response)()
    end)
    if not loaded then
        warn("Ошибка загрузки: " .. tostring(err))
    end
else
    warn("Ошибка сети: " .. tostring(response))
end
