-- PS99 Sniper · Auto-Discover + Instant Hop · LO ♥

local RS   = game:GetService("ReplicatedStorage")
local TS   = game:GetService("TeleportService")
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
end

local SG = Instance.new("ScreenGui")
SG.Name = "PS99Sniper"
SG.ResetOnSpawn = false
pcall(function() SG.Parent = game:GetService("CoreGui") end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

local CF = Instance.new("Frame")
CF.Size = UDim2.new(0, 280, 0, 262)
CF.Position = UDim2.new(0.5, -140, 0.5, -131)
CF.BackgroundColor3 = DARK
CF.BorderSizePixel = 0
CF.Parent = SG
corner(CF, 12)

local cBar = Instance.new("Frame")
cBar.Size = UDim2.new(1,0,0,36)
cBar.BackgroundColor3 = PURPLE
cBar.BorderSizePixel = 0
cBar.Parent = CF
corner(cBar, 12)

local cTitle = Instance.new("TextLabel")
cTitle.Size = UDim2.new(1,0,1,0)
cTitle.BackgroundTransparency = 1
cTitle.Text = "🎯  PS99 Sniper"
cTitle.TextColor3 = WHITE
cTitle.Font = Enum.Font.GothamBold
cTitle.TextSize = 14
cTitle.Parent = cBar

local function mkLabel(par, txt, posY, color, bold)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-16,0,20)
    l.Position = UDim2.new(0,8,0,posY)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextSize = 11
    l.TextColor3 = color or GREY
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
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

mkLabel(CF, "Item Adı", 44)
local itemInput = mkInput(CF, "örn: Treat Magnet", 64)
mkLabel(CF, "Maksimum Fiyat (Gems)", 104)
local priceInput = mkInput(CF, "örn: 300000", 124)
mkLabel(CF, "Server'da bulunamazsa otomatik hop", 164, Color3.fromRGB(120,120,140))

local hopEnabled = true
local hopBg = Instance.new("Frame")
hopBg.Size = UDim2.new(1,-16,0,28)
hopBg.Position = UDim2.new(0,8,0,182)
hopBg.BackgroundColor3 = Color3.fromRGB(25,25,35)
hopBg.Parent = CF
corner(hopBg,6)

local hopOn = Instance.new("TextButton")
hopOn.Size = UDim2.new(0.5,-2,1,0)
hopOn.Position = UDim2.new(0,2,0,0)
hopOn.BackgroundColor3 = GREEN
hopOn.TextColor3 = Color3.fromRGB(10,10,10)
hopOn.Font = Enum.Font.GothamBold
hopOn.TextSize = 11
hopOn.Text = "Hop: AÇIK"
hopOn.Parent = hopBg
corner(hopOn,5)

local hopOff = Instance.new("TextButton")
hopOff.Size = UDim2.new(0.5,-2,1,0)
hopOff.Position = UDim2.new(0.5,0,0,0)
hopOff.BackgroundColor3 = Color3.fromRGB(30,30,45)
hopOff.TextColor3 = GREY
hopOff.Font = Enum.Font.Gotham
hopOff.TextSize = 11
hopOff.Text = "Hop: KAPALI"
hopOff.Parent = hopBg
corner(hopOff,5)

hopOn.MouseButton1Click:Connect(function()
    hopEnabled = true
    hopOn.BackgroundColor3 = GREEN; hopOn.TextColor3 = Color3.fromRGB(10,10,10); hopOn.Font = Enum.Font.GothamBold
    hopOff.BackgroundColor3 = Color3.fromRGB(30,30,45); hopOff.TextColor3 = GREY; hopOff.Font = Enum.Font.Gotham
end)
hopOff.MouseButton1Click:Connect(function()
    hopEnabled = false
    hopOff.BackgroundColor3 = RED; hopOff.TextColor3 = WHITE; hopOff.Font = Enum.Font.GothamBold
    hopOn.BackgroundColor3 = Color3.fromRGB(30,30,45); hopOn.TextColor3 = GREY; hopOn.Font = Enum.Font.Gotham
end)

local startBtn = mkBtn(CF, "▶  SNIPER BAŞLAT", PURPLE, 218, 36)

local SF = Instance.new("Frame")
SF.Size = UDim2.new(0, 265, 0, 210)
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
local sStatusL = mkLabel(SF, "🔄  Başlatılıyor...", 92,  Color3.fromRGB(180,180,255))
local sBoughtL = mkLabel(SF, "✅  Alınan: 0",        116, GREEN, true)
local sServerL = mkLabel(SF, "🌐  Server hop: 0",    138, GREY)
local stopBtn  = mkBtn(SF, "⏹  DURDUR", RED, 164, 32)

