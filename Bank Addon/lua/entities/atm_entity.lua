-- Define the entity
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "ATM"
ENT.Author = "Your Name Here"
ENT.Spawnable = true
ENT.Category = "DarkRP"

-- Set the model
function ENT:Initialize()
  self:SetModel("models/props_interiors/VendingMachineSoda01a.mdl")
  self:SetMaterial("models/props_interiors/VendingMachineSoda01a/vendingmachine01a")

  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_VPHYSICS)
  self:SetSolid(SOLID_VPHYSICS)
  local phys = self:GetPhysicsObject()
  if phys:IsValid() then
    phys:Wake()
    phys:SetMaterial("metal")
    phys:SetMass(500)
    phys:SetBuoyancyRatio(0)
    phys:EnableMotion(false)
  end
end

-- Define the behavior when the entity is used
function ENT:Use(activator, caller)
  if not IsValid(caller) or not caller:IsPlayer() then return end
  net.Start("ATMMenu")
  net.Send(caller)
end