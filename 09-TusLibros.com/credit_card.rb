require './month_year'

class CreditCard
  def initialize(number, owner, expiration_date)
    raise Exception, CreditCard.invalid_number_error_description if number.length != 16
    raise Exception, CreditCard.invalid_owner_name_error_description if owner.empty?
    @number = number
    @owner = owner
    @expiration_date = expiration_date
  end

  def is_expired?(date)
    return true if date.year > @expiration_date.year
    return true if date.year == @expiration_date.year && date.month > @expiration_date.month
    false
  end

  def self.invalid_number_error_description
    'Invalid number'
  end

  def self.invalid_owner_name_error_description
    'Invalid owner name'
  end
end

#que la tarjeta no figure como robada
#que se pueda debitar
#que no se pueda debitar cuando no haya saldo

#____
#-que el carrito reciba el catalogo con los precios
#-que el checkout sume y le pida al catalogo del carrito los precios
#-que el checkout verifique que el nombre tenga menos de 15 caracteres y llame al merchant processor con la tarjeta y el saldo
#-que el checkout agregue la compra cuando el caso sea valido
#-que el merchant processor se fije si la tarjeta tiene saldo suficiente y debite
