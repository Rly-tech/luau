local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local PhantomForcesWindow = Library:NewWindow("Hunting Season | موسم الصيد")

local good = PhantomForcesWindow:NewSection("Esp | الكشف")

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera


local espEnabled = false
local espConnection
local espDeadEnabled = false
local espDeadConnection


local function createESP(part)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = Color3.new(1, 0, 0) 
    highlight.OutlineColor = Color3.new(1, 1, 1) 
    highlight.FillTransparency = 0.5 
    highlight.OutlineTransparency = 0 
    highlight.Parent = part
end


local function removeESP(part)
    local highlight = part:FindFirstChildOfClass("Highlight")
    if highlight then
        highlight:Destroy()
    end
end


local function checkLiveAnimals()
    local animalsFolder = Workspace:FindFirstChild("Animals") 
    if animalsFolder then
        for _, animal in pairs(animalsFolder:GetChildren()) do
            if animal:IsA("Model") and animal:FindFirstChild("Humanoid") then
                if animal.Humanoid.Health > 0 then
                    if not animal:FindFirstChildOfClass("Highlight") then
                        createESP(animal)
                    end
                else
                    removeESP(animal)
                end
            else
                removeESP(animal)
            end
        end
    end
end


local function checkDeadAnimals()
    local deadAnimalsFolder = Workspace:FindFirstChild("DeadAnimals")
    if deadAnimalsFolder then
        for _, deadAnimal in pairs(deadAnimalsFolder:GetChildren()) do
            if deadAnimal:IsA("Model") and deadAnimal:FindFirstChild("Humanoid") and deadAnimal.Humanoid.Health <= 0 then
                if not deadAnimal:FindFirstChildOfClass("Highlight") then
                    createESP(deadAnimal)
                end
            else
                removeESP(deadAnimal)
            end
        end
    end
end

good:CreateToggle("espAnimals | كشف الحيوانات", function(value)
    espEnabled = value

    if value then
        
        espConnection = RunService.RenderStepped:Connect(function()
            checkLiveAnimals()
        end)
    else
        
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end

        
        local animalsFolder = Workspace:FindFirstChild("Animals")
        if animalsFolder then
            for _, animal in pairs(animalsFolder:GetChildren()) do
                removeESP(animal)
            end
        end
    end
end)

good:CreateToggle("EspDead | كشف الحيوانات الميته", function(value)
    espDeadEnabled = value

    if value then
        
        espDeadConnection = RunService.RenderStepped:Connect(function()
            checkDeadAnimals()
        end)
    else
        
        if espDeadConnection then
            espDeadConnection:Disconnect()
            espDeadConnection = nil
        end

        
        local deadAnimalsFolder = Workspace:FindFirstChild("DeadAnimals")
        if deadAnimalsFolder then
            for _, deadAnimal in pairs(deadAnimalsFolder:GetChildren()) do
                removeESP(deadAnimal)
            end
        end
    end
end)


RunService.RenderStepped:Connect(function()
    if espDeadEnabled then
        checkDeadAnimals()
    end
end) 

local KillingCheats = PhantomForcesWindow:NewSection("Discord | ديسكورد")

KillingCheats:CreateButton("Sajad7258", function()
print("dis")
end)