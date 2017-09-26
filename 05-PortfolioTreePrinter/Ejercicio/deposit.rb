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

  def summary_line
    "Depósito por #{value}"
  end

end
