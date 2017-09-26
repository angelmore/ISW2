require './transaction'

class DepositFromTransfer < Transaction

  def self.register_for_on(amount, transfer)
    transaction = self.new(transfer)
    transfer.toAccount.register(transaction)
    transaction
  end

  def initialize(transfer)
    @transfer = transfer
  end

  def value
    @transfer.value
  end

  def transfer_amount
    value
  end

  def transfer
    @transfer
  end

  def affect_balance(balance)
    balance + value
  end

  def summary_line
    "Transferencia por #{value}"
  end

end
