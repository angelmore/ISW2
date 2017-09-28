require './transaction'

class Deposit < Transaction

  def initialize(value)
    @value = value
  end

  def value
    @value
  end

  def affect_balance(balance)
    balance + value
  end

  def accept(visitor)
    visitor.visitDeposit(self)
  end

end