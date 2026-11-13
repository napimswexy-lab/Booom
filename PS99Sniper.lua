-- ╔══════════════════════════════════════════════════════╗
-- ║   Pet Simulator 99 — Trading Plaza Sniper            ║
-- ║   GUI Config · Arceus X Neo Mobile · LO build ♥     ║
-- ╚══════════════════════════════════════════════════════╝

local RS    = game:GetService("ReplicatedStorage")
local RunS  = game:GetService("RunService")
local Plrs  = game:GetService("Players")
local LP    = Plrs.LocalPlayer

-- ══════════════════════════════════════
--   REMOTE KEŞİF
-- ══════════════════════════════════════
local Remotes = RS:WaitForChild("Remotes", 10)
assert(Remotes, "[Sniper] Remotes bulunamadı.")

local function findRemote(name)
    local r = Remotes:FindFirstChild(name)
    if r then return r end
    for _, v in ipairs(Remotes:GetChildren()) do
        if v.Name:lower():find(name:lower()) then return v end
    end
end

local GetListings = findRemote("GetTradeListings") or findRemote("TradingGetListings") or findRemote("GetListings")
local BuyTrade    = findRemote("BuyTrade")         or findRemote("PurchaseTrade")      or findRemote("TradeBuy")

-- ══════════════════════════════════════
--   GUI KURULUM
-- ══════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "PS99Sniper_LO"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent          = LP:WaitForChild("PlayerGui")

local PURPLE  = Color3.fromRGB(90, 45, 180)
local DARK    = Color3.fromRGB(12, 12, 18)
local GREEN   = Color3.fromRGB(80, 220, 130)
local RED     = Color3.fromRGB(200, 60, 60)
local WHITE   = Color3.new(1,1,1)
local GREY    = Color3.fromRGB(160, 160, 170)

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
end

local function label(parent, text, size, color, posY, bold)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -16, 0, 22)
    l.Position = UDim2.new(0, 8, 0, posY)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextSize = size or 12
    l.TextColor3 = color or WHITE
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function inputBox(parent, placeholder, posY)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -16, 0, 32)
    bg.Position = UDim2.new(0, 8, 0, posY)
    bg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    bg.Parent = parent
    corner(bg, 6)

    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(1, -12, 1, 0)
    tb.Position = UDim2.new(0, 6, 0, 0)
    tb.BackgroundTransparency = 1
    tb.PlaceholderText = placeholder
    tb.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
    tb.TextColor3 = WHITE
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 12
    tb.TextXAlignment = Enum.TextXAlignment.Left
    tb.ClearTextOnFocus = false
    tb.Parent = bg
    return tb
end

local function button(parent, text, color, posY, height)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, height or 34)
    btn.Position = UDim2.new(0, 8, 0, posY)
    btn.BackgroundColor3 = color
    btn.TextColor3 = WHITE
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Text = text
    btn.Parent = parent
    corner(btn, 7)
    return btn
end

-- ══════════════════════════════════════
--   CONFIG PANEL (açılış ekranı)
-- ══════════════════════════════════════
local ConfigFrame = Instance.new("Frame")
ConfigFrame.Size = UDim2.new(0, 280, 0, 230)
ConfigFrame.Position = UDim2.new(0.5, -140, 0.5, -115)
ConfigFrame.BackgroundColor3 = DARK
ConfigFrame.BorderSizePixel = 0
ConfigFrame.Parent = ScreenGui
corner(ConfigFrame, 12)

-- Başlık bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = PURPLE
titleBar.Parent = ConfigFrame
corner(titleBar, 12)

-- Alt köşeleri düzelt
local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 10)
titleFix.Position = UDim2.new(0, 0, 1, -10)
titleFix.BackgroundColor3 = PURPLE
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1, 0, 1, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "🎯  PS99 Sniper"
titleLbl.TextColor3 = WHITE
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 14
titleLbl.Parent = titleBar

label(ConfigFrame, "Item Adı", 11, GREY, 44)
local itemInput = inputBox(ConfigFrame, "örn: Treat Magnet", 62)

label(ConfigFrame, "Maksimum Fiyat (Gems)", 11, GREY, 102)
local priceInput = inputBox(ConfigFrame, "örn: 300000", 120)

