require './summarizing_account'

class ReceptiveAccount < SummarizingAccount

  def initialize
    @transactions = []
  end

  def register(transaction)
    @transactions << transaction
  end

  def balance
    @transactions.inject(0) { |balance,transaction |
      if transaction.class.to_s == 'Withdraw'
        balance-transaction.value
      else
        balance+transaction.value
      end
    }
  end

  def registers(transaction)
    @transactions.include? (transaction)
  end

  def manages(account)
    self == account
  end

  def transactions
    @transactions.clone
  end

end
