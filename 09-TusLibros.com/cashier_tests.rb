require 'minitest/autorun'
require 'minitest/reporters'
require './cart'
require './cashier'
require './credit_card'

MiniTest::Reporters.use!

class CashierTests < Minitest::Test

  def test_01_cannot_checkout_empty_cart
    cart = Cart.new []
    credit_card = valid_credit_card
    cashier = Cashier.new({}, cart, credit_card)

    exception = assert_raises Exception do
      cashier.checkout
    end

    assert_equal Cashier.invalid_cart_error_description, exception.message
  end

  def test_02_cannot_checkout_with_expired_credit_card
    cart = Cart.new [2]
    cart.add(2, 5)
    credit_card = expired_credit_card
    cashier = Cashier.new({}, cart, credit_card)

    exception = assert_raises Exception do
      cashier.checkout
    end

    assert_equal Cashier.credit_card_expired_error_description, exception.message
  end

  def test_03_checkout_a_cart_with_two_books_sums_the_prices
    cart = Cart.new [2, 3]
    cart.add(2, 2)
    cart.add(3, 1)
    credit_card = expired_credit_card
    cashier = Cashier.new({}, cart, credit_card)

    exception = assert_raises Exception do
      cashier.checkout
    end

    assert_equal Cashier.credit_card_expired_error_description, exception.message
  end

  def month_year
    MonthYear.new 10, 2020
  end

  def expired_month_year
    MonthYear.new 10, 1900
  end

  def valid_credit_card
    CreditCard.new '9' * 16, 'Pepito Casimiro', month_year
  end

  def expired_credit_card
    CreditCard.new '9' * 16, 'Pepito Casimiro', expired_month_year
  end

end
