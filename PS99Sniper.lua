-- PS99 Sniper · Hop-Persistent · LO ♥

local RS   = game:GetService("ReplicatedStorage")
local TS   = game:GetService("TeleportService")
local LP   = game.Players.LocalPlayer

local PURPLE = Color3.fromRGB(90, 45, 180)
local DARK   = Color3.fromRGB(12, 12, 18)
local GREEN  = Color3.fromRGB(80, 220, 130)
local RED    = Color3.fromRGB(200, 60, 60)
local YELLOW = Color3.fromRGB(255, 210, 60)
local WHITE  = Color3.new(1,1,1)
local GREY   = Color3.fromRGB(160, 160, 170)

if not _G.PS99_PlaceId then
    _G.PS99_PlaceId = game.PlaceId
end

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
end

local SG = Instance.new("ScreenGui")
SG.Name       = "PS99Sniper"
SG.ResetOnSpawn = false
SG.DisplayOrder = 999
pcall(function() SG.Parent = game:GetService("CoreGui") end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

-- protect_gui varsa kullan (Synapse / KRNL vb.)
pcall(function()
    if syn then syn.protect_gui(SG)
    elseif protect_gui then protect_gui(SG) end
end)

local function mkLabel(par, txt, posY, color, bold, size, wrap)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-16,0, wrap and 30 or 20)
    l.Position = UDim2.new(0,8,0,posY)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextSize = size or 11
    l.TextColor3 = color or GREY
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextWrapped = wrap or false
    l.Parent = par
    return l
end

local function mkInput(par, hint, posY)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,-16,0,32)
    bg.Position = UDim2.new(0,8,0,posY)
    bg.BackgroundColor3 = Color3.fromRGB(25,25,35)
    bg.Parent = par
    corner(bg,6)
    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(1,-12,1,0)
    tb.Position = UDim2.new(0,6,0,0)
    tb.BackgroundTransparency = 1
    tb.PlaceholderText = hint
    tb.PlaceholderColor3 = Color3.fromRGB(90,90,100)
    tb.TextColor3 = WHITE
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 12
    tb.TextXAlignment = Enum.TextXAlignment.Left
    tb.ClearTextOnFocus = false
    tb.Parent = bg
    return tb
end

local function mkBtn(par, txt, color, posY, h)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-16,0,h or 34)
    b.Position = UDim2.new(0,8,0,posY)
    b.BackgroundColor3 = color
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Text = txt
    b.Parent = par
    corner(b,7)
    return b
end

-- ══════════════════════════════════
--  CONFIG FRAME
-- ══════════════════════════════════
local CF = Instance.new("Frame")
CF.Size = UDim2.new(0,280,0,235)
CF.Position = UDim2.new(0.5,-140,0.5,-117)
CF.BackgroundColor3 = DARK
CF.BorderSizePixel = 0
CF.Parent = SG
corner(CF,12)

local cBar = Instance.new("Frame")
cBar.Size = UDim2.new(1,0,0,36)
cBar.BackgroundColor3 = PURPLE
cBar.BorderSizePixel = 0
cBar.Parent = CF
corner(cBar,12)

local cBarFix = Instance.new("Frame")
cBarFix.Size = UDim2.new(1,0,0,12)
cBarFix.Position = UDim2.new(0,0,1,-12)
cBarFix.BackgroundColor3 = PURPLE
cBarFix.BorderSizePixel = 0
cBarFix.Parent = cBar

local cTitle = Instance.new("TextLabel")
cTitle.Size = UDim2.new(1,0,1,0)
cTitle.BackgroundTransparency = 1
cTitle.Text = "🎯  PS99 Sniper"
cTitle.TextColor3 = WHITE
cTitle.Font = Enum.Font.GothamBold
cTitle.TextSize = 14
cTitle.Parent = cBar

mkLabel(CF, "Item Adı", 44)
local itemInput = mkInput(CF, "örn: Treat Magnet", 64)
mkLabel(CF, "Maksimum Fiyat (Gems)", 104)
local priceInput = mkInput(CF, "örn: 300000", 124)
mkLabel(CF, "⚠️  Bulunca ses + ekranda gösterir, sen alırsın", 165, YELLOW, false, 10, true)
local startBtn = mkBtn(CF, "▶  SNIPER BAŞLAT", PURPLE, 193, 36)

-- ══════════════════════════════════
--  STATUS FRAME
-- ══════════════════════════════════
local SF = Instance.new("Frame")
SF.Size = UDim2.new(0,265,0,210)
SF.Position = UDim2.new(0.5,-132,0.5,-105)
SF.BackgroundColor3 = DARK
SF.BorderSizePixel = 0
SF.Visible = false
SF.Parent = SG
corner(SF,12)

local sBar = Instance.new("Frame")
sBar.Size = UDim2.new(1,0,0,36)
sBar.BackgroundColor3 = PURPLE
sBar.BorderSizePixel = 0
sBar.Parent = SF
corner(sBar,12)

local sBarFix = Instance.new("Frame")
sBarFix.Size = UDim2.new(1,0,0,12)
sBarFix.Position = UDim2.new(0,0,1,-12)
sBarFix.BackgroundColor3 = PURPLE
sBarFix.BorderSizePixel = 0
sBarFix.Parent = sBar

local sTitleL = Instance.new("TextLabel")
sTitleL.Size = UDim2.new(1,0,1,0)
sTitleL.BackgroundTransparency = 1
sTitleL.Text = "🎯  PS99 Sniper"
sTitleL.TextColor3 = WHITE
sTitleL.Font = Enum.Font.GothamBold
sTitleL.TextSize = 13
sTitleL.Parent = sBar

