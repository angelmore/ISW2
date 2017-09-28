require './compute_transaction_operation'

class TransferNet < ComputeTransactionOperation

  def visitDepositFromTransfer(aDepositFromTransfer)
  	aDepositFromTransfer.value
  end

  def visitDeposit(aDeposit)
  	0
  end

  def visitWithdrawFromTransfer(aWithdrawFromTransfer)
  	-aWithdrawFromTransfer.value
  end

  def visitWithdraw(aWithdraw)
  	0
  end

  def visitCertificateOfDeposit(aCertificateOfDeposit)
    0
  end  

end
