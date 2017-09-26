require './transaction'

class DepositFromTransfer < Deposit

  def self.register_for_on(amount, transfer)
    transaction = self.new(amount, transfer)
    transfer.fromAccount.register(transaction)
    transaction
  end

  def initialize(value, transfer)
    @value = value
    @transfer = transfer
  end

  def value
    @value
  end

  def transfer
    @transfer
  end

end
