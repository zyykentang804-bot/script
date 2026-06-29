if getgenv().FPSGAL then return end
getgenv().FPSGAL = true

local RunService       = game:GetService("RunService")
local Lighting         = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Workspace        = game:GetService("Workspace")

local Players             = cloneref(game:GetService("Players")) or game:GetService("Players")
local ReplicatedStorage   = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local MemoryStoreService  = cloneref(game:GetService("MemoryStoreService")) or game:GetService("MemoryStoreService")
local Workspace           = game:GetService("Workspace")

local LP   = cloneref(Players.LocalPlayer) or Players.LocalPlayer
local PGui = LP:WaitForChild("PlayerGui")

if game.PlaceId == 13643807539 then
local Client = LP
local genv   = getgenv()

genv.Hyphon_2102     = filtergc("function", { StartLine = 2102, IgnoreExecutor = true }, true)
genv.Hyphon_2247     = filtergc("function", { StartLine = 2247, Source = debug.info(genv.Hyphon_2102, "s"), IgnoreExecutor = true }, true)
genv.Hyphon_2846     = filtergc("function", { StartLine = 2846, Source = debug.info(genv.Hyphon_2102, "s"), IgnoreExecutor = true }, true)
genv.Hyphon_fake_dec = filtergc("function", { StartLine = 1097, Source = debug.info(genv.Hyphon_2102, "s"), IgnoreExecutor = true }, true)
genv.Hyphon_Encode   = debug.getupvalue(genv.Hyphon_2102, 1)
genv.Hyphon_Decode   = debug.getupvalue(genv.Hyphon_2102, 21)
genv.Hyphon_Script   = nil

for _, Object in pairs(getnilinstances()) do
    if Object:IsA("Script") and Object.Name:len() == 32 then
        genv.Hyphon_Script = Object
        break
    end
end

if not genv.Hyphon_2102     then Client:Kick("Emulator : Hyphon_2102 not found!")     task.wait(9e9) end
if not genv.Hyphon_2247     then Client:Kick("Emulator : Hyphon_2247 not found!")     task.wait(9e9) end
if not genv.Hyphon_2846     then Client:Kick("Emulator : Hyphon_2846 not found!")     task.wait(9e9) end
if not genv.Hyphon_fake_dec then Client:Kick("Emulator : Hyphon_fake_dec not found!") task.wait(9e9) end
if not genv.Hyphon_Script   then Client:Kick("Emulator : Hyphon_Script not found!")   task.wait(9e9) end

local Emulator_Data = {
    Emulator_Set = false,
    Hyphon_Check = {
        ["Tick"]              = nil,
        ["Hyphon_Check"]      = MemoryStoreService:FindFirstChild("Hyphon_Check"),
        ["Handshake_Version"] = tostring(debug.getupvalue(genv.Hyphon_2846, 42)) .. "Handshake_V5",
    },
    RemoteFunction = {
        ["Tick"]           = nil,
        ["RemoteFunction"] = debug.getupvalue(genv.Hyphon_2247, 6),
        ["Token One"]      = nil,
        ["Token Two"]      = nil,
        ["Current Number"] = nil,
        ["Token Three"]    = nil,
        ["Token Four"]     = nil,
        ["Tablets"]        = {[1]=nil,[2]=nil,[3]=nil,[4]=nil,[5]=nil,[6]=nil},
        ["SSL"]            = nil,
        ["LuaFunction"]    = nil,
    },
}

local Hyphon_Check = nil
Hyphon_Check = hookfunction(Emulator_Data.Hyphon_Check["Hyphon_Check"].FireServer, newcclosure(function(self, ...)
    Emulator_Data.Hyphon_Check["Tick"] = tick()
    return Hyphon_Check(self, ...)
end))

