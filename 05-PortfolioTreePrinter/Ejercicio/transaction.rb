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

  def summary_line
    ""
  end

  def transfer_amount
    0
  end

  def investment_net
    0
  end

  def investment_earning
    0
  end

end
