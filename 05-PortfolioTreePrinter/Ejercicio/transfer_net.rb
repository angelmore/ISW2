require './compute_transaction_operation'

class TransferNet < ComputeTransactionOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject(0) { |transfer_net, transaction|
      transfer_net + transaction.transfer_amount
    }
  end
end
