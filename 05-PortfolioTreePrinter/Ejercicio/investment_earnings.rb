require './compute_transaction_operation'

class InvestmentEarnings < ComputeTransactionOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject(0) { |investment_earning, transaction|
      investment_earning + transaction.investment_earning
    }
  end
end
