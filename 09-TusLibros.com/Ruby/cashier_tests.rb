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
    sales_book = Factory.empty_sales_book
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)

    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal Cashier.invalid_cart_error_description, exception.message
    assert_empty cashier.sales_book["isbn_amount"]
    assert_equal 0, cashier.sales_book["total"]  
  end

  def test_02_cannot_checkout_with_expired_credit_card
    @debit = Proc.new {}
    cart = Cart.new Factory.isbn_prices(2)
    cart.add(2, 5)
    sales_book = Factory.empty_sales_book
    cashier = Cashier.new(sales_book, cart, Factory.expired_credit_card)

    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal Cashier.credit_card_expired_error_description, exception.message
    assert_empty cashier.sales_book["isbn_amount"]
    assert_equal 0, cashier.sales_book["total"]
  end

  def test_03_checkout_a_cart_with_two_books_sums_the_prices
    @debit = Proc.new {}
    cart = Cart.new Factory.isbns_1_2_prices_5_10
    cart.add(1, 1)
    cart.add(2, 3)
    sales_book = Factory.empty_sales_book
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)
    expectedSalesBook = Factory.sales_book_for_isbns_1_2_prices_5_10(1,3,35)
    assert_equal cashier.checkout(self), 35
    assert_equal expectedSalesBook, sales_book 
  end

  def test_04_checkout_two_cart_for_the_same_client
    @debit = Proc.new {}
    sales_book = Factory.empty_sales_book
    creditCard = Factory.valid_credit_card

    firstCart = Cart.new Factory.isbns_1_2_prices_5_10
    firstCart.add(1, 1)
    firstCart.add(2, 3)
    firstCashier = Cashier.new(sales_book, firstCart, creditCard)


    secondCart = Cart.new Factory.isbns_1_2_prices_5_10
    secondCart.add(1, 1)
    secondCart.add(2, 3)
	  secondCashier = Cashier.new(sales_book, secondCart, creditCard)

    assert_equal firstCashier.checkout(self), 35
    assert_equal secondCashier.checkout(self), 35

	  expectedSalesBook = expectedSalesBook = Factory.sales_book_for_isbns_1_2_prices_5_10(2,6,70)

    assert_equal expectedSalesBook, sales_book
  end

  def test_05_cannot_checkout_with_stolen_credit_card
    @debit = Proc.new { raise Exception, debit_stolen_credit_card_error }
    cart = Cart.new Factory.isbn_prices(1)
    cart.add(1, 1)
    sales_book = Factory.empty_sales_book
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)
    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal debit_stolen_credit_card_error, exception.message
    assert_empty cashier.sales_book["isbn_amount"]
    assert_equal 0, cashier.sales_book["total"]  

  end

  def test_06_cannot_checkout_with_credit_card_without_cash
    @debit = Proc.new { raise Exception, debit_no_cash_credit_card_error }
    cart = Cart.new Factory.isbn_prices(1)
    cart.add(1, 1)
    sales_book = Factory.empty_sales_book
    cashier = Cashier.new(sales_book, cart, Factory.valid_credit_card)
    exception = assert_raises Exception do
      cashier.checkout(self)
    end

    assert_equal debit_no_cash_credit_card_error, exception.message
    assert_empty cashier.sales_book["isbn_amount"]
    assert_equal 0, cashier.sales_book["total"]  
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
