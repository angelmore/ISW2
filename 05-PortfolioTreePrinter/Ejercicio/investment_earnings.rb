require './compute_operation'

class InvestmentEarnings < ComputeOperation

  def visitDepositFromTransfer(aDepositFromTransfer)
  	0
  end

  def visitDeposit(aDeposit)
  	0
  end

  def visitWithdrawFromTransfer(aWithdrawFromTransfer)
  	0
  end

  def visitWithdraw(aWithdraw)
  	0
  end

  def visitCertificateOfDeposit(aCertificateOfDeposit)
    aCertificateOfDeposit.capital * (aCertificateOfDeposit.tna / 360) * aCertificateOfDeposit.days
  end

end