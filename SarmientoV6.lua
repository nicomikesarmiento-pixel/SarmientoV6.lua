-- [[ SARMIENTO V6: OFFICIAL STEALTH EXECUTOR ]] --
-- Location: Aurora, PH | Dev: Nico
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- 1. SECURITY & STEALTH (Anti-Detect)
local function Protect(Instance)
    if gethui then Instance.Parent = gethui()
    elseif syn and syn.protect_gui then syn.protect_gui(Instance)
    else Instance.Parent = CoreGui end
end

-- ANTI-KICK BYPASS
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then return nil end
    return old(self, ...)
end)
setreadonly(mt, true)

-- 2. FILE SYSTEM (Auto-Save/Persistence)
local Folder = "SarmientoV6"
local SaveFile = Folder.."/Hub.json"
if not isfolder(Folder) then makefolder(Folder) end

local function GetSavedScripts()
    if isfile(SaveFile) then
        return HttpService:JSONDecode(readfile(SaveFile))
    end
    return {}
end

local function SaveToHub(Name, Code)
    local Current = GetSavedScripts()
    table.insert(Current, {name = Name, code = Code})
    writefile(SaveFile, HttpService:JSONEncode(Current))
end

-- 3. THE ACTUAL EXECUTE COMMAND
local function RunScript(Source)
    local success, err = pcall(function()
        if Source:find("http") then
            loadstring(game:HttpGet(Source))()
        else
            loadstring(Source)()
        end
    end)
    if not success then warn("Sarmiento V6 Error: "..err) end
end

-- 4. ICON & DRAG LOGIC (Integrated Fix)
local Main = Instance.new("ScreenGui")
Main.Name = "Sarmiento_"..math.random(100,999)
Protect(Main)

local Icon = Instance.new("TextButton")
Icon.Size = UDim2.new(0, 50, 0, 50)
Icon.Position = UDim2.new(0, 50, 0, 100)
Icon.BackgroundColor3 = Color3.fromRGB(212, 175, 55)
Icon.Text = "V6"
Icon.Draggable = true -- Standard drag for mobile engines
Icon.Parent = Main

-- Dito papasok yung Execute function pag pinindot yung button sa listahan
Icon.MouseButton1Click:Connect(function()
    -- I-o-open nito yung HTML menu mo na nasalpak sa .so engine
    print("Sarmiento V6 Menu Toggled")
end)

print("Sarmiento V6: Stealth Mode & Executor Online!")
