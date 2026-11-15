-- CI/CD BLINK IN SYNC
-- Paste into Roblox Studio > View > Command Bar, then press Enter.
-- Creates a linked Parts-based island blockout and server-authoritative checkpoints.

local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local MODEL_NAME = "CICD_BlinkInSync"

local old = Workspace:FindFirstChild(MODEL_NAME)
if old then old:Destroy() end
local model = Instance.new("Model")
model.Name = MODEL_NAME
model.Parent = Workspace

local C = {
  navy = Color3.fromRGB(22,34,58), blue = Color3.fromRGB(14,165,233),
  cyan = Color3.fromRGB(0,220,255), green = Color3.fromRGB(46,204,113),
  orange = Color3.fromRGB(244,162,97), grass = Color3.fromRGB(112,170,72),
  rock = Color3.fromRGB(139,91,67), white = Color3.fromRGB(245,248,255)
}
local function makePart(name, size, cf, color, material, parent)
  local p = Instance.new("Part")
  p.Name, p.Size, p.CFrame, p.Color = name, size, cf, color
  p.Material = material or Enum.Material.Slate
  p.Anchored, p.TopSurface, p.BottomSurface = true, Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
  p.Parent = parent or model
  return p
end
local function weld(a,b,name)
  local w = Instance.new("WeldConstraint")
  w.Name, w.Part0, w.Part1, w.Parent = name or ("Link_"..a.Name.."_"..b.Name), a, b, a
  return w
end
local function billboard(adornee, text, width, height, offset, color)
  local g = Instance.new("BillboardGui")
  g.Name, g.Adornee, g.Size, g.StudsOffset, g.AlwaysOnTop = "Label", adornee, UDim2.fromOffset(width,height), offset, true
  g.MaxDistance, g.Parent = 180, adornee
  local t = Instance.new("TextLabel")
  t.BackgroundTransparency, t.Size, t.Font = 1, UDim2.fromScale(1,1), Enum.Font.GothamBlack
  t.Text, t.TextScaled, t.TextColor3, t.TextStrokeTransparency = text, true, color or C.white, 0.35
  t.Parent = g
end

-- Floating island blockout
local core = makePart("Island_Core", Vector3.new(76,8,34), CFrame.new(0,0,0), C.rock, Enum.Material.Rock)
model.PrimaryPart = core
local top = makePart("Grass_Top", Vector3.new(74,1.2,32), CFrame.new(0,4.3,0), C.grass, Enum.Material.Grass)
local cliff = makePart("Front_Cliff_Face", Vector3.new(76,4,2), CFrame.new(0,-2,-16), C.rock, Enum.Material.Rock)
local water = makePart("Water_Plane", Vector3.new(90,0.5,24), CFrame.new(0,-7,-25), Color3.fromRGB(20,160,220), Enum.Material.Glass)
water.Transparency, water.CanCollide = 0.2, false
weld(core,top); weld(core,cliff)

-- Billboard
local postL = makePart("Billboard_Left_Support", Vector3.new(2,19,2), CFrame.new(-1,14,9), C.navy, Enum.Material.Metal)
local postR = makePart("Billboard_Right_Support", Vector3.new(2,19,2), CFrame.new(43,14,9), C.navy, Enum.Material.Metal)
local sign = makePart("Main_Billboard", Vector3.new(46,10,1.5), CFrame.new(21,23,9), C.navy, Enum.Material.Metal)
weld(postL,sign); weld(postR,sign)
billboard(sign, "CI/CD  •  BLINK IN SYNC\nHIGH EXPECTATIONS FOR IMPLEMENTATIONS\nNO EXCEPTIONS FOR VALIDATIONS", 760,150,Vector3.new(0,0,-1.3))

-- Synchronized neon rail
local rail = makePart("Synchronized_Cyan_Rail", Vector3.new(52,0.35,0.35), CFrame.new(21,7.4,-4), C.cyan, Enum.Material.Neon)
rail.CanCollide = false

