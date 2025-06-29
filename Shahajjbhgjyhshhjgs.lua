local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Vyntric Dark Red",
    Accent = "#7b1e1e",       -- Deep dark red for accents
    Outline = "#ffffff",      -- White outline for clarity
    Text = "#ffffff",         -- White text
    Placeholder = "#b85c5c",  -- Muted red for placeholders
    Background = "#1a0d0d",   -- Very dark red/blackish for background
    Button = "#8b2c2c",       -- Dark red for buttons
    Icon = "#d46a6a",         -- Light red/pink for icons
})

local Window = WindUI:CreateWindow({
    Title = "Vyntric Hub",
    Icon = "satellite",
    Author = "Muscle Legends | by ttvkaiser and Exv_",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Vyntric Dark Red",
    SideBarWidth = 200,
    Background = "", -- rbxassetid only
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
})

Window:EditOpenButton({
    Title = "Vyntric Hub",
    Icon = "satellite",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("1a0d0d"), 
        Color3.fromHex("7b1e1e")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = false,
})

local Home = Window:Tab({
    Title = "Home",
    Icon = "house",
    Locked = false,
})
local Main = Window:Tab({
    Title = "Main",
    Icon = "align-justify",
    Locked = false,
})
local Rocks = Window:Tab({
    Title = "Rocks",
    Icon = "mountain",
    Locked = false,
})
local Rebirth = Window:Tab({
    Title = "Rebirth",
    Icon = "biceps-flexed",
    Locked = false,
})
local Kills = Window:Tab({
    Title = "Auto Kill",
    Icon = "skull",
    Locked = false,
})
local Teleport = Window:Tab({
    Title = "Teleport",
    Icon = "tree-palm",
    Locked = false,
})
local Crystals = Window:Tab({
    Title = "Crystals",
    Icon = "gem",
    Locked = false,
})
local Status = Window:Tab({
    Title = "Status",
    Icon = "circle-plus",
    Locked = false,
})
local Misc = Window:Tab({
    Title = "Misc",
    Icon = "command",
    Locked = false,
})

Window:SelectTab(1)

