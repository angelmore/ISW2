require './compute_transaction_operation'

class InvestmentNet < ComputeTransactionOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject(0) { |investment_net, transaction|
      investment_net + transaction.investment_net
    }
  end
end