local stationData = {
  {name="BUILD",x=0,color=C.blue,action="Start BUILD checkpoint"},
  {name="TEST",x=14,color=C.green,action="Run TEST checkpoint"},
  {name="VALIDATE",x=28,color=C.blue,action="Run VALIDATE checkpoint"},
  {name="DEPLOY",x=42,color=C.orange,action="Deploy release"}
}
for i,s in ipairs(stationData) do
  local pedestal = makePart(s.name.."_Pedestal",Vector3.new(10,2,9),CFrame.new(s.x,6,-4),C.navy,Enum.Material.Metal)
  local screen = makePart(s.name.."_Screen",Vector3.new(7,4.5,0.6),CFrame.new(s.x,9.5,-7.6),s.color,Enum.Material.Neon)
  local pad = makePart(s.name.."_InteractionPad",Vector3.new(7,0.5,7),CFrame.new(s.x,7.3,1),s.color,Enum.Material.Neon)
  screen.CanCollide, pad.Transparency = false, 0.15
  pad:SetAttribute("StageIndex",i)
  pad:SetAttribute("StageName",s.name)
  local prompt = Instance.new("ProximityPrompt")
  prompt.Name, prompt.ActionText, prompt.ObjectText = s.name.."_Prompt", s.action, s.name
  prompt.KeyboardKeyCode, prompt.HoldDuration, prompt.MaxActivationDistance = Enum.KeyCode.E, 0.5, 12
  prompt.RequiresLineOfSight, prompt.Parent = false, pad
  billboard(screen,s.name,230,65,Vector3.new(0,0,-0.7))
  weld(core,pedestal); weld(core,screen); weld(core,pad)
end
for i=1,3 do
  local a = makePart("Flow_Arrow_"..i,Vector3.new(2.2,0.25,1.2),CFrame.new(i*14-7,7.55,-4)*CFrame.Angles(0,math.rad(90),0),C.cyan,Enum.Material.Neon)
  a.CanCollide = false; weld(core,a)
end
local gate = makePart("Deployment_Gate",Vector3.new(1,7,10),CFrame.new(49,9,1),Color3.fromRGB(255,90,70),Enum.Material.Neon)
gate.Transparency = 0.25
local beacon = makePart("Release_Beacon",Vector3.new(2,7,2),CFrame.new(56,9,1),C.green,Enum.Material.Neon)
beacon.CanCollide = false
billboard(beacon,"RELEASE READY",230,55,Vector3.new(0,5,0),C.green)
weld(core,gate); weld(core,beacon)

-- Keep the environment as one connected assembly if later unanchored.
for _,d in ipairs(model:GetDescendants()) do
  if d:IsA("BasePart") and d ~= core and d ~= water and not d:FindFirstChildWhichIsA("WeldConstraint") then
    weld(core,d,"AssemblyLink_"..d.Name)
  end
end

-- Server-authoritative sequential checkpoint logic
local previous = ServerScriptService:FindFirstChild("CICD_BlinkInSync_Server")
if previous then previous:Destroy() end
local server = Instance.new("Script")
server.Name = "CICD_BlinkInSync_Server"
server.Source = [=[
local Players = game:GetService("Players")
local model = workspace:WaitForChild("CICD_BlinkInSync")
local gate = model:WaitForChild("Deployment_Gate")
local names = {"BUILD","TEST","VALIDATE","DEPLOY"}
local progress = {}

local function gateLocked(locked)
  gate.CanCollide = locked
  gate.Transparency = locked and 0.25 or 0.85
  gate.Color = locked and Color3.fromRGB(255,90,70) or Color3.fromRGB(46,204,113)
end
local function setup(p)
  progress[p.UserId] = 0
  p:SetAttribute("CICDProgress",0)
  p:SetAttribute("CICDStatus","READY: BUILD")
end
Players.PlayerAdded:Connect(setup)
Players.PlayerRemoving:Connect(function(p) progress[p.UserId] = nil end)
for _,p in ipairs(Players:GetPlayers()) do setup(p) end
local function status(p,msg)
  p:SetAttribute("CICDStatus",msg)
  print("[CI/CD] "..p.Name..": "..msg)
end

for _,obj in ipairs(model:GetDescendants()) do
  if obj:IsA("ProximityPrompt") and obj.Parent:GetAttribute("StageIndex") then
    obj.Triggered:Connect(function(player)
      local index = obj.Parent:GetAttribute("StageIndex")
      local expected = (progress[player.UserId] or 0) + 1
      if index ~= expected then
        status(player,"VALIDATION FAILED — expected "..(names[expected] or "completion"))
        return
      end
      if index == 4 and (progress[player.UserId] or 0) < 3 then
        status(player,"DEPLOY BLOCKED — validation required")
        return
      end
      progress[player.UserId] = index
      player:SetAttribute("CICDProgress",index)
      if index == 3 then
        gateLocked(false)
        status(player,"ALL CHECKPOINTS PASSED — DEPLOY UNLOCKED")
      elseif index == 4 then
        status(player,"RELEASE COMPLETE — BLINK IN SYNC")
      else
        status(player,names[index].." PASSED — NEXT: "..names[index+1])
      end
    end)
  end
end
gateLocked(true)
]=]
server.Parent = ServerScriptService
print("CI/CD BLINK IN SYNC created. Press Play and use E at each station in order.")
