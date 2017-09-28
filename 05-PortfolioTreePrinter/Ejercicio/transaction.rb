require './object'

class Transaction

  def self.register_for_on(amount,account)
    transaction = self.new(amount)
    account.register(transaction)
    transaction
  end

  def value
    self.should_implement
  end

  def affect_balance(balance)
    self.should_implement
  end

  def transfer_amount
    0
  end

end