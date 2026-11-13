-- PS99 Sniper · Arceus X Neo Fix · LO build ♥

local RS    = game:GetService("ReplicatedStorage")
local RunS  = game:GetService("RunService")
local Plrs  = game:GetService("Players")
local LP    = Plrs.LocalPlayer

-- Executor GUI parent — gethui() öncelikli
local function getGuiParent()
    if gethui then return gethui() end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return LP:WaitForChild("PlayerGui")
end

local PURPLE = Color3.fromRGB(90, 45, 180)
local DARK   = Color3.fromRGB(12, 12, 18)
local GREEN  = Color3.fromRGB(80, 220, 130)
local RED    = Color3.fromRGB(200, 60, 60)
local WHITE  = Color3.new(1,1,1)
local GREY   = Color3.fromRGB(160, 160, 170)

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
end

local function mklabel(parent, text, size, color, posY, bold)
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

local function mkbox(parent, placeholder, posY)
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

local function mkbtn(parent, text, color, posY, h)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -16, 0, h or 34)
    b.Position = UDim2.new(0, 8, 0, posY)
    b.BackgroundColor3 = color
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Text = text
    b.Parent = parent
    corner(b, 7)
    return b
end

-- ══════════════════════════════════
--  SCREEN GUI
-- ══════════════════════════════════
local SG = Instance.new("ScreenGui")
SG.Name = "PS99Sniper_LO"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ok2, err2 = pcall(function()
    SG.Parent = getGuiParent()
end)
if not ok2 then
    SG.Parent = LP:WaitForChild("PlayerGui")
end

-- ══════════════════════════════════
--  CONFIG FRAME
-- ══════════════════════════════════
local CF = Instance.new("Frame")
CF.Size = UDim2.new(0, 280, 0, 262)
CF.Position = UDim2.new(0.5, -140, 0.5, -131)
CF.BackgroundColor3 = DARK
CF.BorderSizePixel = 0
CF.Parent = SG
corner(CF, 12)

local cBar = Instance.new("Frame")
cBar.Size = UDim2.new(1, 0, 0, 36)
cBar.BackgroundColor3 = PURPLE
cBar.BorderSizePixel = 0
cBar.Parent = CF
corner(cBar, 12)

local cFix = Instance.new("Frame")
cFix.Size = UDim2.new(1, 0, 0, 12)
cFix.Position = UDim2.new(0, 0, 1, -12)
cFix.BackgroundColor3 = PURPLE
cFix.BorderSizePixel = 0
cFix.Parent = cBar

local cTitle = Instance.new("TextLabel")
cTitle.Size = UDim2.new(1, 0, 1, 0)
cTitle.BackgroundTransparency = 1
cTitle.Text = "🎯  PS99 Sniper"
cTitle.TextColor3 = WHITE
cTitle.Font = Enum.Font.GothamBold
cTitle.TextSize = 14
cTitle.Parent = cBar

mklabel(CF, "Item Adı", 11, GREY, 44)
local itemInput  = mkbox(CF, "örn: Treat Magnet", 62)

mklabel(CF, "Maksimum Fiyat (Gems)", 11, GREY, 102)
local priceInput = mkbox(CF, "örn: 300000", 120)

mklabel(CF, "Eşleşme Tipi", 11, GREY, 160)

local tFrame = Instance.new("Frame")
tFrame.Size = UDim2.new(1, -16, 0, 28)
tFrame.Position = UDim2.new(0, 8, 0, 178)
tFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
tFrame.Parent = CF
corner(tFrame, 6)

local exactMode = false

local fuzzyB = Instance.new("TextButton")
fuzzyB.Size = UDim2.new(0.5, -2, 1, 0)
fuzzyB.Position = UDim2.new(0, 2, 0, 0)
fuzzyB.BackgroundColor3 = PURPLE
fuzzyB.TextColor3 = WHITE
fuzzyB.Font = Enum.Font.GothamBold
fuzzyB.TextSize = 11
fuzzyB.Text = "İçerik Ara"
fuzzyB.Parent = tFrame
corner(fuzzyB, 5)

local exactB = Instance.new("TextButton")
exactB.Size = UDim2.new(0.5, -2, 1, 0)
exactB.Position = UDim2.new(0.5, 0, 0, 0)
exactB.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
exactB.TextColor3 = GREY
exactB.Font = Enum.Font.Gotham
exactB.TextSize = 11
exactB.Text = "Tam Eşleşme"
exactB.Parent = tFrame
corner(exactB, 5)

fuzzyB.MouseButton1Click:Connect(function()
    exactMode = false
    fuzzyB.BackgroundColor3 = PURPLE; fuzzyB.TextColor3 = WHITE; fuzzyB.Font = Enum.Font.GothamBold
    exactB.BackgroundColor3 = Color3.fromRGB(30,30,45); exactB.TextColor3 = GREY; exactB.Font = Enum.Font.Gotham
end)
exactB.MouseButton1Click:Connect(function()
    exactMode = true
    exactB.BackgroundColor3 = PURPLE; exactB.TextColor3 = WHITE; exactB.Font = Enum.Font.GothamBold
    fuzzyB.BackgroundColor3 = Color3.fromRGB(30,30,45); fuzzyB.TextColor3 = GREY; fuzzyB.Font = Enum.Font.Gotham
end)

local startBtn = mkbtn(CF, "▶  SNIPER BAŞLAT", GREEN, 218, 36)

