require './transaction'

class CertificateOfDeposit < Transaction
  def self.register_for_on(capital,days,tna,account)
    certificate = self.new(capital, days, tna, account)
    account.register(certificate)
    certificate
  end

  def initialize(capital, days, tna, account)
    @capital = capital
    @days = days
    @tna = tna
  end

  def capital
    @capital
  end

  def days
    @days
  end

  def tna
    @tna
  end

  def affect_balance(balance)
    balance - capital
  end

  def accept(visitor)
    visitor.visitCertificateOfDeposit(self)
  end

end
