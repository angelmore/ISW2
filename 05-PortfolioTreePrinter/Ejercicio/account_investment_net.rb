require './compute_operation'
require './investment_net'

class AccountInvestmentNet < ComputeOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject(0) { |investment_net, transaction|
      investment_net + transaction.accept(InvestmentNet.new)
    }
  end
end
