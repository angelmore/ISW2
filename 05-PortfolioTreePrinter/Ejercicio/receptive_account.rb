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

  def summary_lines
    @transactions.inject([]) { |summary_lines, transaction|
      summary_lines << transaction.accept(SummaryLines.new)
    }
  end

  def transfer_net
    @transactions.inject(0) { |transfer_net, transaction|
      transfer_net + transaction.accept(TransferNet.new)
    }
  end

  def investment_net
    @transactions.inject(0) { |investment_net, transaction|
      investment_net + transaction.accept(InvestmentNet.new)
    }
  end


  def investment_earnings
    @transactions.inject(0) { |investment_earning, transaction|
      investment_earning + transaction.accept(InvestmentEarnings.new)
    }
  end

end
