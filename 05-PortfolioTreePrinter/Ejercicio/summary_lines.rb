require './compute_transaction_operation'

class SummaryLines < ComputeTransactionOperation

  def visitDepositFromTransfer(aDepositFromTransfer)
    "Transferencia por #{aDepositFromTransfer.value}"
  end

  def visitDeposit(aDeposit)
    "Depósito por #{aDeposit.value}"
  end

  def visitWithdrawFromTransfer(aWithdrawFromTransfer)
  	"Transferencia por #{-aWithdrawFromTransfer.value}"
  end

  def visitWithdraw(aWithdraw)
    "Extracción por #{aWithdraw.value}"
  end

  def visitCertificateOfDeposit(aCertificateOfDeposit)
    "Plazo fijo por #{aCertificateOfDeposit.capital} durante #{aCertificateOfDeposit.days} días a una tna de #{aCertificateOfDeposit.tna}"
  end  

end