local TRADE_KEYWORDS = {"trade","listing","market","shop","buy","purchase","offer","plaza"}

local function isTradeRelated(name)
    local n = name:lower()
    for _, k in ipairs(TRADE_KEYWORDS) do
        if n:find(k) then return true end
    end
    return false
end

local function tryInvoke(remote)
    if not remote:IsA("RemoteFunction") then return nil end
    local ok, result = pcall(function() return remote:InvokeServer() end)
    if ok and type(result) == "table" and #result > 0 then return result end
    return nil
end

local function findWorkingRemote()
    local candidates = {}
    for _, v in ipairs(RS:GetDescendants()) do
        if v:IsA("RemoteFunction") then
            table.insert(candidates, isTradeRelated(v.Name) and 1 or 2, v)
        end
    end
    for _, remote in ipairs(candidates) do
        local result = tryInvoke(remote)
        if result then return remote, result end
    end
    return nil, nil
end

local running    = false
local buyCount   = 0
local hopCount   = 0
local lastBuyMap = {}
local CFG        = {}

local function setStatus(msg, color)
    sStatusL.Text = msg
    sStatusL.TextColor3 = color or Color3.fromRGB(180,180,255)
end

local function hopServer()
    hopCount = hopCount + 1
    sServerL.Text = "🌐  Server hop: "..hopCount
    setStatus("🚀  Hop ediliyor...", Color3.fromRGB(255,200,80))
    task.wait(0.5)
    pcall(function() TS:Teleport(game.PlaceId, LP) end)
end

local function tryBuy(listing)
    local id = tostring(listing.TradeId or listing.Id or listing.id or listing.tradeId or "")
    if lastBuyMap[id] and id ~= "" then return false end
    lastBuyMap[id] = true
    for _, v in ipairs(RS:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local n = v.Name:lower()
            if n:find("buy") or n:find("purchase") or n:find("accept") then
                pcall(function()
                    if v:IsA("RemoteFunction") then v:InvokeServer(listing)
                    else v:FireServer(listing) end
                end)
                pcall(function()
                    if v:IsA("RemoteFunction") then v:InvokeServer(id)
                    else v:FireServer(id) end
                end)
                return true
            end
        end
    end
    return false
end

local function scanLoop()
    setStatus("🔍  Remotlar taranıyor...", Color3.fromRGB(255,200,80))

    local listingRemote = findWorkingRemote()

    if not listingRemote then
        if hopEnabled then
            hopServer()
        else
            setStatus("⚠️  Remote bulunamadı", RED)
            running = false
        end
        return
    end

    setStatus("✅  "..listingRemote.Name.." bulundu", GREEN)
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

                if itemName:lower():find(CFG.TargetItem:lower(), 1, true) and price > 0 and price <= CFG.MaxPrice then
                    found = true
                    setStatus("🎯 BULUNDU: "..itemName.." @ "..tostring(price), GREEN)
                    if tryBuy(listing) then
                        buyCount = buyCount + 1
                        sBoughtL.Text = "✅  Alınan: "..buyCount
                    end
                end
            end

            if not found then
                setStatus("🔄  "..#result.." listing — yok", GREY)
                if hopEnabled then hopServer(); return end
            end
        else
            setStatus("📭  Liste boş", GREY)
            if hopEnabled then hopServer(); return end
        end

        task.wait(0.8)
    end
end

startBtn.MouseButton1Click:Connect(function()
    local itemText = itemInput.Text:match("^%s*(.-)%s*$")
    local maxPrice = tonumber(priceInput.Text)
    if itemText == "" then itemInput.PlaceholderText = "⚠️ Item adı gir!"; return end
    if not maxPrice then priceInput.Text = ""; priceInput.PlaceholderText = "⚠️ Sayı gir!"; return end

    CFG.TargetItem = itemText
    CFG.MaxPrice   = maxPrice
    buyCount = 0; hopCount = 0; lastBuyMap = {}

    sItemL.Text   = "🔍  Item: "..itemText
    sPriceL.Text  = "💎  Max: "..tostring(maxPrice).." gems"
    sBoughtL.Text = "✅  Alınan: 0"
    sServerL.Text = "🌐  Server hop: 0"

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
