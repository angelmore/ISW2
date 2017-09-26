require './transaction'

class Transfer
  def self.register(amount,fromAccount,toAccount)
    Transfer.new DepositFromTransfer.register_for_on(amount, fromAccount, toAccount), Withdraw.register_for_on(amount, fromAccount, toAccount)
  end

  def initialize(deposit, withdraw)
    @deposit = deposit
    @withdraw = withdraw
  end

  def deposit_leg
    @deposit
  end

  def withdraw_leg
    @withdraw
  end

  def value
    @deposit.value
  end

end