local RemoteFunction = nil
RemoteFunction = hookfunction(Emulator_Data.RemoteFunction["RemoteFunction"].InvokeServer, newcclosure(function(self, ...)
    local Arguments = table.pack(...)
    Emulator_Data.RemoteFunction["Tick"] = tick()
    if not Emulator_Data.Emulator_Set and type(Arguments[1]) == "table" and Arguments[1][1] ~= nil then
        Emulator_Data.RemoteFunction["Token One"]      = Arguments[1][1]
        Emulator_Data.RemoteFunction["Token Two"]      = Arguments[1][2]
        Emulator_Data.RemoteFunction["Current Number"] = genv.Hyphon_Decode(Arguments[1][4])
        Emulator_Data.RemoteFunction["Token Three"]    = Arguments[1][6]
        Emulator_Data.RemoteFunction["Token Four"]     = Arguments[1][11]
        if type(Arguments[1][12]) == "table" and Arguments[1][12]["Tablets"] ~= nil then
            Emulator_Data.RemoteFunction["Tablets"] = Arguments[1][12]["Tablets"]
        end
        if type(Arguments[1][13]) == "table" then
            Emulator_Data.RemoteFunction["SSL"]         = Arguments[1][13]["SSL"]
            Emulator_Data.RemoteFunction["LuaFunction"] = Arguments[1][13]["LuaFunction"]
        end
    end
    return RemoteFunction(self, ...)
end))

repeat task.wait() until (Emulator_Data.Hyphon_Check["Tick"] and Emulator_Data.RemoteFunction["Tick"])

genv.Emulator_Set = true

local OldBit32 = nil
OldBit32 = hookfunction(bit32.bxor, newcclosure(function(...)
    if not checkcaller() then
        if getcallingscript() == genv.Hyphon_Script then
            return task.wait(9e9)
        end
    end
    return OldBit32(...)
end))

pcall(function()
    local Wrapped_Functions = filtergc("function", {
        Upvalues  = {"Attempted function hijacking detected. Logged."},
        Constants = {":P"}
    })
    for _, Function in pairs(Wrapped_Functions) do
        local Upvalues = debug.getupvalues(Wrapped_Functions)
        if #Upvalues == 20 then
            for _, Upvalue in pairs(Upvalues) do
                if typeof(Upvalue) == "function" and islclosure(Upvalue) then
                    Upvalues = debug.getupvalues(Upvalue)
                    if #Upvalues == 17 then
                        hookfunction(Function, newcclosure(function() end))
                    end
                end
            end
        end
    end
end)

task.spawn(function() while task.wait(9)  do Emulator_Data.RemoteFunction["Tablets"][1] = tick() Emulator_Data.RemoteFunction["Tablets"][2] = tick() end end)
task.spawn(function() while task.wait(10) do Emulator_Data.RemoteFunction["Tablets"][3] = tick() end end)
task.spawn(function() while task.wait(4)  do Emulator_Data.RemoteFunction["Tablets"][4] = tick() end end)

for _, Object in pairs(ReplicatedStorage:GetChildren()) do
    if Object:IsA("Folder") and Object.Name:len() <= 4 then
        local RF = Object:FindFirstChildOfClass("RemoteFunction")
        RF.OnClientInvoke = function(...)
            local Arguments = table.pack(...)
            if Arguments[1] ~= nil then
                Emulator_Data.RemoteFunction["Token Two"] = genv.Hyphon_Decode(Arguments[1])
            end
            Emulator_Data.RemoteFunction["Current Number"] = -1
            local Table = {
                debug.getupvalue(genv.Hyphon_2102, 26),
                genv.Hyphon_Encode("Hyphon-," .. tostring(math.random(242, 789) .. "{ Date (Data: " .. tostring(math.random(1, 9)) .. ")")),
                genv.Hyphon_fake_dec(Arguments[3], tostring(Client.UserId)),
                debug.getupvalue(genv.Hyphon_2102, 29)(),
                genv.Hyphon_Encode(tostring(Workspace:GetServerTimeNow())),
                {
                    CI = genv.Hyphon_Encode(tostring(tick())),
                    TL = Emulator_Data.RemoteFunction["Tablets"],
                    LS = #tostring(debug.getupvalue(genv.Hyphon_2102, 37)) + game.PlaceVersion
                }
            }
            return table.unpack(Table)
        end
    end
end

