-- Define the function to create a bank account for a player
local function CreateBankAccount(ply)
  if not ply.BankAccount then
    ply.BankAccount = {}
    ply.BankAccount.Balance = 0
  end
end

-- Call CreateBankAccount for each player when they join the server
hook.Add("PlayerSpawn", "CreateBankAccount", function(ply)
  CreateBankAccount(ply)
end)

-- Now let's define functions to deposit and withdraw money from the bank account
function DepositMoney(ply, amount)
  ply.BankAccount.Balance = ply.BankAccount.Balance + amount
  ply:addMoney(-amount)
end

function WithdrawMoney(ply, amount)
  if ply.BankAccount.Balance < amount then
    ply:ChatPrint("You do not have enough money in your bank account.")
    return
  end
  ply.BankAccount.Balance = ply.BankAccount.Balance - amount
  ply:addMoney(amount)
end

-- Let's add network strings for the deposit and withdrawal messages
util.AddNetworkString("DepositMoney")
util.AddNetworkString("WithdrawMoney")

-- Now let's set up the network listeners for deposit and withdrawal messages
net.Receive("DepositMoney", function(len, ply)
  local amount = net.ReadFloat()
  if not ply.BankAccount then CreateBankAccount(ply) end
  DepositMoney(ply, amount)
end)

net.Receive("WithdrawMoney", function(len, ply)
  local amount = net.ReadFloat()
  if not ply.BankAccount then CreateBankAccount(ply) end
  WithdrawMoney(ply, amount)
end)

-- Now let's update the OpenATM function to display the player's bank account balance
function OpenATM(ply)
  local frame = vgui.Create("DFrame")
  frame:SetSize(300, 200)
  frame:SetTitle("ATM")
  frame:SetVisible(true)
  frame:SetDraggable(false)
  frame:ShowCloseButton(true)
  frame:Center()

  -- Display the player's balance
  local balanceLabel = vgui.Create("DLabel", frame)
  balanceLabel:SetText("Your balance: $" .. tostring(ply.BankAccount.Balance))
  balanceLabel:SetPos(50, 30)
  balanceLabel:SetSize(200, 20)

  -- Add a deposit button
  local depositButton = vgui.Create("DButton", frame)
  depositButton:SetText("Deposit")
  depositButton:SetPos(50, 80)
  depositButton:SetSize(75, 30)
  depositButton.DoClick = function()
    Derma_StringRequest("Deposit", "Enter the amount you want to deposit:", "", function(amount)
      net.Start("DepositMoney")
      net.WriteFloat(amount)
      net.SendToServer()
      balanceLabel:SetText("Your balance: $" .. tostring(ply.BankAccount.Balance))
    end)
  end

  -- Add a withdraw button
  local withdrawButton = vgui.Create("DButton", frame)
  withdrawButton:SetText("Withdraw")
  withdrawButton:SetPos(150, 80)
  withdrawButton:SetSize(75, 30)
  withdrawButton.DoClick = function()
    Derma_StringRequest("Withdraw", "Enter the amount you want to withdraw:", "", function(amount)
      net.Start("WithdrawMoney")
      net.WriteFloat(amount)
      net.SendToServer()
      balanceLabel:SetText("Your balance: $" .. tostring(ply.BankAccount.Balance))
    end)
  end
end

-- First, let's define a function to create a bank account for a player
function CreateBankAccount(ply)
  ply.BankAccount = {}
  ply.BankAccount.Balance = 0
end

-- Now let's define functions to deposit and withdraw money from the bank account
function DepositMoney(ply, amount)
  ply.BankAccount.Balance = ply.BankAccount.Balance + amount
  ply:addMoney(-amount)
end

function WithdrawMoney(ply, amount)
  if ply.BankAccount.Balance < amount then
    ply:ChatPrint("You do not have enough money in your bank account.")
    return
  end
  ply.BankAccount.Balance = ply.BankAccount.Balance - amount
  ply:addMoney(amount)
end

-- Let's add network strings for the deposit and withdrawal messages
util.AddNetworkString("DepositMoney")
util.AddNetworkString("WithdrawMoney")

-- Now let's set up the network listeners for deposit and withdrawal messages
net.Receive("DepositMoney", function(len, ply)
  local amount = net.ReadFloat()
  if not ply.BankAccount then CreateBankAccount(ply) end
  DepositMoney(ply, amount)
end)

net.Receive("WithdrawMoney", function(len, ply)
  local amount = net.ReadFloat()
  if not ply.BankAccount then CreateBankAccount(ply) end
  WithdrawMoney(ply, amount)
end)

-- Now let's update the OpenATM function to display the player's bank account balance
function OpenATM(ply)
  local frame = vgui.Create("DFrame")
  frame:SetSize(300, 200)
  frame:SetTitle("ATM")
  frame:SetVisible(true)
  frame:SetDraggable(false)
  frame:ShowCloseButton(true)
  frame:Center()

  -- Display the player's balance
  local balanceLabel = vgui.Create("DLabel", frame)
  balanceLabel:SetText("Your balance: $" .. tostring(ply.BankAccount.Balance))
  balanceLabel:SetPos(50, 30)
  balanceLabel:SetSize(200, 20)

  -- Add a deposit button
  local depositButton = vgui.Create("DButton", frame)
  depositButton:SetText("Deposit")
  depositButton:SetPos(50, 80)
  depositButton:SetSize(75, 30)
  depositButton.DoClick = function()
    Derma_StringRequest("Deposit", "Enter the amount you want to deposit:", "", function(amount)
      net.Start("DepositMoney")
      net.WriteFloat(amount)
      net.SendToServer()
      balanceLabel:SetText("Your balance: $" .. tostring(ply.BankAccount.Balance))
    end)
  end

  -- Add a withdraw button
  local withdrawButton = vgui.Create("DButton", frame)
  withdrawButton:SetText("Withdraw")
  withdrawButton:SetPos(150, 80)
  withdrawButton:SetSize(75, 30)
  withdrawButton.DoClick = function()
    Derma_StringRequest("Withdraw", "Enter the amount you want to withdraw:", "", function(amount)
      net.Start("WithdrawMoney")
      net.WriteFloat(amount)
      net.SendToServer()
      balanceLabel:SetText("Your balance: $" .. tostring(ply.BankAccount.Balance))
    end)
  end
end

-- Now let's update the PlayerUse hook to check for the class "atm_entity" and call the OpenATM function
hook.Add("PlayerUse", "OpenATM", function(ply, ent)
  if ent:GetClass() == "atm_entity" then
    OpenATM(ply, ent:GetPos())
  end
end)