local sItemL   = mkLabel(SF, "🔍  Item: —",         44, WHITE)
local sPriceL  = mkLabel(SF, "💎  Max: —",           66, WHITE)
local sStatusL = mkLabel(SF, "🔄  Başlatılıyor...", 90,  Color3.fromRGB(180,180,255))
local sFoundL  = mkLabel(SF, "",                     112, GREEN, true, 12, true)
sFoundL.Size   = UDim2.new(1,-16,0,36)
local sServerL = mkLabel(SF, "🌐  Hop: 0",           152, GREY)
local stopBtn  = mkBtn(SF, "⏹  DURDUR", RED, 170, 32)

-- ══════════════════════════════════
--  CORE
-- ══════════════════════════════════
local running  = false
local hopCount = 0
local CFG      = {}

local function setStatus(msg, color)
    sStatusL.Text = msg
    sStatusL.TextColor3 = color or Color3.fromRGB(180,180,255)
end

local function playAlert()
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://131961136"
        s.Volume  = 1
        s.Parent  = workspace
        s:Play()
        game:GetService("Debris"):AddItem(s, 3)
    end)
end

local function hopServer()
    hopCount = hopCount + 1
    sServerL.Text = "🌐  Hop: "..hopCount
    setStatus("🚀  Hop ediliyor...", YELLOW)

    -- Durumu teleport'tan önce _G'ye yaz — reinject sonrası kaldığı yerden devam eder
    _G.PS99_Config = {
        TargetItem  = CFG.TargetItem,
        MaxPrice    = CFG.MaxPrice,
        HopCount    = hopCount,
        AutoResume  = true,
    }

    task.wait(0.5)
    pcall(function()
        TS:SetTeleportGui(SG)          -- GUI yükleme ekranında görünür kalsın
        TS:Teleport(_G.PS99_PlaceId, LP)
    end)
end

local function findListingRemote()
    for _, v in ipairs(RS:GetDescendants()) do
        if v:IsA("RemoteFunction") then
            local ok, result = pcall(function() return v:InvokeServer() end)
            if ok and type(result) == "table" and #result > 0 and type(result[1]) == "table" then
                return v, result
            end
        end
    end
    return nil, nil
end

local function scanLoop()
    setStatus("🔍  Remote aranıyor...", YELLOW)

    local listingRemote = findListingRemote()

    if not listingRemote then
        setStatus("⚠️  Remote yok — hop", RED)
        task.wait(0.5)
        if running then hopServer() end
        return
    end

    setStatus("✅  "..listingRemote.Name, GREEN)
    task.wait(0.3)

    while running do
        local ok, result = pcall(function()
            return listingRemote:InvokeServer()
        end)

        if ok and result and type(result) == "table" and #result > 0 then
            local found = false
            for _, listing in ipairs(result) do
                local itemName = tostring(
                    listing.ItemName or listing.Name or listing.name or
                    listing.item or listing.petName or listing.PetName or ""
                )
                local price = tonumber(
                    listing.Price or listing.GemPrice or listing.price or
                    listing.gems or listing.Gems or listing.cost or 0
                ) or 0

                if itemName:lower():find(CFG.TargetItem:lower(), 1, true)
                and price > 0 and price <= CFG.MaxPrice then
                    found = true
                    sFoundL.Text = "🎯 "..itemName.."\n💎 "..tostring(price).." gems — AL!"
                    setStatus("🔔  BULUNDU — HEMEN AL!", GREEN)
                    playAlert()
                end
            end

            if not found then
                sFoundL.Text = ""
                setStatus("🔄  "..#result.." listing — eşleşme yok", GREY)
                if running then hopServer() return end
            end
        else
            sFoundL.Text = ""
            setStatus("📭  Boş — hop", GREY)
            if running then hopServer() return end
        end

        task.wait(0.8)
    end
end

local function startSniper(item, maxPrice, fromHop)
    CFG.TargetItem = item
    CFG.MaxPrice   = maxPrice

    sItemL.Text   = "🔍  Item: "..item
    sPriceL.Text  = "💎  Max: "..tostring(maxPrice).." gems"
    sFoundL.Text  = ""
    sServerL.Text = "🌐  Hop: "..hopCount

    CF.Visible = false
    SF.Visible = true
    running    = true
    task.spawn(scanLoop)
end

-- ══════════════════════════════════
--  AUTO-RESUME (hop sonrası reinject)
-- ══════════════════════════════════
if _G.PS99_Config and _G.PS99_Config.AutoResume then
    local saved = _G.PS99_Config
    _G.PS99_Config.AutoResume = false   -- sonsuz döngüyü kır

    hopCount = saved.HopCount or 0
    startSniper(saved.TargetItem, saved.MaxPrice, true)
end

-- ══════════════════════════════════
--  BUTONLAR
-- ══════════════════════════════════
startBtn.MouseButton1Click:Connect(function()
    local itemText = itemInput.Text:match("^%s*(.-)%s*$")
    local maxPrice = tonumber(priceInput.Text)
    if itemText == "" then
        itemInput.PlaceholderText = "⚠️ Item adı gir!"
        return
    end
    if not maxPrice then
        priceInput.Text = ""
        priceInput.PlaceholderText = "⚠️ Sayı gir!"
        return
    end

    hopCount = 0
    startSniper(itemText, maxPrice, false)
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
    if _G.PS99_Config then _G.PS99_Config.AutoResume = false end
    SF.Visible = false
    CF.Visible = true
    itemInput.Text  = CFG.TargetItem or ""
    priceInput.Text = tostring(CFG.MaxPrice or "")
end)

print("[PS99 Sniper] Yüklendi ✓  |  hop-persistent aktif")
