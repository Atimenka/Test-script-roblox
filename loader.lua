local GitHubRawURL = "https://raw.githubusercontent.com/YourUsername/Ultimate-Roblox-Hub/main/hub.lua"

local function SafeLoad()
    local success, response = pcall(function()
        return game:HttpGet(GitHubRawURL .. "?v=" .. os.time(), true)
    end)
    
    if success then
        local loaded, err = pcall(function()
            loadstring(response)()
        end)
        
        if not loaded then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Ошибка загрузки",
                Text = "Попробуйте позже",
                Duration = 5
            })
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Нет подключения",
            Text = "Проверьте интернет",
            Duration = 5
        })
    end
end

SafeLoad()
