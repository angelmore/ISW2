require './transaction'

class Withdraw < Transaction

  def initialize(value)
    @value = value
  end

  def value
    @value
  end

  def affect_balance(balance)
    balance - value
  end

  def accept(visitor)
    visitor.visitWithdraw(self)
  end

end
