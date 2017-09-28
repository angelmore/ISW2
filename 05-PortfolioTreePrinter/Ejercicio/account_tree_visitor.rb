require './compute_operation'

class AccountTreeVisitor
  def visit_receptive_account(receptive_account, account_names)
    [account_names[receptive_account]]
  end

  def visit_portfolio(portfolio, account_names)
    portfolio.accounts.inject([account_names[portfolio]]) { |res, acc| res + AccountTree.new(acc, account_names).compute.flatten.map { |acc_name| " #{acc_name}"  } }
  end
end