task.spawn(function()
    local function DoRemoteFunction()
        local RF = Emulator_Data.RemoteFunction["RemoteFunction"]
        Emulator_Data.RemoteFunction["Current Number"] += 1
        Emulator_Data.RemoteFunction["Tablets"][5] = (tick() - .5)
        Emulator_Data.RemoteFunction["Tablets"][6] = tick()
        RF:InvokeServer({
            Emulator_Data.RemoteFunction["Token One"],
            Emulator_Data.RemoteFunction["Token Two"],
            nil,
            [4]  = genv.Hyphon_Encode(tostring(Emulator_Data.RemoteFunction["Current Number"])),
            [5]  = debug.getupvalue(genv.Hyphon_2247, 12)("_1") .. "__index",
            [6]  = Emulator_Data.RemoteFunction["Token Three"],
            [7]  = debug.getupvalue(genv.Hyphon_2247, 20),
            [8]  = genv.Hyphon_Encode(tostring(os.time())),
            [9]  = tick(),
            [10] = debug.getupvalue(genv.Hyphon_2247, 23)[debug.getupvalue(genv.Hyphon_2247, 24)],
            [11] = Emulator_Data.RemoteFunction["Token Four"],
            [12] = { ["CurrentTick"] = genv.Hyphon_Encode(tostring(tick())), ["Tablets"] = Emulator_Data.RemoteFunction["Tablets"] },
            [13] = { ["LuaFunction"] = Emulator_Data.RemoteFunction["LuaFunction"], ["SSL"] = Emulator_Data.RemoteFunction["SSL"], ["Metatable code"] = genv.Hyphon_Encode("nil") },
        })
    end
    task.wait(35 - (tick() - Emulator_Data.RemoteFunction["Tick"]))
    while true do task.spawn(DoRemoteFunction) task.wait(35) end
end)

task.spawn(function()
    local function DoHyphonCheck()
        local HC = Emulator_Data.Hyphon_Check["Hyphon_Check"]
        local HV = Emulator_Data.Hyphon_Check["Handshake_Version"]
        HC:FireServer(tick(), HV)
        task.wait(.1)
        HC:FireServer()
    end
    task.wait(9 - (tick() - Emulator_Data.Hyphon_Check["Tick"]))
    while true do task.spawn(DoHyphonCheck) task.wait(9) end
end)

genv.HyphonReady = true
end

-- ─────────────────────────────────────────
-- CLEANUP LAMA
-- ─────────────────────────────────────────
pcall(function()
    if PGui:FindFirstChild("0xNyxGUI") then
        PGui:FindFirstChild("0xNyxGUI"):Destroy()
    end
end)
pcall(function()
    if _G._NyxMain then _G._NyxMain:Disconnect() end
end)
pcall(function()
    if _G._NyxKey then _G._NyxKey:Disconnect() end
end)

-- ─────────────────────────────────────────
-- SNAPSHOT LIGHTING
-- ─────────────────────────────────────────
local lightProps = {
    "Brightness","ClockTime","FogEnd","FogStart","FogColor",
    "GlobalShadows","Ambient","OutdoorAmbient","ShadowSoftness",
    "EnvironmentDiffuseScale","EnvironmentSpecularScale","ExposureCompensation"
}
local OrigLight = {}
for _, p in ipairs(lightProps) do
    pcall(function() OrigLight[p] = Lighting[p] end)
end

local OrigEffects = {}
for _, e in ipairs(Lighting:GetChildren()) do
    if e:IsA("PostEffect") or e:IsA("Sky") then
        pcall(function() OrigEffects[e] = e.Enabled end)
    end
end

local PTYPES = {ParticleEmitter=1,Trail=1,Smoke=1,Fire=1,Sparkles=1,Beam=1}
local OrigParticles = {}
for _, o in ipairs(Workspace:GetDescendants()) do
    if PTYPES[o.ClassName] then
        pcall(function() OrigParticles[o] = o.Enabled end)
    end
end

-- ─────────────────────────────────────────
-- STATE
-- ─────────────────────────────────────────
local ON       = false   -- optimize state
local DEBN     = false   -- debounce tombol
local UIVisible= true    -- UI visible state
local watchConn= nil

-- ─────────────────────────────────────────
-- DETEKSI DEVICE
-- ─────────────────────────────────────────
local kentang = (function()
    local touch = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local ok, mem = pcall(function() return game:GetService("Stats"):GetTotalMemoryUsageMb() end)
    return touch and ok and mem < 1800
end)()
local fpsTarget = 60+

