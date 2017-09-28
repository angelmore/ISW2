require './compute_operation'
require './summary_lines'

class AccountSummaryLines < ComputeOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject([]) { |summary_lines, transaction|
      summary_lines << transaction.accept(SummaryLines.new)
    }
  end
end
