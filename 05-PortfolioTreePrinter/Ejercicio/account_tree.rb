require './compute_transaction_operation'

class AccountTree < ComputeTransactionOperation
  def initialize(account, account_names)
    @account = account
    @account_names = account_names
  end

  def compute
    @account.accounts.inject([@account_names[@account]]) { |tree, acc |
      tree.concat(AccountTree.new(acc, @account_names).compute.map { |account_name| " #{account_name}" })
    }
  end
end
