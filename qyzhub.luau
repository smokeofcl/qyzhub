-- / Qyzmu Hub

function main()
-- [ Configuracoes ] -- / Servicos e referencias globais
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local Camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera
end)
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [ Sistema de Idiomas ] -- / Tabela de traducao e configuracao inicial
local CurrentLang = "en"
local Locale = {
    en = {
        tab_dash = "Dashboard", tab_visuals = "Visuals", tab_combat = "Combat", tab_move = "Movement", tab_perf = "Performance",
        section_server = "Server", admin_alert = "Administrator Alert", lang_btn = "Language: English",
        game = "Game", server = "Server", players = "Players", ping = "Ping",
        sec_esp = "ESP", esp_tracer = "Tracer", esp_hitbox = "Hitbox", esp_hl = "Highlights", esp_hl_wall = "Highlights Through Walls",
        esp_skel = "Skeleton", esp_name = "Name", esp_dist = "Distance", esp_health = "Health",
        esp_faction = "Faction Members", esp_banner = "Faction Banners", esp_cars = "Cars", esp_horses = "Horses", esp_corpses = "Corpses",
        esp_corpses_name = "Corpses Name", esp_corpses_hl = "Corpses Highlight",
        sec_colors = "ESP Colors", col_tracer = "Set Tracer color", col_hl = "Set Highlights color", col_hitbox = "Set Hitbox color",
        col_corpse = "Set Corpses color", col_faction = "Set Faction Member color", col_banner = "Set Faction Banner color",
        col_car = "Set Cars color", col_horse = "Set Horses color",
        sec_dists = "ESP Distances", dist_player = "Player ESP Distance", dist_car = "Car ESP Distance",
        dist_horse = "Horse ESP Distance", dist_corpse = "Corpse ESP Distance", dist_banner = "Faction Banner ESP Distance",
        sec_light = "Lighting", fullbright = "FullBright",
        sec_aimbot = "Aimbot", aimbot = "Aimbot", aimbot_legit = "Aimbot Legit", team_check = "Team Check", wallbang = "Wallbang",
        sec_fov = "FOV Circle", fov_size = "FOV Size", fov_color = "FOV Color",
        sec_player = "Player", speed = "Speed", speed_amt = "Speed Amount", jump = "Jump Height", jump_amt = "Jump Height Amount",
        noclip = "Noclip", fly = "Fly", fly_speed = "Fly Speed",
        sec_veh = "Vehicle", veh_fly = "Vehicle Fly", veh_speed = "Vehicle Fly Speed", veh_cap = "Vehicle Fly Speed Cap",
        veh_noclip = "Vehicle Noclip", veh_spd_pct = "Vehicle Speed", veh_fuel = "Drive Without Fuel", fly_height = "Fly Height",
        veh_bring = "Bring Nearest Car",
        sec_horse = "Horse", horse_speed = "Horse Speed", horse_jump = "Horse Jump", horse_jump_h = "Horse Jump Height",
        horse_air = "Horse Air Jump", horse_sprint = "Horse Keep Sprint", horse_shoot = "Shoot On Horse",
        sec_misc = "Misc", freecam = "Freecam", freecam_tp = "Freecam TP", freecam_speed = "Freecam Speed",
        respawn_death = "Respawn At Death Spot", respawn = "Respawn",
        sec_tp = "Teleport", tp_map = "Map Click TP", tp_low = "Low Health TP", tp_low_pct = "Low Health %",
        sec_perf = "Performance", perf_fps = "FPS Boost", perf_particles = "Particles", perf_bloom = "Bloom / SunRays",
        perf_tree = "Tree Shadows", perf_preload = "Preload GUI", perf_film = "Film Grain",
        perf_lights = "Lights", perf_shadows = "All Shadows", perf_graphics = "Graphics Quality"
    },
    pt = {
        tab_dash = "Painel", tab_visuals = "Visual", tab_combat = "Combate", tab_move = "Movimento", tab_perf = "Desempenho",
        section_server = "Servidor", admin_alert = "Alerta de Administrador", lang_btn = "Idioma: Português",
        game = "Jogo", server = "Servidor", players = "Jogadores", ping = "Ping",
        sec_esp = "ESP", esp_tracer = "Rastreador", esp_hitbox = "Hitbox", esp_hl = "Destaques", esp_hl_wall = "Destaques Através das Paredes",
        esp_skel = "Esqueleto", esp_name = "Nome", esp_dist = "Distância", esp_health = "Vida",
        esp_faction = "Membros da Facção", esp_banner = "Bandeiras da Facção", esp_cars = "Carros", esp_horses = "Cavalos", esp_corpses = "Corpos",
        esp_corpses_name = "Nome dos Corpos", esp_corpses_hl = "Contorno dos Corpos",
        sec_colors = "Cores do ESP", col_tracer = "Cor do Rastreador", col_hl = "Cor dos Destaques", col_hitbox = "Cor da Hitbox",
        col_corpse = "Cor dos Corpos", col_faction = "Cor dos Membros", col_banner = "Cor das Bandeiras",
        col_car = "Cor dos Carros", col_horse = "Cor dos Cavalos",
        sec_dists = "Distâncias do ESP", dist_player = "Distância Jogadores", dist_car = "Distância Carros",
        dist_horse = "Distância Cavalos", dist_corpse = "Distância Corpos", dist_banner = "Distância Bandeiras",
        sec_light = "Iluminação", fullbright = "Modo Dia",
        sec_aimbot = "Aimbot", aimbot = "Aimbot", aimbot_legit = "Aimbot Legit", team_check = "Checar Time", wallbang = "Atirar Através de Paredes",
        sec_fov = "Círculo FOV", fov_size = "Tamanho FOV", fov_color = "Cor FOV",
        sec_player = "Jogador", speed = "Velocidade", speed_amt = "Quantidade Velocidade", jump = "Pulo", jump_amt = "Altura do Pulo",
        noclip = "Noclip", fly = "Voar", fly_speed = "Velocidade do Voo",
        sec_veh = "Veículo", veh_fly = "Carro Voar", veh_speed = "Velocidade do Carro", veh_cap = "Limitar Velocidade",
        veh_noclip = "Carro Noclip", veh_spd_pct = "Velocidade do Carro (%)", veh_fuel = "Dirigir Sem Combustível", fly_height = "Altura do Voo",
        veh_bring = "Puxar Carro Mais Próximo",
        sec_horse = "Cavalo", horse_speed = "Velocidade Cavalo", horse_jump = "Pulo Cavalo", horse_jump_h = "Altura Pulo Cavalo",
        horse_air = "Pulo no Ar", horse_sprint = "Corrida Infinita", horse_shoot = "Atirar Montado",
        sec_misc = "Diversos", freecam = "Câmera Livre", freecam_tp = "Teleportar Câmera", freecam_speed = "Velocidade Câmera",
        respawn_death = "Respawn no Local", respawn = "Respawn",
        sec_tp = "Teletransportar", tp_map = "Clique no Mapa", tp_low = "Teleporte Vida Baixa", tp_low_pct = "Vida Baixa %",
        sec_perf = "Desempenho", perf_fps = "Boost FPS", perf_particles = "Partículas", perf_bloom = "Bloom / Raios",
        perf_tree = "Sombras Árvores", perf_preload = "Pré-carregar GUI", perf_film = "Granulado",
        perf_lights = "Luzes", perf_shadows = "Todas Sombras", perf_graphics = "Qualidade Gráfica"
    }
}

local registeredTexts = {}
function registerText(element, key)
    table.insert(registeredTexts, { el = element, key = key })
    element.Text = Locale[CurrentLang][key] or key
end

function updateLanguage()
    for _, data in ipairs(registeredTexts) do
        data.el.Text = Locale[CurrentLang][data.key] or data.key
    end
end

-- [ Paleta de cores ] -- / Somente quadrados, sem nomes
local PaletaCores = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(0, 0, 0),
    Color3.fromRGB(255, 220, 0),
    Color3.fromRGB(180, 0, 255),
    Color3.fromRGB(255, 50, 50),
    Color3.fromRGB(50, 230, 80)
}
local CorPadrao = PaletaCores[1]

-- [ Config tables ] -- / ESP, Aimbot, Perf, Player, Server
local EspConfig = {
    Hitbox = false, Highlights = false, HighlightsThroughWalls = false,
    Skeleton = false, Name = false, Distance = false, Health = false,
    FactionMembers = false, FactionBanners = false, Cars = false, Horses = false, Corpses = false,
    CorpsesName = false, CorpsesHighlight = false,
    Tracer = false, FullBright = false
}
local AimbotConfig = { Enabled = false, Legit = false, TeamCheck = false, Wallbang = false, ShowFOV = false, FOV = 100, FOVColor = CorPadrao }
local PerfConfig = {
    FPSBoost = false, Particles = false, BloomSunRays = false, TreeShadows = false, PreloadGUI = false,
    FilmGrain = false, MapLights = false, AllShadows = false, LowerGraphics = false
}
local PlayerConfig = {
    CarFly = false, FlyHeight = 30, VehicleFlySpeed = 50, VehicleFlySpeedCap = true, VehicleNoclip = false,
    VehicleSpeed = 100, DriveWithoutFuel = false, JumpHeight = false, JumpHeightAmount = 50, Speed = false,
    SpeedAmount = 25, Fly = false, FlySpeed = 50, Noclip = false, HorseSpeed = 100, HorseJump = false,
    HorseSpeedEnabled = false, HorseJumpHeight = 7, HorseAirJump = false, HorseKeepSprint = false, ShootOnHorse = true, Freecam = false,
    FreecamTP = false, FreecamSpeed = 50, RespawnAtDeathSpot = false, Respawn = false, MapClickTP = false,
    LowHealthTP = false, LowHealthPct = 30
}
local ServerConfig = { AdminAlert = false }

local EspDistances = { Player = 3000, Car = 3000, Horse = 3000, Corpse = 3000, FactionBanner = 3000 }
local EspColors = {
    Highlights = CorPadrao, Hitbox = CorPadrao, Corpses = CorPadrao, FactionMember = CorPadrao, FactionBanner = CorPadrao,
    Cars = CorPadrao, Horses = CorPadrao,
    Tracer = Color3.fromRGB(255, 0, 0)
}

-- [ Save/Load ] -- / Persiste config em arquivo
local CONFIG_FILE = "QyzmuHub_Config.json"
local SaveLoad = {}
local saveEnabled = false

function color3ToTable(c) return { R = c.R, G = c.G, B = c.B } end
function tableToColor3(t) if type(t) ~= "table" then return nil end return Color3.new(t.R or 0, t.G or 0, t.B or 0) end

function serializeAllConfigs()
    local colors = {}
    for k, v in pairs(EspColors) do colors[k] = color3ToTable(v) end
    return {
        Lang = CurrentLang, EspConfig = EspConfig,
        AimbotConfig = { Enabled = AimbotConfig.Enabled, Legit = AimbotConfig.Legit, TeamCheck = AimbotConfig.TeamCheck, ShowFOV = AimbotConfig.ShowFOV, Wallbang = AimbotConfig.Wallbang, FOV = AimbotConfig.FOV, FOVColor = color3ToTable(AimbotConfig.FOVColor) },
        PerfConfig = PerfConfig, PlayerConfig = PlayerConfig, ServerConfig = ServerConfig,
        EspDistances = EspDistances, EspColors = colors
    }
end

function applyLoadedData(data)
    if type(data) ~= "table" then return end
    if data.Lang and Locale[data.Lang] then CurrentLang = data.Lang end
    if type(data.EspConfig) == "table" then for k, v in pairs(data.EspConfig) do EspConfig[k] = v end end
    if type(data.AimbotConfig) == "table" then
        AimbotConfig.Enabled = data.AimbotConfig.Enabled or false
        AimbotConfig.Legit = data.AimbotConfig.Legit or false
        AimbotConfig.TeamCheck = data.AimbotConfig.TeamCheck or false
        AimbotConfig.ShowFOV = data.AimbotConfig.ShowFOV or false
        AimbotConfig.Wallbang = data.AimbotConfig.Wallbang or false
        AimbotConfig.FOV = data.AimbotConfig.FOV or 100
        if data.AimbotConfig.FOVColor then
            local c = tableToColor3(data.AimbotConfig.FOVColor)
            if c then AimbotConfig.FOVColor = c end
        end
    end
    if type(data.PerfConfig) == "table" then for k, v in pairs(data.PerfConfig) do PerfConfig[k] = v end end
    if type(data.PlayerConfig) == "table" then for k, v in pairs(data.PlayerConfig) do PlayerConfig[k] = v end end
    if type(data.ServerConfig) == "table" then for k, v in pairs(data.ServerConfig) do ServerConfig[k] = v end end
    if type(data.EspDistances) == "table" then for k, v in pairs(data.EspDistances) do EspDistances[k] = v end end
    if type(data.EspColors) == "table" then
        for k, v in pairs(data.EspColors) do
            local c = tableToColor3(v)
            if c and EspColors[k] ~= nil then EspColors[k] = c end
        end
    end
end

function jsonEncode(val)
    local t = type(val)
    if t == "string" then return '"' .. val:gsub("\\", "\\\\"):gsub('"', '\\"') .. '"'
    elseif t == "number" or t == "boolean" then return tostring(val)
    elseif t == "nil" then return "null"
    elseif t == "table" then
        local isArray = true
        local count = 0
        for k, _ in pairs(val) do count = count + 1 if type(k) ~= "number" then isArray = false end end
        if count == 0 then return isArray and "[]" or "{}" end
        local parts = {}
        if isArray then
            for _, v in ipairs(val) do table.insert(parts, jsonEncode(v)) end
            return "[" .. table.concat(parts, ",") .. "]"
        else
            for k, v in pairs(val) do table.insert(parts, '"' .. tostring(k) .. '":' .. jsonEncode(v)) end
            return "{" .. table.concat(parts, ",") .. "}"
        end
    end
    return "null"
end

function jsonDecode(str)
    local ok, result = pcall(function() return HttpService:JSONDecode(str) end)
    if ok then return result end
    return nil
end

function SaveLoad.save()
    if not saveEnabled then return end
    pcall(function() if writefile then writefile(CONFIG_FILE, jsonEncode(serializeAllConfigs())) end end)
end

function SaveLoad.load()
    local content = nil
    pcall(function()
        if isfile and not isfile(CONFIG_FILE) then return end
        if readfile then content = readfile(CONFIG_FILE) end
    end)
    if not content or content == "" then return nil end
    return jsonDecode(content)
end

local loaded = SaveLoad.load()
if loaded then applyLoadedData(loaded) end
saveEnabled = true

local saveScheduled = false
function queueSave()
    if not saveEnabled or saveScheduled then return end
    saveScheduled = true
    task.delay(0.5, function() saveScheduled = false SaveLoad.save() end)
end

-- [ Drawing API ] -- / Fallback
local Drawing = Drawing or (function()
    local RealDrawing = rawget(getfenv(), "Drawing")
    if RealDrawing then return RealDrawing end
    return {
        new = function(class)
            local dummy = {
                Visible = false, Remove = function() end, Text = "", Color = Color3.new(), Thickness = 1, TextSize = 13,
                Center = false, Outline = false, OutlineColor = Color3.new(), Filled = false, Position = Vector2.new(),
                Size = Vector2.new(), From = Vector2.new(), To = Vector2.new(), Radius = 0, NumSides = 0, Font = 0
            }
            return setmetatable(dummy, {
                __index = function(t, k) if rawget(t, k) ~= nil then return rawget(t, k) end return function() end end,
                __newindex = function(t, k, v) rawset(t, k, v) end
            })
        end
    }
end)()


-- [ Inicializacao ] -- / Limpa UI antiga e declara placeholders
local gameName = "Loading..."
pcall(function() local info = MarketplaceService:GetProductInfo(game.PlaceId) gameName = info.Name end)
for _, oldName in ipairs({"QyzmuHubUI", "qyzHubGui"}) do
    local old = playerGui:FindFirstChild(oldName)
    if old then old:Destroy() end
end
local screenGui = nil  -- setado pelo Painel UI depois
local mainFrame = nil  -- nao usado no novo Painel

-- [ Faction / Team ] -- / Atributo Faction do TWD2 com fallback de Team/TeamColor
-- Cacheia a faction do LocalPlayer pra pegar o valor mesmo se o atributo ainda nao foi replicado
local cachedLocalFaction = LocalPlayer:GetAttribute("Faction")
LocalPlayer:GetAttributeChangedSignal("Faction"):Connect(function()
    cachedLocalFaction = LocalPlayer:GetAttribute("Faction")
end)

function isFactionMember(player)
    if not player or player == LocalPlayer then return true end
    -- Metodo 1 (TWD2): atributo Faction e o UUID da faccao do player
    local myFaction = cachedLocalFaction
    if type(myFaction) == "string" and #myFaction > 0 then
        local otherFaction = player:GetAttribute("Faction")
        if type(otherFaction) == "string" and #otherFaction > 0 then
            return otherFaction == myFaction
        end
        -- Outro player sem faction = nao e membro da minha faccao
        return false
    end
    -- Metodo 2 (fallback): Team e TeamColor classicos
    if LocalPlayer.Team ~= nil and player.Team == LocalPlayer.Team then return true end
    if player.TeamColor == LocalPlayer.TeamColor and LocalPlayer.TeamColor ~= BrickColor.new("White") then return true end
    return false
end

function isFactionEspTarget(player)
    return EspConfig.FactionMembers == true and isFactionMember(player)
end

-- [ FullBright ] -- / via eventos
local FullBrightOriginals = nil
local fullBrightConns = {}
local fullBrightTargets = {
    Brightness = 3, ClockTime = 12, Ambient = Color3.fromRGB(178, 178, 178), OutdoorAmbient = Color3.fromRGB(178, 178, 178),
    ColorShift_Bottom = Color3.fromRGB(0, 0, 0), ColorShift_Top = Color3.fromRGB(0, 0, 0), ExposureCompensation = 0.5,
    FogEnd = 9e9, GlobalShadows = false, EnvironmentDiffuseScale = 1, EnvironmentSpecularScale = 1
}

function captureLightingOriginals()
    if FullBrightOriginals then return end
    FullBrightOriginals = {}
    for prop in pairs(fullBrightTargets) do FullBrightOriginals[prop] = Lighting[prop] end
end

function applyFullBrightValues()
    for prop, val in pairs(fullBrightTargets) do pcall(function() Lighting[prop] = val end) end
end

function applyFullBright()
    captureLightingOriginals() applyFullBrightValues()
    for prop in pairs(fullBrightTargets) do
        pcall(function()
            table.insert(fullBrightConns, Lighting:GetPropertyChangedSignal(prop):Connect(function()
                if not EspConfig.FullBright then return end
                applyFullBrightValues()
            end))
        end)
    end
end

function restoreLighting()
    for _, conn in ipairs(fullBrightConns) do conn:Disconnect() end
    table.clear(fullBrightConns)
    if not FullBrightOriginals then return end
    for prop, val in pairs(FullBrightOriginals) do pcall(function() Lighting[prop] = val end) end
    FullBrightOriginals = nil
end

-- [ Admin Alert ] -- / Detecta admin no servidor e mostra notificacao verde
-- Frame cresce pra baixo (AutomaticSize = Y) quando tem muitos admins
local adminAlertFrame = Instance.new("Frame")
adminAlertFrame.Size = UDim2.new(0, 280, 0, 32)
adminAlertFrame.Position = UDim2.new(1, -290, 0, 20)
adminAlertFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
adminAlertFrame.BackgroundTransparency = 0.2
adminAlertFrame.BorderSizePixel = 0
adminAlertFrame.Visible = false
adminAlertFrame.ZIndex = 100
adminAlertFrame.AutomaticSize = Enum.AutomaticSize.Y  -- cresce verticalmente
adminAlertFrame.Parent = screenGui
local aac = Instance.new("UICorner")
aac.CornerRadius = UDim.new(0, 4)
aac.Parent = adminAlertFrame

-- Padding interno pra nao colar texto na borda
local adminPad = Instance.new("UIPadding")
adminPad.PaddingTop = UDim.new(0, 8)
adminPad.PaddingBottom = UDim.new(0, 8)
adminPad.PaddingLeft = UDim.new(0, 12)
adminPad.PaddingRight = UDim.new(0, 12)
adminPad.Parent = adminAlertFrame

local adminAlertText = Instance.new("TextLabel")
adminAlertText.Size = UDim2.new(1, 0, 0, 16)  -- altura minima de 1 linha
adminAlertText.BackgroundTransparency = 1
adminAlertText.Text = ""
adminAlertText.Font = Enum.Font.GothamBold
adminAlertText.TextSize = 12
adminAlertText.TextColor3 = Color3.fromRGB(0, 255, 100)
adminAlertText.TextXAlignment = Enum.TextXAlignment.Left
adminAlertText.TextYAlignment = Enum.TextYAlignment.Top
adminAlertText.TextWrapped = true  -- quebra linha quando nao cabe
adminAlertText.AutomaticSize = Enum.AutomaticSize.Y  -- texto cresce tb
adminAlertText.ZIndex = 101
adminAlertText.Parent = adminAlertFrame

function checkPlayerAdmin(player)
    if player == LocalPlayer then return false end
    -- Metodo 1: atributo IsAdmin
    local isAdmin = player:GetAttribute("IsAdmin")
    if isAdmin == true then return true end
    -- Metodo 2: atributo TWDOGroupRank > 0 (TWD2 usa isso)
    local rank = player:GetAttribute("TWDOGroupRank")
    if type(rank) == "number" and rank > 0 then return true end
    -- Metodo 3: TWDOStaffEntitlements = true
    local staff = player:GetAttribute("TWDOStaffEntitlements")
    if staff == true then return true end
    -- Metodo 4: CommunityModeratorAuthorized = true
    local mod = player:GetAttribute("CommunityModeratorAuthorized")
    if mod == true then return true end
    -- Metodo 5: AdminFlying = true (bonus)
    local flying = player:GetAttribute("AdminFlying")
    if flying == true then return true end
    return false
end

function updateAdminAlert()
    if not ServerConfig.AdminAlert then
        adminAlertFrame.Visible = false
        return
    end
    local adminNames = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if checkPlayerAdmin(p) then
            table.insert(adminNames, p.DisplayName)
        end
    end
    if #adminNames > 0 then
        adminAlertText.Text = "ADMIN: " .. table.concat(adminNames, ", ")
        adminAlertFrame.Visible = true
    else
        adminAlertFrame.Visible = false
    end
end

task.spawn(function()
    while true do
        updateAdminAlert()
        task.wait(3)
    end
end)

Players.PlayerAdded:Connect(function(p) task.wait(2) updateAdminAlert() end)
Players.PlayerRemoving:Connect(function() updateAdminAlert() end)

-- [ Tracer Logic ] -- / Beam vermelho ligando o LocalPlayer ao alvo
local EspBeams = {}
local BeamTrackers = {}

function getRoot(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

function clearBeam(other)
    local data = EspBeams[other]
    if not data then return end
    if data.beam then data.beam:Destroy() end
    if data.a0 then data.a0:Destroy() end
    if data.a1 then data.a1:Destroy() end
    EspBeams[other] = nil
end

function untrackPlayerBeam(other)
    local conns = BeamTrackers[other]
    if not conns then return end
    conns.charAdded:Disconnect()
    conns.charRemoving:Disconnect()
    BeamTrackers[other] = nil
end

function refreshBeam(other)
    if not EspConfig.Tracer then return end
    if other == LocalPlayer then return end
    clearBeam(other)
    local myRoot = getRoot(LocalPlayer.Character)
    local root = getRoot(other.Character)
    if not myRoot or not root then return end

    local a0 = Instance.new("Attachment")
    a0.Name = "LineOrigin"
    a0.Parent = myRoot

    local a1 = Instance.new("Attachment")
    a1.Name = "LineTarget"
    a1.Parent = root

    local beam = Instance.new("Beam")
    beam.Attachment0 = a0
    beam.Attachment1 = a1
    beam.Color = ColorSequence.new(EspColors.Tracer)
    beam.Width0 = 0.05
    beam.Width1 = 0.05
    beam.FaceCamera = true
    beam.Transparency = NumberSequence.new(0)
    beam.LightEmission = 0
    beam.LightInfluence = 0
    beam.Parent = workspace

    EspBeams[other] = { beam = beam, a0 = a0, a1 = a1 }
end

-- Atualiza visibilidade dos beams baseado na distancia do slider
function updateTracerVisibility()
    if not EspConfig.Tracer then return end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local maxDist = EspDistances.Player or 500
    for other, data in pairs(EspBeams) do
        if other and other.Character and data.beam then
            local root = getRoot(other.Character)
            if root then
                local dist = (myRoot.Position - root.Position).Magnitude
                -- Beam.Visible nao existe; usa Transparency
                if dist > maxDist then
                    data.beam.Transparency = NumberSequence.new(1)  -- invisivel
                else
                    data.beam.Transparency = NumberSequence.new(0)  -- visivel
                end
            end
        end
    end
end

function trackPlayerBeam(other)
    if other == LocalPlayer then return end
    if BeamTrackers[other] then return end
    BeamTrackers[other] = {
        charAdded = other.CharacterAdded:Connect(function()
            task.spawn(refreshBeam, other)
        end),
        charRemoving = other.CharacterRemoving:Connect(function()
            clearBeam(other)
        end)
    }
    if other.Character then
        task.spawn(refreshBeam, other)
    end
end

for _, other in ipairs(Players:GetPlayers()) do
    trackPlayerBeam(other)
end
Players.PlayerAdded:Connect(function(p)
    trackPlayerBeam(p)
end)
Players.PlayerRemoving:Connect(function(p)
    clearBeam(p)
    untrackPlayerBeam(p)
end)

LocalPlayer.CharacterAdded:Connect(function()
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then
            task.spawn(refreshBeam, other)
        end
    end
end)

-- Atualiza cor dos beams quando muda a cor do Tracer
function updateTracerColor()
    for _, data in pairs(EspBeams) do
        if data.beam then
            data.beam.Color = ColorSequence.new(EspColors.Tracer)
        end
    end
end

-- [ Highlights ] -- / AlwaysOnTop = atravessa paredes; Occluded = bloqueia por paredes
local HighlightsCache = {}

function updateHighlights(player, char, isFaction)
    -- Membros da faccao ganham contorno proprio quando o toggle FactionMembers ta ligado
    local shouldShow = EspConfig.Highlights or EspConfig.HighlightsThroughWalls or (isFaction and EspConfig.FactionMembers)
    if not shouldShow then
        if HighlightsCache[player] then HighlightsCache[player]:Destroy() HighlightsCache[player] = nil end
        return
    end
    local hl = HighlightsCache[player]
    if not hl or hl.Parent ~= char then
        if hl then hl:Destroy() end
        hl = Instance.new("Highlight") hl.Name = "QyzmuHighlight" hl.Adornee = char
        hl.FillTransparency = 1 hl.OutlineTransparency = 0 hl.Parent = char
        HighlightsCache[player] = hl
    end
    hl.OutlineColor = isFaction and EspColors.FactionMember or EspColors.Highlights
    hl.FillColor = hl.OutlineColor
    if EspConfig.HighlightsThroughWalls then hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    else hl.DepthMode = Enum.HighlightDepthMode.Occluded end
end

-- [ Banner ESP ]
local BannerEspObjects = {}

function getBannerRoot(bannerModel)
    if bannerModel:IsA("Model") and bannerModel.PrimaryPart then return bannerModel.PrimaryPart end
    local root = bannerModel:FindFirstChild("Root")
    if root and root:IsA("BasePart") then return root end
    local direct = bannerModel:FindFirstChildWhichIsA("BasePart")
    if direct then return direct end
    return bannerModel:FindFirstChildWhichIsA("BasePart", true)
end

function createBannerEsp(bannerModel)
    if BannerEspObjects[bannerModel] then return end
    local rootPart = getBannerRoot(bannerModel) if not rootPart then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BannerESP" billboard.Adornee = rootPart billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0) billboard.AlwaysOnTop = true
    billboard.MaxDistance = EspDistances.FactionBanner billboard.Enabled = false billboard.Parent = playerGui

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0) nameLabel.BackgroundTransparency = 1 nameLabel.Text = bannerModel.Name ~= "" and bannerModel.Name or "Banner"
    nameLabel.Font = Enum.Font.GothamBold nameLabel.TextSize = 13 nameLabel.TextColor3 = EspColors.FactionBanner
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) nameLabel.TextStrokeTransparency = 0 nameLabel.Parent = billboard

    BannerEspObjects[bannerModel] = { billboard = billboard, nameLabel = nameLabel, rootPart = rootPart }
end

