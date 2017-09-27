require './compute_transaction_operation'

class SummaryLines < ComputeTransactionOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject([]) { |summary_lines, transaction|
      summary_lines << transaction.summary_line
    }
  end
end