-- ─────────────────────────────────────────
-- FPS UNLOCK — setfpscap only
-- ─────────────────────────────────────────
local function tryFPS(cap)
    pcall(function() if setfpscap then setfpscap(cap) end end)
    pcall(function() if syn and syn.setfpscap then syn.setfpscap(cap) end end)
    pcall(function() if KRNL_LOADED and setfpscap then setfpscap(cap) end end)
end

-- ─────────────────────────────────────────
-- OPTIMIZE
-- ─────────────────────────────────────────
local function applyOpti()
    pcall(function() Lighting.GlobalShadows            = false end)
    pcall(function() Lighting.FogEnd                   = 9e8  end)
    pcall(function() Lighting.FogStart                 = 9e8  end)
    pcall(function() Lighting.Brightness               = 1    end)
    pcall(function() Lighting.Ambient                  = Color3.fromRGB(178,178,178) end)
    pcall(function() Lighting.OutdoorAmbient           = Color3.fromRGB(128,128,128) end)
    pcall(function() Lighting.ShadowSoftness           = 0    end)
    pcall(function() Lighting.EnvironmentDiffuseScale  = 0    end)
    pcall(function() Lighting.EnvironmentSpecularScale = 0    end)
    pcall(function() Lighting.ExposureCompensation     = 0    end)

    for _, e in ipairs(Lighting:GetChildren()) do
        if e:IsA("PostEffect") or e:IsA("Sky") then
            pcall(function() e.Enabled = false end)
        end
    end

    pcall(function() Workspace.Terrain.WaterWaveSize     = 0 end)
    pcall(function() Workspace.Terrain.WaterWaveSpeed    = 0 end)
    pcall(function() Workspace.Terrain.WaterReflectance  = 0 end)
    pcall(function() Workspace.Terrain.WaterTransparency = 1 end)
    pcall(function() Workspace.Terrain.Decoration        = false end)

    for _, o in ipairs(Workspace:GetDescendants()) do
        if PTYPES[o.ClassName] then
            pcall(function() o.Enabled = false end)
        end
    end

    if watchConn then pcall(function() watchConn:Disconnect() end) end
    watchConn = Workspace.DescendantAdded:Connect(function(o)
        if PTYPES[o.ClassName] then
            task.defer(function() pcall(function() o.Enabled = false end) end)
        end
    end)

    tryFPS(fpsTarget)
end

local function restoreOpti()
    for _, p in ipairs(lightProps) do
        if OrigLight[p] ~= nil then
            pcall(function() Lighting[p] = OrigLight[p] end)
        end
    end
    for e, was in pairs(OrigEffects) do
        pcall(function() if e and e.Parent then e.Enabled = was end end)
    end
    pcall(function() Workspace.Terrain.Decoration        = true  end)
    pcall(function() Workspace.Terrain.WaterWaveSize     = 0.15  end)
    pcall(function() Workspace.Terrain.WaterWaveSpeed    = 10    end)
    pcall(function() Workspace.Terrain.WaterReflectance  = 0.1   end)
    pcall(function() Workspace.Terrain.WaterTransparency = 0.3   end)
    for o, was in pairs(OrigParticles) do
        pcall(function() if o and o.Parent then o.Enabled = was end end)
    end
    if watchConn then pcall(function() watchConn:Disconnect() end) watchConn = nil end
    tryFPS(60)
end

-- ─────────────────────────────────────────
-- GRADIENT PALETTE
-- merah → pink → putih pink → peach → pink → merah
-- ─────────────────────────────────────────
local GRAD = {
    Color3.fromRGB(220, 40,  70),
    Color3.fromRGB(255, 100, 130),
    Color3.fromRGB(255, 180, 195),
    Color3.fromRGB(255, 225, 200),
    Color3.fromRGB(255, 160, 180),
    Color3.fromRGB(220, 40,  70),
}

-- ─────────────────────────────────────────
-- BUILD GUI
-- ─────────────────────────────────────────
local MainFrame, BtnRef, StatRef, FPSLbl, PingLbl, NameLbl, HintLbl

