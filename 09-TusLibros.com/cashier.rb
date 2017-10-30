require './cart'
require './credit_card_expiration_date'

class Cashier
  def self.checkout(cart, credit_card_expiration_date)
    raise Exception, Cashier.invalid_cart_error_description if cart.empty?
    raise Exception, Cashier.credit_card_expired_error_description if Cashier.expired_credit_card?(credit_card_expiration_date)
  end

  def self.expired_credit_card?(credit_card_expiration_date)
    return true if Time.now.year > credit_card_expiration_date.year
    return true if Time.now.year == credit_card_expiration_date.year && Time.now.month > credit_card_expiration_date.month
    false
  end

  def self.invalid_cart_error_description
    'The cart cannot be empty'
  end

  def self.credit_card_expired_error_description
    'The credit card cannot be expired'
  end
end