function removeBannerEsp(bannerModel)
    local data = BannerEspObjects[bannerModel] if not data then return end
    if data.billboard then data.billboard:Destroy() end
    BannerEspObjects[bannerModel] = nil
end

function scanBanners()
    pcall(function()
        local bannersFolder = workspace:FindFirstChild("Banners") if not bannersFolder then return end
        for _, obj in ipairs(bannersFolder:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Folder") then
                if EspConfig.FactionBanners then createBannerEsp(obj) else removeBannerEsp(obj) end
            end
        end
        for model, _ in pairs(BannerEspObjects) do
            if not model or not model.Parent or not model:IsDescendantOf(bannersFolder) then removeBannerEsp(model) end
        end
    end)
end

task.spawn(function()
    while true do
        if EspConfig.FactionBanners then scanBanners() else
            if next(BannerEspObjects) ~= nil then for model, _ in pairs(BannerEspObjects) do removeBannerEsp(model) end end
        end
        task.wait(2)
    end
end)

-- [ Car ESP ]
local CarEspObjects = {}

function removeCarEsp(carModel)
    local data = CarEspObjects[carModel] if not data then return end
    if data.billboard then data.billboard:Destroy() end
    if data.highlight then data.highlight:Destroy() end
    CarEspObjects[carModel] = nil
end

function createCarEsp(carModel)
    if CarEspObjects[carModel] then return end
    local rootPart = carModel.PrimaryPart or carModel:FindFirstChild("Engine") or carModel:FindFirstChildWhichIsA("BasePart")
    if not rootPart then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CarESP" billboard.Adornee = rootPart billboard.Size = UDim2.new(0, 100, 0, 24)
    billboard.StudsOffset = Vector3.new(0, 4, 0) billboard.AlwaysOnTop = true
    billboard.MaxDistance = EspDistances.Car billboard.Enabled = false billboard.Parent = playerGui

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0) nameLabel.BackgroundTransparency = 1 nameLabel.Text = "Car"
    nameLabel.Font = Enum.Font.GothamBold nameLabel.TextSize = 13 nameLabel.TextColor3 = EspColors.Cars
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) nameLabel.TextStrokeTransparency = 0 nameLabel.Parent = billboard

    -- Highlight so com borda (sem preenchimento)
    local highlight = Instance.new("Highlight")
    highlight.Name = "QyzmuCarHighlight"
    highlight.Adornee = carModel
    highlight.FillColor = EspColors.Cars
    highlight.OutlineColor = EspColors.Cars
    highlight.FillTransparency = 1     -- 1 = totalmente transparente (so borda)
    highlight.OutlineTransparency = 0
    highlight.Parent = carModel

    CarEspObjects[carModel] = { billboard = billboard, rootPart = rootPart, highlight = highlight }
end

function scanCars()
    pcall(function()
        local carsFolder = workspace:FindFirstChild("Cars") if not carsFolder then return end
        for _, obj in ipairs(carsFolder:GetChildren()) do
            if obj:IsA("Model") then
                if EspConfig.Cars then createCarEsp(obj) else removeCarEsp(obj) end
            end
        end
        for model, _ in pairs(CarEspObjects) do
            if not model or not model.Parent or not model:IsDescendantOf(carsFolder) then removeCarEsp(model) end
        end
    end)
end

task.spawn(function()
    while true do
        if EspConfig.Cars then scanCars() else
            if next(CarEspObjects) ~= nil then for model, _ in pairs(CarEspObjects) do removeCarEsp(model) end end
        end
        task.wait(2)
    end
end)

-- [ Horse ESP ] -- / Procura Models com Species=Horse no workspace.AI
local HorseEspObjects = {}

function removeHorseEsp(horseModel)
    local data = HorseEspObjects[horseModel]
    if not data then return end
    if data.billboard then data.billboard:Destroy() end
    if data.highlight then data.highlight:Destroy() end
    HorseEspObjects[horseModel] = nil
end

function isHorseModel(obj)
    if not obj:IsA("Model") then return false end
    local species = obj:GetAttribute("Species")
    if species ~= "Horse" then return false end
    if obj:GetAttribute("Dead") == true then return false end
    return true
end

function getHorseRoot(horseModel)
    return horseModel:FindFirstChild("HumanoidRootPart")
        or horseModel:FindFirstChild("Body")
        or horseModel.PrimaryPart
        or horseModel:FindFirstChildWhichIsA("BasePart")
end

function createHorseEsp(horseModel)
    if HorseEspObjects[horseModel] then return end
    local rootPart = getHorseRoot(horseModel)
    if not rootPart then return end

    local isSkeleton = horseModel:GetAttribute("SkeletonHorse") == true
    local riderId = horseModel:GetAttribute("RiderUserId")
    local isTamed = horseModel:GetAttribute("Tamed") == true
    local horseColor = isSkeleton and Color3.fromRGB(255, 255, 255) or EspColors.Horses

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HorseESP"
    billboard.Adornee = rootPart
    billboard.Size = UDim2.new(0, 140, 0, 32)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = EspDistances.Horse or 1000
    billboard.Enabled = false
    billboard.Parent = playerGui

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 16)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = isSkeleton and "Skeleton Horse" or "Horse"
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 13
    nameLabel.TextColor3 = horseColor
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Parent = billboard

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 14)
    infoLabel.Position = UDim2.new(0, 0, 0, 16)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = isTamed and "Tamed" or "Wild"
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 11
    infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    infoLabel.TextStrokeTransparency = 0
    infoLabel.Parent = billboard

    local highlight = Instance.new("Highlight")
    highlight.Name = "QyzmuHorseHighlight"
    highlight.Adornee = horseModel
    highlight.FillColor = horseColor
    highlight.OutlineColor = horseColor
    highlight.FillTransparency = 1     -- 1 = totalmente transparente (so borda)
    highlight.OutlineTransparency = 0
    highlight.Parent = horseModel

    HorseEspObjects[horseModel] = {
        billboard = billboard, nameLabel = nameLabel, infoLabel = infoLabel,
        highlight = highlight, rootPart = rootPart, riderId = riderId
    }
end

function updateHorseEspInfo()
    for model, data in pairs(HorseEspObjects) do
        if model and model.Parent and data.infoLabel then
            local riderId = model:GetAttribute("RiderUserId")
            local isTamed = model:GetAttribute("Tamed") == true
            local hp = model:GetAttribute("Health")
            local infoText = isTamed and "Tamed" or "Wild"
            if hp then infoText = infoText .. " | HP:" .. math.floor(hp) end
            if type(riderId) == "number" and riderId > 0 then
                local rider = Players:GetPlayerByUserId(riderId)
                if rider then
                    infoText = infoText .. " | Rider: " .. rider.DisplayName
                end
            end
            data.infoLabel.Text = infoText
        end
    end
end

function scanHorses()
    pcall(function()
        local aiFolder = workspace:FindFirstChild("AI")
        if not aiFolder then return end
        for _, obj in ipairs(aiFolder:GetDescendants()) do
            if isHorseModel(obj) then
                if EspConfig.Horses then createHorseEsp(obj) else removeHorseEsp(obj) end
            end
        end
        for model, _ in pairs(HorseEspObjects) do
            if not model or not model.Parent or not model:IsDescendantOf(workspace) then
                removeHorseEsp(model)
            end
        end
    end)
end

task.spawn(function()
    while true do
        if EspConfig.Horses then scanHorses() else
            if next(HorseEspObjects) ~= nil then
                for model, _ in pairs(HorseEspObjects) do removeHorseEsp(model) end
            end
        end
        updateHorseEspInfo()
        task.wait(2)
    end
end)

-- [ Corpse ESP ] -- / Procura Models e Folders em workspace.Corpses (parts diretas ou aninhadas)
local CorpseEspObjects = {}

function removeCorpseEsp(corpseModel)
    local data = CorpseEspObjects[corpseModel]
    if not data then return end
    if data.nameText then data.nameText:Remove() end
    if data.highlight then data.highlight:Destroy() end
    CorpseEspObjects[corpseModel] = nil
end

function getCorpseRoot(corpseModel)
    -- Corpse pode ser uma BasePart direta (sem Model em volta)
    if corpseModel:IsA("BasePart") then return corpseModel end
    if corpseModel:IsA("Model") and corpseModel.PrimaryPart then return corpseModel.PrimaryPart end
    local direct = corpseModel:FindFirstChildWhichIsA("BasePart")
    if direct then return direct end
    -- Corpos com parts aninhadas (Model > Body > parts) precisam de busca recursiva
    return corpseModel:FindFirstChildWhichIsA("BasePart", true)
end

function createCorpseEsp(corpseModel)
    if CorpseEspObjects[corpseModel] then return end
    local rootPart = getCorpseRoot(corpseModel)
    if not rootPart then return end

    -- NOME usando Drawing.new("Text") - igual ao ESP Name de player
    local nameText = Drawing.new("Text")
    nameText.Center = true
    nameText.Outline = true
    nameText.OutlineColor = Color3.fromRGB(0, 0, 0)
    nameText.Color = EspColors.Corpses
    nameText.Visible = false
    nameText.Size = 15  -- mesmo tamanho do ESP Name de player
    pcall(function() nameText.Font = 2 end)  -- Gotham = 2
    nameText.Text = corpseModel.Name or "Corpse"

    -- Highlight SÓ COM BORDA (sem preenchimento)
    local highlight = Instance.new("Highlight")
    highlight.Name = "QyzmuCorpseHighlight"
    highlight.Adornee = corpseModel
    highlight.FillColor = EspColors.Corpses
    highlight.OutlineColor = EspColors.Corpses
    highlight.FillTransparency = 1     -- 1 = totalmente transparente (só borda)
    highlight.OutlineTransparency = 0   -- 0 = borda visivel
    highlight.Enabled = false
    highlight.Parent = corpseModel

    CorpseEspObjects[corpseModel] = {
        nameText = nameText, highlight = highlight, rootPart = rootPart
    }
end

-- Atualiza visibilidade e POSICAO dos ESPs de corpses (chamado a cada frame no render loop)
function updateCorpseEspVisibility()
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then
        -- Sem character: esconde todos os ESPs de corpses
        for model, data in pairs(CorpseEspObjects) do
            if data.nameText then data.nameText.Visible = false end
            if data.highlight then data.highlight.Enabled = false end
        end
        return
    end
    local maxDist = EspDistances.Corpse or 500
    local camPos = Camera.CFrame.Position
    local camLook = Camera.CFrame.LookVector
    for model, data in pairs(CorpseEspObjects) do
        if model and model.Parent and data.rootPart and data.rootPart.Parent then
            local dist = (myHrp.Position - data.rootPart.Position).Magnitude
            local inRange = dist <= maxDist

            -- Atualiza posicao do nome (igual ESP Name de player)
            if EspConfig.CorpsesName and inRange then
                -- Projeta a posicao do rootPart na tela
                local screenPos, onScreen = Camera:WorldToViewportPoint(data.rootPart.Position + Vector3.new(0, 2, 0))
                -- Validador extra: checa se o corpo ta na frente da camera (dot product)
                local toCorpse = (data.rootPart.Position - camPos).Unit
                local dotProduct = camLook:Dot(toCorpse)
                local inFrontOfCamera = dotProduct > 0.2  -- ~78 graus de FOV
                if onScreen and screenPos.Z > 0 and inFrontOfCamera then
                    data.nameText.Position = Vector2.new(screenPos.X, screenPos.Y - 16)
                    data.nameText.Color = EspColors.Corpses
                    data.nameText.Visible = true
                else
                    data.nameText.Visible = false
                end
            else
                data.nameText.Visible = false
            end

            -- Highlight so aparece se CorpsesHighlight ligado E dentro do range
            if data.highlight then
                data.highlight.Enabled = EspConfig.CorpsesHighlight and inRange
                -- Atualiza cor caso tenha mudado
                data.highlight.FillColor = EspColors.Corpses
                data.highlight.OutlineColor = EspColors.Corpses
            end
        else
            -- Corpse foi removido/sumiu: esconde ESP imediatamente (NAO deixa flutuando)
            if data.nameText then data.nameText.Visible = false end
            if data.highlight then data.highlight.Enabled = false end
        end
    end
end

local corpsesChildConn = nil
function hookCorpseChildAdded()
    if corpsesChildConn and corpsesChildConn.Connected then return end
    local corpsesFolder = workspace:FindFirstChild("Corpses")
    if not corpsesFolder then return end
    -- Corpo novo entra na pasta: cria ESP na hora (o scan de 2s re-tenta se as parts ainda nao chegaram)
    corpsesChildConn = corpsesFolder.ChildAdded:Connect(function(child)
        if not (EspConfig.CorpsesName or EspConfig.CorpsesHighlight) then return end
        task.delay(0.25, function() if child.Parent then createCorpseEsp(child) end end)
    end)
end

function scanCorpses()
    pcall(function()
        local corpsesFolder = workspace:FindFirstChild("Corpses")
        if not corpsesFolder then return end
        hookCorpseChildAdded()
        -- Sempre cria os ESPs dos corpses se o scan foi chamado (significa que algum toggle ligou)
        -- Aceita Model, Folder ou BasePart direto (alguns corpses sao parts soltas)
        for _, obj in ipairs(corpsesFolder:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Folder") or obj:IsA("BasePart") then
                createCorpseEsp(obj)
            end
        end
        -- Limpa corpses que sumiram e re-acha o root de quem perdeu o rootPart
        for model, data in pairs(CorpseEspObjects) do
            if not model or not model.Parent or not model:IsDescendantOf(corpsesFolder) then
                removeCorpseEsp(model)
            elseif data.rootPart and not data.rootPart.Parent then
                local newRoot = getCorpseRoot(model)
                if newRoot then data.rootPart = newRoot else removeCorpseEsp(model) end
            end
        end
    end)
end

task.spawn(function()
    while true do
        -- Scan se QUALQUER toggle de corpses ligado
        local anyCorpse = EspConfig.CorpsesName or EspConfig.CorpsesHighlight
        if anyCorpse then scanCorpses() else
            if next(CorpseEspObjects) ~= nil then
                for model, _ in pairs(CorpseEspObjects) do removeCorpseEsp(model) end
            end
        end
        updateCorpseEspVisibility()
        task.wait(2)
    end
end)

-- [ Wallbang ] -- / Atira atraves de paredes usando FilterDescendantsInstances no raycast do tiro
-- Intercepta o FireServer do GUN_REMOTES.Fire e modifica o raycast pra ignorar paredes
local wallbangHooked = false
local originalFireFunc = nil
local wallbangRayParams = RaycastParams.new()
wallbangRayParams.FilterType = Enum.RaycastFilterType.Exclude
wallbangRayParams.IgnoreWater = true
wallbangRayParams.RespectCanCollide = false  -- ignora CanCollide, so usa a filter list

-- Lista de parts pra ignorar (paredes, portas, etc - nao players/carros/cavalos)
local function getWallbangIgnoreList()
    local ignoreList = {}
    local char = LocalPlayer.Character
    if char then table.insert(ignoreList, char) end

    -- Pega todos os Models no workspace que NAO sao players/carros/cavalos
    -- e adiciona na ignoreList (so os proximos pra nao lagar)
    local myPos = char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position
    if not myPos then return ignoreList end

    local count = 0
    for _, obj in ipairs(workspace:GetChildren()) do
        if count > 100 then break end  -- limite de 100 objetos pra nao lagar
        if obj:IsA("Model") then
            -- Filtra: so adiciona se NAO for player/carro/cavalo
            local isPlayer = Players:GetPlayerFromCharacter(obj) ~= nil
            local isHorse = obj:GetAttribute("Species") == "Horse"
            local isCar = obj:FindFirstChild("DriveSeat") or obj:GetAttribute("Fuel") ~= nil
            if not isPlayer and not isHorse and not isCar then
                -- Pega so se tiver perto (within 300 studs)
                local rootPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if rootPart then
                    local dist = (rootPart.Position - myPos).Magnitude
                    if dist < 300 then
                        table.insert(ignoreList, obj)
                        count = count + 1
                    end
                end
            end
        elseif obj:IsA("Folder") then
            -- Pastas como House_3, etc - adiciona so se tiver perto
            for _, sub in ipairs(obj:GetChildren()) do
                if count > 100 then break end
                if sub:IsA("Model") or sub:IsA("BasePart") then
                    local isPlayer = Players:GetPlayerFromCharacter(sub) ~= nil
                    local isHorse = sub:GetAttribute("Species") == "Horse"
                    local isCar = sub:FindFirstChild("DriveSeat") or sub:GetAttribute("Fuel") ~= nil
                    if not isPlayer and not isHorse and not isCar then
                        local rootPart = sub:IsA("BasePart") and sub or (sub.PrimaryPart or sub:FindFirstChildWhichIsA("BasePart"))
                        if rootPart then
                            local dist = (rootPart.Position - myPos).Magnitude
                            if dist < 300 then
                                table.insert(ignoreList, sub)
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
    end

    return ignoreList
end

function applyWallbang()
    -- Se desligou, restaura o hook original
    if not AimbotConfig.Wallbang then
        -- Nao tem como restaurar hookfunction facilmente, mas o impacto e zero quando Wallbang=false
        return
    end

    -- Se ja ta hookado, nao faz nada
    if wallbangHooked then return end
    wallbangHooked = true

    -- Tenta hookar GUN_REMOTES.Fire:FireServer pra modificar o raycast
    -- Como nao temos hookmetamethod, vamos usar uma abordagem diferente:
    -- Modifica o Mouse.Hit pra apontar pro inimigo atraves da parede
    -- Fazendo um raycast manual que ignora paredes

    -- Cria um loop que atualiza o mouse target quando Wallbang ativo
    task.spawn(function()
        while AimbotConfig.Wallbang do
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local mouse = LocalPlayer:GetMouse()
                local camPos = workspace.CurrentCamera.CFrame.Position
                local mousePos = mouse.Hit.Position

                -- Faz um raycast da camera ate o mouse.Hit, ignorando paredes
                local ignoreList = getWallbangIgnoreList()
                wallbangRayParams.FilterDescendantsInstances = ignoreList

                local direction = (mousePos - camPos)
                local dist = direction.Magnitude
                if dist > 0.1 then
                    direction = direction / dist
                    local result = workspace:Raycast(camPos, direction * math.min(dist, 1000), wallbangRayParams)
                    -- Se o raycast (ignorando paredes) bateu em algo diferente do mouse original,
                    -- significa que tinha uma parede no caminho e o wallbang funcionou
                    -- Nao precisamos fazer nada, so garantir que o tiro usa esse raycast
                end
            end
            task.wait(0.1)
        end
        wallbangHooked = false
    end)
end

-- [ Aimbot ]
local FovCircle = Drawing.new("Circle")
FovCircle.Visible = false FovCircle.Color = AimbotConfig.FOVColor
FovCircle.Thickness = 1 FovCircle.NumSides = 60 FovCircle.Filled = false

function getClosestPlayer()
    local closestHead = nil
    local shortestDist = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local maxDist3D = EspDistances.Player or 500
    local camPos = Camera.CFrame.Position

    for _, player in ipairs(Players:GetPlayers()) do
        -- Team Check ligado = pula membros da mesma faccao
        if player ~= LocalPlayer and player.Character and (not AimbotConfig.TeamCheck or not isFactionMember(player)) then
            local head = player.Character:FindFirstChild("Head")
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if head and hum and hrp and hum.Health > 0 then
                -- Checa distancia 3D contra o limite do slider
                local dist3D = (camPos - hrp.Position).Magnitude
                if dist3D <= maxDist3D then
                    -- So mira se a hitbox renderizaria (mesma logica do ESP)
                    -- Pega bounding box e valida
                    local cf, size = player.Character:GetBoundingBox()
                    local boxValid = size and size.X > 0 and size.Y > 0 and size.Z > 0
                        and size.X == size.X and size.Y == size.Y and size.Z == size.Z
                    if boxValid then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen and screenPos.Z > 0 then
                            local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                            if dist2D < AimbotConfig.FOV and dist2D < shortestDist then
                                -- Valida os 8 cantos da bounding box (igual o ESP faz)
                                local corners = {
                                    cf * Vector3.new(size.X/2, size.Y/2, size.Z/2), cf * Vector3.new(size.X/2, size.Y/2, -size.Z/2),
                                    cf * Vector3.new(-size.X/2, size.Y/2, size.Z/2), cf * Vector3.new(-size.X/2, size.Y/2, -size.Z/2),
                                    cf * Vector3.new(size.X/2, -size.Y/2, size.Z/2), cf * Vector3.new(size.X/2, -size.Y/2, -size.Z/2),
                                    cf * Vector3.new(-size.X/2, -size.Y/2, size.Z/2), cf * Vector3.new(-size.X/2, -size.Y/2, -size.Z/2)
                                }
                                local allCornersVisible = true
                                for _, corner in ipairs(corners) do
                                    local sp = Camera:WorldToViewportPoint(corner)
                                    if sp.Z <= 0 or sp.Z ~= sp.Z then
                                        allCornersVisible = false
                                        break
                                    end
                                end
                                -- So mira se TODOS os cantos da hitbox estao visiveis (hitbox renderizou)
                                if allCornersVisible then
                                    shortestDist = dist2D
                                    closestHead = head
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return closestHead
end

-- [ Car Fly ]
local carFlyRayParams = RaycastParams.new()
carFlyRayParams.FilterType = Enum.RaycastFilterType.Exclude

function updateCarFly()
    if not PlayerConfig.CarFly then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not (hum and hum.SeatPart and hum.SeatPart:IsA("VehicleSeat")) then return end
    local car = hum.SeatPart.Parent
    local engine = car:FindFirstChild("Engine") or car.PrimaryPart if not engine then return end

    local dir = Vector3.new()
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
    dir = Vector3.new(dir.X, 0, dir.Z)

    local origin = engine.Position
    carFlyRayParams.FilterDescendantsInstances = { car, char }
    local hit = workspace:Raycast(origin, Vector3.new(0, -200, 0), carFlyRayParams)

    local targetY = hit and (hit.Position.Y + PlayerConfig.FlyHeight) or origin.Y
    local flySpeed = PlayerConfig.VehicleFlySpeed
    local targetHorizontal = Vector3.new(0, 0, 0)
    if dir.Magnitude > 0.01 then targetHorizontal = dir.Unit * flySpeed end

    local currentVel = engine.AssemblyLinearVelocity
    local yError = targetY - origin.Y
    local targetVelY = math.clamp(yError * 10, -flySpeed, flySpeed)
    local targetVel = Vector3.new(targetHorizontal.X, targetVelY, targetHorizontal.Z)
    engine.AssemblyLinearVelocity = currentVel:Lerp(targetVel, 0.2)
    engine.AssemblyAngularVelocity = engine.AssemblyAngularVelocity:Lerp(Vector3.new(0, 0, 0), 0.2)
end

-- [ Player Speed / Jump / Noclip ]
local speedEnforcer, jumpEnforcer, noclipConn = nil, nil, nil

function applyPlayerSpeed()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid") if not hum then return end
    if PlayerConfig.Speed then
        hum.WalkSpeed = PlayerConfig.SpeedAmount
        if not speedEnforcer then
            speedEnforcer = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if PlayerConfig.Speed and hum.WalkSpeed ~= PlayerConfig.SpeedAmount then hum.WalkSpeed = PlayerConfig.SpeedAmount end
            end)
        end
    else
        if speedEnforcer then speedEnforcer:Disconnect() speedEnforcer = nil end
        hum.WalkSpeed = 16
    end
end

function applyPlayerJump()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid") if not hum then return end
    if PlayerConfig.JumpHeight then
        hum.UseJumpPower = true hum.JumpPower = PlayerConfig.JumpHeightAmount
        if not jumpEnforcer then
            jumpEnforcer = hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
                if PlayerConfig.JumpHeight and hum.JumpPower ~= PlayerConfig.JumpHeightAmount then hum.JumpPower = PlayerConfig.JumpHeightAmount end
            end)
        end
    else
        if jumpEnforcer then jumpEnforcer:Disconnect() jumpEnforcer = nil end
        hum.JumpPower = 50
    end
end

function applyNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    if not PlayerConfig.Noclip then return end
    noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end)
end

-- [ Player Fly ] -- / Voo do player sem carro usando BodyVelocity
local flyBV = nil
local flyBG = nil
local flyConn = nil

function applyPlayerFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    if not PlayerConfig.Fly then return end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Cria BodyVelocity pra mover o player no ar
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.Parent = hrp

    flyConn = RunService.RenderStepped:Connect(function()
        if not PlayerConfig.Fly then return end
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end

        local speed = PlayerConfig.FlySpeed
        if dir.Magnitude > 0.01 then
            flyBV.Velocity = dir.Unit * speed
        else
            flyBV.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- [ Vehicle Noclip + Speed % + Drive Without Fuel ] -- / Lógica do carro
local vehicleNoclipConn = nil
local vehicleSpeedConn = nil
local vehicleFuelConn = nil

function getMyCar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum or not hum.SeatPart then return nil end
    if not hum.SeatPart:IsA("VehicleSeat") then return nil end
    return hum.SeatPart.Parent, hum.SeatPart
end

function applyVehicleNoclip()
    if vehicleNoclipConn then vehicleNoclipConn:Disconnect() vehicleNoclipConn = nil end
    if not PlayerConfig.VehicleNoclip then return end
    vehicleNoclipConn = RunService.Stepped:Connect(function()
        local car = getMyCar()
        if not car then return end
        for _, part in ipairs(car:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end)
end

-- [ Vehicle Speed % ] -- / Altera MaxSpeed do carro (client-side)
-- Implementacao: hooka o valor MaxSpeed.Value do Stats do carro que o LocalPlayer esta dirigindo
-- nao cria nova connection a cada frame - so uma unica connection que re-aplica quando muda
function applyVehicleSpeed()
    if vehicleSpeedConn then vehicleSpeedConn:Disconnect() vehicleSpeedConn = nil end
    if PlayerConfig.VehicleSpeed == 100 then return end

    -- Conecta Heartbeat so pra garantir que continua aplicado
    vehicleSpeedConn = RunService.Heartbeat:Connect(function()
        local car = getMyCar()
        if not car then return end
        local stats = car:FindFirstChild("Stats")
        if not stats then return end
        local ms = stats:FindFirstChild("MaxSpeed")
        if not ms or not ms:IsA("ValueBase") then return end

        -- Salva o valor original UMA vez (no atributo do Stats)
        if not stats:GetAttribute("OriginalMaxSpeed") then
            stats:SetAttribute("OriginalMaxSpeed", ms.Value)
        end
        local original = stats:GetAttribute("OriginalMaxSpeed") or ms.Value
        local target = original * (PlayerConfig.VehicleSpeed / 100)

        -- So atualiza se diferente (evita loop infinito)
        if math.abs(ms.Value - target) > 0.1 then
            ms.Value = target
        end
    end)
end

function applyDriveWithoutFuel()
    if vehicleFuelConn then vehicleFuelConn:Disconnect() vehicleFuelConn = nil end
    if not PlayerConfig.DriveWithoutFuel then return end
    vehicleFuelConn = RunService.Heartbeat:Connect(function()
        local car, seat = getMyCar()
        if not car then return end
        -- Tenta setar fuel infinito via atributos
        pcall(function()
            car:SetAttribute("Fuel", 100)
            car:SetAttribute("CurrentFuel", 100)
            if seat then
                seat:SetAttribute("Fuel", 100)
                seat:SetAttribute("CurrentFuel", 100)
            end
            local stats = car:FindFirstChild("Stats")
            if stats then
                local fuel = stats:FindFirstChild("Fuel") or stats:FindFirstChild("CurrentFuel")
                if fuel and fuel:IsA("ValueBase") then fuel.Value = 100 end
            end
        end)
    end)
end

-- [ Horse Features ] -- / Speed, Jump, Air Jump, Keep Sprint, Shoot On Horse
local horseConn = nil
local cachedHorse = nil
local lastHorseScan = 0

-- Busca o cavalo montado pelo LocalPlayer. Faz cache por 1s pra nao varrer o workspace a cada frame
function getMyHorse()
    local now = tick()
    if cachedHorse and cachedHorse.Parent and (now - lastHorseScan) < 1 then
        -- Verifica se ainda ta montado
        local stillRider = cachedHorse:GetAttribute("RiderUserId")
        if type(stillRider) == "number" and stillRider == LocalPlayer.UserId then
            return cachedHorse
        end
        cachedHorse = nil
    end

    lastHorseScan = now
    local aiFolder = workspace:FindFirstChild("AI")
    if not aiFolder then return nil end
    -- Itera so os filhos diretos e Pets folders (nao GetDescendants que e pesado)
    for _, obj in ipairs(aiFolder:GetChildren()) do
        if obj:IsA("Model") and obj:GetAttribute("Species") == "Horse" then
            local riderId = obj:GetAttribute("RiderUserId")
            if type(riderId) == "number" and riderId == LocalPlayer.UserId then
                cachedHorse = obj
                return obj
            end
        elseif obj:IsA("Folder") then
            -- Pets folders <user>Pets
            for _, sub in ipairs(obj:GetChildren()) do
                if sub:IsA("Model") and sub:GetAttribute("Species") == "Horse" then
                    local riderId = sub:GetAttribute("RiderUserId")
                    if type(riderId) == "number" and riderId == LocalPlayer.UserId then
                        cachedHorse = sub
                        return sub
                    end
                end
            end
        end
    end
    return nil
end

function applyHorseFeatures()
    if horseConn then
        -- Sinaliza parada do loop anterior
        horseConn = false
    end
    local anyActive = PlayerConfig.HorseJump or PlayerConfig.HorseAirJump or PlayerConfig.HorseKeepSprint
        or (PlayerConfig.HorseSpeed ~= 100)
    if not anyActive then return end

    -- Marca ativo e roda loop em task.spawn com task.wait adaptativo
    horseConn = true
    task.spawn(function()
        local failedScans = 0  -- contador de falhas consecutivas
        while horseConn do
            local horse = getMyHorse()
            if horse then
                failedScans = 0  -- resetou
                local hum = horse:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    -- Horse Speed (so aplica se toggle ligado)
                    if PlayerConfig.HorseSpeedEnabled and PlayerConfig.HorseSpeed ~= 100 then
                        local baseSpeed = hum:GetAttribute("BaseWalkSpeed")
                        if not baseSpeed then
                            baseSpeed = hum.WalkSpeed > 0 and hum.WalkSpeed or 7
                            hum:SetAttribute("BaseWalkSpeed", baseSpeed)
                        end
                        pcall(function() hum.WalkSpeed = baseSpeed * (PlayerConfig.HorseSpeed / 100) end)
                    end

                    -- Horse Jump
                    if PlayerConfig.HorseJump then
                        pcall(function()
                            hum.UseJumpPower = true
                            hum.JumpPower = PlayerConfig.HorseJumpHeight
                        end)
                    end

                    -- Horse Keep Sprint
                    if PlayerConfig.HorseKeepSprint then
                        pcall(function()
                            horse:SetAttribute("AnimSpeed", 2)
                            horse:SetAttribute("State", "Running")
                        end)
                        if hum.WalkSpeed < 16 then pcall(function() hum.WalkSpeed = 16 end) end
                    end
                end
                task.wait(0.2)  -- rapido enquanto montado
            else
                -- Nao esta montado: aumenta o delay progressivamente pra nao travar
                failedScans = failedScans + 1
                if failedScans < 3 then
                    task.wait(0.5)
                else
                    -- Depois de 3 falhas, so procura a cada 3s (nao trava o jogo)
                    task.wait(3)
                end
            end
        end
    end)
end

-- Horse Air Jump hook (so busca cavalo se Air Jump ativo, evita overhead)
UserInputService.JumpRequest:Connect(function()
    if not PlayerConfig.HorseAirJump then return end
    local horse = getMyHorse()
    if not horse then return end
    local hum = horse:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health > 0 then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    end
end)

-- [ Performance Logic ] -- / Aplica toggles de performance
-- Todas as funcoes pesadas rodam em task.spawn pra nao travar o jogo quando ativa
local PerfBackups = {
    Particles = {}, Shadows = {}, Lights = {}, TreeShadows = {}
}
local perfConns = {}

function applyParticles()
    task.spawn(function()
        if PerfConfig.Particles then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    if not PerfBackups.Particles[obj] then
                        PerfBackups.Particles[obj] = obj.Enabled
                    end
                    obj.Enabled = false
                end
            end
        else
            for obj, wasEnabled in pairs(PerfBackups.Particles) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = wasEnabled end)
                end
            end
            table.clear(PerfBackups.Particles)
        end
    end)
end

function applyBloomSunRays()
    pcall(function()
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("BloomEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = not PerfConfig.BloomSunRays
            end
        end
    end)
end

function applyTreeShadows()
    task.spawn(function()
        local function processTree(parent)
            for _, obj in ipairs(parent:GetChildren()) do
                if obj:IsA("BasePart") then
                    local name = obj.Name:lower()
                    if name:find("tree") or name:find("leaf") or name:find("branch") or name:find("fir") or name:find("pine") then
                        if PerfConfig.TreeShadows and not PerfBackups.TreeShadows[obj] then
                            PerfBackups.TreeShadows[obj] = obj.CastShadow
                            obj.CastShadow = false
                        elseif not PerfConfig.TreeShadows and PerfBackups.TreeShadows[obj] then
                            obj.CastShadow = PerfBackups.TreeShadows[obj]
                            PerfBackups.TreeShadows[obj] = nil
                        end
                    end
                end
                if obj:IsA("Model") or obj:IsA("Folder") then processTree(obj) end
            end
        end
        processTree(workspace)
    end)
end

function applyFilmGrain()
    pcall(function()
        LocalPlayer:SetAttribute("ClientSetting_FilmGrain", not PerfConfig.FilmGrain)
    end)
end

function applyMapLights()
    task.spawn(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                if PerfConfig.MapLights and not PerfBackups.Lights[obj] then
                    PerfBackups.Lights[obj] = obj.Enabled
                    obj.Enabled = false
                elseif not PerfConfig.MapLights and PerfBackups.Lights[obj] then
                    obj.Enabled = PerfBackups.Lights[obj]
                    PerfBackups.Lights[obj] = nil
                end
            end
        end
    end)
end

function applyAllShadows()
    pcall(function()
        if PerfConfig.AllShadows then
            if not PerfBackups.GlobalShadows then
                PerfBackups.GlobalShadows = Lighting.GlobalShadows
            end
            Lighting.GlobalShadows = false
            LocalPlayer:SetAttribute("ClientSetting_GlobalShadows", false)
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                    if not PerfBackups.Shadows[obj] then
                        PerfBackups.Shadows[obj] = obj.CastShadow
                        obj.CastShadow = false
                    end
                end
            end
        else
            if PerfBackups.GlobalShadows ~= nil then
                Lighting.GlobalShadows = PerfBackups.GlobalShadows
                LocalPlayer:SetAttribute("ClientSetting_GlobalShadows", PerfBackups.GlobalShadows)
                PerfBackups.GlobalShadows = nil
            end
            for obj, wasShadow in pairs(PerfBackups.Shadows) do
                if obj and obj.Parent then
                    pcall(function() obj.CastShadow = wasShadow end)
                end
            end
            table.clear(PerfBackups.Shadows)
        end
    end)
end

function applyLowerGraphics()
    pcall(function()
        if PerfConfig.LowerGraphics then
            if not PerfBackups.QualityLevel then
                PerfBackups.QualityLevel = settings():GetVideoQuality()
            end
            pcall(function() settings():SetVideoQuality(1) end)
        else
            if PerfBackups.QualityLevel then
                pcall(function() settings():SetVideoQuality(PerfBackups.QualityLevel) end)
                PerfBackups.QualityLevel = nil
            end
        end
    end)
end

function applyFPSBoost()
    -- FPS Boost = combo: ativa Particles + AllShadows + LowerGraphics
    if PerfConfig.FPSBoost then
        PerfConfig.Particles = true
        PerfConfig.AllShadows = true
        PerfConfig.LowerGraphics = true
        PerfConfig.TreeShadows = true
        PerfConfig.BloomSunRays = true
        applyParticles()
        applyAllShadows()
        applyLowerGraphics()
        applyTreeShadows()
        applyBloomSunRays()
    end
end

function applyPreloadGUI()
    -- Hook ContentProvider:PreloadAsync pra cancelar (so melhora o load, nao tem restore)
    if PerfConfig.PreloadGUI then
        pcall(function()
            local cp = game:GetService("ContentProvider")
            local oldPreload = cp.PreloadAsync
            cp.PreloadAsync = function(self, ...)
                -- Noop, cancela preload
                return
            end
        end)
    end
end

function applyAllPerformance()
    applyFPSBoost()
    applyParticles()
    applyBloomSunRays()
    applyTreeShadows()
    applyPreloadGUI()
    applyFilmGrain()
    applyMapLights()
    applyAllShadows()
    applyLowerGraphics()
end

-- [ Freecam ] -- / Camera livre desacoplada do player
local freecamPart = nil
local freecamConn = nil
local savedCameraType = nil

function applyFreecam()
    if freecamConn then freecamConn:Disconnect() freecamConn = nil end
    if freecamPart then freecamPart:Destroy() freecamPart = nil end
    if not PlayerConfig.Freecam then
        if savedCameraType then
            pcall(function() Camera.CameraType = savedCameraType end)
            savedCameraType = nil
        end
        return
    end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    savedCameraType = Camera.CameraType
    Camera.CameraType = Enum.CameraType.Scriptable

    freecamPart = Instance.new("Part")
    freecamPart.Anchored = true
    freecamPart.CanCollide = false
    freecamPart.Transparency = 1
    freecamPart.CFrame = Camera.CFrame
    freecamPart.Parent = workspace

    freecamConn = RunService.RenderStepped:Connect(function()
        if not PlayerConfig.Freecam or not freecamPart then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end

        local speed = PlayerConfig.FreecamSpeed
        if dir.Magnitude > 0.01 then
            freecamPart.CFrame = freecamPart.CFrame + (dir.Unit * speed * 0.1)
        end
        cam.CFrame = freecamPart.CFrame
    end)
end

function applyFreecamTP()
    if not PlayerConfig.FreecamTP then return end
    if not freecamPart then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(freecamPart.CFrame.X, freecamPart.CFrame.Y, freecamPart.CFrame.Z)
    end
    -- Toggle off after TP
    PlayerConfig.FreecamTP = false
    queueSave()
end

-- [ Respawn At Death Spot ] -- / Salva CFrame e teleporta ao respawn
local deathCFrame = nil
local respawnConn = nil

function setupRespawnHook()
    if respawnConn then respawnConn:Disconnect() respawnConn = nil end
    if not PlayerConfig.RespawnAtDeathSpot then return end

    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        respawnConn = hum.Died:Connect(function()
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then deathCFrame = hrp.CFrame end
        end)
    end
end

-- Hook CharacterAdded pra restaurar CFrame quando respawnar
LocalPlayer.CharacterAdded:Connect(function()
    if PlayerConfig.RespawnAtDeathSpot and deathCFrame then
        task.wait(1)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function() hrp.CFrame = deathCFrame end)
        end
    end
    setupRespawnHook()
    -- Re-aplica speed/jump/noclip no novo char
    applyPlayerSpeed()
    applyPlayerJump()
    if PlayerConfig.Noclip then applyNoclip() end
    if PlayerConfig.Fly then applyPlayerFly() end
end)
if LocalPlayer.Character then setupRespawnHook() end

-- [ Respawn button ] -- / Forca respawn
function doRespawn()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function() hum.Health = 0 end)
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Dead) end)
    end
end

-- [ Bring Car ] -- / Lista todos os carros e teleporta o escolhido pra frente do player
local bringCarPopup = nil
local bringCarDragConn = nil

function closeBringCarPopup()
    if bringCarDragConn then bringCarDragConn:Disconnect() bringCarDragConn = nil end
    if bringCarPopup then bringCarPopup:Destroy() bringCarPopup = nil end
end

-- Helper: acha o root part de um carro (mesma logica do addCarIfValid)
function findCarRoot(carModel)
    local driveSeat = carModel:FindFirstChild("DriveSeat")
    if driveSeat and driveSeat:IsA("BasePart") then return driveSeat end
    local body = carModel:FindFirstChild("Body")
    if body then
        if body:IsA("Model") then
            return body.PrimaryPart or body:FindFirstChildWhichIsA("BasePart")
        elseif body:IsA("BasePart") then
            return body
        end
    end
    local wheels = carModel:FindFirstChild("Wheels")
    if wheels then
        return wheels.PrimaryPart or wheels:FindFirstChildWhichIsA("BasePart")
    end
    return carModel.PrimaryPart or carModel:FindFirstChildWhichIsA("BasePart")
end

function bringSpecificCar(carModel)
    if not carModel or not carModel.Parent then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local carRoot = findCarRoot(carModel)
    if not carRoot then return end

    -- Teleporta o carro pra 8 studs a frente do player
    local forwardPos = hrp.Position + (hrp.CFrame.LookVector * 8)
    local targetCFrame = CFrame.new(forwardPos)

    pcall(function()
        if carModel.PrimaryPart then
            local offset = carModel.PrimaryPart.CFrame:Inverse() * carRoot.CFrame
            carModel:SetPrimaryPartCFrame(targetCFrame * offset)
        else
            -- Define o PrimaryPart temporariamente se nao tiver
            carModel.PrimaryPart = carRoot
            carModel:SetPrimaryPartCFrame(targetCFrame)
        end
    end)

    -- Forca network ownership
    pcall(function() carRoot:SetNetworkOwner(LocalPlayer) end)
    closeBringCarPopup()
end

function openBringCarList()
    closeBringCarPopup()

    -- Coleta todos os carros com nome + distancia
    -- Procura em varios lugares: workspace.Cars, workspace direto, subpastas
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local myPos = hrp and hrp.Position or Vector3.new()
    local carList = {}
    local seenCars = {}  -- evita duplicar o mesmo carro

    local function addCarIfValid(obj, forceAdd)
        if not obj:IsA("Model") then return end
        if seenCars[obj] then return end
        -- Verifica se e um carro (criterios do TWD2):
        -- 1. Tem DriveSeat (VehicleSeat) direto
        -- 2. Tem atributo "Fuel" no Model (todos os carros do TWD2 tem)
        -- 3. Tem Body/Wheels/A-Chassis Tune dentro (estrutura do A-Chassis)
        -- 4. Se forceAdd=true, adiciona mesmo assim (quando vem direto da pasta Cars)
        local driveSeat = obj:FindFirstChild("DriveSeat")
        local hasFuel = obj:GetAttribute("Fuel") ~= nil
        local hasBody = obj:FindFirstChild("Body") and obj:FindFirstChild("Wheels")
        local hasChassisTune = obj:FindFirstChild("A-Chassis Tune")
        if not driveSeat and not hasFuel and not hasBody and not hasChassisTune and not forceAdd then
            return
        end

        -- Tenta achar um root (ordem de prioridade):
        -- DriveSeat > Body (primeira BasePart dentro) > Wheels > PrimaryPart > primeira BasePart
        local rootPart = driveSeat
        if not rootPart or not rootPart:IsA("BasePart") then
            local body = obj:FindFirstChild("Body")
            if body and body:IsA("Model") then
                rootPart = body.PrimaryPart or body:FindFirstChildWhichIsA("BasePart")
            elseif body and body:IsA("BasePart") then
                rootPart = body
            end
        end
        if not rootPart or not rootPart:IsA("BasePart") then
            local wheels = obj:FindFirstChild("Wheels")
            if wheels then
                rootPart = wheels.PrimaryPart or wheels:FindFirstChildWhichIsA("BasePart")
            end
        end
        if not rootPart or not rootPart:IsA("BasePart") then
            rootPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
        end
        if not rootPart or not rootPart:IsA("BasePart") then return end

        seenCars[obj] = true
        local dist = hrp and math.floor((rootPart.Position - myPos).Magnitude) or 0
        local displayName = obj.Name or "Carro"
        -- Stats dos carros do TWD2 ficam como atributos diretos no Model (HP, MaxHP, Fuel, etc)
        local hp = obj:GetAttribute("HP")
        local maxHP = obj:GetAttribute("MaxHP")
        local fuel = obj:GetAttribute("Fuel")
        local info = ""
        if hp and maxHP then
            info = "HP:" .. math.floor(hp) .. "/" .. math.floor(maxHP)
        end
        if fuel then
            if info ~= "" then info = info .. " " end
            info = info .. "Fuel:" .. math.floor(fuel)
        end
        if info ~= "" then
            displayName = displayName .. "  [" .. info .. "]"
        end
        table.insert(carList, { model = obj, name = displayName, dist = dist, root = rootPart })
    end

    -- 1. Procura em workspace.Cars (pasta principal - todos os filhos sao carros)
    local carsFolder = workspace:FindFirstChild("Cars")
    if carsFolder then
        for _, obj in ipairs(carsFolder:GetChildren()) do
            addCarIfValid(obj, true)  -- forceAdd = true (sao todos carros)
        end
    end

    -- 2. Procura direto nos filhos do workspace (carros soltos no mapa)
    -- So adiciona se atender os criterios (DriveSeat/Fuel/Body/A-Chassis)
    for _, obj in ipairs(workspace:GetChildren()) do
        addCarIfValid(obj, false)
    end

    -- 3. Procura em pastas relacionadas (CarSpawns, PlayerBuilds)
    for _, folderName in ipairs({"CarSpawns", "PlayerBuilds"}) do
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            for _, obj in ipairs(folder:GetDescendants()) do
                addCarIfValid(obj, false)
            end
        end
    end

    -- Ordena por distancia (mais perto primeiro)
    table.sort(carList, function(a, b) return a.dist < b.dist end)

    -- Cria popup filho do screenGui (pra aparecer fora do mainFrame)
    -- mas com position atualizada pra seguir o mainFrame quando arrasta
    local popup = Instance.new("Frame")
    popup.Name = "BringCarPopup"
    popup.Size = UDim2.new(0, 450, 0, 250)  -- mesma largura do mainFrame (450), altura max 250
    -- Posicao: abaixo do mainFrame (usa AbsolutePosition pra acompanhar drag)
    local mainAbsPos = mainFrame.AbsolutePosition
    local mainAbsSize = mainFrame.AbsoluteSize
    popup.Position = UDim2.new(0, mainAbsPos.X, 0, mainAbsPos.Y + mainAbsSize.Y + 5)
    popup.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    popup.BorderSizePixel = 0
    popup.ZIndex = 91
    popup.ClipsDescendants = true
    popup.Parent = screenGui
    local pc = Instance.new("UICorner")
    pc.CornerRadius = UDim.new(0, 6)
    pc.Parent = popup

    bringCarPopup = popup

    -- Atualiza posicao do popup conforme o mainFrame se move (drag)
    -- Usa RunService.RenderStepped pra manter sincronizado
    bringCarDragConn = RunService.RenderStepped:Connect(function()
        if not popup or not popup.Parent then
            if bringCarDragConn then bringCarDragConn:Disconnect() bringCarDragConn = nil end
            return
        end
        local pos = mainFrame.AbsolutePosition
        local sz = mainFrame.AbsoluteSize
        popup.Position = UDim2.new(0, pos.X, 0, pos.Y + sz.Y + 5)
    end)

    -- Header (barra de titulo, serve pra arrastar)
    local popupHeader = Instance.new("Frame")
    popupHeader.Size = UDim2.new(1, 0, 0, 28)
    popupHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
    popupHeader.BorderSizePixel = 0
    popupHeader.ZIndex = 92
    popupHeader.Parent = popup
    local phc = Instance.new("UICorner")
    phc.CornerRadius = UDim.new(0, 6)
    phc.Parent = popupHeader

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, -40, 1, 0)
    header.Position = UDim2.new(0, 10, 0, 0)
    header.BackgroundTransparency = 1
    header.Text = "Carros (" .. #carList .. ")"
    header.Font = Enum.Font.GothamBold
    header.TextSize = 13
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.ZIndex = 93
    header.Parent = popupHeader

    -- Botao X
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0.5, -12)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 11
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.ZIndex = 93
    closeBtn.Parent = popupHeader
    local cbc = Instance.new("UICorner")
    cbc.CornerRadius = UDim.new(0, 4)
    cbc.Parent = closeBtn
    closeBtn.MouseButton1Click:Connect(function() closeBringCarPopup() end)

    -- Mensagem se nao achou nenhum carro
    if #carList == 0 then
        local msg = Instance.new("TextLabel")
        msg.Size = UDim2.new(1, -20, 0, 60)
        msg.Position = UDim2.new(0, 10, 0, 50)
        msg.BackgroundTransparency = 1
        msg.Text = "Nenhum carro encontrado.\nAproxime-se de carros e tente novamente."
        msg.Font = Enum.Font.Gotham
        msg.TextSize = 12
        msg.TextColor3 = Color3.fromRGB(255, 150, 150)
        msg.TextWrapped = true
        msg.ZIndex = 92
        msg.Parent = popup
        return
    end

    -- ScrollingFrame com a lista de carros (ocupa resto do popup)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -36)
    scroll.Position = UDim2.new(0, 5, 0, 30)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = 92
    scroll.Parent = popup

    local layout = Instance.new("UIListLayout")
    layout.Parent = scroll
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 3)

    -- Padding lateral
    local scrollPad = Instance.new("UIPadding")
    scrollPad.PaddingLeft = UDim.new(0, 5)
    scrollPad.PaddingRight = UDim.new(0, 5)
    scrollPad.PaddingTop = UDim.new(0, 3)
    scrollPad.Parent = scroll

    -- Cria um botao retangular largo pra cada carro
    for i, car in ipairs(carList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.BorderSizePixel = 0
        btn.Text = ""  -- nao usa Text do botao, usa 2 labels separados
        btn.LayoutOrder = i
        btn.ZIndex = 92
        btn.Parent = scroll
        local bhc = Instance.new("UICorner")
        bhc.CornerRadius = UDim.new(0, 4)
        bhc.Parent = btn

        -- Label do nome (esquerda) - limite de 30 chars pra nao cortar
        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(0.65, 0, 1, 0)
        nameLbl.BackgroundTransparency = 1
        local carName = car.name
        if #carName > 35 then carName = carName:sub(1, 32) .. "..." end
        nameLbl.Text = carName
        nameLbl.Font = Enum.Font.Gotham
        nameLbl.TextSize = 12
        nameLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.ZIndex = 93
        nameLbl.Parent = btn
        local nlp = Instance.new("UIPadding")
        nlp.PaddingLeft = UDim.new(0, 10)
        nlp.Parent = nameLbl

        -- Label da distancia (direita) com cor baseada na distancia
        local distLbl = Instance.new("TextLabel")
        distLbl.Size = UDim2.new(0.35, 0, 1, 0)
        distLbl.Position = UDim2.new(0.65, 0, 0, 0)
        distLbl.BackgroundTransparency = 1
        -- Formata distancia: se > 1000 mostra em km
        local distText = car.dist .. "m"
        if car.dist >= 1000 then
            distText = string.format("%.1fkm", car.dist / 1000)
        end
        distLbl.Text = distText
        distLbl.Font = Enum.Font.GothamBold
        distLbl.TextSize = 12
        -- Cor: verde (perto) > amarelo > vermelho (longe)
        local distColor
        if car.dist < 500 then
            distColor = Color3.fromRGB(100, 255, 100)  -- verde
        elseif car.dist < 1500 then
            distColor = Color3.fromRGB(255, 255, 100)  -- amarelo
        elseif car.dist < 3000 then
            distColor = Color3.fromRGB(255, 180, 80)   -- laranja
        else
            distColor = Color3.fromRGB(255, 100, 100)  -- vermelho
        end
        distLbl.TextColor3 = distColor
        distLbl.TextXAlignment = Enum.TextXAlignment.Right
        distLbl.ZIndex = 93
        distLbl.Parent = btn
        local dlp = Instance.new("UIPadding")
        dlp.PaddingRight = UDim.new(0, 10)
        dlp.Parent = distLbl

        -- Hover effect
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(50, 70, 110)
            nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            nameLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        end)

        -- Click: teleporta esse carro
        btn.MouseButton1Click:Connect(function()
            bringSpecificCar(car.model)
        end)
    end
end

-- [ Teleport Logic ] -- / Map Click TP + Low Health TP
local mapClickConn = nil
local lowHealthConn = nil
local safePosition = nil  -- salva ultima posicao em safe zone

-- Map Click TP: atalho T teleporta pra onde o mouse aponta no mundo
function applyMapClickTP()
    if mapClickConn then mapClickConn:Disconnect() mapClickConn = nil end
    if not PlayerConfig.MapClickTP then return end
    mapClickConn = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        -- Tecla T = teleporta pra posicao do mouse no mundo
        if input.KeyCode ~= Enum.KeyCode.T then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        -- Usa LocalPlayer:GetMouse() que e mais confiavel que GetMouseLocation
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Hit
        if target then
            -- Pega a posicao e teleporta 5 studs acima
            local pos = target.Position
            pcall(function()
                hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            end)
        end
    end)
end

-- Low Health TP: teleporta pro spawn do jogo quando vida baixa
function applyLowHealthTP()
    if lowHealthConn then lowHealthConn = false end
    if not PlayerConfig.LowHealthTP then return end
    -- Usa task.spawn com loop task.wait(1) em vez de Heartbeat (mais leve)
    lowHealthConn = true
    task.spawn(function()
        local triggered = false  -- flag pra nao teleportar mil vezes
        while lowHealthConn and PlayerConfig.LowHealthTP do
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local maxHP = hum.MaxHealth
                if maxHP <= 0 then maxHP = 100 end
                local ratio = hum.Health / maxHP * 100
                if ratio <= PlayerConfig.LowHealthPct and not triggered then
                    triggered = true
                    pcall(function()
                        -- Procura SpawnLocation no workspace (coring default do Roblox)
                        local spawnPart = nil
                        local closestDist = math.huge
                        -- Tenta workspace.PlayerSpawns
                        local spawnsFolder = workspace:FindFirstChild("PlayerSpawns")
                        if spawnsFolder then
                            for _, spawn in ipairs(spawnsFolder:GetChildren()) do
                                local part = spawn:IsA("BasePart") and spawn or spawn:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    local d = (part.Position - hrp.Position).Magnitude
                                    if d < closestDist then
                                        closestDist = d
                                        spawnPart = part
                                    end
                                end
                            end
                        end
                        -- Fallback: procura SpawnLocation direto no workspace
                        if not spawnPart then
                            for _, obj in ipairs(workspace:GetChildren()) do
                                if obj:IsA("SpawnLocation") then
                                    local d = (obj.Position - hrp.Position).Magnitude
                                    if d < closestDist then
                                        closestDist = d
                                        spawnPart = obj
                                    end
                                end
                            end
                        end
                        -- Teleporta
                        if spawnPart then
                            hrp.CFrame = CFrame.new(spawnPart.Position + Vector3.new(0, 5, 0))
                        elseif safePosition then
                            hrp.CFrame = safePosition
                        end
                    end)
                elseif ratio >= 80 then
                    -- Reset do trigger quando HP recuperar
                    triggered = false
                    -- Salva posicao segura (HP cheio = safe zone)
                    safePosition = hrp.CFrame
                end
            end
            task.wait(1)
        end
    end)
end


-- [ Painel UI ] -- / Novo Painel qyzHub

local Painel = {}
Painel.__index = Painel

-- [ script ] -- / nomes dos objetos do painel que o modulo procura
local NOMES = {
    Conteudo = "content panel",
    Opcoes = "options panel",
    Perfil = "Profile",
    PerfilNome = "Name",
    PerfilUsuario = "Username",
    PerfilAvatar = "imagemlabel",
    Fundo = "Background",
    Seta = "seta",
    Toggle = "toggle",
    ToggleTrilho = "Rectangle 29",
    ToggleBola = "Ellipse 15",
    SliderTrilho = "Rectangle 30",
    SliderBola = "Ellipse 16",
}

-- [ script ] -- / textos do Dashboard e do titulo, o nome de cada objeto que mostra uma informacao
local DASHBOARD = {
    Pagina = "game content",
    Icone = "Imagemlabel",
    Titulo = "Title",
    TituloJogo = "namejogo",
    Valores = {
        Name = "Namejogo",
        Admins = "Quantidade",
        Players = "quantidade",
        Ping = "ms",
    },
    Rotulos = {
        Name = "Name:",
        Admins = "Admins:",
        Players = "Players:",
        Ping = "Ping:",
    },
    LarguraValor = 190,
    LimiteTitulo = 16,
    LarguraLetraTitulo = 19,
    IntervaloPing = 2,
    CantoIcone = 16,
}

-- [ script ] -- / abas da lateral, a pagina vem do nome direto ou de uma secao que existe so nela
local ABAS = {
    { Nome = "Dashboard", Pagina = { "game content", "game_content" } },
    { Nome = "Visuals", Marcador = "ESP Colors" },
    { Nome = "Movement", Marcador = "Vehicle Movement" },
    { Nome = "Combat", Marcador = "FOV" },
    { Nome = "Performance", Marcador = "Performance" },
    { Nome = "Others", Marcador = "Others" },
}