local function toggle()
    if DEBN then return end
    DEBN = true
    ON = not ON
    if ON then
        applyOpti()
        BtnRef.Text             = "⚡ ON — ACTIVE"
        BtnRef.BackgroundColor3 = Color3.fromRGB(190, 35, 65)
        StatRef.Text            = "🔥 FPS Target: " .. fpsTarget
        StatRef.TextColor3      = Color3.fromRGB(255, 160, 180)
    else
        restoreOpti()
        BtnRef.Text             = "🎮 OFF — OPTIMIZE"
        BtnRef.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
        StatRef.Text            = "Status: Standby"
        StatRef.TextColor3      = Color3.fromRGB(170, 170, 170)
    end
    task.delay(0.35, function() DEBN = false end)
end

local function buildGUI()
    local G = Instance.new("ScreenGui")
    G.Name           = "NyxGUI"
    G.ResetOnSpawn   = false
    G.DisplayOrder   = 9999
    G.IgnoreGuiInset = true
    G.Parent         = PGui

    -- MAIN FRAME
    local F = Instance.new("Frame", G)
    F.Name                   = "Main"
    F.Size                   = UDim2.new(0, 225, 0, 195)
    F.Position               = UDim2.new(1, -233, 0.5, -97)
    F.BackgroundColor3       = Color3.fromRGB(13, 9, 15)
    F.BackgroundTransparency = 0.04
    F.BorderSizePixel        = 0
    F.Active                 = true
    F.Draggable              = true
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 14)
    local fS = Instance.new("UIStroke", F)
    fS.Color = Color3.fromRGB(215, 40, 75)
    fS.Thickness = 1.8
    fS.Transparency = 0.18
    MainFrame = F

    -- HEADER BG merah
    local HBg = Instance.new("Frame", F)
    HBg.Size             = UDim2.new(1, 0, 0, 44)
    HBg.BackgroundColor3 = Color3.fromRGB(170, 28, 52)
    HBg.BorderSizePixel  = 0
    Instance.new("UICorner", HBg).CornerRadius = UDim.new(0, 14)

    -- Header overlay kanan (peach/pink)
    local HO = Instance.new("Frame", HBg)
    HO.Size                  = UDim2.new(0.5, 0, 1, 0)
    HO.Position              = UDim2.new(0.5, 0, 0, 0)
    HO.BackgroundColor3      = Color3.fromRGB(255, 175, 190)
    HO.BackgroundTransparency= 0.18
    HO.BorderSizePixel       = 0
    Instance.new("UICorner", HO).CornerRadius = UDim.new(0, 14)

    -- Nama 0xNyx
    local NL = Instance.new("TextLabel", HBg)
    NL.Size                  = UDim2.new(0.6, 0, 1, 0)
    NL.Position              = UDim2.new(0, 10, 0, 0)
    NL.BackgroundTransparency= 1
    NL.Text                  = "0xNyx"
    NL.TextColor3            = Color3.fromRGB(255, 255, 255)
    NL.TextSize              = 21
    NL.Font                  = Enum.Font.GothamBold
    NL.TextXAlignment        = Enum.TextXAlignment.Left
    NameLbl = NL

    -- Sub kanan
    local SB = Instance.new("TextLabel", HBg)
    SB.Size                  = UDim2.new(0.4, -8, 1, 0)
    SB.Position              = UDim2.new(0.6, 0, 0, 0)
    SB.BackgroundTransparency= 1
    SB.Text                  = "Optimizer"
    SB.TextColor3            = Color3.fromRGB(255, 215, 225)
    SB.TextSize              = 10
    SB.Font                  = Enum.Font.Gotham
    SB.TextXAlignment        = Enum.TextXAlignment.Right

    -- Garis separator
    local Ln = Instance.new("Frame", F)
    Ln.Size             = UDim2.new(1, -16, 0, 2)
    Ln.Position         = UDim2.new(0, 8, 0, 46)
    Ln.BackgroundColor3 = Color3.fromRGB(215, 40, 75)
    Ln.BorderSizePixel  = 0
    Instance.new("UICorner", Ln).CornerRadius = UDim.new(1, 0)
    local LnR = Instance.new("Frame", Ln)
    LnR.Size             = UDim2.new(0.5, 0, 1, 0)
    LnR.Position         = UDim2.new(0.5, 0, 0, 0)
    LnR.BackgroundColor3 = Color3.fromRGB(255, 200, 210)
    LnR.BorderSizePixel  = 0
    Instance.new("UICorner", LnR).CornerRadius = UDim.new(1, 0)

    -- Device info
    local DL = Instance.new("TextLabel", F)
    DL.Size                  = UDim2.new(1,-14,0,15)
    DL.Position              = UDim2.new(0,7,0,52)
    DL.BackgroundTransparency= 1
    DL.Text                  = (kentang and "📱 Kentang" or "💻 Bagus") .. "  •  FPS: " .. fpsTarget
    DL.TextColor3            = Color3.fromRGB(255, 185, 200)
    DL.TextSize              = 10
    DL.Font                  = Enum.Font.Gotham
    DL.TextXAlignment        = Enum.TextXAlignment.Left

    -- Status
    local SL = Instance.new("TextLabel", F)
    SL.Size                  = UDim2.new(1,-14,0,15)
    SL.Position              = UDim2.new(0,7,0,68)
    SL.BackgroundTransparency= 1
    SL.Text                  = "Status: Standby"
    SL.TextColor3            = Color3.fromRGB(170,170,170)
    SL.TextSize              = 10
    SL.Font                  = Enum.Font.Gotham
    SL.TextXAlignment        = Enum.TextXAlignment.Left
    StatRef = SL

    -- TOMBOL UTAMA
    local Btn = Instance.new("TextButton", F)
    Btn.Size             = UDim2.new(1,-14,0,50)
    Btn.Position         = UDim2.new(0,7,0,87)
    Btn.BackgroundColor3 = Color3.fromRGB(38,38,46)
    Btn.TextColor3       = Color3.fromRGB(255,255,255)
    Btn.Text             = "🎮 OFF — OPTIMIZE"
    Btn.TextSize         = 15
    Btn.Font             = Enum.Font.GothamBold
    Btn.BorderSizePixel  = 0
    Btn.AutoButtonColor  = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    local bS = Instance.new("UIStroke", Btn)
    bS.Color = Color3.fromRGB(215, 70, 100)
    bS.Thickness = 1.2
    bS.Transparency = 0.38
    BtnRef = Btn

    Btn.MouseEnter:Connect(function()
        if not ON then
            pcall(function()
                TweenService:Create(Btn, TweenInfo.new(0.12),
                    {BackgroundColor3 = Color3.fromRGB(60,32,48)}):Play()
            end)
        end
    end)
    Btn.MouseLeave:Connect(function()
        if not ON then
            pcall(function()
                TweenService:Create(Btn, TweenInfo.new(0.12),
                    {BackgroundColor3 = Color3.fromRGB(38,38,46)}):Play()
            end)
        end
    end)
    Btn.MouseButton1Click:Connect(toggle)

    -- LIVE BAR
    local LF = Instance.new("Frame", F)
    LF.Size                   = UDim2.new(1,-14,0,26)
    LF.Position               = UDim2.new(0,7,0,143)
    LF.BackgroundColor3       = Color3.fromRGB(28, 10, 18)
    LF.BackgroundTransparency = 0.08
    LF.BorderSizePixel        = 0
    Instance.new("UICorner", LF).CornerRadius = UDim.new(0, 8)
    local lS = Instance.new("UIStroke", LF)
    lS.Color = Color3.fromRGB(190, 50, 80)
    lS.Thickness = 1
    lS.Transparency = 0.45

    local FL = Instance.new("TextLabel", LF)
    FL.Size                  = UDim2.new(0.5,0,1,0)
    FL.Position              = UDim2.new(0,6,0,0)
    FL.BackgroundTransparency= 1
    FL.Text                  = "FPS: —"
    FL.TextColor3            = Color3.fromRGB(255, 110, 145)
    FL.TextSize              = 12
    FL.Font                  = Enum.Font.GothamBold
    FL.TextXAlignment        = Enum.TextXAlignment.Left
    FPSLbl = FL

    local PL = Instance.new("TextLabel", LF)
    PL.Size                  = UDim2.new(0.5,-6,1,0)
    PL.Position              = UDim2.new(0.5,0,0,0)
    PL.BackgroundTransparency= 1
    PL.Text                  = "Ping: —"
    PL.TextColor3            = Color3.fromRGB(255, 205, 215)
    PL.TextSize              = 12
    PL.Font                  = Enum.Font.GothamBold
    PL.TextXAlignment        = Enum.TextXAlignment.Right
    PingLbl = PL

    -- HINT keybind Z
    local HL = Instance.new("TextLabel", F)
    HL.Size                  = UDim2.new(1,-14,0,13)
    HL.Position              = UDim2.new(0,7,0,173)
    HL.BackgroundTransparency= 1
    HL.Text                  = "[ Z ] Toggle UI"
    HL.TextColor3            = Color3.fromRGB(130, 80, 100)
    HL.TextSize              = 9
    HL.Font                  = Enum.Font.Gotham
    HL.TextXAlignment        = Enum.TextXAlignment.Center
    HintLbl = HL

    return G
