require './summarizing_account'

class Portfolio < SummarizingAccount

  def initialize
    @accounts = []
  end

  def self.create_with(account1,account2)
    portfolio_with_accounts = Portfolio.new
    portfolio_with_accounts.add_account(account1)
    portfolio_with_accounts.add_account(account2)
    portfolio_with_accounts
  end

  def self.ACCOUNT_ALREADY_MANAGED
    'Account already managed'
  end

  def add_account(account)
    raise Exception, Portfolio.ACCOUNT_ALREADY_MANAGED if manages account
    @accounts << account
  end

  def balance
    @accounts.inject(0) { |result, account| result + account.balance }
  end

  def registers(transaction)
    @accounts.any? { |account| account.registers(transaction) }
  end

  def manages(account)
    account == self || @accounts.any? { |account1| account1.manages(account) }
  end

  def transactions
    @accounts.inject([]) { |result, account| result + account.transactions }
  end
end
