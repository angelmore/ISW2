require './deposit_from_transfer'
require './withdraw_from_transfer'

class Transfer
  def self.register(amount,fromAccount,toAccount)
    Transfer.new amount, fromAccount, toAccount
  end

  def initialize(amount, fromAccount, toAccount)
    @value = amount
    @fromAccount = fromAccount
    @toAccount = toAccount
    @deposit = DepositFromTransfer.register_for_on(amount, self)
    @withdraw = WithdrawFromTransfer.register_for_on(amount, self)
  end

  def fromAccount
    @fromAccount
  end

  def toAccount
    @toAccount
  end

  def deposit_leg
    @deposit
  end

  def withdraw_leg
    @withdraw
  end

  def value
    @value
  end

end
