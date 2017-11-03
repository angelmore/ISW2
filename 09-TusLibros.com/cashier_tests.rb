require 'minitest/autorun'
require 'minitest/reporters'
require './cart'
require './cashier'
require './credit_card'
require './factory'

MiniTest::Reporters.use!

class CashierTests < Minitest::Test

  def test_01_cannot_checkout_empty_cart
    @debit = Proc.new {}
    cart = Cart.new Factory.empty_catalog
    sales_book = []
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)

    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal Cashier.invalid_cart_error_description, exception.message
    assert_empty cashier.sales_book
  end

  def test_02_cannot_checkout_with_expired_credit_card
    @debit = Proc.new {}
    cart = Cart.new Factory.isbn_prices(2)
    cart.add(2, 5)
    sales_book = []
    cashier = Cashier.new(sales_book, cart, Factory.expired_credit_card)

    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal Cashier.credit_card_expired_error_description, exception.message
    assert_empty cashier.sales_book
  end

  def test_03_checkout_a_cart_with_two_books_sums_the_prices
    @debit = Proc.new {}
    cart = Cart.new Factory.isbns_1_2_prices_5_10
    cart.add(1, 1)
    cart.add(2, 3)
    sales_book = []
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)
    assert_equal cashier.checkout(self), 35
    assert !sales_book.empty?
  end

  def test_04_cannot_checkout_with_stolen_credit_card
    @debit = Proc.new { raise Exception, debit_stolen_credit_card_error }
    cart = Cart.new Factory.isbn_prices(1)
    cart.add(1, 1)
    sales_book = []
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)
    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal debit_stolen_credit_card_error, exception.message
    assert_empty cashier.sales_book
  end

  def test_05_cannot_checkout_with_stolen_credit_card
    @debit = Proc.new { raise Exception, debit_no_cash_credit_card_error }
    cart = Cart.new Factory.isbn_prices(1)
    cart.add(1, 1)
    sales_book = []
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)
    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal debit_no_cash_credit_card_error, exception.message
    assert_empty cashier.sales_book
  end

  def debit_stolen_credit_card_error
    'The credit card cannot be stolen'
  end

  def debit_no_cash_credit_card_error
    'The credit card has no cash'
  end

  def debit(credit_card, total)
    @debit.call
  end

end
