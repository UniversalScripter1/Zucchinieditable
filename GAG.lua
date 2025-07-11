debugX = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Zucchini Hub",
    Icon = 0,
    LoadingTitle = "Universal scripter",
    LoadingSubtitle = "by Lance",
    Theme = "Default",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

local Tab = Window:CreateTab("Replica", 4483362458)
local Section = Tab:CreateSection("Dupe Section")

local InfoLabel = Tab:CreateLabel("Must wait 1 hour to duplicate")
local TimerLabel = Tab:CreateLabel("")
local ToolNameLabel = Tab:CreateLabel("Currently holding: None")

-- 🔁 Real-time tool monitor
task.spawn(function()
    local player = game.Players.LocalPlayer
    while task.wait(0.5) do
        local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
        if tool then
            ToolNameLabel:Set("Currently holding: " .. tool.Name)
        else
            ToolNameLabel:Set("Currently holding: None")
        end
    end
end)

-- 🕒 Timer logic
local timerRunning = false

local Button = Tab:CreateButton({
    Name = "Dupe",
    Callback = function()
        if timerRunning then
            Rayfield:Notify({
                Title = "Cooldown Active",
                Content = "You need to wait for 1 hour!",
                Duration = 5
            })
            return
        end

        Rayfield:Notify({
            Title = "Timer Started",
            Content = "You must wait 1 hour.",
            Duration = 4
        })

        timerRunning = true
        local totalSeconds = 3600 -- 1 hour

        task.spawn(function()
            for i = totalSeconds, 0, -1 do
                local minutes = math.floor(i / 60)
                local seconds = i % 60
                TimerLabel:Set("Time remaining: " .. string.format("%02d:%02d", minutes, seconds))
                task.wait(1)
            end

            game.Players.LocalPlayer:Kick("If it didn't dupe try again")
        end)
    end,
})

Rayfield:LoadConfiguration()