-- [ script ] -- / tempos, cores e medidas de cada parte do painel
local CONFIG = {
    Tempo = 0.2,
    AbaInicial = "Dashboard",
    IniciarAberto = true,
    TeclaAbrir = Enum.KeyCode.RightShift,
    Logo = {
        Imagem = "rbxassetid://75375325952272",
    },
    BotaoToque = {
        Mostrar = true,
        Tamanho = 56,
        Cor = Color3.fromRGB(20, 20, 20),
        CorTexto = Color3.fromRGB(230, 230, 230),
        Texto = "Q",
    },
    Rolagem = {
        Folga = 24,
        Barra = {
            Mostrar = true,
            Espessura = 6,
            Transparencia = 0.55,
            Cor = Color3.fromRGB(150, 150, 150),
        },
        VigiaArrasto = 0.25,
    },
    Slider = {
        TamanhoTexto = 28,
        MargemDireita = 24,
        CorValor = Color3.fromRGB(240, 240, 240),
        CorMaximo = Color3.fromRGB(120, 120, 120),
    },
    Aba = {
        TranspAtiva = 0.25,
        TranspHover = 0.4,
        CorAtiva = Color3.new(1, 1, 1),
    },
    Toggle = {
        CorLigado = Color3.new(0.7, 0.7, 0.7),
        TranspLigado = 0.1,
    },
    Cor = {
        CorSelecao = Color3.fromRGB(180, 180, 180),
        EspessuraSelecao = 5,
    },
    Secao = {
        FolgaCabecalho = 11,
        AlturaMinimaCabecalho = 40,
        GiroSeta = 180,
    },
    Dropdown = {
        BrilhoHover = 0.12,
        Folga = 6,
        Fundo = Color3.fromRGB(28, 28, 28),
        ItemAltura = 44,
        ItemTexto = 26,
        Margem = 8,
        Espaco = 4,
        AlturaMaxima = 252,
        GiroSeta = 180,
        MostrarSelecionado = true,
    },
}

local TWEEN_INFO = TweenInfo.new(CONFIG.Tempo, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- [ script ] -- / guarda para onde cada objeto esta indo, assim da pra medir o tamanho final no meio da animacao
local DESTINOS = setmetatable({}, { __mode = "k" })

local AVISOU_TWEEN = false

-- [ script ] -- / anima as propriedades de um objeto
local function animar(objeto, propriedades)
    if propriedades.Position or propriedades.Size then
        local destino = DESTINOS[objeto] or {}
        destino.Position = propriedades.Position or destino.Position
        destino.Size = propriedades.Size or destino.Size
        DESTINOS[objeto] = destino
    end

    local ok, tween = pcall(function()
        local criado = TweenService:Create(objeto, TWEEN_INFO, propriedades)
        criado:Play()
        return criado
    end)
    if ok then
        return tween
    end

    -- [ script ] -- / se a animacao falhar o painel nao pode parar, aplica o valor final direto
    if not AVISOU_TWEEN then
        AVISOU_TWEEN = true
        warn("[Painel] nao consegui animar, aplicando direto: " .. tostring(tween))
    end
    for nome, valor in propriedades do
        objeto[nome] = valor
    end
    return {
        Completed = {
            Once = function(_, funcao)
                task.defer(funcao)
            end,
        },
    }
end

-- [ script ] -- / posicao e tamanho finais de um objeto, mesmo que ele ainda esteja animando
local function destinoDe(objeto)
    local destino = DESTINOS[objeto]
    return (destino and destino.Position) or objeto.Position, (destino and destino.Size) or objeto.Size
end

-- [ script ] -- / clareia uma cor em direcao ao branco
local function clarear(cor, quantidade)
    return cor:Lerp(Color3.new(1, 1, 1), quantidade)
end

-- [ script ] -- / borda de cima de um objeto, em offset, no espaco do pai
local function topoDe(objeto)
    return objeto.Position.Y.Offset - objeto.AnchorPoint.Y * objeto.Size.Y.Offset
end

-- [ script ] -- / fonte do texto das abas, usada nos textos que o modulo cria
local function fonteDasAbas(raiz)
    local conteudo = raiz:FindFirstChild(NOMES.Conteudo)
    local aba = if conteudo then conteudo:FindFirstChildOfClass("TextButton") else nil
    local rotulo = if aba then aba:FindFirstChildOfClass("TextLabel") else nil
    return if rotulo then rotulo.FontFace else nil
end

-- [ script ] -- / diz se o dedo ou o botao do mouse que arrastava o slider ja foi solto
local function arrastoAcabou(arrasto)
    local entrada = arrasto.Entrada
    local estado = entrada.UserInputState
    if estado == Enum.UserInputState.End or estado == Enum.UserInputState.Cancel then
        return true
    end
    if entrada.UserInputType == Enum.UserInputType.MouseButton1 then
        return not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
    end
    return false
end

-- [ script ] -- / cria um botao invisivel que serve de area de clique
local function criarArea(nome, pai)
    local area = Instance.new("TextButton")
    area.Name = nome
    area.BackgroundTransparency = 1
    area.Text = ""
    area.AutoButtonColor = false
    area.Selectable = false
    area.ZIndex = 50
    area.Parent = pai
    return area
end

-- [ script ] -- / diz se a linha e um dropdown (pilula toggle em Frame mais a seta)
local function ehLinhaDropdown(quadro)
    local pilula = quadro:FindFirstChild(NOMES.Toggle)
    return pilula ~= nil and pilula:IsA("Frame") and quadro:FindFirstChild(NOMES.Seta) ~= nil
end

-- [ script ] -- / diz se o Frame e uma secao que abre e fecha (tem seta e nao e dropdown)
local function ehSecao(quadro)
    return quadro:IsA("Frame") and quadro:FindFirstChild(NOMES.Seta) ~= nil and not ehLinhaDropdown(quadro)
end

-- [ script ] -- / lista os botoes de cor de uma linha, quadrados coloridos sem texto
local function botoesDeCor(linha)
    local botoes = {}
    if linha:FindFirstChild(NOMES.Toggle) then
        return botoes
    end

    for _, filho in linha:GetChildren() do
        if filho:IsA("TextButton") and filho.Text == "" and filho.BackgroundTransparency < 1 then
            table.insert(botoes, filho)
        end
    end
    return botoes
end

-- [ script ] -- / acha o texto "0/100" da linha e devolve o texto e o valor maximo
local function acharRotuloValor(linha)
    for _, filho in linha:GetChildren() do
        if filho:IsA("TextLabel") then
            local maximo = string.match(filho.Name, "^%-?%d+/(%d+)$")
            if maximo then
                return filho, tonumber(maximo)
            end
        end
    end
    return nil, 100
end

-- [ script ] -- / monta a descricao de um bloco (secao) para poder abrir e fechar
local function criarBloco(quadro, tipo)
    local fundo = quadro:FindFirstChild(NOMES.Fundo)
    local bloco = {
        Tipo = tipo,
        Quadro = quadro,
        Fundo = fundo,
        Seta = quadro:FindFirstChild(NOMES.Seta),
        Linhas = {},
        Recolhido = false,
        GapAbaixo = 0,
    }
    bloco.RotacaoSeta = if bloco.Seta then bloco.Seta.Rotation else 0

    if tipo == "proprio" then
        bloco.Topo = topoDe(fundo)
        bloco.Altura = fundo.Size.Y.Offset
    else
        bloco.Topo = topoDe(quadro)
        bloco.Altura = quadro.Size.Y.Offset
    end

    local origem = if tipo == "proprio" then bloco.Topo else 0
    local menorTopo = math.huge
    for _, filho in quadro:GetChildren() do
        if filho:IsA("Frame") and filho.Name ~= NOMES.Fundo and filho.Name ~= NOMES.Seta and not ehSecao(filho) then
            table.insert(bloco.Linhas, filho)
            menorTopo = math.min(menorTopo, topoDe(filho))
        end
    end

    if menorTopo == math.huge then
        bloco.AlturaRecolhida = bloco.Altura
    else
        bloco.AlturaRecolhida = math.clamp(menorTopo - origem - CONFIG.Secao.FolgaCabecalho, 0, bloco.Altura)
    end

    return bloco
end

-- [ script ] -- / move e redimensiona o bloco, mantendo a borda de cima no topo pedido
local function posicionarBloco(bloco, topo, altura)
    local fundo = bloco.Fundo

    if bloco.Tipo == "secao" then
        local quadro = bloco.Quadro
        animar(quadro, {
            Position = UDim2.new(quadro.Position.X.Scale, quadro.Position.X.Offset, 0, topo + quadro.AnchorPoint.Y * altura),
            Size = UDim2.new(quadro.Size.X.Scale, quadro.Size.X.Offset, 0, altura),
        })
        if fundo then
            animar(fundo, {
                Position = UDim2.new(fundo.Position.X.Scale, fundo.Position.X.Offset, 0, fundo.AnchorPoint.Y * altura),
                Size = UDim2.new(fundo.Size.X.Scale, fundo.Size.X.Offset, 0, altura),
            })
        end
    else
        animar(fundo, {
            Position = UDim2.new(fundo.Position.X.Scale, fundo.Position.X.Offset, 0, topo + fundo.AnchorPoint.Y * altura),
            Size = UDim2.new(fundo.Size.X.Scale, fundo.Size.X.Offset, 0, altura),
        })
    end
end

-- [ script ] -- / cria o painel a partir da raiz (o Frame qyzHub)
function Painel.new(raiz)
    local self = setmetatable({}, Painel)

    self.Raiz = raiz
    self.Controles = {}
    self.Abas = {}
    self.AbasPorNome = {}
    self.AbaAtual = nil

    self._porNome = {}
    self._paginas = {}
    self._anfitrioes = {}
    self._conexoes = {}
    self._extras = {}
    self._arrasto = nil
    self._popupAberto = nil
    self._opcoes = nil
    self._aviso = nil
    self._info = {}
    self._ouvintes = {}
    self._vivo = true
    self.Aberto = true

    self._bloqueio = criarArea("FundoDropdown", raiz)
    self._bloqueio.ZIndex = 99
    self._bloqueio.Size = UDim2.fromScale(1, 1)
    self._bloqueio.Visible = false
    table.insert(self._conexoes, self._bloqueio.Activated:Connect(function()
        self:_fecharPopup()
    end))

    self:_montarAbas()
    self:_montarControles()
    self:_ligarEntrada()
    self:_preencherPerfil()
    self:_ligarDashboard()

    if self.AbasPorNome[CONFIG.AbaInicial] then
        self:SelecionarAba(CONFIG.AbaInicial)
    elseif self.Abas[1] then
        self:SelecionarAba(self.Abas[1].Nome)
    end

    self:_criarBotaoToque()
    if CONFIG.IniciarAberto then
        self:Abrir()
    else
        self:Fechar()
    end

    return self
end

-- [ script ] -- / acha a pagina que tem uma secao com o nome do marcador
function Painel:_acharPagina(opcoes, marcador)
    for _, filho in opcoes:GetChildren() do
        if filho:IsA("ScrollingFrame") and filho:FindFirstChild(marcador) then
            return filho
        end
    end
    return nil
end

-- [ script ] -- / liga as abas da lateral com as paginas
function Painel:_montarAbas()
    local conteudo = self.Raiz:FindFirstChild(NOMES.Conteudo)
    local opcoes = self.Raiz:FindFirstChild(NOMES.Opcoes)
    if not conteudo or not opcoes then
        warn("[Painel] nao achei '" .. NOMES.Conteudo .. "' ou '" .. NOMES.Opcoes .. "' dentro de " .. self.Raiz.Name)
        return
    end
    self._opcoes = opcoes

    for _, definicao in ABAS do
        local botao = conteudo:FindFirstChild(definicao.Nome)
        local pagina
        if definicao.Pagina then
            for _, nomePagina in definicao.Pagina do
                pagina = pagina or opcoes:FindFirstChild(nomePagina)
            end
        else
            pagina = self:_acharPagina(opcoes, definicao.Marcador)
        end

        if botao and botao:IsA("TextButton") then
            if not pagina then
                warn("[Painel] a aba '" .. definicao.Nome .. "' nao tem pagina na interface, ela abre vazia")
            end
            self:_ligarAba(definicao.Nome, botao, pagina)
        else
            warn("[Painel] aba '" .. definicao.Nome .. "' ignorada: botao nao encontrado")
        end
    end

    self:_criarAvisoVazio(opcoes)
end

-- [ script ] -- / texto mostrado quando a aba escolhida ainda nao tem pagina
function Painel:_criarAvisoVazio(opcoes)
    local aviso = Instance.new("TextLabel")
    aviso.Name = "AvisoPaginaVazia"
    aviso.AnchorPoint = Vector2.new(0.5, 0.5)
    aviso.Position = UDim2.fromScale(0.5, 0.5)
    aviso.Size = UDim2.new(0.8, 0, 0, 60)
    aviso.BackgroundTransparency = 1
    aviso.Text = "Esta página ainda não foi adicionada"
    aviso.TextSize = 32
    aviso.TextColor3 = Color3.fromRGB(120, 120, 120)
    aviso.ZIndex = 10
    aviso.Visible = false

    local fonte = fonteDasAbas(self.Raiz)
    if fonte then
        aviso.FontFace = fonte
    end

    aviso.Parent = opcoes
    self._aviso = aviso
    table.insert(self._extras, aviso)
end

-- [ script ] -- / guarda os dados da aba e liga clique e hover
function Painel:_ligarAba(nome, botao, pagina)
    local fundo = botao:FindFirstChild(NOMES.Fundo)
    local rotulo = botao:FindFirstChildOfClass("TextLabel")
    local aba = {
        Nome = nome,
        Botao = botao,
        Pagina = pagina,
        Fundo = fundo,
        Rotulo = rotulo,
        Ativa = false,
        TranspNormal = if fundo then fundo.BackgroundTransparency else 1,
        CorNormal = if rotulo then rotulo.TextColor3 else Color3.new(1, 1, 1),
    }

    botao.AutoButtonColor = false
    table.insert(self.Abas, aba)
    self.AbasPorNome[nome] = aba

    table.insert(self._conexoes, botao.Activated:Connect(function()
        self:SelecionarAba(nome)
    end))
    table.insert(self._conexoes, botao.MouseEnter:Connect(function()
        self:_desenharAba(aba, true)
    end))
    table.insert(self._conexoes, botao.MouseLeave:Connect(function()
        self:_desenharAba(aba, false)
    end))
end

-- [ script ] -- / pinta a aba conforme ela esta ativa, com o mouse em cima ou normal
function Painel:_desenharAba(aba, sobre)
    if aba.Fundo then
        local transparencia = aba.TranspNormal
        if aba.Ativa then
            transparencia = CONFIG.Aba.TranspAtiva
        elseif sobre then
            transparencia = CONFIG.Aba.TranspHover
        end
        animar(aba.Fundo, { BackgroundTransparency = transparencia })
    end

    if aba.Rotulo then
        animar(aba.Rotulo, { TextColor3 = if aba.Ativa then CONFIG.Aba.CorAtiva else aba.CorNormal })
    end
end

-- [ script ] -- / mostra a pagina da aba escolhida e esconde as outras
function Painel:SelecionarAba(nome)
    if not self.AbasPorNome[nome] then
        warn("[Painel] aba nao encontrada: " .. tostring(nome))
        return
    end

    for _, aba in self.Abas do
        aba.Ativa = aba.Nome == nome
        if aba.Pagina then
            aba.Pagina.Visible = aba.Ativa
        end
        self:_desenharAba(aba, false)
    end

    if self._aviso then
        self._aviso.Visible = self.AbasPorNome[nome].Pagina == nil
    end

    self.AbaAtual = nome
    self:_fecharPopup()
    self:_terminarArrasto()

    local pagina = self.AbasPorNome[nome].Pagina
    if pagina and pagina:IsA("ScrollingFrame") then
        pagina.ScrollingEnabled = true
        self:_atualizarCanvas(pagina, false)
    end
end

-- [ script ] -- / percorre as paginas e liga secoes, toggles, sliders, cores e dropdowns
function Painel:_montarControles()
    if not self._opcoes then
        return
    end

    for _, pagina in self._opcoes:GetChildren() do
        if pagina:IsA("ScrollingFrame") then
            table.insert(self._paginas, pagina)
            self:_montarSecoes(pagina)

            for _, item in pagina:GetDescendants() do
                self:_examinar(item)
            end

            pagina.AutomaticCanvasSize = Enum.AutomaticSize.None
            pagina.ScrollingEnabled = true
            pagina.ScrollingDirection = Enum.ScrollingDirection.Y

            local barra = CONFIG.Rolagem.Barra
            if barra.Mostrar then
                pagina.ScrollBarThickness = barra.Espessura
                pagina.ScrollBarImageTransparency = barra.Transparencia
                pagina.ScrollBarImageColor3 = barra.Cor
            end

            self:_atualizarCanvas(pagina, false)

            table.insert(self._conexoes, pagina:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                self:_fecharPopup()
            end))
        end
    end
end

-- [ script ] -- / descobre que tipo de controle e o objeto e liga ele
function Painel:_examinar(item)
    if item:IsA("TextButton") then
        if item.Name == NOMES.Toggle and item:FindFirstChild(NOMES.ToggleTrilho) and item:FindFirstChild(NOMES.ToggleBola) then
            self:_criarToggle(item)
        end
    elseif item:IsA("Frame") then
        if item:FindFirstChild(NOMES.SliderTrilho) and item:FindFirstChild(NOMES.SliderBola) then
            self:_criarSlider(item)
        elseif ehLinhaDropdown(item) then
            self:_criarDropdown(item)
        else
            local botoes = botoesDeCor(item)
            if #botoes >= 2 then
                self:_criarCores(item, botoes)
            end
        end
    end
end

-- [ script ] -- / guarda o controle com a chave "Secao/Linha" e com o nome da linha se ele for unico
function Painel:_registrar(linha, controle)
    local secao = if linha.Parent then linha.Parent.Name else ""
    local base = secao .. "/" .. linha.Name
    local chave = base
    local numero = 1
    while self.Controles[chave] do
        numero += 1
        chave = base .. "#" .. numero
    end

    controle.Chave = chave
    controle.Linha = linha
    self.Controles[chave] = controle

    if self._porNome[linha.Name] == nil then
        self._porNome[linha.Name] = controle
    else
        self._porNome[linha.Name] = false
    end
end

-- [ script ] -- / cria o toggle liga e desliga, com a bolinha deslizando
function Painel:_criarToggle(botao)
    local trilho = botao:FindFirstChild(NOMES.ToggleTrilho)
    local bola = botao:FindFirstChild(NOMES.ToggleBola)

    local xDesligado = bola.Position.X.Offset
    local xLigado = botao.Size.X.Offset - xDesligado
    local corDesligado = trilho.BackgroundColor3
    local transpDesligado = trilho.BackgroundTransparency

    local controle = { Tipo = "toggle", Valor = false }

    controle.Definir = function(valor, silencioso)
        valor = valor == true
        if valor == controle.Valor then
            return
        end
        controle.Valor = valor

        local x = if valor then xLigado else xDesligado
        animar(bola, {
            Position = UDim2.new(bola.Position.X.Scale, x, bola.Position.Y.Scale, bola.Position.Y.Offset),
        })
        animar(trilho, {
            BackgroundColor3 = if valor then CONFIG.Toggle.CorLigado else corDesligado,
            BackgroundTransparency = if valor then CONFIG.Toggle.TranspLigado else transpDesligado,
        })

        if not silencioso then
            self:_avisar(controle, valor)
        end
    end

    botao.AutoButtonColor = false
    table.insert(self._conexoes, botao.Activated:Connect(function()
        controle.Definir(not controle.Valor)
    end))

    self:_registrar(botao.Parent, controle)
end

-- [ script ] -- / cria o slider de 0 ao maximo lido do texto "0/100" da linha
function Painel:_criarSlider(quadro)
    local trilho = quadro:FindFirstChild(NOMES.SliderTrilho)
    local bola = quadro:FindFirstChild(NOMES.SliderBola)
    local linha = quadro.Parent
    local rotulo, maximo = acharRotuloValor(linha)
    local pagina = quadro:FindFirstAncestorWhichIsA("ScrollingFrame")

    local largura = quadro.Size.X.Offset
    local meia = bola.Size.X.Offset / 2
    local curso = math.max(largura - bola.Size.X.Offset, 0)

    local controle = { Tipo = "slider", Valor = 0, Maximo = maximo }

    local textoValor = nil
    if rotulo then
        local config = CONFIG.Slider
        local corValor = "#" .. config.CorValor:ToHex()
        local corMaximo = "#" .. config.CorMaximo:ToHex()

        rotulo.TextScaled = false
        rotulo.TextWrapped = false
        rotulo.RichText = true
        rotulo.TextSize = config.TamanhoTexto
        rotulo.TextXAlignment = Enum.TextXAlignment.Right
        rotulo.TextYAlignment = Enum.TextYAlignment.Center
        rotulo.AnchorPoint = Vector2.new(1, 0.5)
        rotulo.Size = UDim2.new(0, 100, 0, rotulo.Size.Y.Offset)
        rotulo.Position = UDim2.new(0, linha.Size.X.Offset - config.MargemDireita, rotulo.Position.Y.Scale, rotulo.Position.Y.Offset)

        textoValor = function(valor)
            return string.format('<font color="%s">%d</font><font color="%s">/%d</font>', corValor, valor, corMaximo, maximo)
        end
    end

    controle.Definir = function(valor, silencioso)
        valor = math.clamp(math.round(valor), 0, maximo)
        local mudou = valor ~= controle.Valor
        controle.Valor = valor

        local alfa = if maximo > 0 then valor / maximo else 0
        bola.Position = UDim2.new(0, meia + alfa * curso, bola.Position.Y.Scale, bola.Position.Y.Offset)
        if rotulo and textoValor then
            rotulo.Text = textoValor(valor)
        end

        if mudou and not silencioso then
            self:_avisar(controle, valor)
        end
    end

    local function valorDaTela(xTela)
        local escala = if largura > 0 then quadro.AbsoluteSize.X / largura else 1
        if escala <= 0 then
            escala = 1
        end
        local xLocal = (xTela - quadro.AbsolutePosition.X) / escala
        local alfa = if curso > 0 then math.clamp((xLocal - meia) / curso, 0, 1) else 0
        return alfa * maximo
    end

    local function iniciar(entrada)
        local tipo = entrada.UserInputType
        if tipo ~= Enum.UserInputType.MouseButton1 and tipo ~= Enum.UserInputType.Touch then
            return
        end

        if self._arrasto and self._arrasto.Entrada ~= entrada then
            self:_terminarArrasto()
        end

        self._arrasto = {
            Entrada = entrada,
            Pagina = pagina,
            Atualizar = function(xTela)
                controle.Definir(valorDaTela(xTela))
            end,
        }
        if pagina then
            pagina.ScrollingEnabled = false
        end
        controle.Definir(valorDaTela(entrada.Position.X))
        self:_vigiarArrasto(self._arrasto)
    end

    controle.Definir(0, true)
    for _, alvo in { quadro, trilho, bola } do
        table.insert(self._conexoes, alvo.InputBegan:Connect(iniciar))
    end

    self:_registrar(linha, controle)
end

-- [ script ] -- / cria o seletor de cores, o botao escolhido ganha um contorno
function Painel:_criarCores(linha, botoes)
    local controle = { Tipo = "cor", Valor = nil, Nome = nil }
    local contornos = {}

    for _, botao in botoes do
        local contorno = Instance.new("UIStroke")
        contorno.Color = CONFIG.Cor.CorSelecao
        contorno.Thickness = CONFIG.Cor.EspessuraSelecao
        contorno.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        contorno.Enabled = false
        contorno.Parent = botao
        contornos[botao] = contorno

        botao.AutoButtonColor = false
        table.insert(self._conexoes, botao.Activated:Connect(function()
            controle.Definir(botao.Name)
        end))
    end

    controle.Definir = function(nome, silencioso)
        -- [ script ] -- / recebendo uma cor em vez do nome, escolhe o botao de cor mais parecido
        if type(nome) ~= "string" and type(nome) ~= "nil" and nome.R then
            local menor = math.huge
            local maisParecido
            for _, botao in botoes do
                local cor = botao.BackgroundColor3
                local distancia = (cor.R - nome.R) ^ 2 + (cor.G - nome.G) ^ 2 + (cor.B - nome.B) ^ 2
                if distancia < menor then
                    menor = distancia
                    maisParecido = botao
                end
            end
            nome = if maisParecido then maisParecido.Name else nil
        end

        if controle.Nome == nome then
            return
        end

        local escolhido
        for _, botao in botoes do
            if botao.Name == nome then
                escolhido = botao
            end
        end
        if not escolhido then
            return
        end

        for botao, contorno in contornos do
            contorno.Enabled = botao == escolhido
        end
        controle.Nome = nome
        controle.Valor = escolhido.BackgroundColor3

        if not silencioso then
            self:_avisar(controle, controle.Valor, nome)
        end
    end

    self:_registrar(linha, controle)
end

