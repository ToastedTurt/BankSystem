function OpenATM(ply)
  local frame = vgui.Create("DFrame")
  frame:SetSize(300, 200)
  frame:SetTitle("ATM")
  frame:SetVisible(true)
  frame:SetDraggable(false)
  frame:ShowCloseButton(true)
  frame:Center()

  local depositButton = vgui.Create("DButton", frame)
  depositButton:SetText("Deposit")
  depositButton:SetPos(50, 50)
  depositButton:SetSize(75, 30)
  depositButton.DoClick = function()
    Derma_StringRequest("Deposit", "Enter the amount you want to deposit:", "", function(amount)
      net.Start("DepositMoney")
      net.WriteFloat(amount)
      net.SendToServer()
    end)
  end

  local withdrawButton = vgui.Create("DButton", frame)
  withdrawButton:SetText("Withdraw")
  withdrawButton:SetPos(150, 50)
  withdrawButton:SetSize(75, 30)
  withdrawButton.DoClick = function()
    Derma_StringRequest("Withdraw", "Enter the amount you want to withdraw:", "", function(amount)
      net.Start("WithdrawMoney")
      net.WriteFloat(amount)
      net.SendToServer()
    end)
  end
end

hook.Add("PlayerUse", "OpenATM", function(ply, ent)
  if ent:GetClass() == "atm_entity" then
    OpenATM(ply)
  end
end)
