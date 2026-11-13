-- PS99 Sniper · CoreGui Fix · LO build ♥

local RS   = game:GetService("ReplicatedStorage")
local RunS = game:GetService("RunService")
local LP   = game.Players.LocalPlayer

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
    return c
end

local SG = Instance.new("ScreenGui")
SG.Name = "PS99Sniper_LO"
SG.ResetOnSpawn = false
pcall(function() SG.Parent = game:GetService("CoreGui") end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

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

-- Item label + input
local iLbl = Instance.new("TextLabel")
iLbl.Size = UDim2.new(1,-16,0,20)
iLbl.Position = UDim2.new(0,8,0,44)
iLbl.BackgroundTransparency = 1
iLbl.Text = "Item Adı"
iLbl.TextSize = 11
iLbl.TextColor3 = GREY
iLbl.Font = Enum.Font.Gotham
iLbl.TextXAlignment = Enum.TextXAlignment.Left
iLbl.Parent = CF

local iBg = Instance.new("Frame")
iBg.Size = UDim2.new(1,-16,0,32)
iBg.Position = UDim2.new(0,8,0,64)
iBg.BackgroundColor3 = Color3.fromRGB(25,25,35)
iBg.Parent = CF
corner(iBg, 6)

local itemInput = Instance.new("TextBox")
itemInput.Size = UDim2.new(1,-12,1,0)
itemInput.Position = UDim2.new(0,6,0,0)
itemInput.BackgroundTransparency = 1
itemInput.PlaceholderText = "örn: Treat Magnet"
itemInput.PlaceholderColor3 = Color3.fromRGB(90,90,100)
itemInput.TextColor3 = WHITE
itemInput.Font = Enum.Font.Gotham
itemInput.TextSize = 12
itemInput.TextXAlignment = Enum.TextXAlignment.Left
itemInput.ClearTextOnFocus = false
itemInput.Parent = iBg

-- Price label + input
local pLbl = Instance.new("TextLabel")
pLbl.Size = UDim2.new(1,-16,0,20)
pLbl.Position = UDim2.new(0,8,0,104)
pLbl.BackgroundTransparency = 1
pLbl.Text = "Maksimum Fiyat (Gems)"
pLbl.TextSize = 11
pLbl.TextColor3 = GREY
pLbl.Font = Enum.Font.Gotham
pLbl.TextXAlignment = Enum.TextXAlignment.Left
pLbl.Parent = CF

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(1,-16,0,32)
pBg.Position = UDim2.new(0,8,0,124)
pBg.BackgroundColor3 = Color3.fromRGB(25,25,35)
pBg.Parent = CF
corner(pBg, 6)

local priceInput = Instance.new("TextBox")
priceInput.Size = UDim2.new(1,-12,1,0)
priceInput.Position = UDim2.new(0,6,0,0)
priceInput.BackgroundTransparency = 1
priceInput.PlaceholderText = "örn: 300000"
priceInput.PlaceholderColor3 = Color3.fromRGB(90,90,100)
priceInput.TextColor3 = WHITE
priceInput.Font = Enum.Font.Gotham
priceInput.TextSize = 12
priceInput.TextXAlignment = Enum.TextXAlignment.Left
priceInput.ClearTextOnFocus = false
priceInput.Parent = pBg

-- Eşleşme toggle
local mLbl = Instance.new("TextLabel")
mLbl.Size = UDim2.new(1,-16,0,20)
mLbl.Position = UDim2.new(0,8,0,164)
mLbl.BackgroundTransparency = 1
mLbl.Text = "Eşleşme Tipi"
mLbl.TextSize = 11
mLbl.TextColor3 = GREY
mLbl.Font = Enum.Font.Gotham
mLbl.TextXAlignment = Enum.TextXAlignment.Left
mLbl.Parent = CF

local tFrame = Instance.new("Frame")
tFrame.Size = UDim2.new(1,-16,0,28)
tFrame.Position = UDim2.new(0,8,0,184)
tFrame.BackgroundColor3 = Color3.fromRGB(25,25,35)
tFrame.Parent = CF
corner(tFrame, 6)

local exactMode = false

local fuzzyB = Instance.new("TextButton")
fuzzyB.Size = UDim2.new(0.5,-2,1,0)
fuzzyB.Position = UDim2.new(0,2,0,0)
fuzzyB.BackgroundColor3 = PURPLE
fuzzyB.TextColor3 = WHITE
fuzzyB.Font = Enum.Font.GothamBold
fuzzyB.TextSize = 11
fuzzyB.Text = "İçerik Ara"
fuzzyB.Parent = tFrame
corner(fuzzyB, 5)

local exactB = Instance.new("TextButton")
exactB.Size = UDim2.new(0.5,-2,1,0)
exactB.Position = UDim2.new(0.5,0,0,0)
exactB.BackgroundColor3 = Color3.fromRGB(30,30,45)
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

-- Başlat butonu
local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(1,-16,0,36)
startBtn.Position = UDim2.new(0,8,0,220)
startBtn.BackgroundColor3 = GREEN
startBtn.TextColor3 = WHITE
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 13
startBtn.Text = "▶  SNIPER BAŞLAT"
startBtn.Parent = CF
corner(startBtn, 7)

-- ══════════════════════════════════
--  STATUS FRAME
-- ══════════════════════════════════
local SF = Instance.new("Frame")
SF.Size = UDim2.new(0, 260, 0, 190)
SF.Position = UDim2.new(0.5, -130, 0.5, -95)
SF.BackgroundColor3 = DARK
SF.BorderSizePixel = 0
SF.Visible = false
SF.Parent = SG
corner(SF, 12)

local sBar = Instance.new("Frame")
sBar.Size = UDim2.new(1,0,0,36)
sBar.BackgroundColor3 = PURPLE
sBar.BorderSizePixel = 0
sBar.Parent = SF
corner(sBar, 12)

local sBarFix = Instance.new("Frame")
sBarFix.Size = UDim2.new(1,0,0,12)
sBarFix.Position = UDim2.new(0,0,1,-12)
sBarFix.BackgroundColor3 = PURPLE
sBarFix.BorderSizePixel = 0
sBarFix.Parent = sBar

local sTitle = Instance.new("TextLabel")
sTitle.Size = UDim2.new(1,0,1,0)
sTitle.BackgroundTransparency = 1
sTitle.Text = "🎯  PS99 Sniper · Aktif"
sTitle.TextColor3 = WHITE
sTitle.Font = Enum.Font.GothamBold
sTitle.TextSize = 13
sTitle.Parent = sBar

local function sLabel(txt, color, posY, bold)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-16,0,22)
    l.Position = UDim2.new(0,8,0,posY)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextSize = 12
    l.TextColor3 = color
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = SF
    return l