local DiscordInviteSection = Home:Section({ 
    Title = "Discord Invite",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local Button = Home:Button({
    Title = "Copy Discord Invite",
    Desc = "Click to copy invite to clipboard",
    Locked = false,
    Callback = function()
        local inviteLink = "https://discord.gg/G6q7FJCyc8"
        if setclipboard then
            setclipboard(inviteLink)
            print("Copied to clipboard:", inviteLink)
        else
            warn("Clipboard function not supported on this executor.")
        end
    end
})

local LocalPlayerSection = Home:Section({ 
    Title = "Local Player Configurations",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local originalSpeed = humanoid.WalkSpeed -- Store original
local speedValue = originalSpeed         -- Default to original for safety

-- Input box for speed
local EnterSpeedInput = Home:Input({
    Title = "Enter Speed",
    Desc = "",
    Value = "",
    InputIcon = "",
    Type = "Input",
    Placeholder = "Enter speed...",
    Callback = function(input)
        local num = tonumber(input)
        if num then
            speedValue = num
            print("Speed value set to:", speedValue)
        else
            warn("Invalid speed input")
        end
    end
})

-- Set Speed Toggle
local SetSpeedToggle = Home:Toggle({
    Title = "Set Speed",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            originalSpeed = humanoid.WalkSpeed -- Remember current speed
            humanoid.WalkSpeed = speedValue
            print("Speed applied:", speedValue)
        else
            humanoid.WalkSpeed = originalSpeed
            print("Speed restored to:", originalSpeed)
        end
    end
})

-- Infinite Jump
local infJumpEnabled = false

local InfJumpToggle = Home:Toggle({
    Title = "Infinite Jumps",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        infJumpEnabled = state
        print("Infinite Jump: " .. tostring(state))
    end
})

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- No Clip
local noclip = false

local NoClipToggle = Home:Toggle({
    Title = "No Clip",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        noclip = state
        print("No Clip: " .. tostring(state))
    end
})

RunService.Stepped:Connect(function()
    if noclip then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

local AutoFarmSection = Main:Section({ 
    Title = "Auto Farm",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local autoLiftRunning = false

local AutoLiftToggle = Main:Toggle({
    Title = "Auto Lift",
    Desc = "Works with anything",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoLiftRunning = state
        print("Toggle Activated: " .. tostring(state))

        if state then
            task.spawn(function()
                local player = game:GetService("Players").LocalPlayer
                local muscleEvent = player:WaitForChild("muscleEvent")

                while autoLiftRunning do
                    muscleEvent:FireServer("rep")
                    task.wait(0.1)
                end
            end)
        end
    end
})

local runPunchLoop = false

local AutoPunchToggle = Main:Toggle({
    Title = "Auto Fast Punch",
    Desc = "Automatically punches fast with animation",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        runPunchLoop = state

        task.spawn(function()
            while runPunchLoop do
                local player = game.Players.LocalPlayer
                local char = player.Character or game.Workspace:FindFirstChild(player.Name)
                local punchTool = player.Backpack:FindFirstChild("Punch") or (char and char:FindFirstChild("Punch"))

                if punchTool then
                    -- Equip tool if it's not already equipped
                    if punchTool.Parent ~= char then
                        punchTool.Parent = char
                        task.wait(0.1)
                    end

                    -- Reduce attack time if applicable
                    local attackTime = punchTool:FindFirstChild("attackTime")
                    if attackTime then
                        attackTime.Value = 0
                    end

                    punchTool:Activate()
                else
                    warn("Punch tool not found")
                    AutoPunchToggle:SetValue(false)
                    break
                end

                task.wait()
            end
        end)
    end
})

local AutoPunchNormalToggle = Main:Toggle({
    Title = "Auto Normal Punch",
    Desc = "Automatically punches normal with animation",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        runPunchLoop = state

        task.spawn(function()
            while runPunchLoop do
                local player = game.Players.LocalPlayer
                local char = player.Character or game.Workspace:FindFirstChild(player.Name)
                local punchTool = player.Backpack:FindFirstChild("Punch") or (char and char:FindFirstChild("Punch"))

                if punchTool then
                    -- Equip tool if it's not already equipped
                    if punchTool.Parent ~= char then
                        punchTool.Parent = char
                        task.wait(0.1)
                    end

                    -- Reduce attack time if applicable
                    local attackTime = punchTool:FindFirstChild("attackTime")
                    if attackTime then
                        attackTime.Value = 0.35
                    end

                    punchTool:Activate()
                else
                    warn("Punch tool not found")
                    AutoPunchToggle:SetValue(false)
                    break
                end

                task.wait()
            end
        end)
    end
})

local AutoGymSection = Main:Section({ 
    Title = "Auto Gym",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local AutoEquipSection = Main:Section({ 
    Title = "Auto Equip",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local AutoToolsSection = Main:Section({ 
    Title = "Auto Tools",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local WhitelistingSection = Kills:Section({ 
    Title = "Whitelisting",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local whitelist = {}

local WhitelistInput = Kills:Input({
    Title = "Whitelist Player",
    Desc = "Adds player to whitelist",
    Value = "",
    InputIcon = "",
    Type = "Input", -- or "Textarea"
    Placeholder = "Enter username...",
    Callback = function(input)
        local target = game.Players:FindFirstChild(input)
        if target then
            whitelist[target.Name] = true
            print("Whitelisted: " .. target.Name)
        else
            warn("Player not found: " .. input)
        end
    end
})

local autoKillRunning = false
local whitelist = whitelist or {} -- Ensure it's defined

local AutoWhitelistKillToggle = Kills:Toggle({
    Title = "Auto Kill (Whitelist)",
    Desc = "Only kills players on your whitelist",
    Icon = "skull",
    Type = "",
    Default = false,
    Callback = function(state)
        autoKillRunning = state

        task.spawn(function()
            while autoKillRunning do
                local player = game.Players.LocalPlayer

                for _, target in ipairs(game.Players:GetPlayers()) do
                    if target ~= player and whitelist[target.Name] then
                        local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                        local rHand = player.Character and player.Character:FindFirstChild("RightHand")
                        local lHand = player.Character and player.Character:FindFirstChild("LeftHand")

                        if root and rHand and lHand then
                            firetouchinterest(rHand, root, 1)
                            firetouchinterest(lHand, root, 1)
                            firetouchinterest(rHand, root, 0)
                            firetouchinterest(lHand, root, 0)
                        end
                    end
                end

                task.wait(0.1)
            end
        end)
    end
})

local BlacklistingSection = Kills:Section({ 
    Title = "Blacklisting",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local blacklist = {}

local BlacklistInput = Kills:Input({
    Title = "Blacklist Player",
    Desc = "Adds player to blacklist",
    Value = "",
    InputIcon = "",
    Type = "Input", -- or "Textarea"
    Placeholder = "Enter username...",
    Callback = function(input)
        local target = game.Players:FindFirstChild(input)
        if target then
            blacklist[target.Name] = true
            print("Blacklisted: " .. target.Name)
        else
            warn("Player not found: " .. input)
        end
    end
})

local autoKillRunning = false
local blacklist = blacklist or {} -- Ensure it's defined

local AutoBlackKillToggle = Kills:Toggle({
    Title = "Auto Kill (Blacklist)",
    Desc = "Auto kills only blacklisted players",
    Icon = "",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoKillRunning = state

        task.spawn(function()
            while autoKillRunning do
                local player = game.Players.LocalPlayer

                for _, target in ipairs(game.Players:GetPlayers()) do
                    if target ~= player and blacklist[target.Name] then
                        local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                        local rHand = player.Character and player.Character:FindFirstChild("RightHand")
                        local lHand = player.Character and player.Character:FindFirstChild("LeftHand")

                        if root and rHand and lHand then
                            firetouchinterest(rHand, root, 1)
                            firetouchinterest(lHand, root, 1)
                            firetouchinterest(rHand, root, 0)
                            firetouchinterest(lHand, root, 0)
                        end
                    end
                end

                task.wait(0.1)
            end
        end)
    end
})

local AutoKillsSection = Kills:Section({ 
    Title = "Auto Kills",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local autoKillRunning = false

local AutoKillToggle = Kills:Toggle({
    Title = "Auto Kill",
    Desc = "Auto kills all players",
    Icon = "", -- You can change this icon
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoKillRunning = state

        task.spawn(function()
            while autoKillRunning do
                local player = game.Players.LocalPlayer

                for _, target in ipairs(game.Players:GetPlayers()) do
                    if target ~= player and not whitelist[target.Name] then
                        local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                        local rHand = player.Character and player.Character:FindFirstChild("RightHand")
                        local lHand = player.Character and player.Character:FindFirstChild("LeftHand")

                        if root and rHand and lHand then
                            firetouchinterest(rHand, root, 1)
                            firetouchinterest(lHand, root, 1)
                            firetouchinterest(rHand, root, 0)
                            firetouchinterest(lHand, root, 0)
                        end
                    end
                end

                task.wait(0.1)
            end
        end)
    end
})

local MatrixAuraSection = Kills:Section({ 
    Title = "Matrix Aura",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local TeleportToPlayerSection = Teleport:Section({ 
    Title = "Teleport To Players",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local TeleportToAreaSection = Teleport:Section({ 
    Title = "Teleport To Area",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})

local TeleportToSecretSection = Teleport:Section({ 
    Title = "Teleport To Secrets",
    TextXAlignment = "Left",
    TextSize = 19, -- Default Size
})
