require 'minitest/autorun'
require 'minitest/reporters'
require './cart'

MiniTest::Reporters.use!

class CartTests < Minitest::Test

  def test_01_new_cart_is_empty
    cart = Cart.new []
    assert cart.empty?
  end

  def test_02_cannot_add_a_book_with_an_invalid_isbn_to_a_cart
    invalid_isbn = 1000
    cart = Cart.new [invalid_isbn-1]
    exception = assert_raises Exception do
      cart.add(invalid_isbn, 1)
    end
    assert_equal(Cart.invalid_isbn_error_description, exception.message)
    assert_empty cart
  end

  def test_03_a_cart_with_a_book_with_a_valid_isbn_is_not_an_empty_cart
    isbn = 1
    cart = Cart.new [isbn]
    cart.add(isbn, 1)
    assert !cart.empty?
  end

  def test_04_cannot_add_a_book_with_a_negative_quantity_to_a_cart
    isbn = 1000
    cart = Cart.new [isbn]
    exception = assert_raises Exception do
      cart.add(isbn, -1)
    end
    assert_equal Cart.invalid_quantity_error_description, exception.message
    assert_empty cart
  end

  def test_05_cannot_add_a_book_with_a_non_integer_quantity_to_a_cart
    isbn = 1000
    cart = Cart.new [isbn]
    exception = assert_raises Exception do
      cart.add(isbn, 3.2)
    end
    assert_equal Cart.invalid_quantity_error_description, exception.message
    assert_empty cart
  end

  def test_06_a_book_of_a_cart_is_included_in_cart_books
    isbn = 5
    cart = Cart.new [isbn]
    cart.add(isbn, 1)
    assert cart.list.include? isbn
  end

  def test_07_the_quantity_of_an_added_isbn_must_be_correct
    isbn = 5
    quantity = 2
    cart = Cart.new [isbn]
    cart.add(isbn, quantity)
    assert_equal cart.list.count(isbn), quantity
  end

  def test_08_if_a_product_is_added_more_than_once_the_quantities_must_be_summed
    isbn = 5
    cart = Cart.new [isbn]
    cart.add(isbn, 1)
    cart.add(isbn, 1)
    assert_equal cart.list.count(isbn), 2
  end

end
