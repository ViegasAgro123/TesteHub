-- Made BY Mr.Alegator
-- Modificado por SeuNome para incluir keys fixas

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, -20)
title.Text = "Universal Key System Script"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.Parent = frame

-- (código de arrastar a janela omitido para brevidade, mas você deve manter o original)

local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(1, 0, 0.5, 0)
KeySystem.Position = UDim2.new(0, 0, 0, 0)
KeySystem.Text = "Enter the Key"
KeySystem.TextColor3 = Color3.new(0, 0, 0)
KeySystem.BackgroundTransparency = 0.5
KeySystem.BackgroundColor3 = Color3.new(1, 1, 1)
KeySystem.TextWrapped = true
KeySystem.Parent = frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.5, 0, 0.5, 0)
SubmitButton.Position = UDim2.new(0, 0, 0.5, 0)
SubmitButton.Text = "Submit"
SubmitButton.Parent = frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.Parent = frame

CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.5, 0, 0.5, 0)
GetKeyButton.Position = UDim2.new(0.5, 0, 0.5, 0)
GetKeyButton.Text = "Get Key"
GetKeyButton.Parent = frame

-- ========== CONFIGURAÇÃO DAS KEYS (FIXAS) ==========
local validKeys = {
    ["PERMA-2026"] = true,  -- key permanente
}

-- Gerar TEMP-001 até TEMP-050
for i = 1, 50 do
    local key = string.format("TEMP-%03d", i)
    validKeys[key] = true
end

-- (Opcional) Mostrar as keys no console
print("=== KEYS VÁLIDAS ===")
for k, _ in pairs(validKeys) do
    print(k)
end
print("====================")
-- ===================================================

SubmitButton.MouseButton1Click:Connect(function()
    local enteredKey = KeySystem.Text
    if validKeys[enteredKey] then
        screenGui:Destroy()

        -- ===== COLE AQUI O CÓDIGO OFUSCADO DO GAMEPLAY =====
-- ============================================
-- SCRIPT DE GAMEPLAY - AGROGUARDIAN
-- Funções: Fly, Noclip, Infinite Jump, Speed
-- ============================================

-- Carrega a biblioteca Rayfield (igual no loader)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ========== VARIÁVEIS GLOBAIS ==========
local player = game.Players.LocalPlayer
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Controles de estado
local flyEnabled = false
local noclipEnabled = false
local infiniteJumpEnabled = false

-- Valores ajustáveis (valores iniciais)
local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50

-- Referências para objetos de voo
local flyConnection = nil
local noclipConnection = nil

-- ========== CRIAÇÃO DA INTERFACE ==========
local Window = Rayfield:CreateWindow({
    Name = "🎮 AgroGuardian - Gameplay",
    LoadingTitle = "Carregando funções...",
    LoadingSubtitle = "by SeuNome",
    ConfigurationSaving = { Enabled = true }
})

-- ========== ABA DE MOVIMENTO ==========
local MoveTab = Window:CreateTab("Movimento", nil)  -- Ícone pode ser adicionado depois
local MoveSection = MoveTab:CreateSection("Controles de Voo")

-- ========== FUNÇÃO DE VOO (FLY) ==========
-- Baseada em implementações clássicas de fly para Roblox [citation:1][citation:2]

local function toggleFly()
    flyEnabled = not flyEnabled
    
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    if flyEnabled then
        -- Ativa modo de voo
        humanoid.PlatformStand = true  -- Impede animações de caminhada
        
        -- Cria BodyVelocity para controle de movimento
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1, 1, 1) * math.huge  -- Força infinita
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        -- Cria BodyGyro para manter orientação
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * math.huge
        bodyGyro.P = 1000  -- Força de rotação
        bodyGyro.D = 50
        bodyGyro.CFrame = rootPart.CFrame
        bodyGyro.Parent = rootPart
        
        -- Loop de controle do voo
        flyConnection = runService.Heartbeat:Connect(function()
            if not flyEnabled or not character or not rootPart then
                if flyConnection then flyConnection:Disconnect() end
                return
            end
            
            local moveDirection = Vector3.new(0, 0, 0)
            local camera = workspace.CurrentCamera
            
            -- Controles WASD (baseados na direção da câmera)
            if userInput:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector * flySpeed
            end
            if userInput:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector * flySpeed
            end
            if userInput:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector * flySpeed
            end
            if userInput:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector * flySpeed
            end
            
            -- Subir/descer (Space/Shift)
            if userInput:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
            end
            if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
            end
            
            -- Aplica velocidade
            bodyVelocity.Velocity = moveDirection
            -- Mantém rotação alinhada com a câmera
            bodyGyro.CFrame = camera.CFrame
        end)
        
        Rayfield:Notify({ Title = "Voo", Content = "Voo ativado! Use WASD + Espaço/Shift", Duration = 3 })
    else
        -- Desativa voo
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        -- Remove objetos de voo
        if rootPart then
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            local bodyGyro = rootPart:FindFirstChildOfClass("BodyGyro")
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
        
        if humanoid then
            humanoid.PlatformStand = false
        end
        
        Rayfield:Notify({ Title = "Voo", Content = "Voo desativado", Duration = 2 })
    end