end

local sItemLbl   = sLabel("🔍  Item: —",     GREY,  44, false)
local sPriceLbl  = sLabel("💎  Max: —",      GREY,  66, false)
local sStatusLbl = sLabel("⏸  Bekleniyor",  Color3.fromRGB(180,180,255), 92, false)
local sBoughtLbl = sLabel("✅  Alınan: 0",   GREEN, 116, true)

local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1,-16,0,32)
stopBtn.Position = UDim2.new(0,8,0,150)
stopBtn.BackgroundColor3 = RED
stopBtn.TextColor3 = WHITE
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 13
stopBtn.Text = "⏹  DURDUR"
stopBtn.Parent = SF
corner(stopBtn, 7)

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
    local direct = Rem:FindFirstChild(name)
    if direct then return direct end
    for _, v in ipairs(Rem:GetChildren()) do
        if v.Name:lower():find(name:lower()) then return v end
    end
    return nil
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
    GetListings = findRemote("GetTradeListings") or findRemote("TradingGetListings") or findRemote("GetListings")
    BuyTrade    = findRemote("BuyTrade") or findRemote("PurchaseTrade") or findRemote("TradeBuy")

    if not GetListings or not BuyTrade then
        setStatus("⚠️ Remote yok — Trading Plaza'da mısın?", RED)
        running = false
        return
    end

    while running do
        setStatus("🔄  Taranıyor...", Color3.fromRGB(180,180,255))
        local ok, result = pcall(function()
            if GetListings:IsA("RemoteFunction") then
                return GetListings:InvokeServer()
            end
            return nil
        end)
        if ok and result and type(result) == "table" then
            for _, listing in ipairs(result) do
                local itemName = tostring(listing.ItemName or listing.Name or listing.item or listing.petName or "")
                local price    = tonumber(listing.Price or listing.GemPrice or listing.price or listing.gems) or math.huge
                if matchItem(itemName) and price <= CFG.MaxPrice then
                    setStatus("🎯 BULUNDU: "..itemName.." @ "..tostring(price), GREEN)
                    if tryBuy(listing) then
                        buyCount = buyCount + 1
                        sBoughtLbl.Text = "✅  Alınan: "..buyCount
                    end
                end
            end
        else
            setStatus("📭  Sonuç yok / farklı format", GREY)
        end
        task.wait(0.8)
    end
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
