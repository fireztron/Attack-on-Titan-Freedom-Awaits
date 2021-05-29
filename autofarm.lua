--[[
    join private server (it's free)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("RunService")

--// Studs between player and position
local function getDistance(position)
   local hrp = LocalPlayer.Character.HumanoidRootPart
   return (position - hrp.Position).Magnitude
end

--// Auto attack loop
_G.autofarm = true
spawn(function()
   while _G.autofarm do
       for _, titan in pairs(workspace.Titans:GetChildren()) do
           for _, hitbox in pairs(titan.Hitboxes.Player:GetChildren()) do
               if hitbox.Name == "Nape" then
                   local LPChar = LocalPlayer.Character
                   if LPChar then
                       local hrp = LPChar:FindFirstChild("HumanoidRootPart")
                       if hrp and getDistance(hitbox.Position) < 50 then
                           local args = {
                               [1] = {
                                   [1] = hitbox
                               },
                               [2] = 9e9 -- power ?
                           }

                           game:GetService("ReplicatedStorage").Assets.Remotes.Blade:FireServer(unpack(args))
                       end
                   end
               end
           end
       end
       RS.Heartbeat:Wait()
   end
end)

--// Teleport loop
spawn(function()
   while _G.autofarm do
       for _, titan in pairs(workspace.Titans:GetChildren()) do
           for _, hitbox in pairs(titan.Hitboxes.Player:GetChildren()) do
               if hitbox.Name == "Nape" then
               local LPChar = LocalPlayer.Character
               local titanHum = hitbox:FindFirstChild("HP")
                   if LPChar and titanHum and titanHum.Value > 0 then
                       local hrp = LPChar:FindFirstChild("HumanoidRootPart")
                       if hrp then
                           repeat
                               hrp.CFrame = CFrame.new(hitbox.Position + Vector3.new(0,6,0), hitbox.Position)
                               RS.Heartbeat:Wait()
                           until
                               titanHum.Value <= 0 or _G.autofarm == false
                       end
                   end
               end
           end
       end
       RS.Heartbeat:Wait()
   end
end)