end

-- ─────────────────────────────────────────
-- SATU LOOP UTAMA
-- ─────────────────────────────────────────
local gi        = 1
local loopTick  = 0
local pingTick  = 0
local gradTick  = 0
local fpsBuf    = {}

local function startLoop()
    _G._NyxMain = RunService.Heartbeat:Connect(function(dt)
        local now = tick()

        -- FPS: hitung tiap frame
        local fps = math.clamp(math.floor(1 / math.max(dt, 0.0001)), 0, 9999)
        fpsBuf[#fpsBuf+1] = fps
        if #fpsBuf > 12 then table.remove(fpsBuf, 1) end

        -- Update FPS label tiap ~0.1s
        if now - loopTick >= 0.1 then
            loopTick = now
            local s = 0
            for _, v in ipairs(fpsBuf) do s = s + v end
            local avg = math.floor(s / math.max(#fpsBuf, 1))
            pcall(function()
                FPSLbl.Text = "FPS: " .. avg
                FPSLbl.TextColor3 = avg >= 55
                    and Color3.fromRGB(255, 110, 145)
                    or  avg >= 30
                    and Color3.fromRGB(255, 190, 140)
                    or  Color3.fromRGB(200, 35, 55)
            end)
        end

        -- Ping tiap 0.6s
        if now - pingTick >= 0.6 then
            pingTick = now
            local ok, p = pcall(function()
                return math.floor(Client:GetNetworkPing() * 1000)
            end)
            if ok then
                pcall(function()
                    PingLbl.Text = "Ping: " .. p .. "ms"
                    PingLbl.TextColor3 = p < 80
                        and Color3.fromRGB(255, 200, 215)
                        or  p < 150
                        and Color3.fromRGB(255, 170, 110)
                        or  Color3.fromRGB(200, 35, 55)
                end)
            end
        end

        -- Gradient nama tiap 0.65s
        if now - gradTick >= 0.65 then
            gradTick = now
            gi = (gi % #GRAD) + 1
            pcall(function()
                TweenService:Create(NameLbl,
                    TweenInfo.new(0.6, Enum.EasingStyle.Sine),
                    {TextColor3 = GRAD[gi]}
                ):Play()
            end)
        end
    end)
end

-- ─────────────────────────────────────────
-- KEYBIND Z — toggle show/hide UI
-- ─────────────────────────────────────────
local function startKeybind()
    _G._NyxKey = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end  -- abaikan kalau lagi ketik di chat
        if input.KeyCode == Enum.KeyCode.Z then
            UIVisible = not UIVisible
            pcall(function()
                MainFrame.Visible = UIVisible
            end)
            -- Kalau muncul lagi, tunjukkan hint singkat
            if UIVisible then
                print("[0xNyx] UI dibuka (Z)")
            else
                print("[0xNyx] UI disembunyikan (Z)")
            end
        end
    end)
end

-- ─────────────────────────────────────────
-- RUN
-- ─────────────────────────────────────────
tryFPS(60)
buildGUI()
startLoop()
startKeybind()    -- keybind mode (z)

print("[0xNyx v6] Ready | " .. (kentang and "Kentang" or "Bagus") .. " | FPS: " .. fpsTarget)
print("[0xNyx v6] Tekan Z untuk sembunyikan/tampilkan UI")