require './cart'
require './credit_card'

class Cashier
  def initialize(sales_book, cart, credit_card)
    @sales_book = sales_book
    @cart = cart
    @credit_card = credit_card
  end

  def checkout
    raise Exception, Cashier.invalid_cart_error_description if @cart.empty?
    raise Exception, Cashier.credit_card_expired_error_description if @credit_card.is_expired?(Time.now)


  end

  def self.invalid_cart_error_description
    'The cart cannot be empty'
  end

  def self.credit_card_expired_error_description
    'The credit card cannot be expired'
  end
end
