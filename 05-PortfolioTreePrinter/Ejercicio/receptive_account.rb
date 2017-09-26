require './summarizing_account'

class ReceptiveAccount < SummarizingAccount

  def initialize
    @transactions = []
    @summary_lines = []
    @transfer_net = 0
  end

  def register(transaction)
    @transactions << transaction
    @summary_lines << transaction.summary_line
    @transfer_net += transaction.transfer_amount
  end

  def account_transfer_net
    @transfer_net
  end

  def account_summary_lines
    @summary_lines
  end

  def investment_net
    @transactions.inject(0) { |investment_net, transaction|
      investment_net + transaction.investment_net
    }
  end

  def investment_earnings
    @transactions.inject(0) { |investment_earning, transaction|
      investment_earning + transaction.investment_earning
    }
  end

  def balance
    @transactions.inject(0) { |balance, transaction|
      transaction.affect_balance(balance)
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

  def account_tree(account_names)
    [account_names[self]]
  end

end
