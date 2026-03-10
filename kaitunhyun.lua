repeat task.wait() until game:IsLoaded()

local lp = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local vu = game:GetService("VirtualUser")
local lv = player.Data.Level

local TweenService = game:GetService("TweenService")

function TweenTo(pos)

local char = game.Players.LocalPlayer.Character
local hrp = char.HumanoidRootPart

local distance = (hrp.Position - pos.Position).Magnitude
local speed = 300

local tween = TweenService:Create(
hrp,
TweenInfo.new(distance/speed, Enum.EasingStyle.Linear),
{CFrame = pos}
)

tween:Play()
tween.Completed:Wait()

end

getgenv().AutoFarm = true

--================ ANTI AFK =================--

player.Idled:Connect(function()
vu:CaptureController()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


-- Hook nhẹ chỉ chặn mấy cái dễ gây ban
local oldNamecall
pcall(function()
    local mt = getrawmetatable(game)
    if not mt then return end
    
    oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Chỉ chặn remote TeleportDetect (dễ gây ban nhất)
        if method == "FireServer" and self.Name == "TeleportDetect" then
            return -- Chặn im lặng
        end
        
        -- Cho phép mọi thứ khác qua
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
end)

-- Fake movement nhẹ (tránh anti-cheat phát hiện đứng im)
task.spawn(function()
    while task.wait(10) do
        pcall(function()
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") then
                -- Chỉ fake khi thực sự đứng im
                if char.Humanoid.MoveDirection.Magnitude < 0.1 then
                    char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    wait(0.05)
                    char.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                end
            end
        end)
    end
end)

-- ==========================================
-- TẮT DECAL XA (GIẢM VRAM)
-- ==========================================

task.spawn(function()
    while task.wait(3) do
        pcall(function()
            local char = lp.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Decal") or v:IsA("Texture") then
                    if v.Parent and v.Parent:IsA("BasePart") then
                        local dist = (v.Parent.Position - char.HumanoidRootPart.Position).Magnitude
                        if dist > 150 then
                            v.Transparency = 1
                        else
                            v.Transparency = 0
                        end
                    end
                end
            end
        end)
    end
end)

-- ==========================================
-- DỌN BỘ NHỚ (CHỐNG TRÀN RAM)
-- ==========================================

task.spawn(function()
    while task.wait(60) do
        pcall(function()
            collectgarbage("collect")
        end)
    end
end)


--================ ANTI AFK =================--

player.Idled:Connect(function()
vu:CaptureController()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--================ AUTO TEAM PIRATES =================--

task.spawn(function()
repeat task.wait() until player.PlayerGui:FindFirstChild("Main")
rs.Remotes.CommF_:InvokeServer("SetTeam","Pirates")
end)

--================ AUTO BUY HAKI =================--

task.spawn(function()

while task.wait(20) do
pcall(function()

if not player.Character:FindFirstChild("HasBuso") then

player.Character.HumanoidRootPart.CFrame =
CFrame.new(-1442,29,-28)

task.wait(1)

rs.Remotes.CommF_:InvokeServer("BuyHaki","Buso")

end

end)
end

end)

--================ QUEST =================--

function CheckQuest()

local L = lv.Value

if L <= 9 then
return "BanditQuest1","Bandit",1,CFrame.new(1038,16,1547)

elseif L <= 14 then
return "JungleQuest","Monkey",1,CFrame.new(-1598,36,153)

elseif L <= 29 then
return "JungleQuest","Gorilla",2,CFrame.new(-1237,6,-486)

elseif L <= 39 then
return "BuggyQuest1","Pirate",1,CFrame.new(-1141,4,3820)

elseif L <= 59 then
return "BuggyQuest1","Brute",2,CFrame.new(-1141,4,3820)

elseif L <= 74 then
return "DesertQuest","Desert Bandit",1,CFrame.new(894,6,4390)

elseif L <= 89 then
return "DesertQuest","Desert Officer",2,CFrame.new(894,6,4390)

elseif L <= 99 then
return "SnowQuest","Snow Bandit",1,CFrame.new(1389,87,-1298)

elseif L <= 119 then
return "SnowQuest","Snowman",2,CFrame.new(1389,87,-1298)

elseif L <= 149 then
return "MarineQuest2","Chief Petty Officer",1,CFrame.new(-5036,29,4324)

elseif L <= 174 then
return "SkyQuest","Sky Bandit",1,CFrame.new(-4841,717,-2623)

elseif L <= 189 then
return "SkyQuest","Dark Master",2,CFrame.new(-4841,717,-2623)

elseif L <= 209 then
return "MagmaQuest","Military Soldier",1,CFrame.new(-5316,12,8517)

elseif L <= 249 then
return "Area1Quest","Raider",1,CFrame.new(-429,72,1836)

elseif L <= 274 then
return "Area1Quest","Mercenary",2,CFrame.new(-429,72,1836)

elseif L <= 299 then
return "Area2Quest","Swan Pirate",1,CFrame.new(638,71,918)

elseif L <= 324 then
return "Area2Quest","Factory Staff",2,CFrame.new(638,71,918)

elseif L <= 1124 then
return "ZombieQuest","Zombie",1,CFrame.new(-5495,48,-794)

elseif L <= 1199 then
return "ZombieQuest","Vampire",2,CFrame.new(-5495,48,-794)

elseif L <= 1274 then
return "SnowMountainQuest","Snow Trooper",1,CFrame.new(606,401,-5370)

elseif L <= 1349 then
return "SnowMountainQuest","Winter Warrior",2,CFrame.new(606,401,-5370)

elseif L <= 1424 then
return "IceSideQuest","Lab Subordinate",1,CFrame.new(-6060,16,-4905)

elseif L <= 1499 then
return "IceSideQuest","Horned Warrior",2,CFrame.new(-6060,16,-4905)

elseif L <= 1574 then
return "PiratePortQuest","Pirate Millionaire",1,CFrame.new(-290,44,5580)

elseif L <= 1674 then
return "PiratePortQuest","Pistol Billionaire",2,CFrame.new(-290,44,5580)

elseif L <= 1774 then
return "AmazonQuest","Dragon Crew Warrior",1,CFrame.new(5833,52,-1105)

elseif L <= 1824 then
return "AmazonQuest","Dragon Crew Archer",2,CFrame.new(5833,52,-1105)

elseif L <= 1899 then
return "MarineTreeIsland","Marine Commodore",1,CFrame.new(2179,28,-6741)

elseif L <= 1974 then
return "DeepForestIsland3","Forest Pirate",1,CFrame.new(-13234,331,-7625)

elseif L <= 2024 then
return "HauntedQuest1","Reborn Skeleton",1,CFrame.new(-9482,142,5567)

elseif L <= 2100 then
return "HauntedQuest1","Living Zombie",2,CFrame.new(-9482,142,5567)

else
return "CakeQuest1","Cookie Crafter",1,CFrame.new(-2021,37,-12027)
end

end

--================ AUTO FARM =================--

task.spawn(function()

while getgenv().AutoFarm do
task.wait()

local quest,monster,id,questPos = CheckQuest()

if not player.PlayerGui.Main.Quest.Visible then
TweenTo(questPos)
task.wait(1)
rs.Remotes.CommF_:InvokeServer("StartQuest",quest,id)
end

for _,mob in pairs(workspace.Enemies:GetChildren()) do
if mob.Name == monster and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then

repeat task.wait()

player.Character.HumanoidRootPart.CFrame =
mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0)

mob.HumanoidRootPart.CFrame =
player.Character.HumanoidRootPart.CFrame * CFrame.new(0,-30,0)

mob.HumanoidRootPart.CanCollide = false
mob.Humanoid.WalkSpeed = 0

vu:CaptureController()
vu:Button1Down(Vector2.new(0,0))

until mob.Humanoid.Health <= 0 or not getgenv().AutoFarm

end
end

end

end)


-- ==========================================
-- CODE CLICK MỚI CỦA BẠN
-- ==========================================

getgenv()._FastAttackBackup = getgenv()._FastAttackBackup or {}

-- config
local HITBOX = 1000
local LOOP_DELAY = 0.01

local function safeRequireWeaponData()
    local ok, mod = pcall(function()
        return require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WeaponData"))
    end)
    return ok and mod or nil
end

local WeaponData = safeRequireWeaponData()

local function findAttackMelee()
    if getgenv().attackMelee and typeof(getgenv().attackMelee) == "function" then
        return getgenv().attackMelee
    end

    if typeof(getgc) ~= "function" or typeof(debug) ~= "table" or typeof(debug.getinfo) ~= "function" then
        return nil
    end

    for _, v in next, getgc(true) do
        if typeof(v) == "function" then
            local ok, info = pcall(debug.getinfo, v)
            if ok and info and info.name == "attackMelee" then
                getgenv().attackMelee = v
                return v
            end
        end
    end
    return nil
end

local function cacheUpvalueTargets(fn)
    if getgenv()._FastAttackBackup._uv_cached then return end
    getgenv()._FastAttackBackup._uv_cached = true
    getgenv()._FastAttackBackup._uv_idx = {}

    if typeof(getupvalues) ~= "function" then return end

    local ok, uvs = pcall(getupvalues, fn)
    if not ok or type(uvs) ~= "table" then return end

    for i, v in next, uvs do
        local t = typeof(v)
        if t == "number" then
            if v > 0 and v < 5 then
                table.insert(getgenv()._FastAttackBackup._uv_idx, {i = i, kind = "number"})
            end
        elseif t == "boolean" then
            if v == true then
                table.insert(getgenv()._FastAttackBackup._uv_idx, {i = i, kind = "boolean"})
            end
        end
    end
end

local function applyFastUpvalues(fn)
    if typeof(setupvalue) ~= "function" then return end
    local idxs = getgenv()._FastAttackBackup._uv_idx
    if type(idxs) ~= "table" then return end

    for _, it in ipairs(idxs) do
        if it.kind == "number" then
            pcall(setupvalue, fn, it.i, 0)
        elseif it.kind == "boolean" then
            pcall(setupvalue, fn, it.i, false)
        end
    end
end

-- Vòng lặp click mới
task.spawn(function()
    repeat task.wait() until game:IsLoaded() and lp

    while task.wait(0.01) do
        local fn = findAttackMelee()
        if fn then
            cacheUpvalueTargets(fn)
            break
        end
    end

    while task.wait(LOOP_DELAY) do
        if _G.UltraClick then
            pcall(function()
                local attackFn = getgenv().attackMelee
                if typeof(attackFn) ~= "function" then
                    attackFn = findAttackMelee()
                    if typeof(attackFn) ~= "function" then
                        return
                    end
                end

                local char = lp.Character
                if not char then return end

                local tool = char:FindFirstChildOfClass("Tool")
                if not tool then return end

                if not WeaponData then
                    WeaponData = safeRequireWeaponData()
                    if not WeaponData then return end
                end

                local weaponName = tool:GetAttribute("WeaponName")
                if not weaponName then return end

                local w = WeaponData[weaponName]
                if not w then return end

                if getgenv()._FastAttackBackup.Hitbox == nil then
                    getgenv()._FastAttackBackup.Hitbox = w.HitboxMagnitude
                end

                applyFastUpvalues(attackFn)
                w.HitboxMagnitude = HITBOX

                pcall(function()
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end)
                pcall(attackFn)
            end)
        end
    end
end)


-- ========== Auto Equip Melee =========--
task.spawn(function()

while task.wait(2) do

pcall(function()

local backpack = game.Players.LocalPlayer.Backpack

for _,v in pairs(backpack:GetChildren()) do

if v:IsA("Tool") and v.ToolTip == "Fighting Style" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end

end

end)

end

end)


-- ULTRA ATTACK GỐC
-- ==========================================

local function FastAttack(target)
    local char = lp.Character
    if not char then return end
    local hrp = target:FindFirstChild("HumanoidRootPart")
    local hum = target:FindFirstChild("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end
    pcall(function()
        local weaponName = CombatUtil:GetWeaponName(tool)
        local uuid = tostring(lp.UserId):sub(2,4) .. tostring(math.random(10000,99999))
        local hitData = {{target, hrp}}
        hitRemote:FireServer(hrp, hitData, nil, nil, uuid)
        CombatUtil:ApplyDamageHighlight(target, char, weaponName, hrp, nil)
    end)
end

local function GetMobs()
    local mobs = {}
    for _, mob in ipairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            table.insert(mobs, mob)
        end
    end
    return mobs
end

task.spawn(function()
    while task.wait(0.01) do
        if _G.UltraAttack then
            pcall(function()
                local mobs = GetMobs()
                if #mobs > 0 then
                    if attackRemote then attackRemote:FireServer() end
                    for _, mob in ipairs(mobs) do FastAttack(mob) end
                end
            end)
        end
    end
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDangNhoEm/TuanAnhIOS/refs/heads/main/koby"))()

-- ======= Buy All Melee =======--
task.spawn(function()

local rs = game:GetService("ReplicatedStorage")

while task.wait(15) do
pcall(function()

rs.Remotes.CommF_:InvokeServer("BuyBlackLeg")
rs.Remotes.CommF_:InvokeServer("BuyElectro")
rs.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
rs.Remotes.CommF_:InvokeServer("BuyDragonClaw")
rs.Remotes.CommF_:InvokeServer("BuyDeathStep")
rs.Remotes.CommF_:InvokeServer("BuySuperHuman")
rs.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
rs.Remotes.CommF_:InvokeServer("BuyElectricClaw")
rs.Remotes.CommF_:InvokeServer("BuyGodHuman")

-- =============== Auto Farm Mas ================--
task.spawn(function()

while task.wait(5) do
pcall(function()

local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

if tool and tool:FindFirstChild("Level") then

if tool.Level.Value >= 400 then

-- đổi võ tiếp theo
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent =
game.Players.LocalPlayer.Character

end

end

end)
end

end)

--================ Suỵt =================--
task.spawn(function()

while task.wait(10) do
pcall(function()

for _,v in pairs(workspace.Enemies:GetChildren()) do

if v.Name == "Awakened Ice Admiral" or v.name == "Tide Keeper" then


repeat task.wait()

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
v.HumanoidRootPart.CFrame * CFrame.new(0,30,0)

until v.Humanoid.Health <= 0

end

end

end)
end

end)

--================ Im Lặng Là Vàng ===========--
task.spawn(function()

while task.wait(60) do

local found = false

for _,v in pairs(workspace.Enemies:GetChildren()) do
if v.Name == "Awakened Ice Admiral" or v.name == "Tide Keeper" then

found = true
end
end

if not found then
game:GetService("TeleportService"):Teleport(game.PlaceId)
end

end

end)

--================ FAST ATTACK =================--

task.spawn(function()

while task.wait() do
pcall(function()
vu:CaptureController()
vu:Button1Down(Vector2.new(0,0))
end)
end

end)

--================ Raid Fruit bị trùng ==============--
local rs = game:GetService("ReplicatedStorage")

function StartRaid()

rs.Remotes.CommF_:InvokeServer(
"RaidsNpc","Select","Flame"
)

rs.Remotes.CommF_:InvokeServer(
"RaidsNpc","Start"
)

end

task.spawn(function()

while task.wait(10) do
pcall(function()

local fruit = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")

if fruit and fruit.Name:find("Fruit") then

StartRaid()

end

end)
end

end)

--================ Auto Fragment ===============--
task.spawn(function()

while task.wait(30) do
pcall(function()

local fragment =
game.Players.LocalPlayer.Data.Fragments.Value

if fragment < 5000 then
StartRaid()
end

end)
end

end)

--================ Auto Tween To Fruit ===============--
task.spawn(function()

while task.wait(10) do

for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Tool") and v.Name:find("Fruit") then

TweenTo(v.Handle.CFrame)

end
end

end

end)
--================ AUTO SEA =================--

task.spawn(function()

while task.wait(10) do

local L = lv.Value
local PlaceId = game.PlaceId

if L >= 700 and PlaceId == 2753915549 then
rs.Remotes.CommF_:InvokeServer("TravelDressrosa")
end

if L >= 1500 and PlaceId == 4442272183 then
rs.Remotes.CommF_:InvokeServer("TravelZou")
end

end

end)