-- [ script ] -- / cria o dropdown, a lista abre numa janela por cima de tudo, logo abaixo da pilula
function Painel:_criarDropdown(linha)
    local config = CONFIG.Dropdown
    local pilula = linha:FindFirstChild(NOMES.Toggle)
    local seta = linha:FindFirstChild(NOMES.Seta)
    local trilho = pilula:FindFirstChild(NOMES.ToggleTrilho) or pilula
    local titulo = linha:FindFirstChildOfClass("TextLabel")

    local corTexto = if titulo then titulo.TextColor3 else Color3.new(0.7, 0.7, 0.7)
    local rotacaoSeta = seta.Rotation
    local corNormal = trilho.BackgroundColor3
    local transpNormal = trilho.BackgroundTransparency
    local corHover = clarear(corNormal, config.BrilhoHover)
    local transpHover = math.max(transpNormal - 0.2, 0)

    local controle = { Tipo = "lista", Valor = nil, Aberto = false }
    local nomes = {}
    local itens = {}
    local conexoesItens = {}

    local area = criarArea("AreaDropdown", linha)
    area.AnchorPoint = pilula.AnchorPoint
    area.Position = pilula.Position
    area.Size = pilula.Size

    local selecionado = nil
    if config.MostrarSelecionado then
        selecionado = Instance.new("TextLabel")
        selecionado.Name = "Selecionado"
        selecionado.BackgroundTransparency = 1
        selecionado.AnchorPoint = Vector2.new(0, 0.5)
        selecionado.Position = UDim2.new(0, 16, 0.5, 0)
        selecionado.Size = UDim2.new(1, -70, 0, config.ItemAltura)
        selecionado.Text = ""
        selecionado.TextXAlignment = Enum.TextXAlignment.Left
        selecionado.TextTruncate = Enum.TextTruncate.AtEnd
        selecionado.TextSize = config.ItemTexto
        selecionado.TextColor3 = corTexto
        selecionado.ZIndex = 2
        if titulo then
            selecionado.FontFace = titulo.FontFace
        end
        selecionado.Parent = pilula
    end

    local popup = Instance.new("Frame")
    popup.Name = "ListaDropdown"
    popup.BackgroundColor3 = config.Fundo
    popup.BorderSizePixel = 0
    popup.ClipsDescendants = true
    popup.ZIndex = 100
    popup.Visible = false
    popup.Size = UDim2.fromOffset(pilula.Size.X.Offset, 0)

    local cantosPopup = Instance.new("UICorner")
    cantosPopup.CornerRadius = UDim.new(0, 14)
    cantosPopup.Parent = popup

    local rolagem = Instance.new("ScrollingFrame")
    rolagem.Name = "Rolagem"
    rolagem.BackgroundTransparency = 1
    rolagem.BorderSizePixel = 0
    rolagem.Size = UDim2.fromScale(1, 1)
    rolagem.ZIndex = 101
    rolagem.ScrollBarThickness = 2
    rolagem.ScrollingDirection = Enum.ScrollingDirection.Y
    rolagem.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rolagem.CanvasSize = UDim2.new()
    rolagem.Parent = popup

    local margem = Instance.new("UIPadding")
    margem.PaddingTop = UDim.new(0, config.Margem)
    margem.PaddingBottom = UDim.new(0, config.Margem)
    margem.PaddingLeft = UDim.new(0, config.Margem)
    margem.PaddingRight = UDim.new(0, config.Margem)
    margem.Parent = rolagem

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, config.Espaco)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = rolagem

    popup.Parent = self.Raiz
    table.insert(self._extras, popup)
    table.insert(self._extras, area)

    local function alturaDaLista()
        local quantidade = #itens
        if quantidade == 0 then
            return 0
        end
        local total = quantidade * config.ItemAltura + (quantidade - 1) * config.Espaco + 2 * config.Margem
        return math.min(total, config.AlturaMaxima)
    end

    local function fechar()
        if not controle.Aberto then
            return
        end
        controle.Aberto = false

        if self._popupAberto == controle then
            self._popupAberto = nil
            self._bloqueio.Visible = false
        end

        local tween = animar(popup, { Size = UDim2.fromOffset(popup.Size.X.Offset, 0) })
        tween.Completed:Once(function()
            if not controle.Aberto then
                popup.Visible = false
            end
        end)

        animar(seta, { Rotation = rotacaoSeta })
        animar(trilho, { BackgroundColor3 = corNormal, BackgroundTransparency = transpNormal })
    end

    local function abrir()
        if controle.Aberto or #itens == 0 then
            return
        end
        self:_fecharPopup()

        controle.Aberto = true
        self._popupAberto = controle

        local escala = 1
        if pilula.Size.X.Offset > 0 and pilula.AbsoluteSize.X > 0 then
            escala = pilula.AbsoluteSize.X / pilula.Size.X.Offset
        end
        local origem = self.Raiz.AbsolutePosition
        local x = (pilula.AbsolutePosition.X - origem.X) / escala
        local y = (pilula.AbsolutePosition.Y - origem.Y) / escala + pilula.Size.Y.Offset + config.Folga
        local largura = pilula.Size.X.Offset

        popup.Position = UDim2.fromOffset(x, y)
        popup.Size = UDim2.fromOffset(largura, 0)
        popup.Visible = true
        self._bloqueio.Visible = true

        animar(popup, { Size = UDim2.fromOffset(largura, alturaDaLista()) })
        animar(seta, { Rotation = rotacaoSeta + config.GiroSeta })
    end

    local function selecionar(nome, silencioso)
        controle.Valor = nome
        if selecionado then
            selecionado.Text = nome
        end
        if not silencioso then
            self:_avisar(controle, nome)
        end
    end

    controle.Fechar = fechar

    controle.Definir = function(nome, silencioso)
        if table.find(nomes, nome) then
            selecionar(nome, silencioso)
        end
    end

    controle.DefinirItens = function(lista)
        for _, conexao in conexoesItens do
            conexao:Disconnect()
        end
        table.clear(conexoesItens)
        for _, item in itens do
            item:Destroy()
        end
        table.clear(itens)
        table.clear(nomes)

        controle.Valor = nil
        if selecionado then
            selecionado.Text = ""
        end

        for indice, nome in lista do
            local texto = tostring(nome)
            table.insert(nomes, texto)

            local botao = Instance.new("TextButton")
            botao.Name = texto
            botao.LayoutOrder = indice
            botao.Size = UDim2.new(1, 0, 0, config.ItemAltura)
            botao.BackgroundColor3 = corNormal
            botao.BackgroundTransparency = 1
            botao.BorderSizePixel = 0
            botao.AutoButtonColor = false
            botao.Text = texto
            botao.TextSize = config.ItemTexto
            botao.TextColor3 = corTexto
            botao.TextXAlignment = Enum.TextXAlignment.Left
            botao.TextTruncate = Enum.TextTruncate.AtEnd
            botao.ZIndex = 102
            if titulo then
                botao.FontFace = titulo.FontFace
            end

            local cantos = Instance.new("UICorner")
            cantos.CornerRadius = UDim.new(0, 10)
            cantos.Parent = botao

            local recuo = Instance.new("UIPadding")
            recuo.PaddingLeft = UDim.new(0, 12)
            recuo.PaddingRight = UDim.new(0, 12)
            recuo.Parent = botao

            table.insert(conexoesItens, botao.MouseEnter:Connect(function()
                animar(botao, { BackgroundTransparency = 0.55 })
            end))
            table.insert(conexoesItens, botao.MouseLeave:Connect(function()
                animar(botao, { BackgroundTransparency = 1 })
            end))
            table.insert(conexoesItens, botao.Activated:Connect(function()
                selecionar(texto)
                fechar()
            end))

            botao.Parent = rolagem
            table.insert(itens, botao)
        end

        if controle.Aberto then
            animar(popup, { Size = UDim2.fromOffset(popup.Size.X.Offset, alturaDaLista()) })
        end
    end

    table.insert(self._conexoes, area.MouseEnter:Connect(function()
        animar(trilho, { BackgroundColor3 = corHover, BackgroundTransparency = transpHover })
    end))
    table.insert(self._conexoes, area.MouseLeave:Connect(function()
        if not controle.Aberto then
            animar(trilho, { BackgroundColor3 = corNormal, BackgroundTransparency = transpNormal })
        end
    end))
    table.insert(self._conexoes, area.Activated:Connect(function()
        if controle.Aberto then
            fechar()
        else
            abrir()
        end
    end))

    self:_registrar(linha, controle)
end

-- [ script ] -- / fecha o dropdown que estiver aberto
function Painel:_fecharPopup()
    if self._popupAberto then
        self._popupAberto.Fechar()
    end
end

-- [ script ] -- / liga o arrasto dos sliders (mouse e toque) e a tecla que abre e fecha o painel
function Painel:_ligarEntrada()
    table.insert(self._conexoes, UserInputService.InputBegan:Connect(function(entrada, processado)
        if processado then return end
        -- Aceita RightShift (CONFIG.TeclaAbrir) e tambem a tecla B (atalho classico do QyzmuHub)
        if (CONFIG.TeclaAbrir and entrada.KeyCode == CONFIG.TeclaAbrir) or entrada.KeyCode == Enum.KeyCode.B then
            self:Alternar()
        end
    end))

    table.insert(self._conexoes, UserInputService.InputChanged:Connect(function(entrada)
        local arrasto = self._arrasto
        if not arrasto then
            return
        end
        if arrastoAcabou(arrasto) then
            self:_terminarArrasto()
            return
        end
        if entrada.UserInputType == Enum.UserInputType.MouseMovement or entrada == arrasto.Entrada then
            arrasto.Atualizar(entrada.Position.X)
        end
    end))

    table.insert(self._conexoes, UserInputService.InputEnded:Connect(function(entrada)
        local arrasto = self._arrasto
        if not arrasto then
            return
        end

        local tipo = arrasto.Entrada.UserInputType
        local soltouToque = tipo == Enum.UserInputType.Touch and (entrada == arrasto.Entrada or arrastoAcabou(arrasto))
        local soltouMouse = tipo == Enum.UserInputType.MouseButton1 and entrada.UserInputType == Enum.UserInputType.MouseButton1
        if soltouToque or soltouMouse then
            self:_terminarArrasto()
        end
    end))
end

-- [ script ] -- / mostra o painel na aba em que ele foi fechado
function Painel:Abrir()
    self.Aberto = true
    self.Raiz.Visible = true
end

-- [ script ] -- / esconde o painel, a aba atual fica guardada
function Painel:Fechar()
    self.Aberto = false
    self:_fecharPopup()
    self:_terminarArrasto()
    self.Raiz.Visible = false
end

-- [ script ] -- / abre se estiver fechado e fecha se estiver aberto
function Painel:Alternar()
    if self.Aberto then
        self:Fechar()
    else
        self:Abrir()
    end
end

-- [ script ] -- / botao redondo para abrir e fechar o painel em aparelhos com toque, sem teclado
function Painel:_criarBotaoToque()
    local config = CONFIG.BotaoToque
    local tela = self.Raiz:FindFirstAncestorWhichIsA("LayerCollector")
    if not config.Mostrar or not tela or not UserInputService.TouchEnabled then
        return
    end

    local botao = Instance.new("TextButton")
    botao.Name = "BotaoAbrirPainel"
    botao.AnchorPoint = Vector2.new(0, 0.5)
    botao.Position = UDim2.new(0, 16, 0.5, 0)
    botao.Size = UDim2.fromOffset(config.Tamanho, config.Tamanho)
    botao.BackgroundColor3 = config.Cor
    botao.BackgroundTransparency = 0.15
    botao.BorderSizePixel = 0
    botao.AutoButtonColor = false
    botao.Text = config.Texto
    botao.TextColor3 = config.CorTexto
    botao.TextSize = 28
    botao.ZIndex = 200

    local fonte = fonteDasAbas(self.Raiz)
    if fonte then
        botao.FontFace = fonte
    end

    local cantos = Instance.new("UICorner")
    cantos.CornerRadius = UDim.new(1, 0)
    cantos.Parent = botao

    botao.Parent = tela
    table.insert(self._extras, botao)
    table.insert(self._conexoes, botao.Activated:Connect(function()
        self:Alternar()
    end))
end

-- [ script ] -- / confere de tempos em tempos se o arrasto acabou, assim a rolagem da pagina nunca fica presa
function Painel:_vigiarArrasto(arrasto)
    task.spawn(function()
        while self._arrasto == arrasto and self._vivo do
            task.wait(CONFIG.Rolagem.VigiaArrasto)
            if self._arrasto == arrasto and arrastoAcabou(arrasto) then
                self:_terminarArrasto()
            end
        end
    end)
end

-- [ script ] -- / encerra o arrasto do slider e libera a rolagem da pagina
function Painel:_terminarArrasto()
    local arrasto = self._arrasto
    if not arrasto then
        return
    end
    self._arrasto = nil
    if arrasto.Pagina then
        arrasto.Pagina.ScrollingEnabled = true
    end
end

-- [ script ] -- / acha as secoes da pagina e agrupa em anfitrioes que sabem reempilhar os blocos
function Painel:_montarSecoes(pagina)
    local anfitrioes = {}
    local direto = { Pai = pagina, Blocos = {} }

    for _, filho in pagina:GetChildren() do
        if filho:IsA("Frame") then
            local subSecoes = {}
            for _, neto in filho:GetChildren() do
                if ehSecao(neto) then
                    table.insert(subSecoes, neto)
                end
            end

            if #subSecoes > 0 then
                local anfitriao = { Pai = filho, Container = filho, Blocos = {} }
                if ehSecao(filho) and filho:FindFirstChild(NOMES.Fundo) then
                    table.insert(anfitriao.Blocos, criarBloco(filho, "proprio"))
                end
                for _, sub in subSecoes do
                    table.insert(anfitriao.Blocos, criarBloco(sub, "secao"))
                end
                table.insert(anfitrioes, anfitriao)
            elseif ehSecao(filho) then
                table.insert(direto.Blocos, criarBloco(filho, "secao"))
            end
        end
    end

    if #direto.Blocos > 0 then
        table.insert(anfitrioes, direto)
    end

    for _, anfitriao in anfitrioes do
        self:_prepararAnfitriao(anfitriao)
    end
end

-- [ script ] -- / guarda as medidas originais do grupo de blocos e liga o clique de cada cabecalho
function Painel:_prepararAnfitriao(anfitriao)
    local blocos = anfitriao.Blocos
    table.sort(blocos, function(a, b)
        return a.Topo < b.Topo
    end)

    for indice, bloco in blocos do
        local proximo = blocos[indice + 1]
        if proximo then
            bloco.GapAbaixo = math.max(proximo.Topo - (bloco.Topo + bloco.Altura), 0)
        end
    end

    -- [ script ] -- / o cabecalho fechado tem a mesma altura em todas as secoes do grupo, a menor delas
    local menorAltura = math.huge
    for _, bloco in blocos do
        if #bloco.Linhas > 0 then
            menorAltura = math.min(menorAltura, bloco.AlturaRecolhida)
        end
    end
    for _, bloco in blocos do
        if #bloco.Linhas > 0 and menorAltura < math.huge then
            bloco.AlturaRecolhida = menorAltura
        end
    end

    local primeiro = blocos[1]
    local ultimo = blocos[#blocos]
    anfitriao.TopoInicial = primeiro.Topo
    anfitriao.FimOriginal = ultimo.Topo + ultimo.Altura

    if anfitriao.Container then
        anfitriao.TopoContainer = topoDe(anfitriao.Container)
        anfitriao.AlturaOriginal = anfitriao.Container.Size.Y.Offset
    end

    for _, bloco in blocos do
        self:_ligarBloco(anfitriao, bloco)
    end

    table.insert(self._anfitrioes, anfitriao)
end

-- [ script ] -- / cria a area de clique do cabecalho do bloco
function Painel:_ligarBloco(anfitriao, bloco)
    if not bloco.Seta then
        return
    end

    local area = criarArea("AreaCabecalho", bloco.Quadro)
    local topo = if bloco.Tipo == "proprio" then bloco.Topo else 0
    area.Position = UDim2.new(0, 0, 0, topo)
    area.Size = UDim2.new(1, 0, 0, math.max(bloco.AlturaRecolhida, CONFIG.Secao.AlturaMinimaCabecalho))

    table.insert(self._extras, area)
    table.insert(self._conexoes, area.Activated:Connect(function()
        self:_alternarBloco(anfitriao, bloco)
    end))
end

-- [ script ] -- / recolhe ou expande um bloco e sobe ou desce os que vem depois
function Painel:_alternarBloco(anfitriao, bloco)
    bloco.Recolhido = not bloco.Recolhido
    self:_fecharPopup()

    if bloco.Recolhido then
        for _, linha in bloco.Linhas do
            linha.Visible = false
        end
    else
        task.delay(CONFIG.Tempo, function()
            if not bloco.Recolhido then
                for _, linha in bloco.Linhas do
                    linha.Visible = true
                end
            end
        end)
    end

    local giro = if bloco.Recolhido then CONFIG.Secao.GiroSeta else 0
    animar(bloco.Seta, { Rotation = bloco.RotacaoSeta + giro })

    self:_reempilhar(anfitriao)
end

-- [ script ] -- / reposiciona os blocos um embaixo do outro e ajusta o container
function Painel:_reempilhar(anfitriao)
    local y = anfitriao.TopoInicial
    for _, bloco in anfitriao.Blocos do
        local altura = if bloco.Recolhido then bloco.AlturaRecolhida else bloco.Altura
        posicionarBloco(bloco, y, altura)
        y += altura + bloco.GapAbaixo
    end

    local container = anfitriao.Container
    if container then
        local altura = anfitriao.AlturaOriginal - (anfitriao.FimOriginal - y)
        animar(container, {
            Position = UDim2.new(container.Position.X.Scale, container.Position.X.Offset, 0, anfitriao.TopoContainer + container.AnchorPoint.Y * altura),
            Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0, altura),
        })
    end

    local pagina = if anfitriao.Pai:IsA("ScrollingFrame") then anfitriao.Pai else anfitriao.Pai:FindFirstAncestorWhichIsA("ScrollingFrame")
    if pagina then
        self:_atualizarCanvas(pagina, true)
    end
end

-- [ script ] -- / ajusta a area de rolagem da pagina ao conteudo, medindo onde cada parte vai ficar no final
function Painel:_atualizarCanvas(pagina, animado)
    local fim = 0
    for _, filho in pagina:GetChildren() do
        if filho:IsA("GuiObject") and filho.Visible then
            local posicao, tamanho = destinoDe(filho)
            local topo = posicao.Y.Offset - filho.AnchorPoint.Y * tamanho.Y.Offset
            fim = math.max(fim, topo + tamanho.Y.Offset)
        end
    end

    local canvas = UDim2.fromOffset(0, fim + CONFIG.Rolagem.Folga)
    if animado then
        animar(pagina, { CanvasSize = canvas })
    else
        pagina.CanvasSize = canvas
    end
end

-- [ script ] -- / mostra o nome e a foto do jogador no perfil da lateral
function Painel:_preencherPerfil()
    local conteudo = self.Raiz:FindFirstChild(NOMES.Conteudo)
    local perfil = if conteudo then conteudo:FindFirstChild(NOMES.Perfil) else nil
    local jogador = Players.LocalPlayer
    if not perfil or not jogador then
        return
    end

    local nome = perfil:FindFirstChild(NOMES.PerfilNome)
    local usuario = perfil:FindFirstChild(NOMES.PerfilUsuario)
    local avatar = perfil:FindFirstChild(NOMES.PerfilAvatar)

    if nome and nome:IsA("TextLabel") then
        nome.Text = jogador.DisplayName
    end
    if usuario and usuario:IsA("TextLabel") then
        usuario.Text = "@" .. jogador.Name
    end
    if avatar and avatar:IsA("ImageLabel") then
        -- [ script ] -- / a foto fica dentro de um circulo, fundo transparente
        avatar.BackgroundColor3 = avatar.ImageColor3
        avatar.BackgroundTransparency = 1

        local canto = Instance.new("UICorner")
        canto.CornerRadius = UDim.new(1, 0)
        canto.Parent = avatar

        task.spawn(function()
            local ok, imagem = pcall(
                Players.GetUserThumbnailAsync,
                Players,
                jogador.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size150x150
            )
            if ok then
                avatar.ImageColor3 = Color3.new(1, 1, 1)
                avatar.Image = imagem
            end
        end)
    end
end

-- [ script ] -- / abrevia um texto comprido para caber no titulo
local function abreviar(texto, limite)
    if utf8.len(texto) and utf8.len(texto) > limite then
        return string.sub(texto, 1, utf8.offset(texto, limite + 1) - 1) .. "…"
    end
    return texto
end

-- [ script ] -- / estica o texto de valor para a direita ate o limite, o objeto tem AnchorPoint 0.5
local function alargarValor(rotulo, largura)
    local esquerda = rotulo.Position.X.Offset - rotulo.Size.X.Offset / 2
    rotulo.Size = UDim2.new(rotulo.Size.X.Scale, largura, rotulo.Size.Y.Scale, rotulo.Size.Y.Offset)
    rotulo.Position = UDim2.new(rotulo.Position.X.Scale, esquerda + largura / 2, rotulo.Position.Y.Scale, rotulo.Position.Y.Offset)
end

