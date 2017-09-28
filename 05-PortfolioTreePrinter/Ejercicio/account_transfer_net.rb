require './compute_operation'
require './transfer_net'

class AccountTransferNet < ComputeOperation
  def initialize(account)
    @account = account
  end

  def compute
    @account.transactions.inject(0) { |transfer_net, transaction|
      transfer_net + transaction.accept(TransferNet.new)
    }
  end
end
