require 'minitest/autorun'
require 'minitest/reporters'
require './cart'
require './cashier'
require './credit_card_expiration_date'

MiniTest::Reporters.use!

class CashierTests < Minitest::Test

  def test_01_cannot_checkout_empty_cart
    exception = assert_raises Exception do
      cart = Cart.new []
      credit_card_expiration_date = CreditCardExpirationDate.new 5, 2019
      Cashier.checkout cart, credit_card_expiration_date
    end

    assert_equal Cashier.invalid_cart_error_description, exception.message
  end

  def test_02_cannot_checkout_with_expired_credit_card
    exception = assert_raises Exception do
      cart = Cart.new [2]
      cart.add(2, 5)
      credit_card_expiration_date = CreditCardExpirationDate.new 5, 1960
      Cashier.checkout(cart, credit_card_expiration_date)
    end

    assert_equal Cashier.credit_card_expired_error_description, exception.message
  end

end
