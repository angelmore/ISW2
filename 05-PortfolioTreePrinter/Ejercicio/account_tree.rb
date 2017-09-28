require './compute_operation'
require './account_tree_visitor'

class AccountTree < ComputeOperation
  def initialize(account, account_names)
    @account = account
    @account_names = account_names
  end

  def compute
    @account.accept(AccountTreeVisitor.new, @account_names)
  end
end