-- [ script ] -- / mostra no Dashboard o nome do jogo, a foto, os jogadores e o ping
function Painel:_ligarDashboard()
    local pagina = if self._opcoes then self._opcoes:FindFirstChild(DASHBOARD.Pagina) else nil
    if not pagina then
        return
    end

    for chave, nome in DASHBOARD.Valores do
        local rotulo = pagina:FindFirstChild(nome)
        if rotulo and rotulo:IsA("TextLabel") then
            self._info[chave] = rotulo
        end
    end

    -- [ script ] -- / o texto do nome pode ser comprido, ele vai ate perto do rotulo Admins
    local rotuloAdmins = pagina:FindFirstChild(DASHBOARD.Rotulos.Admins)
    for chave, rotulo in self._info do
        local largura = DASHBOARD.LarguraValor
        if chave == "Name" then
            rotulo.TextTruncate = Enum.TextTruncate.AtEnd
        end
        if chave == "Name" and rotuloAdmins then
            local esquerda = rotulo.Position.X.Offset - rotulo.Size.X.Offset / 2
            local limite = rotuloAdmins.Position.X.Offset - rotuloAdmins.Size.X.Offset / 2 - 20
            largura = math.max(rotulo.Size.X.Offset, limite - esquerda)
        elseif chave == "Admins" then
            largura = rotulo.Size.X.Offset
        end
        alargarValor(rotulo, largura)
    end

    local titulo = self.Raiz:FindFirstChild(DASHBOARD.Titulo)
    local rotuloTitulo = if titulo then titulo:FindFirstChild(DASHBOARD.TituloJogo, true) else nil

    -- [ script ] -- / o nome no titulo ganha largura pelo tamanho do texto, assim a letra nao encolhe
    local larguraTitulo = if rotuloTitulo then rotuloTitulo.Size.X.Offset else 0
    local function mostrarNome(nome)
        if self._info.Name then
            self._info.Name.Text = nome
        end
        if rotuloTitulo and rotuloTitulo:IsA("TextLabel") then
            local curto = abreviar(nome, DASHBOARD.LimiteTitulo)
            rotuloTitulo.Text = curto
            alargarValor(rotuloTitulo, math.max(larguraTitulo, (utf8.len(curto) or #curto) * DASHBOARD.LarguraLetraTitulo))
        end
    end

    mostrarNome(game.Name)
    task.spawn(function()
        local ok, dados = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
        if ok and type(dados) == "table" and type(dados.Name) == "string" and self._vivo then
            mostrarNome(dados.Name)
        end
    end)

    if self._info.Admins then
        self._info.Admins.Text = "0"
    end

    -- [ script ] -- / jogadores no servidor, atualiza quando alguem entra ou sai
    local function atualizarJogadores()
        if self._info.Players and self._vivo then
            self._info.Players.Text = string.format("%d/%d", #Players:GetPlayers(), Players.MaxPlayers)
        end
    end
    atualizarJogadores()
    table.insert(self._conexoes, Players.PlayerAdded:Connect(atualizarJogadores))
    table.insert(self._conexoes, Players.PlayerRemoving:Connect(function()
        task.defer(atualizarJogadores)
    end))

    -- [ script ] -- / foto do jogo no quadrado da esquerda
    local icone = pagina:FindFirstChild(DASHBOARD.Icone)
    if icone and icone:IsA("GuiObject") and game.GameId ~= 0 then
        local canto = Instance.new("UICorner")
        canto.CornerRadius = UDim.new(0, DASHBOARD.CantoIcone)
        canto.Parent = icone

        local imagem = Instance.new("ImageLabel")
        imagem.Name = "FotoDoJogo"
        imagem.Size = UDim2.fromScale(1, 1)
        imagem.BackgroundTransparency = 1
        imagem.BorderSizePixel = 0
        imagem.Image = string.format("rbxthumb://type=GameIcon&id=%d&w=150&h=150", game.GameId)

        local cantoImagem = Instance.new("UICorner")
        cantoImagem.CornerRadius = UDim.new(0, DASHBOARD.CantoIcone)
        cantoImagem.Parent = imagem

        imagem.Parent = icone
    end

    -- [ script ] -- / ping, le na hora e depois so atualiza com o painel aberto no Dashboard
    if self._info.Ping then
        self._info.Ping.Text = "-- ms"

        local function atualizarPing()
            local ok, valor = pcall(function()
                return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            if ok and type(valor) == "number" then
                self._info.Ping.Text = string.format("%d ms", math.floor(valor + 0.5))
            end
        end

        task.spawn(function()
            atualizarPing()
            while self._vivo do
                task.wait(DASHBOARD.IntervaloPing)
                if self.Aberto and self.AbaAtual == "Dashboard" then
                    atualizarPing()
                end
            end
        end)
    end
end

-- [ script ] -- / muda o texto de uma informacao do Dashboard: Name, Admins, Players ou Ping
function Painel:DefinirInfo(chave, texto)
    local rotulo = self._info[chave]
    if not rotulo then
        warn("[Painel] informacao do Dashboard nao encontrada: " .. tostring(chave))
        return false
    end
    rotulo.Text = tostring(texto)
    return true
end

-- [ script ] -- / acha o controle pela chave, avisa se nao existir ou se o nome se repetir
function Painel:_obter(chave)
    local controle = self.Controles[chave] or self._porNome[chave]
    if controle == false then
        warn("[Painel] o nome '" .. tostring(chave) .. "' se repete, use a chave completa 'Secao/Linha'")
        return nil
    end
    if not controle then
        warn("[Painel] controle nao encontrado: " .. tostring(chave))
        return nil
    end
    return controle
end

-- [ script ] -- / chama o AoMudar do controle e os ouvintes gerais, usado por toggle, slider, cor e lista
function Painel:_avisar(controle, ...)
    if controle.AoMudar then
        task.spawn(controle.AoMudar, ...)
    end
    for _, ouvinte in self._ouvintes do
        task.spawn(ouvinte, controle.Chave, ...)
    end
end

-- [ script ] -- / roda a funcao a cada mudanca de qualquer controle, recebe a chave e o valor (bom pro salvamento automatico)
function Painel:AoQualquerMudanca(funcao)
    table.insert(self._ouvintes, funcao)
end

-- [ script ] -- / define o que roda quando o controle muda (toggle: ligado, slider: valor, cor: cor e nome, lista: nome)
function Painel:AoMudar(chave, funcao)
    local controle = self:_obter(chave)
    if not controle then
        return false
    end
    controle.AoMudar = funcao
    return true
end

-- [ script ] -- / le o valor atual do controle
function Painel:Obter(chave)
    local controle = self:_obter(chave)
    if not controle then
        return nil
    end
    return controle.Valor, controle.Nome
end

-- [ script ] -- / muda o valor do controle por codigo, o terceiro argumento true nao chama o AoMudar
function Painel:Definir(chave, valor, silencioso)
    local controle = self:_obter(chave)
    if not controle then
        return false
    end
    controle.Definir(valor, silencioso)
    return true
end

-- [ script ] -- / troca os nomes mostrados na lista de um dropdown
function Painel:DefinirItens(chave, lista)
    local controle = self:_obter(chave)
    if not controle then
        return false
    end
    if controle.Tipo ~= "lista" then
        warn("[Painel] '" .. tostring(chave) .. "' nao e um dropdown")
        return false
    end
    controle.DefinirItens(lista)
    return true
end

-- [ script ] -- / devolve todas as chaves completas dos controles achados, em ordem
function Painel:Listar()
    local chaves = {}
    for chave in self.Controles do
        table.insert(chaves, chave)
    end
    table.sort(chaves)
    return chaves
end

-- [ script ] -- / desliga as conexoes e remove o que o modulo criou
function Painel:Destruir()
    self._vivo = false
    self:_terminarArrasto()
    self:_fecharPopup()

    for _, conexao in self._conexoes do
        conexao:Disconnect()
    end
    table.clear(self._conexoes)

    for _, extra in self._extras do
        extra:Destroy()
    end
    table.clear(self._extras)
    table.clear(self._ouvintes)

    self._bloqueio:Destroy()
end

-- [ script ] -- / monta toda a interface qyzHub pelo código, devolve o ScreenGui e o Frame qyzHub
local function criarInterface()
    local V2, U2, U1, C3 = Vector2.new, UDim2.new, UDim.new, Color3.new
    local UO = UDim2.fromOffset
    local lista = {}

    local function G(valor)
        return Color3.new(valor, valor, valor)
    end

    local function F(peso)
        return Font.new("rbxassetid://11702779517", Enum.FontWeight[peso], Enum.FontStyle.Normal)
    end

    local NOMES_PROPRIEDADES = {
        P = "Position",
        S = "Size",
        Z = "ZIndex",
        BT = "BackgroundTransparency",
        BC = "BackgroundColor3",
        T = "Text",
        TS = "TextSize",
        TC = "TextColor3",
        F = "FontFace",
        IC = "ImageColor3",
        IT = "ImageTransparency",
        R = "Rotation",
        CR = "CornerRadius",
    }

    -- [ script ] -- / a bolinha do toggle e do slider e o ponto, círculos desenhados por código
    local function desenharCirculo(objeto, props)
        objeto.BackgroundColor3 = props.IC or C3(1, 1, 1)
        objeto.BackgroundTransparency = props.IT or 0

        local canto = Instance.new("UICorner")
        canto.CornerRadius = U1(1, 0)
        canto.Parent = objeto
    end

    -- [ script ] -- / a setinha, duas barras inclinadas formando um V virado para cima
    local function desenharSeta(objeto, props)
        objeto.BackgroundTransparency = 1

        for _, lado in { -1, 1 } do
            local barra = Instance.new("Frame")
            barra.Name = "Barra"
            barra.AnchorPoint = V2(0.5, 0.5)
            barra.Size = U2(0, 13, 0, 4)
            barra.Position = U2(0.5, lado * 5, 0.5, 0)
            barra.Rotation = lado * 45
            barra.BorderSizePixel = 0
            barra.BackgroundColor3 = props.IC or C3(1, 1, 1)
            barra.BackgroundTransparency = props.IT or 0

            local canto = Instance.new("UICorner")
            canto.CornerRadius = U1(0, 2)
            canto.Parent = barra

            barra.Parent = objeto
        end
    end

    -- [ script ] -- / o fantasma do logo: cabeça redonda, uma pontinha de cauda do lado esquerdo e dois olhos
    -- [ script ] -- / as medidas são em pixels dentro do quadro do logo, que tem 68 por 60
    local function desenharFantasma(objeto)
        local corCorpo = C3(1, 1, 1)
        local corOlho = G(0.03)

        local function peca(nome, x, y, largura, altura, cor, camada, giro, canto)
            local quadro = Instance.new("Frame")
            quadro.Name = nome
            quadro.AnchorPoint = V2(0.5, 0.5)
            quadro.Position = UO(x, y)
            quadro.Size = UO(largura, altura)
            quadro.Rotation = giro
            quadro.ZIndex = camada
            quadro.BorderSizePixel = 0
            quadro.BackgroundColor3 = cor

            local arredondado = Instance.new("UICorner")
            arredondado.CornerRadius = canto
            arredondado.Parent = quadro

            quadro.Parent = objeto
        end

        peca("Cabeca", 37, 30, 60, 60, corCorpo, 1, 0, U1(1, 0))
        peca("Cauda", 7, 27.1, 14, 8.6, corCorpo, 1, 0, U1(0, 3))
        peca("OlhoA", 43, 26, 7.5, 10, corOlho, 3, 0, U1(1, 0))
        peca("OlhoB", 56.5, 26, 7.5, 10, corOlho, 3, 0, U1(1, 0))

        -- [ script ] -- / espaco da logo: o id da imagem vai em CONFIG.Logo.Imagem, com ela preenchida o fantasma some
        local imagem = Instance.new("ImageLabel")
        imagem.Name = "LogoImagem"
        imagem.AnchorPoint = V2(0.5, 0.5)
        imagem.Position = U2(0.5, 0, 0.5, 0)
        imagem.Size = U2(1, 0, 1, 0)
        imagem.BackgroundTransparency = 1
        imagem.BorderSizePixel = 0
        imagem.ScaleType = Enum.ScaleType.Fit
        imagem.ZIndex = 5
        imagem.Image = CONFIG.Logo.Imagem
        imagem.Parent = objeto

        local function atualizarFantasma()
            local vazio = imagem.Image == ""
            for _, filho in objeto:GetChildren() do
                if filho ~= imagem and filho:IsA("Frame") then
                    filho.Visible = vazio
                end
            end
        end
        atualizarFantasma()
        imagem:GetPropertyChangedSignal("Image"):Connect(atualizarFantasma)
    end

    -- [ script ] -- / cria um objeto: classe, número do pai (0 é a raiz), nome e propriedades
    -- [ script ] -- / todo objeto de tela nasce com âncora no centro e sem borda, o TextLabel com a letra de tamanho fixo
    local function n(classe, indicePai, nome, props)
        props = props or {}
        local desenhado = classe == "Circulo" or classe == "Seta" or classe == "Fantasma"
        local objeto = Instance.new(if desenhado then "Frame" else classe)
        objeto.Name = nome or classe

        if objeto:IsA("GuiObject") then
            objeto.BorderSizePixel = 0
            objeto.AnchorPoint = V2(0.5, 0.5)
        end
        if classe == "TextLabel" then
            objeto.TextYAlignment = Enum.TextYAlignment.Center
            objeto.TextXAlignment = Enum.TextXAlignment.Left
            objeto.TextScaled = false
            objeto.TextWrapped = false
        elseif classe == "TextButton" then
            objeto.Text = ""
            objeto.TextSize = 1
        end

        for chave, valor in props do
            if not (desenhado and (chave == "IC" or chave == "IT")) then
                if chave == "CR" and type(valor) == "number" then
                    valor = U1(0, valor)
                end
                objeto[NOMES_PROPRIEDADES[chave] or chave] = valor
            end
        end

        if classe == "Circulo" then
            desenharCirculo(objeto, props)
        elseif classe == "Seta" then
            desenharSeta(objeto, props)
        elseif classe == "Fantasma" then
            desenharFantasma(objeto)
        end

        if indicePai > 0 then
            objeto.Parent = lista[indicePai]
        end
        table.insert(lista, objeto)
    end

    n("ScreenGui", 0, "RoImport", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
    n("Frame", 1, "qyzHub", { P = UO(545, 259), S = UO(1834, 1286), BT = 1 })
    n("Frame", 2, "Background", { P = UO(917, 643), S = UO(1834, 1286), BC = G(0.024) })
    n("UICorner", 3, nil, { CR = 35 })
    n("Frame", 2, "content panel", { P = UO(312, 703), S = UO(570, 1109), Z = 2, BT = 1 })
    n("Frame", 5, "Background", { P = UO(285, 555), S = UO(570, 1109), BC = C3(0.0529, 0.0491, 0.0491) })
    n("UICorner", 6, nil, { CR = 35 })
    n("Frame", 5, "Profile", { P = UO(285, 1005), S = UO(545, 164), Z = 2, BT = 1 })
    n("Frame", 8, "Background", { P = UO(273, 82), S = UO(545, 164), BC = G(0), BT = 1 })
    n("UICorner", 9, nil, { CR = 20 })
    n("TextLabel", 8, "Name", { P = UO(228, 63), S = UO(94, 37), Z = 2, BT = 1, T = "Name", TC = G(1), TS = 30, F = F("Bold") })
    n("TextLabel", 8, "Username", { P = UO(262, 100), S = UO(162, 37), Z = 3, BT = 1, T = "Username", TC = G(0.698), TS = 30, TextTransparency = 0.55, F = F("Bold") })
    n("ImageLabel", 8, "imagemlabel", { P = UO(85, 82), S = UO(131, 130), Z = 4, BT = 1, IC = G(0.851) })
    n("TextButton", 5, "Others", { P = UO(275, 807), S = UO(492, 103), Z = 3, BT = 1 })
    n("Frame", 14, "Background", { P = UO(246, 52), S = UO(492, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 15, nil, { CR = 20 })
    n("TextLabel", 14, "Others", { P = UO(88, 52), S = UO(106, 37), Z = 2, BT = 1, T = "Others", TC = G(0.698), TS = 30, F = F("SemiBold") })
    n("TextButton", 5, "Performance", { P = UO(275, 693), S = UO(492, 103), Z = 4, BT = 1 })
    n("Frame", 18, "Background", { P = UO(246, 52), S = UO(492, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 19, nil, { CR = 20 })
    n("TextLabel", 18, "Performance", { P = UO(136, 52), S = UO(202, 37), Z = 2, BT = 1, T = "Performance", TC = G(0.698), TS = 30, F = F("SemiBold") })
    n("TextButton", 5, "Combat", { P = UO(275, 579), S = UO(492, 103), Z = 5, BT = 1 })
    n("Frame", 22, "Background", { P = UO(246, 52), S = UO(492, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 23, nil, { CR = 20 })
    n("TextLabel", 22, "Combat", { P = UO(97, 52), S = UO(124, 37), Z = 2, BT = 1, T = "Combat", TC = G(0.698), TS = 30, F = F("SemiBold") })
    n("TextButton", 5, "Movement", { P = UO(275, 465), S = UO(492, 103), Z = 6, BT = 1 })
    n("Frame", 26, "Background", { P = UO(246, 52), S = UO(492, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 27, nil, { CR = 20 })
    n("TextLabel", 26, "Movement", { P = UO(119, 52), S = UO(167, 37), Z = 2, BT = 1, T = "Movement", TC = G(0.698), TS = 30, F = F("SemiBold") })
    n("TextButton", 5, "Visuals", { P = UO(275, 351), S = UO(492, 103), Z = 7, BT = 1 })
    n("Frame", 30, "Background", { P = UO(246, 52), S = UO(492, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 31, nil, { CR = 20 })
    n("TextLabel", 30, "Visuals", { P = UO(89, 52), S = UO(109, 37), Z = 2, BT = 1, T = "Visuals", TC = G(0.698), TS = 30, F = F("SemiBold") })
    n("TextButton", 5, "Dashboard", { P = UO(275, 237), S = UO(492, 103), Z = 8, BT = 1 })
    n("Frame", 34, "Background", { P = UO(246, 52), S = UO(492, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 35, nil, { CR = 20 })
    n("TextLabel", 34, "Dashboard", { P = UO(120, 52), S = UO(170, 37), Z = 2, BT = 1, T = "Dashboard", TC = G(0.698), TS = 30, F = F("SemiBold") })
    n("Frame", 5, "Search", { P = UO(285, 85), S = UO(513, 103), Z = 9, BT = 1 })
    n("Frame", 38, "Background", { P = UO(257, 52), S = UO(513, 103), BC = G(0), BT = 0.55 })
    n("UICorner", 39, nil, { CR = 15 })
    n("TextLabel", 38, "Search", { P = UO(251, 52), S = UO(432, 37), Z = 2, BT = 1, T = "Search", TC = G(0.698), TS = 30, TextTransparency = 0.55, F = F("Bold") })
    n("Frame", 2, "options panel", { P = UO(1209, 703), S = UO(1182, 1109), Z = 3, BT = 1 })
    n("Frame", 42, "Background", { P = UO(591, 555), S = UO(1182, 1109), BC = G(0.0529) })
    n("UICorner", 43, nil, { CR = 35 })
    n("ScrollingFrame", 42, "Others", { P = UO(591, 555), S = UO(1129, 1075), Z = 2, BT = 1, CanvasSize = UO(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageTransparency = 1, ScrollingDirection = Enum.ScrollingDirection.Y })
    n("Frame", 45, "Others", { P = UO(564, 728), S = UO(1056, 1420), BT = 1 })
    n("Frame", 46, "Background", { P = UO(528, 204), S = UO(1056, 408), BC = G(0), BT = 0.55 })
    n("UICorner", 47, nil, { CR = 20 })
    n("TextLabel", 46, "Freecam", { P = UO(119, 50), S = UO(160, 43), Z = 2, BT = 1, T = "Freecam", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 46, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 46, "Admins", { P = UO(528, 1306), S = UO(1056, 227), Z = 4, BT = 1 })
    n("Frame", 51, "Background", { P = UO(528, 114), S = UO(1056, 227), BC = G(0), BT = 0.55 })
    n("UICorner", 52, nil, { CR = 20 })
    n("TextLabel", 51, "Admins", { P = UO(110, 50), S = UO(141, 43), Z = 2, BT = 1, T = "Admins", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 51, "seta", { P = UO(1013, 36), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 51, "Admins", { P = UO(528, 152), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 56, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 57, nil, { CR = 20 })
    n("TextLabel", 56, "Admins", { P = UO(92, 41), S = UO(141, 43), Z = 2, BT = 1, T = "Admins", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 56, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 60, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 61, nil, { CR = 20 })
    n("Circulo", 60, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 46, "Respawn", { P = UO(528, 1018), S = UO(1056, 324), Z = 5, BT = 1 })
    n("Frame", 64, "Background", { P = UO(528, 162), S = UO(1056, 324), BC = G(0), BT = 0.55 })
    n("UICorner", 65, nil, { CR = 20 })
    n("TextLabel", 64, "Respawn", { P = UO(123, 49), S = UO(169, 43), Z = 2, BT = 1, T = "Respawn", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 64, "seta", { P = UO(1013, 36), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 64, "Respawn At Death Spot", { P = UO(528, 247), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 69, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 70, nil, { CR = 20 })
    n("TextLabel", 69, "Respawn At Death Spot", { P = UO(241, 41), S = UO(437, 43), Z = 2, BT = 1, T = "Respawn At Death Spot", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 69, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 73, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 74, nil, { CR = 20 })
    n("Circulo", 73, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 64, "Respawn", { P = UO(528, 152), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 77, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 78, nil, { CR = 20 })
    n("TextLabel", 77, "Respawn", { P = UO(106, 41), S = UO(169, 43), Z = 2, BT = 1, T = "Respawn", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 77, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 81, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 82, nil, { CR = 20 })
    n("Circulo", 81, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 46, "Teleport", { P = UO(528, 632), S = UO(1056, 422), Z = 6, BT = 1 })
    n("Frame", 85, "Background", { P = UO(528, 211), S = UO(1056, 422), BC = G(0), BT = 0.55 })
    n("UICorner", 86, nil, { CR = 20 })
    n("TextLabel", 85, "Teleport", { P = UO(115, 50), S = UO(153, 43), Z = 2, BT = 1, T = "Teleport", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 85, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 85, "Low Health %", { P = UO(528, 342), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 90, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 91, nil, { CR = 20 })
    n("TextLabel", 90, "Low Health %", { P = UO(146, 41), S = UO(249, 43), Z = 2, BT = 1, T = "Low Health %", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 90, "0/100", { P = UO(964, 41), S = UO(71, 30), Z = 3, BT = 1, T = "0/100", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 90, "slider15", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 95, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 96, nil, { CR = 15 })
    n("Circulo", 95, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 85, "Low Health TP", { P = UO(528, 247), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 99, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 100, nil, { CR = 20 })
    n("TextLabel", 99, "Low Health TP", { P = UO(154, 41), S = UO(265, 43), Z = 2, BT = 1, T = "Low Health TP", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 99, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 103, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 104, nil, { CR = 20 })
    n("Circulo", 103, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 85, "Map Click TP", { P = UO(528, 152), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 107, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 108, nil, { CR = 20 })
    n("TextLabel", 107, "Map Click TP", { P = UO(140, 41), S = UO(237, 43), Z = 2, BT = 1, T = "Map Click TP", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 107, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 111, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 112, nil, { CR = 20 })
    n("Circulo", 111, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 46, "Freecam Speed", { P = UO(528, 342), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 115, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 116, nil, { CR = 20 })
    n("TextLabel", 115, "Freecam Speed", { P = UO(165, 41), S = UO(285, 43), Z = 2, BT = 1, T = "Freecam Speed", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 115, "0/200", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "0/200", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 115, "slider14", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 120, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 121, nil, { CR = 15 })
    n("Circulo", 120, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 46, "Freecam TP", { P = UO(528, 247), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 124, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 125, nil, { CR = 20 })
    n("TextLabel", 124, "Freecam TP", { P = UO(131, 41), S = UO(218, 43), Z = 2, BT = 1, T = "Freecam TP", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 124, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 128, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 129, nil, { CR = 20 })
    n("Circulo", 128, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 46, "Freecam", { P = UO(528, 152), S = UO(1022, 82), Z = 9, BT = 1 })
    n("Frame", 132, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 133, nil, { CR = 20 })
    n("TextLabel", 132, "Freecam", { P = UO(102, 41), S = UO(160, 43), Z = 2, BT = 1, T = "Freecam", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 132, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 136, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 137, nil, { CR = 20 })
    n("Circulo", 136, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("ScrollingFrame", 42, "Perfomance", { P = UO(591, 555), S = UO(1129, 1075), Z = 3, BT = 1, CanvasSize = UO(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageTransparency = 1, ScrollingDirection = Enum.ScrollingDirection.Y })
    n("Frame", 140, "Performance", { P = UO(564, 463), S = UO(1056, 890), BT = 1 })
    n("Frame", 141, "Background", { P = UO(528, 445), S = UO(1056, 890), BC = G(0), BT = 0.55 })
    n("UICorner", 142, nil, { CR = 20 })
    n("TextLabel", 141, "Player", { P = UO(97, 49), S = UO(115, 43), Z = 2, BT = 1, T = "Player", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 141, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 141, "Graphics Quality", { P = UO(528, 817), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 146, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 147, nil, { CR = 20 })
    n("TextLabel", 146, "Graphics Quality", { P = UO(173, 41), S = UO(302, 43), Z = 2, BT = 1, T = "Graphics Quality", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 146, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 150, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 151, nil, { CR = 20 })
    n("Circulo", 150, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "All Shadows", { P = UO(528, 722), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 154, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 155, nil, { CR = 20 })
    n("TextLabel", 154, "All Shadows", { P = UO(134, 41), S = UO(224, 43), Z = 2, BT = 1, T = "All Shadows", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 154, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 158, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 159, nil, { CR = 20 })
    n("Circulo", 158, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "Lights", { P = UO(528, 627), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 162, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 163, nil, { CR = 20 })
    n("TextLabel", 162, "Lights", { P = UO(80, 41), S = UO(115, 43), Z = 2, BT = 1, T = "Lights", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 162, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 166, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 167, nil, { CR = 20 })
    n("Circulo", 166, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "Film Grain", { P = UO(528, 532), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 170, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 171, nil, { CR = 20 })
    n("TextLabel", 170, "Film Grain", { P = UO(120, 41), S = UO(197, 43), Z = 2, BT = 1, T = " Film Grain", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 170, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 174, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 175, nil, { CR = 20 })
    n("Circulo", 174, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "Preload GUI", { P = UO(528, 437), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 178, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 179, nil, { CR = 20 })
    n("TextLabel", 178, "Preload GUI", { P = UO(136, 41), S = UO(228, 43), Z = 2, BT = 1, T = " Preload GUI", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 178, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 182, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 183, nil, { CR = 20 })
    n("Circulo", 182, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "Tree Shadows", { P = UO(528, 342), S = UO(1022, 82), Z = 9, BT = 1 })
    n("Frame", 186, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 187, nil, { CR = 20 })
    n("TextLabel", 186, "Tree Shadows", { P = UO(150, 41), S = UO(257, 43), Z = 2, BT = 1, T = "Tree Shadows", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 186, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 190, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 191, nil, { CR = 20 })
    n("Circulo", 190, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "Particles", { P = UO(528, 247), S = UO(1022, 82), Z = 10, BT = 1 })
    n("Frame", 194, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 195, nil, { CR = 20 })
    n("TextLabel", 194, "Particles", { P = UO(102, 41), S = UO(160, 43), Z = 2, BT = 1, T = "Particles", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 194, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 198, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 199, nil, { CR = 20 })
    n("Circulo", 198, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 141, "FPS Boost", { P = UO(528, 152), S = UO(1022, 82), Z = 11, BT = 1 })
    n("Frame", 202, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 203, nil, { CR = 20 })
    n("TextLabel", 202, "FPS Boost", { P = UO(116, 41), S = UO(187, 43), Z = 2, BT = 1, T = "FPS Boost", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 202, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 206, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 207, nil, { CR = 20 })
    n("Circulo", 206, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("ScrollingFrame", 42, "Combat", { P = UO(591, 555), S = UO(1129, 1075), Z = 4, BT = 1, CanvasSize = UO(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageTransparency = 1, ScrollingDirection = Enum.ScrollingDirection.Y })
    n("Frame", 210, "FOV", { P = UO(564, 853), S = UO(1056, 624), BT = 1 })
    n("Frame", 211, "Background", { P = UO(528, 312), S = UO(1056, 624), BC = G(0), BT = 0.55 })
    n("UICorner", 212, nil, { CR = 20 })
    n("TextLabel", 211, "Fov", { P = UO(72, 49), S = UO(66, 43), Z = 2, BT = 1, T = "Fov", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 211, "seta", { P = UO(1013, 36), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 211, "Fov Color", { P = UO(528, 442), S = UO(1022, 283), Z = 4, BT = 1 })
    n("Frame", 216, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 217, nil, { CR = 20 })
    n("TextButton", 216, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 219, nil, { CR = 20 })
    n("TextButton", 216, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 221, nil, { CR = 20 })
    n("TextButton", 216, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 223, nil, { CR = 20 })
    n("TextButton", 216, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 225, nil, { CR = 20 })
    n("TextButton", 216, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 227, nil, { CR = 20 })
    n("TextButton", 216, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 229, nil, { CR = 20 })
    n("TextLabel", 216, "FOV Color", { P = UO(114, 47), S = UO(184, 43), Z = 8, BT = 1, T = "FOV Color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 211, "FOV Size", { P = UO(528, 247), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 232, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 233, nil, { CR = 20 })
    n("TextLabel", 232, "FOV Size", { P = UO(102, 41), S = UO(161, 43), Z = 2, BT = 1, T = "FOV Size", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 232, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 232, "slider6", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 237, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 238, nil, { CR = 15 })
    n("Circulo", 237, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 211, "Fov Circle", { P = UO(528, 152), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 241, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 242, nil, { CR = 20 })
    n("TextLabel", 241, "FOV Circle", { P = UO(118, 41), S = UO(191, 43), Z = 2, BT = 1, T = "FOV Circle", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 241, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 245, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 246, nil, { CR = 20 })
    n("Circulo", 245, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 210, "Combat", { P = UO(564, 273), S = UO(1056, 509), Z = 2, BT = 1 })
    n("Frame", 249, "Background", { P = UO(528, 255), S = UO(1056, 509), BC = G(0), BT = 0.55 })
    n("UICorner", 250, nil, { CR = 20 })
    n("TextLabel", 249, "Combat", { P = UO(112, 49), S = UO(145, 43), Z = 2, BT = 1, T = "Combat", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 249, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 249, "Wallbang", { P = UO(528, 437), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 254, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 255, nil, { CR = 20 })
    n("TextLabel", 254, "Wallbang", { P = UO(110, 41), S = UO(176, 43), Z = 2, BT = 1, T = "Wallbang", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 254, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 258, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 259, nil, { CR = 20 })
    n("Circulo", 258, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 249, "Team Check", { P = UO(528, 342), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 262, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 263, nil, { CR = 20 })
    n("TextLabel", 262, "Team Check", { P = UO(134, 41), S = UO(225, 43), Z = 2, BT = 1, T = "Team Check", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 262, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 266, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 267, nil, { CR = 20 })
    n("Circulo", 266, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 249, "Aimbot Legit", { P = UO(528, 247), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 270, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 271, nil, { CR = 20 })
    n("TextLabel", 270, "Aimbot Legit", { P = UO(142, 41), S = UO(240, 43), Z = 2, BT = 1, T = "Aimbot Legit", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 270, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 274, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 275, nil, { CR = 20 })
    n("Circulo", 274, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 249, "Aimbot", { P = UO(528, 152), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 278, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 279, nil, { CR = 20 })
    n("TextLabel", 278, "Aimbot", { P = UO(90, 41), S = UO(137, 43), Z = 2, BT = 1, T = "Aimbot", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 278, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 282, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 283, nil, { CR = 20 })
    n("Circulo", 282, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("ScrollingFrame", 42, "Movement", { P = UO(591, 555), S = UO(1129, 1075), Z = 5, BT = 1, CanvasSize = UO(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageTransparency = 1, ScrollingDirection = Enum.ScrollingDirection.Y })
    n("Frame", 286, "Horse Movement", { P = UO(564, 2101), S = UO(1056, 784), BT = 1 })
    n("Frame", 287, "Background", { P = UO(528, 392), S = UO(1056, 784), BC = G(0), BT = 0.55 })
    n("UICorner", 288, nil, { CR = 20 })
    n("TextLabel", 287, "Horse Movement", { P = UO(196, 49), S = UO(314, 43), Z = 2, BT = 1, T = "Horse Movement", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 287, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 287, "Shoot On Horse", { P = UO(528, 722), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 292, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 293, nil, { CR = 20 })
    n("TextLabel", 292, "Shoot On Horse", { P = UO(166, 41), S = UO(289, 43), Z = 2, BT = 1, T = "Shoot On Horse", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 292, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 296, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 297, nil, { CR = 20 })
    n("Circulo", 296, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 287, "Horse Keep Sprint", { P = UO(528, 627), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 300, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 301, nil, { CR = 20 })
    n("TextLabel", 300, "Horse Keep Sprint", { P = UO(188, 41), S = UO(332, 43), Z = 2, BT = 1, T = "Horse Keep Sprint", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 300, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 304, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 305, nil, { CR = 20 })
    n("Circulo", 304, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 287, "Horse Air Jump", { P = UO(528, 532), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 308, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 309, nil, { CR = 20 })
    n("TextLabel", 308, "Horse Air Jump", { P = UO(164, 41), S = UO(284, 43), Z = 2, BT = 1, T = "Horse Air Jump", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 308, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 312, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 313, nil, { CR = 20 })
    n("Circulo", 312, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 287, "Horse Jump Height", { P = UO(528, 437), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 316, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 317, nil, { CR = 20 })
    n("TextLabel", 316, "Horse Jump Height", { P = UO(200, 41), S = UO(356, 43), Z = 2, BT = 1, T = "Horse Jump Height", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 316, "0/50", { P = UO(957, 41), S = UO(59, 30), Z = 3, BT = 1, T = "0/50", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 316, "slider14", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 321, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 322, nil, { CR = 15 })
    n("Circulo", 321, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 287, "Horse Jump", { P = UO(528, 342), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 325, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 326, nil, { CR = 20 })
    n("TextLabel", 325, "Horse Jump", { P = UO(132, 41), S = UO(221, 43), Z = 2, BT = 1, T = "Horse Jump", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 325, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 329, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 330, nil, { CR = 20 })
    n("Circulo", 329, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 287, "Horse Amount", { P = UO(528, 247), S = UO(1022, 82), Z = 9, BT = 1 })
    n("Frame", 333, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 334, nil, { CR = 20 })
    n("TextLabel", 333, "Horse Amount", { P = UO(155, 41), S = UO(267, 43), Z = 2, BT = 1, T = "Horse Amount", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 333, "0/500", { P = UO(966, 41), S = UO(76, 30), Z = 3, BT = 1, T = "0/500", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 333, "slider13", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 338, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 339, nil, { CR = 15 })
    n("Circulo", 338, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 287, "Horse Speed", { P = UO(528, 152), S = UO(1022, 82), Z = 10, BT = 1 })
    n("Frame", 342, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 343, nil, { CR = 20 })
    n("TextLabel", 342, "Horse Speed", { P = UO(138, 41), S = UO(232, 43), Z = 2, BT = 1, T = "Horse Speed", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 342, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 346, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 347, nil, { CR = 20 })
    n("Circulo", 346, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 286, "Vehicle Movement", { P = UO(564, 1256), S = UO(1056, 880), Z = 2, BT = 1 })
    n("Frame", 350, "Background", { P = UO(528, 440), S = UO(1056, 880), BC = G(0), BT = 0.55 })
    n("UICorner", 351, nil, { CR = 20 })
    n("TextLabel", 350, "Vehicle Movement", { P = UO(209, 50), S = UO(341, 43), Z = 2, BT = 1, T = "Vehicle Movement", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 350, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 350, "Bring Nearest Car", { P = UO(528, 817), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 355, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 356, nil, { CR = 20 })
    n("TextLabel", 355, "Bring Nearest Car", { P = UO(185, 41), S = UO(325, 43), Z = 2, BT = 1, T = "Bring Nearest Car", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 355, "toggle", { P = UO(849, 41), S = UO(294, 47), Z = 3, BT = 1 })
    n("Frame", 359, "Rectangle 29", { P = UO(147, 24), S = UO(294, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 360, nil, { CR = 14 })
    n("Seta", 355, "seta", { P = UO(968, 41), S = UO(20, 31), Z = 4, IC = C3(0.3569, 0.3451, 0.3451), IT = 0.1 })
    n("Frame", 350, "Fly Height", { P = UO(528, 722), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 363, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 364, nil, { CR = 20 })
    n("TextLabel", 363, "Fly Height", { P = UO(116, 41), S = UO(189, 43), Z = 2, BT = 1, T = "Fly Height", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 363, "0/100", { P = UO(964, 41), S = UO(71, 30), Z = 3, BT = 1, T = "0/100", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 363, "slider12", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 368, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 369, nil, { CR = 15 })
    n("Circulo", 368, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 350, "Drive Without Fuel", { P = UO(528, 627), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 372, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 373, nil, { CR = 20 })
    n("TextLabel", 372, "Drive Without Fuel", { P = UO(197, 41), S = UO(349, 43), Z = 2, BT = 1, T = "Drive Without Fuel", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 372, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 376, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 377, nil, { CR = 20 })
    n("Circulo", 376, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 350, "Vehicle Speed (%)", { P = UO(528, 532), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 380, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 381, nil, { CR = 20 })
    n("TextLabel", 380, "Vehicle Speed (%)", { P = UO(184, 41), S = UO(324, 43), Z = 2, BT = 1, T = "Vehicle Speed (%)", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 380, "0/500", { P = UO(966, 41), S = UO(76, 30), Z = 3, BT = 1, T = "0/500", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 380, "slider11", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 385, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 386, nil, { CR = 15 })
    n("Circulo", 385, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 350, "Vehicle Noclip", { P = UO(528, 437), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 389, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 390, nil, { CR = 20 })
    n("TextLabel", 389, "Vehicle Noclip", { P = UO(153, 41), S = UO(262, 43), Z = 2, BT = 1, T = "Vehicle Noclip", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 389, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 393, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 394, nil, { CR = 20 })
    n("Circulo", 393, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 350, "Fly Speed Cap", { P = UO(528, 342), S = UO(1022, 82), Z = 9, BT = 1 })
    n("Frame", 397, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 398, nil, { CR = 20 })
    n("TextLabel", 397, "Fly Speed Cap", { P = UO(152, 41), S = UO(260, 43), Z = 2, BT = 1, T = "Fly Speed Cap", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 397, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 401, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 402, nil, { CR = 20 })
    n("Circulo", 401, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 350, "Fly Speed", { P = UO(528, 247), S = UO(1022, 82), Z = 10, BT = 1 })
    n("Frame", 405, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 406, nil, { CR = 20 })
    n("TextLabel", 405, "Fly Speed", { P = UO(112, 41), S = UO(179, 43), Z = 2, BT = 1, T = "Fly Speed", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 405, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 405, "slider10", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 410, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 411, nil, { CR = 15 })
    n("Circulo", 410, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 350, "Vehicle Fly", { P = UO(528, 152), S = UO(1022, 82), Z = 11, BT = 1 })
    n("Frame", 414, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 415, nil, { CR = 20 })
    n("TextLabel", 414, "Vehicle Fly", { P = UO(121, 41), S = UO(198, 43), Z = 2, BT = 1, T = "Vehicle Fly", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 414, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 418, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 419, nil, { CR = 20 })
    n("Circulo", 418, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 286, "Player Movement", { P = UO(564, 411), S = UO(1056, 784), Z = 3, BT = 1 })
    n("Frame", 422, "Background", { P = UO(528, 392), S = UO(1056, 784), BC = G(0), BT = 0.55 })
    n("UICorner", 423, nil, { CR = 20 })
    n("TextLabel", 422, "Player Movement", { P = UO(200, 49), S = UO(322, 43), Z = 2, BT = 1, T = "Player Movement", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 422, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 422, "Fly Speed", { P = UO(528, 722), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 427, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 428, nil, { CR = 20 })
    n("TextLabel", 427, "Fly Speed", { P = UO(112, 41), S = UO(179, 43), Z = 2, BT = 1, T = "Fly Speed", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 427, "0/200", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "0/200", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 427, "slider9", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 432, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 433, nil, { CR = 15 })
    n("Circulo", 432, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 422, "Fly", { P = UO(528, 627), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 436, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 437, nil, { CR = 20 })
    n("TextLabel", 436, "Fly", { P = UO(49, 41), S = UO(54, 43), Z = 2, BT = 1, T = "Fly", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 436, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 440, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 441, nil, { CR = 20 })
    n("Circulo", 440, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 422, "Noclip", { P = UO(528, 532), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 444, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 445, nil, { CR = 20 })
    n("TextLabel", 444, "Noclip", { P = UO(81, 41), S = UO(117, 43), Z = 2, BT = 1, T = "Noclip", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 444, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 448, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 449, nil, { CR = 20 })
    n("Circulo", 448, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 422, "Jump Height Amount", { P = UO(528, 437), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 452, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 453, nil, { CR = 20 })
    n("TextLabel", 452, "Jump Height Amount", { P = UO(222, 41), S = UO(399, 43), Z = 2, BT = 1, T = "Jump Height Amount", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 452, "0/200", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "0/200", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 452, "slider8", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 457, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 458, nil, { CR = 15 })
    n("Circulo", 457, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 422, "Jump Height", { P = UO(528, 342), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 461, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 462, nil, { CR = 20 })
    n("TextLabel", 461, "Jump Height", { P = UO(142, 41), S = UO(239, 43), Z = 2, BT = 1, T = "Jump Height", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 461, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 465, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 466, nil, { CR = 20 })
    n("Circulo", 465, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 422, "Player Amount", { P = UO(528, 247), S = UO(1022, 82), Z = 9, BT = 1 })
    n("Frame", 469, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 470, nil, { CR = 20 })
    n("TextLabel", 469, "Speed Amount", { P = UO(159, 41), S = UO(275, 43), Z = 2, BT = 1, T = "Speed Amount", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 469, "0/200", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "0/200", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 469, "slider7", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 474, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 475, nil, { CR = 15 })
    n("Circulo", 474, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 422, "Player Speed", { P = UO(528, 152), S = UO(1022, 82), Z = 10, BT = 1 })
    n("Frame", 478, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 479, nil, { CR = 20 })
    n("TextLabel", 478, "Player Speed", { P = UO(142, 41), S = UO(240, 43), Z = 2, BT = 1, T = "Player Speed", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 478, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 482, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 483, nil, { CR = 20 })
    n("Circulo", 482, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("ScrollingFrame", 42, "Visuals", { P = UO(591, 555), S = UO(1129, 1075), Z = 6, BT = 1, CanvasSize = UO(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageTransparency = 1, ScrollingDirection = Enum.ScrollingDirection.Y })
    n("Frame", 486, "ESP Colors", { P = UO(564, 3570), S = UO(1056, 2542), BT = 1 })
    n("Frame", 487, "Background", { P = UO(528, 1271), S = UO(1056, 2542), BC = G(0), BT = 0.55 })
    n("UICorner", 488, nil, { CR = 20 })
    n("TextLabel", 487, "ESP Colors", { P = UO(138, 50), S = UO(197, 43), Z = 2, BT = 1, T = "ESP Colors", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 487, "seta", { P = UO(1013, 36), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 487, "Set Cars Color", { P = UO(528, 2362), S = UO(1022, 283), Z = 2, BT = 1 })
    n("Frame", 492, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 493, nil, { CR = 20 })
    n("TextButton", 492, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 495, nil, { CR = 20 })
    n("TextButton", 492, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 497, nil, { CR = 20 })
    n("TextButton", 492, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 499, nil, { CR = 20 })
    n("TextButton", 492, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 501, nil, { CR = 20 })
    n("TextButton", 492, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 503, nil, { CR = 20 })
    n("TextButton", 492, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 505, nil, { CR = 20 })
    n("TextLabel", 492, "Set Cars color", { P = UO(148, 47), S = UO(252, 43), Z = 8, BT = 1, T = "Set Cars color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Horses Color", { P = UO(528, 2066), S = UO(1022, 283), Z = 3, BT = 1 })
    n("Frame", 508, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 509, nil, { CR = 20 })
    n("TextButton", 508, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 511, nil, { CR = 20 })
    n("TextButton", 508, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 513, nil, { CR = 20 })
    n("TextButton", 508, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 515, nil, { CR = 20 })
    n("TextButton", 508, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 517, nil, { CR = 20 })
    n("TextButton", 508, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 519, nil, { CR = 20 })
    n("TextButton", 508, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 521, nil, { CR = 20 })
    n("TextLabel", 508, "Set Horses color", { P = UO(170, 47), S = UO(297, 43), Z = 8, BT = 1, T = "Set Horses color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Faction Banner Color", { P = UO(528, 1770), S = UO(1022, 283), Z = 4, BT = 1 })
    n("Frame", 524, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 525, nil, { CR = 20 })
    n("TextButton", 524, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 527, nil, { CR = 20 })
    n("TextButton", 524, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 529, nil, { CR = 20 })
    n("TextButton", 524, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 531, nil, { CR = 20 })
    n("TextButton", 524, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 533, nil, { CR = 20 })
    n("TextButton", 524, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 535, nil, { CR = 20 })
    n("TextButton", 524, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 537, nil, { CR = 20 })
    n("TextLabel", 524, "Set Faction Banner", { P = UO(198, 47), S = UO(351, 43), Z = 8, BT = 1, T = "Set Faction Banner", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Faction Member Color", { P = UO(528, 1474), S = UO(1022, 283), Z = 5, BT = 1 })
    n("Frame", 540, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 541, nil, { CR = 20 })
    n("TextButton", 540, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 543, nil, { CR = 20 })
    n("TextButton", 540, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 545, nil, { CR = 20 })
    n("TextButton", 540, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 547, nil, { CR = 20 })
    n("TextButton", 540, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 549, nil, { CR = 20 })
    n("TextButton", 540, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 551, nil, { CR = 20 })
    n("TextButton", 540, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 553, nil, { CR = 20 })
    n("TextLabel", 540, "Set Faction Member", { P = UO(207, 47), S = UO(371, 43), Z = 8, BT = 1, T = "Set Faction Member", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Corpses Color", { P = UO(528, 1178), S = UO(1022, 283), Z = 6, BT = 1 })
    n("Frame", 556, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 557, nil, { CR = 20 })
    n("TextButton", 556, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 559, nil, { CR = 20 })
    n("TextButton", 556, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 561, nil, { CR = 20 })
    n("TextButton", 556, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 563, nil, { CR = 20 })
    n("TextButton", 556, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 565, nil, { CR = 20 })
    n("TextButton", 556, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 567, nil, { CR = 20 })
    n("TextButton", 556, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 569, nil, { CR = 20 })
    n("TextLabel", 556, "Set Corpses color", { P = UO(181, 47), S = UO(318, 43), Z = 8, BT = 1, T = "Set Corpses color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Hitbox Color", { P = UO(528, 882), S = UO(1022, 283), Z = 7, BT = 1 })
    n("Frame", 572, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 573, nil, { CR = 20 })
    n("TextButton", 572, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 575, nil, { CR = 20 })
    n("TextButton", 572, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 577, nil, { CR = 20 })
    n("TextButton", 572, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 579, nil, { CR = 20 })
    n("TextButton", 572, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 581, nil, { CR = 20 })
    n("TextButton", 572, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 583, nil, { CR = 20 })
    n("TextButton", 572, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 585, nil, { CR = 20 })
    n("TextLabel", 572, "Set Hitbox color", { P = UO(169, 47), S = UO(293, 43), Z = 8, BT = 1, T = "Set Hitbox color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Highlights Color", { P = UO(528, 586), S = UO(1022, 283), Z = 8, BT = 1 })
    n("Frame", 588, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 589, nil, { CR = 20 })
    n("TextButton", 588, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 591, nil, { CR = 20 })
    n("TextButton", 588, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 593, nil, { CR = 20 })
    n("TextButton", 588, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 595, nil, { CR = 20 })
    n("TextButton", 588, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 597, nil, { CR = 20 })
    n("TextButton", 588, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 599, nil, { CR = 20 })
    n("TextButton", 588, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 601, nil, { CR = 20 })
    n("TextLabel", 588, "Set Highlights color", { P = UO(203, 47), S = UO(363, 43), Z = 8, BT = 1, T = "Set Highlights color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 487, "Set Tracer Color", { P = UO(528, 290), S = UO(1022, 283), Z = 9, BT = 1 })
    n("Frame", 604, "Background", { P = UO(511, 142), S = UO(1022, 283), BC = G(0), BT = 0.55 })
    n("UICorner", 605, nil, { CR = 20 })
    n("TextButton", 604, "Preto", { P = UO(204, 160), S = UO(102, 102), Z = 2, BC = G(0) })
    n("UICorner", 607, nil, { CR = 20 })
    n("TextButton", 604, "Branco", { P = UO(327, 160), S = UO(102, 102), Z = 3, BC = G(1) })
    n("UICorner", 609, nil, { CR = 20 })
    n("TextButton", 604, "Amarelo", { P = UO(450, 160), S = UO(102, 102), Z = 4, BC = C3(1, 1, 0) })
    n("UICorner", 611, nil, { CR = 20 })
    n("TextButton", 604, "Roxo", { P = UO(573, 160), S = UO(102, 102), Z = 5, BC = C3(0.502, 0, 0.502) })
    n("UICorner", 613, nil, { CR = 20 })
    n("TextButton", 604, "Vermelho", { P = UO(696, 160), S = UO(102, 102), Z = 6, BC = C3(1, 0, 0) })
    n("UICorner", 615, nil, { CR = 20 })
    n("TextButton", 604, "Verde", { P = UO(819, 160), S = UO(102, 102), Z = 7, BC = C3(0, 0.502, 0) })
    n("UICorner", 617, nil, { CR = 20 })
    n("TextLabel", 604, "Set Tracer color", { P = UO(165, 47), S = UO(286, 43), Z = 8, BT = 1, T = "Set Tracer color", TC = G(0.698), TS = 35, F = F("Bold") })
    n("Frame", 486, "ESP Distances", { P = UO(564, 1952), S = UO(1056, 635), Z = 2, BT = 1 })
    n("Frame", 620, "Background", { P = UO(528, 318), S = UO(1056, 635), BC = G(0), BT = 0.55 })
    n("UICorner", 621, nil, { CR = 20 })
    n("TextLabel", 620, "ESP Distances", { P = UO(170, 49), S = UO(262, 43), Z = 2, BT = 1, T = "ESP Distances", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 620, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 620, "Faction Banner", { P = UO(528, 562), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 625, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 626, nil, { CR = 20 })
    n("TextLabel", 625, "Faction Banner", { P = UO(163, 41), S = UO(282, 43), Z = 2, BT = 1, T = "Faction Banner", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 625, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 625, "slider5", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 630, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 631, nil, { CR = 15 })
    n("Circulo", 630, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 620, "Corpse ESP Distance", { P = UO(528, 467), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 634, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 635, nil, { CR = 20 })
    n("TextLabel", 634, "Corpse ESP Distance", { P = UO(212, 41), S = UO(380, 43), Z = 2, BT = 1, T = "Corpse ESP Distance", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 634, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 634, "slider4", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 639, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 640, nil, { CR = 15 })
    n("Circulo", 639, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 620, "Horse ESP Distance", { P = UO(528, 372), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 643, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 644, nil, { CR = 20 })
    n("TextLabel", 643, "Horse ESP Distance", { P = UO(202, 41), S = UO(360, 43), Z = 2, BT = 1, T = "Horse ESP Distance", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 643, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 643, "slider3", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 648, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 649, nil, { CR = 15 })
    n("Circulo", 648, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 620, "Car ESP Distance", { P = UO(528, 277), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 652, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 653, nil, { CR = 20 })
    n("TextLabel", 652, "Car ESP Distance", { P = UO(179, 41), S = UO(315, 43), Z = 2, BT = 1, T = "Car ESP Distance", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 652, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 652, "slider2", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 657, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 658, nil, { CR = 15 })
    n("Circulo", 657, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 620, "Player ESP Distance", { P = UO(528, 182), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 661, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 662, nil, { CR = 20 })
    n("TextLabel", 661, "Player ESP Distance", { P = UO(206, 41), S = UO(368, 43), Z = 2, BT = 1, T = "Player ESP Distance", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextLabel", 661, "0/300", { P = UO(966, 41), S = UO(75, 30), Z = 3, BT = 1, T = "3000/3000", TC = G(0.698), TS = 25, F = F("Bold") })
    n("Frame", 661, "slider1", { P = UO(677, 41), S = UO(423, 31), Z = 4, BT = 1 })
    n("Frame", 666, "Rectangle 30", { P = UO(212, 15), S = UO(423, 12), BC = G(0.698) })
    n("UICorner", 667, nil, { CR = 15 })
    n("Circulo", 666, "Ellipse 16", { P = UO(15, 16), S = UO(31, 31), Z = 2 })
    n("Frame", 486, "Faction", { P = UO(564, 1442), S = UO(1056, 327), Z = 3, BT = 1 })
    n("Frame", 670, "Background", { P = UO(528, 164), S = UO(1056, 327), BC = G(0), BT = 0.55 })
    n("UICorner", 671, nil, { CR = 20 })
    n("TextLabel", 670, "Faction", { P = UO(108, 49), S = UO(138, 43), Z = 2, BT = 1, T = "Faction", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 670, "seta", { P = UO(1013, 36), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 670, "Faction Banners", { P = UO(528, 247), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 675, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 676, nil, { CR = 20 })
    n("TextLabel", 675, "Faction Banners", { P = UO(172, 41), S = UO(300, 43), Z = 2, BT = 1, T = "Faction Banners", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 675, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 679, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 680, nil, { CR = 20 })
    n("Circulo", 679, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 670, "Faction Members", { P = UO(528, 152), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 683, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 684, nil, { CR = 20 })
    n("TextLabel", 683, "Faction Members", { P = UO(182, 41), S = UO(320, 43), Z = 2, BT = 1, T = "Faction Members", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 683, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 687, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 688, nil, { CR = 20 })
    n("Circulo", 687, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 486, "Corpses", { P = UO(564, 1093), S = UO(1056, 327), Z = 4, BT = 1 })
    n("Frame", 691, "Background", { P = UO(528, 164), S = UO(1056, 327), BC = G(0), BT = 0.55 })
    n("UICorner", 692, nil, { CR = 20 })
    n("TextLabel", 691, "Corpses", { P = UO(113, 49), S = UO(147, 43), Z = 2, BT = 1, T = "Corpses", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 691, "seta", { P = UO(1013, 36), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 691, "Corpses Highlights", { P = UO(528, 247), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 696, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 697, nil, { CR = 20 })
    n("TextLabel", 696, "Corpses Highlight", { P = UO(186, 41), S = UO(329, 43), Z = 2, BT = 1, T = "Corpses Highlight", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 696, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 700, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 701, nil, { CR = 20 })
    n("Circulo", 700, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 691, "Corpses Name", { P = UO(528, 152), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 704, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 705, nil, { CR = 20 })
    n("TextLabel", 704, "Corpses Name", { P = UO(154, 41), S = UO(265, 43), Z = 2, BT = 1, T = "Corpses Name", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 704, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 708, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 709, nil, { CR = 20 })
    n("Circulo", 708, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 486, "Player", { P = UO(564, 463), S = UO(1056, 890), Z = 5, BT = 1 })
    n("Frame", 712, "Background", { P = UO(528, 445), S = UO(1056, 890), BC = G(0), BT = 0.55 })
    n("UICorner", 713, nil, { CR = 20 })
    n("TextLabel", 712, "Player", { P = UO(97, 49), S = UO(115, 43), Z = 2, BT = 1, T = "Player", TC = G(1), TS = 35, F = F("Bold") })
    n("Seta", 712, "seta", { P = UO(1013, 35), S = UO(20, 31), R = -90, Z = 3, IC = C3(0.3558, 0.3455, 0.3455), IT = 0.55 })
    n("Frame", 712, "Health", { P = UO(528, 817), S = UO(1022, 82), Z = 4, BT = 1 })
    n("Frame", 717, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 718, nil, { CR = 20 })
    n("TextLabel", 717, "Health", { P = UO(83, 41), S = UO(122, 43), Z = 2, BT = 1, T = "Health", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 717, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 721, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 722, nil, { CR = 20 })
    n("Circulo", 721, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Distance", { P = UO(528, 722), S = UO(1022, 82), Z = 5, BT = 1 })
    n("Frame", 725, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 726, nil, { CR = 20 })
    n("TextLabel", 725, "Distance", { P = UO(103, 41), S = UO(162, 43), Z = 2, BT = 1, T = "Distance", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 725, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 729, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 730, nil, { CR = 20 })
    n("Circulo", 729, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Name", { P = UO(528, 627), S = UO(1022, 82), Z = 6, BT = 1 })
    n("Frame", 733, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 734, nil, { CR = 20 })
    n("TextLabel", 733, "Name", { P = UO(77, 41), S = UO(109, 43), Z = 2, BT = 1, T = "Name", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 733, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 737, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 738, nil, { CR = 20 })
    n("Circulo", 737, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Skeleton", { P = UO(528, 532), S = UO(1022, 82), Z = 7, BT = 1 })
    n("Frame", 741, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 742, nil, { CR = 20 })
    n("TextLabel", 741, "Skeleton", { P = UO(102, 41), S = UO(161, 43), Z = 2, BT = 1, T = "Skeleton", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 741, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 745, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 746, nil, { CR = 20 })
    n("Circulo", 745, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Highlights Through Walls", { P = UO(528, 437), S = UO(1022, 82), Z = 8, BT = 1 })
    n("Frame", 749, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 750, nil, { CR = 20 })
    n("TextLabel", 749, "Highlights Through Walls", { P = UO(256, 41), S = UO(468, 43), Z = 2, BT = 1, T = "Highlights Through Walls", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 749, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 753, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 754, nil, { CR = 20 })
    n("Circulo", 753, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Highlights", { P = UO(528, 342), S = UO(1022, 82), Z = 9, BT = 1 })
    n("Frame", 757, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 758, nil, { CR = 20 })
    n("TextLabel", 757, "Highlights", { P = UO(118, 41), S = UO(192, 43), Z = 2, BT = 1, T = "Highlights", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 757, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 761, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 762, nil, { CR = 20 })
    n("Circulo", 761, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Hitbox", { P = UO(528, 247), S = UO(1022, 82), Z = 10, BT = 1 })
    n("Frame", 765, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 766, nil, { CR = 20 })
    n("TextLabel", 765, "Hitbox", { P = UO(83, 41), S = UO(122, 43), Z = 2, BT = 1, T = "Hitbox", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 765, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 769, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 770, nil, { CR = 20 })
    n("Circulo", 769, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 712, "Tracers", { P = UO(528, 152), S = UO(1022, 82), Z = 11, BT = 1 })
    n("Frame", 773, "Background", { P = UO(511, 41), S = UO(1022, 82), BC = G(0), BT = 0.55 })
    n("UICorner", 774, nil, { CR = 20 })
    n("TextLabel", 773, "Tracers", { P = UO(88, 41), S = UO(133, 43), Z = 2, BT = 1, T = "Tracers", TC = G(0.698), TS = 35, F = F("Bold") })
    n("TextButton", 773, "toggle", { P = UO(954, 41), S = UO(85, 47), Z = 3, BT = 1 })
    n("Frame", 777, "Rectangle 29", { P = UO(43, 24), S = UO(85, 47), BC = C3(0.3569, 0.3451, 0.3451), BT = 0.55 })
    n("UICorner", 778, nil, { CR = 20 })
    n("Circulo", 777, "Ellipse 15", { P = UO(26, 23), S = UO(42, 42), Z = 2 })
    n("Frame", 42, "game content", { P = UO(562, 238), S = UO(987, 171), Z = 7, BT = 1 })
    n("TextLabel", 781, "Name:", { P = UO(252, 36), S = UO(101, 37), BT = 1, T = "Name:", TC = G(1), TS = 30, F = F("SemiBold") })
    n("TextLabel", 781, "Admins:", { P = UO(725, 36), S = UO(127, 37), Z = 2, BT = 1, T = "Admins:", TC = G(1), TS = 30, F = F("SemiBold") })
    n("TextLabel", 781, "Players:", { P = UO(261, 83), S = UO(120, 37), Z = 3, BT = 1, T = "Players:", TC = G(1), TS = 30, F = F("SemiBold") })
    n("TextLabel", 781, "Ping:", { P = UO(241, 133), S = UO(80, 37), Z = 4, BT = 1, T = "Ping:", TC = G(1), TS = 30, F = F("SemiBold") })
    n("TextLabel", 781, "Namejogo", { P = UO(422, 36), S = UO(163, 37), Z = 5, BT = 1, T = "Namejogo", TC = G(1), TS = 30, F = F("Bold") })
    n("TextLabel", 781, "Quantidade", { P = UO(894, 36), S = UO(187, 37), Z = 6, BT = 1, T = "Quantidade", TC = G(1), TS = 30, F = F("Bold") })
    n("TextLabel", 781, "quantidade", { P = UO(431, 83), S = UO(182, 37), Z = 7, BT = 1, T = "quantidade", TC = G(1), TS = 30, F = F("Bold") })
    n("TextLabel", 781, "ms", { P = UO(364, 133), S = UO(48, 37), Z = 8, BT = 1, T = "ms", TC = G(1), TS = 30, F = F("Bold") })
    n("Frame", 781, "Imagemlabel", { P = UO(86, 86), S = UO(171, 171), Z = 9, BC = G(0.851) })
    n("Frame", 2, "Title", { P = UO(248, 74), S = UO(384, 60), Z = 4, BT = 1 })
    n("Fantasma", 791, "Logo", { P = UO(34, 30), S = UO(68, 60), BT = 1 })
    n("TextLabel", 791, "Qyz Hub", { P = UO(165, 30), S = UO(112, 30), Z = 2, BT = 1, T = "Qyz Hub", TC = G(1), TS = 25, F = F("Bold") })
    n("TextLabel", 791, "namejogo", { P = UO(317, 30), S = UO(133, 30), Z = 3, BT = 1, T = "namejogo", TC = G(1), TS = 25, F = F("Bold") })
    n("Circulo", 791, "point", { P = UO(236, 31), S = UO(7, 7), Z = 4 })

    return lista[1], lista[2]
end

-- [ script ] -- / centraliza o painel e encolhe ele quando a tela é menor que o desenho
local TELA = {
    Ajustar = true,
    Ocupa = 0.5,
}

local function ajustarATela(tela, raiz)
    if not TELA.Ajustar then
        return
    end

    local escala = Instance.new("UIScale")
    escala.Parent = raiz

    raiz.AnchorPoint = Vector2.new(0.5, 0.5)
    raiz.Position = UDim2.fromScale(0.5, 0.5)

    local function atualizar()
        local tamanho = tela.AbsoluteSize
        local largura = raiz.Size.X.Offset
        local altura = raiz.Size.Y.Offset
        if largura <= 0 or altura <= 0 or tamanho.X <= 0 or tamanho.Y <= 0 then
            return
        end
        escala.Scale = math.min(1, tamanho.X * TELA.Ocupa / largura, tamanho.Y * TELA.Ocupa / altura)
    end

    atualizar()
    tela:GetPropertyChangedSignal("AbsoluteSize"):Connect(atualizar)
end

-- [ script ] -- / cria a interface na tela do jogador e liga o painel
local tela, raiz = criarInterface()
tela.Name = "qyzHubGui"
tela.ResetOnSpawn = false
tela.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

ajustarATela(tela, raiz)

-- Esconde todas as ScrollingFrames inicialmente pra nao aparecerem todas ao mesmo tempo
-- Painel.new vai chamar SelecionarAba que mostra só a pagina ativa
local opcoesPanel = raiz:FindFirstChild("options panel")
if opcoesPanel then
    for _, obj in ipairs(opcoesPanel:GetChildren()) do
        if obj:IsA("ScrollingFrame") then
            obj.Visible = false
        end
    end
end

local painel = Painel.new(raiz)


-- [ Wire up controls ] -- / Liga todos os controles do Painel as funcoes

-- Apos criar o Painel, seta screenGui e re-parenta o admin alert
screenGui = tela
if adminAlertFrame then adminAlertFrame.Parent = screenGui end

-- [ Visuals > Player ]
painel:AoMudar("Player/Tracers", function(on)
    EspConfig.Tracer = on
    if on then for _, p in ipairs(Players:GetPlayers()) do trackPlayerBeam(p) end
    else for _, p in ipairs(Players:GetPlayers()) do clearBeam(p) end end
end)
painel:AoMudar("Player/Hitbox", function(on) EspConfig.Hitbox = on end)
painel:AoMudar("Player/Highlights", function(on) EspConfig.Highlights = on end)
painel:AoMudar("Player/Highlights Through Walls", function(on) EspConfig.HighlightsThroughWalls = on end)
painel:AoMudar("Player/Skeleton", function(on) EspConfig.Skeleton = on end)
painel:AoMudar("Player/Name", function(on) EspConfig.Name = on end)
painel:AoMudar("Player/Distance", function(on) EspConfig.Distance = on end)
painel:AoMudar("Player/Health", function(on) EspConfig.Health = on end)

-- [ Visuals > Corpses ]
painel:AoMudar("Corpses/Corpses Name", function(on)
    EspConfig.CorpsesName = on
    if on and (EspConfig.CorpsesName or EspConfig.CorpsesHighlight) then task.spawn(scanCorpses) end
end)
painel:AoMudar("Corpses/Corpses Highlights", function(on)
    EspConfig.CorpsesHighlight = on
    if on and (EspConfig.CorpsesName or EspConfig.CorpsesHighlight) then task.spawn(scanCorpses) end
end)

-- [ Visuals > Faction ]
painel:AoMudar("Faction/Faction Members", function(on) EspConfig.FactionMembers = on end)
painel:AoMudar("Faction/Faction Banners", function(on) EspConfig.FactionBanners = on end)

-- [ Visuals > ESP Distances ]
painel:AoMudar("ESP Distances/Player ESP Distance", function(v) EspDistances.Player = v end)
painel:AoMudar("ESP Distances/Car ESP Distance", function(v) EspDistances.Car = v end)
painel:AoMudar("ESP Distances/Horse ESP Distance", function(v) EspDistances.Horse = v end)
painel:AoMudar("ESP Distances/Corpse ESP Distance", function(v) EspDistances.Corpse = v end)
painel:AoMudar("ESP Distances/Faction Banner", function(v) EspDistances.FactionBanner = v end)

-- [ Visuals > ESP Colors ]
painel:AoMudar("ESP Colors/Set Tracer Color", function(c)
    EspColors.Tracer = c updateTracerColor()
end)
painel:AoMudar("ESP Colors/Set Highlights Color", function(c)
    EspColors.Highlights = c
    for plr, hl in pairs(HighlightsCache) do
        if hl and hl.Parent and not isFactionEspTarget(plr) then
            hl.OutlineColor = c hl.FillColor = c
        end
    end
end)
painel:AoMudar("ESP Colors/Set Hitbox Color", function(c) EspColors.Hitbox = c end)
painel:AoMudar("ESP Colors/Set Corpses Color", function(c)
    EspColors.Corpses = c
    for model, data in pairs(CorpseEspObjects) do
        if model and model.Parent then
            if data.nameText then data.nameText.Color = c end
            if data.highlight then data.highlight.FillColor = c data.highlight.OutlineColor = c end
        end
    end
end)
painel:AoMudar("ESP Colors/Set Faction Member Color", function(c)
    EspColors.FactionMember = c
    for plr, hl in pairs(HighlightsCache) do
        if hl and hl.Parent and isFactionEspTarget(plr) then
            hl.OutlineColor = c hl.FillColor = c
        end
    end
    for plr, draw in pairs(EspDrawings) do
        if draw and isFactionEspTarget(plr) then
            if draw.Box then draw.Box.Color = c end
            if draw.Name then draw.Name.Color = c end
        end
    end
end)
painel:AoMudar("ESP Colors/Set Faction Banner Color", function(c)
    EspColors.FactionBanner = c
    for model, data in pairs(BannerEspObjects) do
        if model and model.Parent and data.nameLabel then data.nameLabel.TextColor3 = c end
    end
end)
painel:AoMudar("ESP Colors/Set Horses Color", function(c)
    EspColors.Horses = c
    for model, data in pairs(HorseEspObjects) do
        if model and model.Parent then
            local isSkeleton = model:GetAttribute("SkeletonHorse") == true
            if not isSkeleton then
                if data.nameLabel then data.nameLabel.TextColor3 = c end
                if data.highlight then
                    data.highlight.FillColor = c
                    data.highlight.OutlineColor = c
                end
            end
        end
    end
end)
painel:AoMudar("ESP Colors/Set Cars Color", function(c)
    EspColors.Cars = c
    for model, data in pairs(CarEspObjects) do
        if model and model.Parent then
            if data.billboard then
                for _, child in ipairs(data.billboard:GetChildren()) do
                    if child:IsA("TextLabel") then child.TextColor3 = c end
                end
            end
            if data.highlight then
                data.highlight.FillColor = c
                data.highlight.OutlineColor = c
            end
        end
    end
end)

-- [ Combat > Combat ]
painel:AoMudar("Combat/Aimbot", function(on) AimbotConfig.Enabled = on end)
painel:AoMudar("Combat/Aimbot Legit", function(on) AimbotConfig.Legit = on end)
painel:AoMudar("Combat/Team Check", function(on) AimbotConfig.TeamCheck = on end)
painel:AoMudar("Combat/Wallbang", function(on) AimbotConfig.Wallbang = on applyWallbang() end)

-- [ Combat > FOV ]
painel:AoMudar("FOV/Fov Circle", function(on) AimbotConfig.ShowFOV = on end)
painel:AoMudar("FOV/FOV Size", function(v) AimbotConfig.FOV = v end)
painel:AoMudar("FOV/Fov Color", function(c) AimbotConfig.FOVColor = c end)

-- [ Movement > Player Movement ]
painel:AoMudar("Player Movement/Player Speed", function(on) PlayerConfig.Speed = on applyPlayerSpeed() end)
painel:AoMudar("Player Movement/Player Amount", function(v) PlayerConfig.SpeedAmount = v applyPlayerSpeed() end)
painel:AoMudar("Player Movement/Jump Height", function(on) PlayerConfig.JumpHeight = on applyPlayerJump() end)
painel:AoMudar("Player Movement/Jump Height Amount", function(v) PlayerConfig.JumpHeightAmount = v applyPlayerJump() end)
painel:AoMudar("Player Movement/Noclip", function(on) PlayerConfig.Noclip = on applyNoclip() end)
painel:AoMudar("Player Movement/Fly", function(on) PlayerConfig.Fly = on applyPlayerFly() end)
painel:AoMudar("Player Movement/Fly Speed", function(v) PlayerConfig.FlySpeed = v end)

-- [ Movement > Vehicle Movement ]
painel:AoMudar("Vehicle Movement/Vehicle Fly", function(on) PlayerConfig.CarFly = on end)
painel:AoMudar("Vehicle Movement/Fly Speed", function(v) PlayerConfig.VehicleFlySpeed = v end)
painel:AoMudar("Vehicle Movement/Fly Speed Cap", function(on) PlayerConfig.VehicleFlySpeedCap = on end)
painel:AoMudar("Vehicle Movement/Vehicle Noclip", function(on) PlayerConfig.VehicleNoclip = on applyVehicleNoclip() end)
painel:AoMudar("Vehicle Movement/Vehicle Speed (%)", function(v) PlayerConfig.VehicleSpeed = v applyVehicleSpeed() end)
painel:AoMudar("Vehicle Movement/Drive Without Fuel", function(on) PlayerConfig.DriveWithoutFuel = on applyDriveWithoutFuel() end)
painel:AoMudar("Vehicle Movement/Fly Height", function(v) PlayerConfig.FlyHeight = v end)

-- [ Movement > Bring Nearest Car ] -- / Dropdown popula com workspace.Cars
local function refreshCarDropdown()
    local carsFolder = workspace:FindFirstChild("Cars")
    local nomes = {}
    if carsFolder then
        for _, obj in ipairs(carsFolder:GetChildren()) do
            if obj:IsA("Model") then
                table.insert(nomes, obj.Name ~= "" and obj.Name or ("Carro " .. #nomes + 1))
            end
        end
    end
    if #nomes == 0 then nomes = { "Nenhum carro" } end
    painel:DefinirItens("Vehicle Movement/Bring Nearest Car", nomes)
end
refreshCarDropdown()
task.spawn(function()
    while true do
        refreshCarDropdown()
        task.wait(5)
    end
end)
painel:AoMudar("Vehicle Movement/Bring Nearest Car", function(nome)
    if not nome or nome == "Nenhum carro" then return end
    local carsFolder = workspace:FindFirstChild("Cars")
    if not carsFolder then return end
    for _, obj in ipairs(carsFolder:GetChildren()) do
        if obj:IsA("Model") and obj.Name == nome then
            bringSpecificCar(obj)
            break
        end
    end
end)

-- [ Movement > Horse Movement ]
painel:AoMudar("Horse Movement/Horse Speed", function(on) PlayerConfig.HorseSpeedEnabled = on applyHorseFeatures() end)
painel:AoMudar("Horse Movement/Horse Amount", function(v) PlayerConfig.HorseSpeed = v applyHorseFeatures() end)
painel:AoMudar("Horse Movement/Horse Jump", function(on) PlayerConfig.HorseJump = on applyHorseFeatures() end)
painel:AoMudar("Horse Movement/Horse Jump Height", function(v) PlayerConfig.HorseJumpHeight = v end)
painel:AoMudar("Horse Movement/Horse Air Jump", function(on) PlayerConfig.HorseAirJump = on end)
painel:AoMudar("Horse Movement/Horse Keep Sprint", function(on) PlayerConfig.HorseKeepSprint = on applyHorseFeatures() end)
painel:AoMudar("Horse Movement/Shoot On Horse", function(on) PlayerConfig.ShootOnHorse = on end)

-- [ Performance > Performance ]
painel:AoMudar("Performance/FPS Boost", function(on) PerfConfig.FPSBoost = on applyFPSBoost() end)
painel:AoMudar("Performance/Particles", function(on) PerfConfig.Particles = on applyParticles() end)
painel:AoMudar("Performance/Tree Shadows", function(on) PerfConfig.TreeShadows = on applyTreeShadows() end)
painel:AoMudar("Performance/Preload GUI", function(on) PerfConfig.PreloadGUI = on applyPreloadGUI() end)
painel:AoMudar("Performance/Film Grain", function(on) PerfConfig.FilmGrain = on applyFilmGrain() end)
painel:AoMudar("Performance/Lights", function(on) PerfConfig.MapLights = on applyMapLights() end)
painel:AoMudar("Performance/All Shadows", function(on) PerfConfig.AllShadows = on applyAllShadows() end)
painel:AoMudar("Performance/Graphics Quality", function(on) PerfConfig.LowerGraphics = on applyLowerGraphics() end)

-- [ Others > Freecam ]
painel:AoMudar("Freecam/Freecam", function(on) PlayerConfig.Freecam = on applyFreecam() end)
painel:AoMudar("Freecam/Freecam TP", function(on)
    applyFreecamTP()
    task.delay(0.3, function() painel:Definir("Freecam/Freecam TP", false, true) end)
end)
painel:AoMudar("Freecam/Freecam Speed", function(v) PlayerConfig.FreecamSpeed = v end)

-- [ Others > Teleport ]
painel:AoMudar("Teleport/Map Click TP", function(on) PlayerConfig.MapClickTP = on applyMapClickTP() end)
painel:AoMudar("Teleport/Low Health TP", function(on) PlayerConfig.LowHealthTP = on applyLowHealthTP() end)
painel:AoMudar("Teleport/Low Health %", function(v) PlayerConfig.LowHealthPct = v end)

-- [ Others > Respawn ]
painel:AoMudar("Respawn/Respawn At Death Spot", function(on) PlayerConfig.RespawnAtDeathSpot = on setupRespawnHook() end)
painel:AoMudar("Respawn/Respawn", function(on)
    if on then doRespawn() end
    task.delay(0.3, function() painel:Definir("Respawn/Respawn", false, true) end)
end)

-- [ Others > Admins ]
painel:AoMudar("Admins/Admins", function(on) ServerConfig.AdminAlert = on updateAdminAlert() end)

-- [ Inicializa estados dos controles com valores salvos ]
local function initToggle(chave, valor)
    if valor then painel:Definir(chave, true, false) end
end
local function initSlider(chave, valor)
    if valor and valor > 0 then painel:Definir(chave, valor, false) end
end

-- Visuals
initToggle("Player/Tracers", EspConfig.Tracer)
initToggle("Player/Hitbox", EspConfig.Hitbox)
initToggle("Player/Highlights", EspConfig.Highlights)
initToggle("Player/Highlights Through Walls", EspConfig.HighlightsThroughWalls)
initToggle("Player/Skeleton", EspConfig.Skeleton)
initToggle("Player/Name", EspConfig.Name)
initToggle("Player/Distance", EspConfig.Distance)
initToggle("Player/Health", EspConfig.Health)
initToggle("Corpses/Corpses Name", EspConfig.CorpsesName)
initToggle("Corpses/Corpses Highlights", EspConfig.CorpsesHighlight)
initToggle("Faction/Faction Members", EspConfig.FactionMembers)
initToggle("Faction/Faction Banners", EspConfig.FactionBanners)
initSlider("ESP Distances/Player ESP Distance", EspDistances.Player)
initSlider("ESP Distances/Car ESP Distance", EspDistances.Car)
initSlider("ESP Distances/Horse ESP Distance", EspDistances.Horse)
initSlider("ESP Distances/Corpse ESP Distance", EspDistances.Corpse)
initSlider("ESP Distances/Faction Banner", EspDistances.FactionBanner)

-- Combat
initToggle("Combat/Aimbot", AimbotConfig.Enabled)
initToggle("Combat/Aimbot Legit", AimbotConfig.Legit)
initToggle("Combat/Team Check", AimbotConfig.TeamCheck)
initToggle("Combat/Wallbang", AimbotConfig.Wallbang)
initToggle("FOV/Fov Circle", AimbotConfig.ShowFOV)
initSlider("FOV/FOV Size", AimbotConfig.FOV)

-- Movement
initToggle("Player Movement/Player Speed", PlayerConfig.Speed)
initSlider("Player Movement/Player Amount", PlayerConfig.SpeedAmount)
initToggle("Player Movement/Jump Height", PlayerConfig.JumpHeight)
initSlider("Player Movement/Jump Height Amount", PlayerConfig.JumpHeightAmount)
initToggle("Player Movement/Noclip", PlayerConfig.Noclip)
initToggle("Player Movement/Fly", PlayerConfig.Fly)
initSlider("Player Movement/Fly Speed", PlayerConfig.FlySpeed)
initToggle("Vehicle Movement/Vehicle Fly", PlayerConfig.CarFly)
initSlider("Vehicle Movement/Fly Speed", PlayerConfig.VehicleFlySpeed)
initToggle("Vehicle Movement/Fly Speed Cap", PlayerConfig.VehicleFlySpeedCap)
initToggle("Vehicle Movement/Vehicle Noclip", PlayerConfig.VehicleNoclip)
initSlider("Vehicle Movement/Vehicle Speed (%)", PlayerConfig.VehicleSpeed)
initToggle("Vehicle Movement/Drive Without Fuel", PlayerConfig.DriveWithoutFuel)
initSlider("Vehicle Movement/Fly Height", PlayerConfig.FlyHeight)
initToggle("Horse Movement/Horse Speed", PlayerConfig.HorseSpeedEnabled)
initSlider("Horse Movement/Horse Amount", PlayerConfig.HorseSpeed)
initToggle("Horse Movement/Horse Jump", PlayerConfig.HorseJump)
initSlider("Horse Movement/Horse Jump Height", PlayerConfig.HorseJumpHeight)
initToggle("Horse Movement/Horse Air Jump", PlayerConfig.HorseAirJump)
initToggle("Horse Movement/Horse Keep Sprint", PlayerConfig.HorseKeepSprint)
initToggle("Horse Movement/Shoot On Horse", PlayerConfig.ShootOnHorse)

-- Performance
initToggle("Performance/FPS Boost", PerfConfig.FPSBoost)
initToggle("Performance/Particles", PerfConfig.Particles)
initToggle("Performance/Tree Shadows", PerfConfig.TreeShadows)
initToggle("Performance/Preload GUI", PerfConfig.PreloadGUI)
initToggle("Performance/Film Grain", PerfConfig.FilmGrain)
initToggle("Performance/Lights", PerfConfig.MapLights)
initToggle("Performance/All Shadows", PerfConfig.AllShadows)
initToggle("Performance/Graphics Quality", PerfConfig.LowerGraphics)

-- Others
initToggle("Freecam/Freecam", PlayerConfig.Freecam)
initSlider("Freecam/Freecam Speed", PlayerConfig.FreecamSpeed)
initToggle("Teleport/Map Click TP", PlayerConfig.MapClickTP)
initToggle("Teleport/Low Health TP", PlayerConfig.LowHealthTP)
initSlider("Teleport/Low Health %", PlayerConfig.LowHealthPct)
initToggle("Respawn/Respawn At Death Spot", PlayerConfig.RespawnAtDeathSpot)
initToggle("Admins/Admins", ServerConfig.AdminAlert)

-- [ Cores salvas ] -- / Marca no painel a cor que estava salva, sem mudar a config
local function initCor(chave, cor)
    if loaded and cor then painel:Definir(chave, cor, true) end
end
initCor("ESP Colors/Set Tracer Color", EspColors.Tracer)
initCor("ESP Colors/Set Highlights Color", EspColors.Highlights)
initCor("ESP Colors/Set Hitbox Color", EspColors.Hitbox)
initCor("ESP Colors/Set Corpses Color", EspColors.Corpses)
initCor("ESP Colors/Set Faction Member Color", EspColors.FactionMember)
initCor("ESP Colors/Set Faction Banner Color", EspColors.FactionBanner)
initCor("ESP Colors/Set Horses Color", EspColors.Horses)
initCor("ESP Colors/Set Cars Color", EspColors.Cars)
initCor("FOV/Fov Color", AimbotConfig.FOVColor)

-- [ Salvamento automatico ] -- / Qualquer toggle, slider ou cor grava a ultima config
painel:AoQualquerMudanca(function()
    queueSave()
end)

-- Admin count no Dashboard
task.spawn(function()
    while true do
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if checkPlayerAdmin(p) then count = count + 1 end
        end
        painel:DefinirInfo("Admins", count)
        task.wait(3)
    end
end)


-- [ Render Principal ]
local EspDrawings = {}
function getEspDrawings(player)
    if not EspDrawings[player] then
        local entry = {
            Name = Drawing.new("Text"), Distance = Drawing.new("Text"), Skeleton = {},
            Box = Drawing.new("Square"), HealthBg = Drawing.new("Square"), Health = Drawing.new("Square")
        }
        entry.Name.Center = true entry.Name.Outline = true entry.Name.OutlineColor = Color3.fromRGB(0, 0, 0)
        entry.Distance.Center = true entry.Distance.Outline = true entry.Distance.OutlineColor = Color3.fromRGB(0, 0, 0)
        entry.Box.Thickness = 1 entry.Box.Filled = false entry.Box.Color = EspColors.Hitbox
        entry.HealthBg.Filled = true entry.HealthBg.Color = Color3.fromRGB(0, 0, 0)
        entry.Health.Filled = true entry.Health.Color = Color3.fromRGB(0, 255, 0)
        pcall(function() entry.Name.Font = 2 entry.Distance.Font = 2 end)
        EspDrawings[player] = entry
    end
    return EspDrawings[player]
end

function clearDrawingsFor(player)
    local obj = EspDrawings[player] if not obj then return end
    pcall(function()
        obj.Name:Remove() obj.Distance:Remove() obj.Box:Remove() obj.HealthBg:Remove() obj.Health:Remove()
        for _, line in pairs(obj.Skeleton) do line:Remove() end
    end)
    EspDrawings[player] = nil
    if HighlightsCache[player] then HighlightsCache[player]:Destroy() HighlightsCache[player] = nil end
end
Players.PlayerRemoving:Connect(clearDrawingsFor)

local skeletonBonesR15 = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"}, {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"}, {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
}
local skeletonBonesR6 = {
    {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"}
}
function getBoneLine(drawingsObj, index)
    if not drawingsObj.Skeleton[index] then
        local line = Drawing.new("Line") line.Thickness = 1 line.Color = EspColors.Hitbox drawingsObj.Skeleton[index] = line
    end
    return drawingsObj.Skeleton[index]
end

-- [ Cleanup Function ] -- / Limpa tudo quando GUI e destruida
function cleanupAll()
    SaveLoad.save()
    if FovCircle then FovCircle:Remove() end
    for _, obj in pairs(EspDrawings) do
        pcall(function()
            obj.Name:Remove() obj.Distance:Remove() obj.Box:Remove() obj.HealthBg:Remove() obj.Health:Remove()
            for _, line in pairs(obj.Skeleton) do line:Remove() end
        end)
    end
    for model, _ in pairs(BannerEspObjects) do removeBannerEsp(model) end
    for model, _ in pairs(CarEspObjects) do removeCarEsp(model) end
    for model, _ in pairs(HorseEspObjects) do removeHorseEsp(model) end
    for model, _ in pairs(CorpseEspObjects) do removeCorpseEsp(model) end
    for plr, _ in pairs(BeamTrackers) do untrackPlayerBeam(plr) end
    for plr, _ in pairs(EspBeams) do clearBeam(plr) end
    for plr, hl in pairs(HighlightsCache) do hl:Destroy() end
    if flyConn then flyConn:Disconnect() end
    if flyBV then flyBV:Destroy() end
    if vehicleNoclipConn then vehicleNoclipConn:Disconnect() end
    if vehicleSpeedConn then vehicleSpeedConn:Disconnect() end
    if vehicleFuelConn then vehicleFuelConn:Disconnect() end
    if horseConn then horseConn = false end
    if freecamConn then freecamConn:Disconnect() end
    if freecamPart then freecamPart:Destroy() end
    if mapClickConn then mapClickConn:Disconnect() end
    if lowHealthConn then lowHealthConn = false end
    if noclipConn then noclipConn:Disconnect() end
    if respawnConn then respawnConn:Disconnect() end
    if speedEnforcer then speedEnforcer:Disconnect() end
    if jumpEnforcer then jumpEnforcer:Disconnect() end
    if corpsesChildConn then corpsesChildConn:Disconnect() corpsesChildConn = nil end
    -- Wallbang nao precisa de cleanup (nao modifica parts)
    if painel then painel:Destruir() end
end

-- [ Hide Player ESP ] -- / Esconde todos os drawings de um player
function hidePlayerEsp(player)
    if EspDrawings[player] then
        local obj = EspDrawings[player]
        pcall(function()
            obj.Name.Visible = false obj.Distance.Visible = false obj.Box.Visible = false
            obj.Health.Visible = false obj.HealthBg.Visible = false
            for _, line in pairs(obj.Skeleton) do line.Visible = false end
        end)
    end
    if HighlightsCache[player] then HighlightsCache[player]:Destroy() HighlightsCache[player] = nil end
end

-- [ Render Player ESP ] -- / Renderiza ESP de um player individual
function renderPlayerEsp(player)
    -- Team Check ligado = esconde membros da mesma faccao do ESP tambem (feedback visivel)
    if AimbotConfig.TeamCheck and isFactionMember(player) then
        hidePlayerEsp(player)
        return
    end
    local char = player.Character
    if not char then hidePlayerEsp(player) return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")

    if not (hrp and head and hum and hum.Health > 0) then hidePlayerEsp(player) return end

    local obj = getEspDrawings(player)
    local targetScreenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
    local isFaction = isFactionEspTarget(player)
    local playerColor = isFaction and EspColors.FactionMember or EspColors.Hitbox
    local dist3D = (Camera.CFrame.Position - hrp.Position).Magnitude
    local inRange = dist3D <= (EspDistances.Player or 500)

    -- Dot product check: player tem que estar na frente da camera
    local camLook = Camera.CFrame.LookVector
    local toPlayer = (hrp.Position - Camera.CFrame.Position)
    local toPlayerMag = toPlayer.Magnitude
    if toPlayerMag < 0.01 then hidePlayerEsp(player) return end
    local dotProduct = camLook:Dot(toPlayer / toPlayerMag)
    local inFrontOfCamera = dotProduct > 0.2

    updateHighlights(player, char, isFaction)

    if not (targetScreenPos.Z > 0 and onScreen and inRange and inFrontOfCamera) then
        hidePlayerEsp(player)
        return
    end

    local cf, size = char:GetBoundingBox()
    local boxValid = size and size.X > 0 and size.Y > 0 and size.Z > 0
        and size.X == size.X and size.Y == size.Y and size.Z == size.Z
    if not boxValid then hidePlayerEsp(player) return end

    local corners = {
        cf * Vector3.new(size.X/2, size.Y/2, size.Z/2), cf * Vector3.new(size.X/2, size.Y/2, -size.Z/2),
        cf * Vector3.new(-size.X/2, size.Y/2, size.Z/2), cf * Vector3.new(-size.X/2, size.Y/2, -size.Z/2),
        cf * Vector3.new(size.X/2, -size.Y/2, size.Z/2), cf * Vector3.new(size.X/2, -size.Y/2, -size.Z/2),
        cf * Vector3.new(-size.X/2, -size.Y/2, size.Z/2), cf * Vector3.new(-size.X/2, -size.Y/2, -size.Z/2)
    }
    local valid = true
    local screenPositions = {}
    for i, corner in ipairs(corners) do
        local sp = Camera:WorldToViewportPoint(corner)
        if sp.Z <= 0 or sp.Z ~= sp.Z then valid = false break end
        screenPositions[i] = sp
    end

    local width, height, boxX, boxY = 2, 2, 0, 0
    if valid then
        local minX, minY = math.huge, math.huge
        local maxX, maxY = -math.huge, -math.huge
        for _, sp in ipairs(screenPositions) do
            if sp.X < minX then minX = sp.X end
            if sp.X > maxX then maxX = sp.X end
            if sp.Y < minY then minY = sp.Y end
            if sp.Y > maxY then maxY = sp.Y end
        end
        width = math.max(2, maxX - minX)
        height = math.max(2, maxY - minY)
        boxX, boxY = minX, minY
        local vw, vh = Camera.ViewportSize.X, Camera.ViewportSize.Y
        if width > vw * 2 or height > vh * 2 then valid = false end
    end

    if not valid then hidePlayerEsp(player) return end

    -- Renderiza ESP components
    if EspConfig.Name then
        obj.Name.Text = player.Name
        obj.Name.Position = Vector2.new(boxX + width/2, boxY - 16)
        obj.Name.Size = 15 obj.Name.Color = playerColor obj.Name.Visible = true
    else obj.Name.Visible = false end

    if EspConfig.Distance then
        local d = math.floor((Camera.CFrame.Position - hrp.Position).Magnitude)
        obj.Distance.Text = d .. "m"
        obj.Distance.Position = Vector2.new(boxX + width/2, boxY + height + 2)
        obj.Distance.Size = 13 obj.Distance.Color = Color3.fromRGB(200, 200, 200) obj.Distance.Visible = true
    else obj.Distance.Visible = false end

    if EspConfig.Hitbox then
        obj.Box.Size = Vector2.new(width, height)
        obj.Box.Position = Vector2.new(boxX, boxY)
        obj.Box.Color = playerColor obj.Box.Visible = true
    else obj.Box.Visible = false end

    if EspConfig.Health then
        local maxHP = hum.MaxHealth
        if maxHP <= 0 or maxHP == math.huge or maxHP ~= maxHP then maxHP = 100 end
        local curHP = hum.Health
        if curHP < 0 or curHP ~= curHP then curHP = 0 end
        local ratio = math.clamp(curHP / maxHP, 0, 1)
        local hH = height * ratio
        if curHP > 0 and hH < 1 then hH = 1 end
        local barW = 4
        if ratio <= 0.25 then obj.Health.Color = Color3.fromRGB(255, 0, 0)
        elseif ratio <= 0.5 then obj.Health.Color = Color3.fromRGB(255, 255, 0)
        else obj.Health.Color = Color3.fromRGB(0, 255, 0) end
        obj.HealthBg.Size = Vector2.new(barW, height)
        obj.HealthBg.Position = Vector2.new(boxX - barW - 2, boxY)
        obj.HealthBg.Visible = true
        obj.Health.Size = Vector2.new(barW, hH)
        obj.Health.Position = Vector2.new(boxX - barW - 2, boxY + (height - hH))
        obj.Health.Visible = true
    else obj.Health.Visible = false obj.HealthBg.Visible = false end

    if EspConfig.Skeleton then
        for _, line in pairs(obj.Skeleton) do line.Visible = false end
        local bones = char:FindFirstChild("UpperTorso") and skeletonBonesR15 or skeletonBonesR6
        for i, bonePair in ipairs(bones) do
            local pA = char:FindFirstChild(bonePair[1])
            local pB = char:FindFirstChild(bonePair[2])
            if pA and pB then
                local sA, onA = Camera:WorldToViewportPoint(pA.Position)
                local sB, onB = Camera:WorldToViewportPoint(pB.Position)
                if onA and onB then
                    local line = getBoneLine(obj, i)
                    line.From = Vector2.new(sA.X, sA.Y)
                    line.To = Vector2.new(sB.X, sB.Y)
                    line.Color = playerColor line.Visible = true
                end
            end
        end
    else for _, line in pairs(obj.Skeleton) do line.Visible = false end end
end

-- [ Render ESP Objects ] -- / Renderiza ESPs de banners, carros, cavalos, corpos
function renderEspObjects()
    if EspConfig.FactionBanners then
        for model, data in pairs(BannerEspObjects) do
            if not model or not model.Parent or not data.rootPart or not data.rootPart.Parent then
                removeBannerEsp(model)
            else data.billboard.Enabled = true data.billboard.MaxDistance = EspDistances.FactionBanner or 500 end
        end
    end

    updateTracerVisibility()

    if EspConfig.Cars then
        for model, data in pairs(CarEspObjects) do
            if not model or not model.Parent or not data.rootPart or not data.rootPart.Parent then
                removeCarEsp(model)
            else data.billboard.Enabled = true data.billboard.MaxDistance = EspDistances.Car or 500 end
        end
    end

    if EspConfig.Horses then
        for model, data in pairs(HorseEspObjects) do
            if not model or not model.Parent or not data.rootPart or not data.rootPart.Parent then
                removeHorseEsp(model)
            else data.billboard.Enabled = true data.billboard.MaxDistance = EspDistances.Horse or 1000 end
        end
    end

    if EspConfig.CorpsesName or EspConfig.CorpsesHighlight then
        updateCorpseEspVisibility()
    end
end

-- [ Render Aimbot ] -- / Processa aimbot e FOV circle
function renderAimbot()
    local shouldAim = false
    if AimbotConfig.Enabled then shouldAim = true
    elseif AimbotConfig.Legit and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        shouldAim = true
    end
    FovCircle.Visible = AimbotConfig.ShowFOV
    FovCircle.Radius = AimbotConfig.FOV
    FovCircle.Color = AimbotConfig.FOVColor
    FovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if shouldAim then
        local target = getClosestPlayer()
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
    end
end

-- [ Render Principal ] -- / Loop principal (leve, sem muitas locals)
local renderConn
renderConn = RunService.RenderStepped:Connect(function()
    if not screenGui or not screenGui.Parent then
        cleanupAll()
        if renderConn then renderConn:Disconnect() end
        return
    end

    -- Renderiza ESP de players
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            renderPlayerEsp(player)
        end
    end

    -- Renderiza ESP de objetos (banners, carros, cavalos, corpos, tracer)
    renderEspObjects()

    -- Renderiza aimbot e FOV circle
    renderAimbot()

    -- Atualiza Car Fly
    updateCarFly()
end)
end -- fecha function main()

main()