label(ConfigFrame, "Eşleşme Tipi", 11, GREY, 160)

-- Exact / Fuzzy toggle
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, -16, 0, 28)
toggleFrame.Position = UDim2.new(0, 8, 0, 178)
toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
toggleFrame.Parent = ConfigFrame
corner(toggleFrame, 6)

local exactMode = false

local fuzzyBtn = Instance.new("TextButton")
fuzzyBtn.Size = UDim2.new(0.5, -2, 1, 0)
fuzzyBtn.Position = UDim2.new(0, 2, 0, 0)
fuzzyBtn.BackgroundColor3 = PURPLE
fuzzyBtn.TextColor3 = WHITE
fuzzyBtn.Font = Enum.Font.GothamBold
fuzzyBtn.TextSize = 11
fuzzyBtn.Text = "İçerik Ara"
fuzzyBtn.Parent = toggleFrame
corner(fuzzyBtn, 5)

local exactBtn = Instance.new("TextButton")
exactBtn.Size = UDim2.new(0.5, -2, 1, 0)
exactBtn.Position = UDim2.new(0.5, 0, 0, 0)
exactBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
exactBtn.TextColor3 = GREY
exactBtn.Font = Enum.Font.Gotham
exactBtn.TextSize = 11
exactBtn.Text = "Tam Eşleşme"
exactBtn.Parent = toggleFrame
corner(exactBtn, 5)

fuzzyBtn.MouseButton1Click:Connect(function()
    exactMode = false
    fuzzyBtn.BackgroundColor3 = PURPLE
    fuzzyBtn.TextColor3 = WHITE
    fuzzyBtn.Font = Enum.Font.GothamBold
    exactBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    exactBtn.TextColor3 = GREY
    exactBtn.Font = Enum.Font.Gotham
end)

exactBtn.MouseButton1Click:Connect(function()
    exactMode = true
    exactBtn.BackgroundColor3 = PURPLE
    exactBtn.TextColor3 = WHITE
    exactBtn.Font = Enum.Font.GothamBold
    fuzzyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    fuzzyBtn.TextColor3 = GREY
    fuzzyBtn.Font = Enum.Font.Gotham
end)

-- ══════════════════════════════════════
--   STATUS PANEL (sniper çalışırken)
-- ══════════════════════════════════════
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(0, 260, 0, 180)
StatusFrame.Position = UDim2.new(0, 10, 0.5, -90)
StatusFrame.BackgroundColor3 = DARK
StatusFrame.BorderSizePixel = 0
StatusFrame.Visible = false
StatusFrame.Parent = ScreenGui
corner(StatusFrame, 12)

local sBar = Instance.new("Frame")
sBar.Size = UDim2.new(1, 0, 0, 36)
sBar.BackgroundColor3 = PURPLE
sBar.Parent = StatusFrame
corner(sBar, 12)

local sBarFix = Instance.new("Frame")
sBarFix.Size = UDim2.new(1, 0, 0, 10)
sBarFix.Position = UDim2.new(0, 0, 1, -10)
sBarFix.BackgroundColor3 = PURPLE
sBarFix.BorderSizePixel = 0
sBarFix.Parent = sBar

local sTitleLbl = Instance.new("TextLabel")
sTitleLbl.Size = UDim2.new(1, 0, 1, 0)
sTitleLbl.BackgroundTransparency = 1
sTitleLbl.Text = "🎯  PS99 Sniper · Aktif"
sTitleLbl.TextColor3 = WHITE
sTitleLbl.Font = Enum.Font.GothamBold
sTitleLbl.TextSize = 13
sTitleLbl.Parent = sBar

local sItemLbl   = label(StatusFrame, "🔍  Item: —",    11, GREY,  44)
local sPriceLbl  = label(StatusFrame, "💎  Max: —",     11, GREY,  64)
local sStatusLbl = label(StatusFrame, "⏸  Bekleniyor", 11, Color3.fromRGB(180,180,255), 90)
local sBoughtLbl = label(StatusFrame, "✅  Alınan: 0",  12, GREEN, 112, true)

