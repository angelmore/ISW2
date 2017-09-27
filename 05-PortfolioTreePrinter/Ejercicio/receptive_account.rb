require './summarizing_account'

class ReceptiveAccount < SummarizingAccount

  def initialize
    @transactions = []
  end

  def register(transaction)
    @transactions << transaction
  end

  def registers(transaction)
    @transactions.include? (transaction)
  end

  def accounts
    []
  end

  def manages(account)
    self == account
  end

  def balance
    @transactions.inject(0) { |balance, transaction|
      transaction.affect_balance(balance)
    }
  end

  def transactions
    @transactions.clone
  end

  def account_tree(account_names)
    [account_names[self]]
  end

end