-- ══════════════════════════════════
--  STATUS FRAME
-- ══════════════════════════════════
local SF = Instance.new("Frame")
SF.Size = UDim2.new(0, 260, 0, 185)
SF.Position = UDim2.new(0, 10, 0.5, -92)
SF.BackgroundColor3 = DARK
SF.BorderSizePixel = 0
SF.Visible = false
SF.Parent = SG
corner(SF, 12)

local sBar = Instance.new("Frame")
sBar.Size = UDim2.new(1, 0, 0, 36)
sBar.BackgroundColor3 = PURPLE
sBar.BorderSizePixel = 0
sBar.Parent = SF
corner(sBar, 12)

local sBarFix = Instance.new("Frame")
sBarFix.Size = UDim2.new(1, 0, 0, 12)
sBarFix.Position = UDim2.new(0, 0, 1, -12)
sBarFix.BackgroundColor3 = PURPLE
sBarFix.BorderSizePixel = 0
sBarFix.Parent = sBar

local sTitle = Instance.new("TextLabel")
sTitle.Size = UDim2.new(1, 0, 1, 0)
sTitle.BackgroundTransparency = 1
sTitle.Text = "🎯  PS99 Sniper · Aktif"
sTitle.TextColor3 = WHITE
sTitle.Font = Enum.Font.GothamBold
sTitle.TextSize = 13
sTitle.Parent = sBar

local sItemLbl   = mklabel(SF, "🔍  Item: —",     11, GREY,  44)
local sPriceLbl  = mklabel(SF, "💎  Max: —",      11, GREY,  64)
local sStatusLbl = mklabel(SF, "⏸  Bekleniyor",  11, Color3.fromRGB(180,180,255), 90)
local sBoughtLbl = mklabel(SF, "✅  Alınan: 0",   12, GREEN, 112, true)
local stopBtn    = mkbtn(SF, "⏹  DURDUR", RED, 148, 30)

-- Sürükleme
local drag, dInput, dStart, dPos = false, nil, nil, nil
SF.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag=true; dStart=i.Position; dPos=SF.Position
        i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end)
    end
end)
SF.InputChanged:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement then dInput=i end
end)
RunS.RenderStepped:Connect(function()
    if drag and dInput then
        local d = dInput.Position - dStart
        SF.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset+d.X, dPos.Y.Scale, dPos.Y.Offset+d.Y)
    end
end)

-- ══════════════════════════════════
--  SNIPER CORE
-- ══════════════════════════════════
local running    = false
local buyCount   = 0
local lastBuyMap = {}
local CFG        = {}

local GetListings, BuyTrade

local function findRemote(name)
    local Rem = RS:FindFirstChild("Remotes")
    if not Rem then return nil end
    local r = Rem:FindFirstChild(name)
    if r then return r end
    for _, v in ipairs(Rem:GetChildren()) do
        if v.Name:lower():find(name:lower()) then return v end
    end
end

local function setStatus(msg, color)
    sStatusLbl.Text = msg
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
    -- Remote'ları burada bul (GUI zaten açık, hata varsa status'ta göster)
    GetListings = findRemote("GetTradeListings") or findRemote("TradingGetListings") or findRemote("GetListings")
    BuyTrade    = findRemote("BuyTrade") or findRemote("PurchaseTrade") or findRemote("TradeBuy")

    if not GetListings or not BuyTrade then
        setStatus("⚠️ Remote bulunamadı — Trading Plaza'da mısın?", RED)
        running = false
        return
    end

    while running do
        setStatus("🔄  Taranıyor...", Color3.fromRGB(180,180,255))
        local ok, result = pcall(function()
            if GetListings:IsA("RemoteFunction") then
                return GetListings:InvokeServer()
            end
        end)
        if ok and result and type(result) == "table" then
            for _, listing in ipairs(result) do
                local itemName = listing.ItemName or listing.Name or listing.item or listing.petName or ""
                local price    = listing.Price or listing.GemPrice or listing.price or listing.gems or math.huge
                if matchItem(tostring(itemName)) and tonumber(price) <= CFG.MaxPrice then
                    setStatus("🎯 BULUNDU: "..tostring(itemName).." @ "..tostring(price), GREEN)
                    if tryBuy(listing) then
                        buyCount = buyCount + 1
                        sBoughtLbl.Text = "✅  Alınan: "..buyCount
                    end
                end
            end
        else
            setStatus("📭  Liste boş / format farklı", GREY)
        end
        task.wait(0.8)
    end
end

-- ══════════════════════════════════
--  BUTONLAR
-- ══════════════════════════════════
startBtn.MouseButton1Click:Connect(function()
    local itemText  = itemInput.Text:match("^%s*(.-)%s*$")
    local priceText = priceInput.Text:match("^%s*(.-)%s*$")
    local maxPrice  = tonumber(priceText)
    if itemText == "" then itemInput.PlaceholderText = "⚠️ Item adı gir!"; return end
    if not maxPrice then priceInput.PlaceholderText = "⚠️ Sayı gir!"; priceInput.Text = ""; return end

    CFG.TargetItem = itemText
    CFG.MaxPrice   = maxPrice
    CFG.ExactMatch = exactMode

    sItemLbl.Text  = "🔍  Item: "..itemText
    sPriceLbl.Text = "💎  Max: "..tostring(maxPrice).." gems"
    buyCount       = 0
    lastBuyMap     = {}
    sBoughtLbl.Text = "✅  Alınan: 0"

    CF.Visible = false
    SF.Visible = true
    running = true
    task.spawn(scanLoop)
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
    SF.Visible = false
    CF.Visible = true
    itemInput.Text  = CFG.TargetItem or ""
    priceInput.Text = tostring(CFG.MaxPrice or "")
end)

print("[PS99 Sniper] Yüklendi ✓")
