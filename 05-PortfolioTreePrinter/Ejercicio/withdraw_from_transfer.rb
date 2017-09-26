require './transaction'

class WithdrawFromTransfer < Transaction
  def self.register_for_on(amount, transfer)
    transaction = self.new(transfer)
    transfer.fromAccount.register(transaction)
    transaction
  end

  def initialize(transfer)
    @transfer = transfer
  end

  def transfer_amount
    -value
  end

  def value
    @transfer.value
  end

  def transfer
    @transfer
  end

  def affect_balance(balance)
    balance - value
  end

  def summary_line
    "Transferencia por #{-value}"
  end
end