end

-- Toggle para ativar/desativar voo
MoveTab:CreateToggle({
    Name = "Ativar Voo",
    CurrentValue = false,
    Callback = function(value)
        toggleFly()
    end
})

-- Slider para velocidade do voo
MoveTab:CreateSlider({
    Name = "Velocidade do Voo",
    Range = {10, 200},
    Increment = 5,
    Suffix = "studs/s",
    CurrentValue = flySpeed,
    Callback = function(value)
        flySpeed = value
    end
})

-- ========== SEÇÃO DE NOCLIP ==========
MoveTab:CreateSection("Atravessar Paredes")

-- Função de Noclip [citation:1][citation:3][citation:5]
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        -- Ativa noclip: desativa colisão de todas as partes do personagem
        noclipConnection = runService.Stepped:Connect(function()
            local character = player.Character
            if not character then return end
            
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        
        Rayfield:Notify({ Title = "Noclip", Content = "Noclip ativado! Você atravessa paredes.", Duration = 3 })
    else
        -- Desativa noclip
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        -- Restaura colisão (opcional - o jogo pode restaurar sozinho)
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        Rayfield:Notify({ Title = "Noclip", Content = "Noclip desativado", Duration = 2 })
    end
end

MoveTab:CreateToggle({
    Name = "Noclip (Atravessar Paredes)",
    CurrentValue = false,
    Callback = function(value)
        toggleNoclip()
    end
})

-- ========== SEÇÃO DE PULO E VELOCIDADE ==========
MoveTab:CreateSection("Pulo e Velocidade")

-- Infinite Jump (Super Pulo) [citation:2][citation:5][citation:6]
MoveTab:CreateToggle({
    Name = "Super Pulo (Infinito)",
    CurrentValue = false,
    Callback = function(value)
        infiniteJumpEnabled = value
        if value then
            Rayfield:Notify({ Title = "Super Pulo", Content = "Pulo infinito ativado! Aperte espaço várias vezes.", Duration = 3 })
        else
            Rayfield:Notify({ Title = "Super Pulo", Content = "Pulo infinito desativado", Duration = 2 })
        end
    end
})

-- Slider para altura do pulo
MoveTab:CreateSlider({
    Name = "Altura do Pulo",
    Range = {50, 500},
    Increment = 5,
    Suffix = "studs",
    CurrentValue = jumpPower,
    Callback = function(value)
        jumpPower = value
        -- Aplica imediatamente se o personagem existir
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = value
            end
        end
    end
})

-- Slider para velocidade de andar [citation:4][citation:8]
MoveTab:CreateSlider({
    Name = "Velocidade de Andar",
    Range = {16, 200},
    Increment = 1,
    Suffix = "studs/s",
    CurrentValue = walkSpeed,
    Callback = function(value)
        walkSpeed = value
        -- Aplica imediatamente
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end
})

-- Botão para resetar valores padrão
MoveTab:CreateButton({
    Name = "Resetar Valores Padrão",
    Callback = function()
        walkSpeed = 16
        jumpPower = 50
        flySpeed = 50
        
        -- Aplica aos sliders (Rayfield atualiza automaticamente)
        -- Aplica ao personagem
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
        end
        
        Rayfield:Notify({ Title = "Reset", Content = "Valores restaurados para padrão", Duration = 2 })
    end
})

-- ========== EVENTOS GLOBAIS ==========

-- Infinite Jump: detecta quando o usuário tenta pular [citation:5][citation:6]
userInput.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Monitora mudanças de personagem (respawn)
player.CharacterAdded:Connect(function(newCharacter)
    -- Quando o personagem renasce, precisamos reaplicar configurações
    
    -- Pequena espera para o personagem carregar
    task.wait(1)
    
    -- Reaplica walkspeed e jump power se estiverem diferentes do padrão
    local humanoid = newCharacter:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if walkSpeed ~= 16 then
            humanoid.WalkSpeed = walkSpeed
        end
        if jumpPower ~= 50 then
            humanoid.JumpPower = jumpPower
        end
    end
    
    -- Se noclip estiver ativado, precisamos religar (a conexão Stepped continua, mas o personagem mudou)
    -- A conexão já vai pegar o novo personagem automaticamente no próximo Stepped
    
    -- Se fly estiver ativado, precisamos reiniciar (os objetos BodyVelocity foram destruídos)
    if flyEnabled then
        -- Desliga o estado antigo e religa
        flyEnabled = false
        toggleFly()  -- Isso vai reativar com o novo personagem
    end
end)

-- ========== FINALIZAÇÃO ==========
print("✅ Script de gameplay carregado com sucesso!")
        -- ====================================================

    else
        -- Opcional: mostrar mensagem de erro
        local notification = Instance.new("Message")
        notification.Parent = game.Players.LocalPlayer.PlayerGui
        notification.Text = "Key inválida!"
        wait(2)
        notification:Destroy()
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-target.net/3091163/DIRBjnjPH47Q") -- Substitua pelo seu link
    local notification = Instance.new("Message")
    notification.Parent = game.Players.LocalPlayer.PlayerGui
    notification.Text = "Link copiado para a área de transferência!"
    wait(2)
    notification:Destroy()
end)