local stopBtn = button(StatusFrame, "⏹  DURDUR", RED, 142, 30)

-- Sürükleme (status panel)
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
StatusFrame.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = inp.Position; startPos = StatusFrame.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
StatusFrame.InputChanged:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = inp
    end
end)
RunS.RenderStepped:Connect(function()
    if dragging and dragInput then
        local d = dragInput.Position - dragStart
        StatusFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- ══════════════════════════════════════
--   SNIPER CORE
-- ══════════════════════════════════════
local running    = false
local buyCount   = 0
local lastBuyMap = {}
local CFG        = {}

local function setStatus(msg, color)
    sStatusLbl.Text       = msg
    sStatusLbl.TextColor3 = color or Color3.fromRGB(180,180,255)
end

local function tryBuy(listing)
    local id = tostring(listing.TradeId or listing.Id or listing.id or "")
    if lastBuyMap[id] then return false end
    lastBuyMap[id] = true
    pcall(function() BuyTrade:FireServer(listing) end)
    pcall(function() BuyTrade:FireServer(id) end)
    return true
end

local function matchItem(name)
    if CFG.ExactMatch then
        return name:lower() == CFG.TargetItem:lower()
    else
        return name:lower():find(CFG.TargetItem:lower(), 1, true) ~= nil
    end
end

local function scanLoop()
    while running do
        setStatus("🔄  Taranıyor...", Color3.fromRGB(180,180,255))
        local ok, result = pcall(function()
            if GetListings and GetListings:IsA("RemoteFunction") then
                return GetListings:InvokeServer()
            end
        end)
        if ok and result and type(result) == "table" then
            for _, listing in ipairs(result) do
                local itemName = listing.ItemName or listing.Name or listing.item or listing.petName or ""
                local price    = listing.Price    or listing.GemPrice or listing.price or listing.gems or math.huge
                if matchItem(tostring(itemName)) and tonumber(price) <= CFG.MaxPrice then
                    setStatus("🎯 BULUNDU: " .. tostring(itemName) .. " @ " .. tostring(price), GREEN)
                    if tryBuy(listing) then
                        buyCount = buyCount + 1
                        sBoughtLbl.Text = "✅  Alınan: " .. buyCount
                        print(string.format("[Sniper] ALINDI → %s | %s gems", tostring(itemName), tostring(price)))
                    end
                end
            end
        else
            setStatus("📭  Liste boş / format uyumsuz", GREY)
        end
        task.wait(0.8)
    end
end

-- ══════════════════════════════════════
--   BAŞLAT BUTONU (config panel)
-- ══════════════════════════════════════
local startBtn = button(ConfigFrame, "▶  SNIPER BAŞLAT", GREEN, 214, 36)
-- Paneli büyüt
ConfigFrame.Size = UDim2.new(0, 280, 0, 258)

startBtn.MouseButton1Click:Connect(function()
    local itemText  = itemInput.Text:match("^%s*(.-)%s*$")
    local priceText = priceInput.Text:match("^%s*(.-)%s*$")
    local maxPrice  = tonumber(priceText)

    if itemText == "" then
        itemInput.PlaceholderText = "⚠️ Item adı gir!"
        return
    end
    if not maxPrice then
        priceInput.PlaceholderText = "⚠️ Sayı gir!"
        priceInput.Text = ""
        return
    end

    CFG.TargetItem = itemText
    CFG.MaxPrice   = maxPrice
    CFG.ExactMatch = exactMode

    sItemLbl.Text  = "🔍  Item: " .. itemText
    sPriceLbl.Text = "💎  Max: " .. tostring(maxPrice) .. " gems"
    buyCount       = 0
    lastBuyMap     = {}
    sBoughtLbl.Text = "✅  Alınan: 0"

    ConfigFrame.Visible = false
    StatusFrame.Visible = true

    running = true
    task.spawn(scanLoop)
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
    StatusFrame.Visible = false
    ConfigFrame.Visible = true
    itemInput.Text  = CFG.TargetItem or ""
    priceInput.Text = tostring(CFG.MaxPrice or "")
    setStatus("⏸  Durduruldu", GREY)
end)

print("[PS99 Sniper] GUI yüklendi ✓")
