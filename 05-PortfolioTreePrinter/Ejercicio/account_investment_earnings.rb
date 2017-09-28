require './compute_operation'
require './investment_earnings'

class AccountInvestmentEarnings < ComputeOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject(0) { |investment_earning, transaction|
      investment_earning + transaction.accept(InvestmentEarnings.new)
    }
  end
end
