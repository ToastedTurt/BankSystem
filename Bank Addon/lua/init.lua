if SERVER then
    include("banking_system.lua")
    include("atm_entity.lua")
end

if CLIENT then
    include("banking_system.lua")
    include("atm.lua")
    include("atm_entity.lua")
end