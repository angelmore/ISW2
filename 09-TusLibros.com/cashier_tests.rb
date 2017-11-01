require 'minitest/autorun'
require 'minitest/reporters'
require './cart'
require './cashier'
require './credit_card'
require './factory'

MiniTest::Reporters.use!

class CashierTests < Minitest::Test

  def test_01_cannot_checkout_empty_cart
    cart = Cart.new Factory.empty_catalog
    cashier = Cashier.new({}, cart, Factory.valid_credit_card)

    exception = assert_raises Exception do
      cashier.checkout
    end

    assert_equal Cashier.invalid_cart_error_description, exception.message
  end

  def test_02_cannot_checkout_with_expired_credit_card
    cart = Cart.new Factory.isbn_prices(2)
    cart.add(2, 5)
    cashier = Cashier.new({}, cart, Factory.expired_credit_card)

    exception = assert_raises Exception do
      cashier.checkout
    end

    assert_equal Cashier.credit_card_expired_error_description, exception.message
  end

  def test_03_checkout_a_cart_with_two_books_sums_the_prices
    cart = Cart.new Factory.isbns_1_2_prices_5_10
    cart.add(1, 1)
    cart.add(2, 3)
    cashier = Cashier.new({}, cart, Factory.valid_credit_card)
    assert_equal cashier.checkout, 35
  end

end
