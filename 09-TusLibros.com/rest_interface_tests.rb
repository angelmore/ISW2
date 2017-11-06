require 'minitest/autorun'
require 'minitest/reporters'
require './cart'
require './cashier'
require './credit_card'
require './rest_interface'
require './factory'

MiniTest::Reporters.use!

class RestInterfaceTests < Minitest::Test
  def test_01_nonexistent_user_cannot_create_cart
    rest_interface = Factory.empty_rest_interface self, self

    exception = assert_raises Exception do
      rest_interface.create_cart(1, 'asd')
    end

    assert_equal exception.message, RestInterface.nonexistent_client_error_description
  end

  def test_02_cannot_create_cart_with_invalid_password
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self

    exception = assert_raises Exception do
      rest_interface.create_cart(1, 'asd')
    end

    assert_equal exception.message, RestInterface.invalid_password_error_description
  end

  def test_03_a_created_new_cart_is_empty
    @seconds = 1
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    cart_id = Factory.create_cart(rest_interface)
    assert_equal rest_interface.list_cart(cart_id), []
  end

  def test_04_a_book_can_be_added_to_a_existing_cart
    @seconds = 1
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    cart_id = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id, 1, 1)
    assert_equal rest_interface.list_cart(cart_id), [1]
  end

  def test_05_a_book_cannot_be_added_to_a_nonexisting_cart
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    cart_id = Factory.create_cart(rest_interface)
    exception = assert_raises Exception do
      rest_interface.add_to_cart(cart_id + 1, 1, 1)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_06_cannot_list_nonexistent_cart
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self

    exception = assert_raises Exception do
      rest_interface.list_cart(4)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_07_cannot_checkout_nonexistent_cart
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self

    exception = assert_raises Exception do
      rest_interface.checkout(1, Factory.valid_credit_card)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_08_cannot_checkout_nonexistent_cart
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self

    exception = assert_raises Exception do
      rest_interface.checkout(1, Factory.valid_credit_card)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_09_cannot_list_the_purchases_of_nonexistent_client_id
    rest_interface = Factory.empty_rest_interface self, self

    exception = assert_raises Exception do
      rest_interface.list_of_purchases(1, 'asd')
    end

    assert_equal exception.message, RestInterface.nonexistent_client_error_description
  end

  def test_10_cannot_list_the_purchases_of_a_client_with_invalid_password
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    client_id = Factory.a_user_with_a_password.keys.first
    password = Factory.a_user_with_a_password[client_id] + "1"

    exception = assert_raises Exception do
      rest_interface.list_of_purchases(client_id, password)
    end

    assert_equal exception.message, RestInterface.invalid_password_error_description
  end

  def test_11_cannot_add_book_on_expired_cart
    @seconds = 31 * 60
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    cart_id = Factory.create_cart(rest_interface)

    exception = assert_raises Exception do
      rest_interface.add_to_cart(cart_id, 1, 1)
    end

    assert_equal exception.message, RestInterface.expired_cart_error_description
  end

  def test_12_cannot_list_items_of_expired_cart
    @seconds = 1
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    cart_id = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id, 1, 1)
    @seconds = 31 * 60

    exception = assert_raises Exception do
      rest_interface.list_cart(cart_id)
    end

    assert_equal exception.message, RestInterface.expired_cart_error_description
  end

  def test_13_cannot_checkout_expired_cart
    @seconds = 1
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    cart_id = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id, 1, 1)
    @seconds = 31 * 60

    exception = assert_raises Exception do
      rest_interface.checkout(cart_id, Factory.valid_credit_card)
    end

    assert_equal exception.message, RestInterface.expired_cart_error_description
  end

  # HAY QUE TESTEAR ALGO DEL CHECKOUT ????
  # def test_14_can_checkout__cart
  #   @seconds = 1
  #   @debit = Proc.new {}
  #   rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
  #   cart_id = Factory.create_cart(rest_interface)
  #   isbn = 1
  #   rest_interface.add_to_cart(cart_id, isbn, 1)
  #   rest_interface.checkout(cart_id, Factory.valid_credit_card)
    
  # end


  def test_14_list_of_purchases_includes_all_books_of_a_cart_after_checkout
    @seconds = 1
    @debit = Proc.new {}
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    client_id = Factory.a_user_with_a_password.keys.first
    password = Factory.a_user_with_a_password[client_id]
    cart_id = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id, 1, 1)
    rest_interface.add_to_cart(cart_id, 2, 3)
    rest_interface.checkout(cart_id, Factory.valid_credit_card)
    assert_equal "1|2|2|2|4", rest_interface.list_of_purchases(client_id, password)
  end


   def test_15_list_of_purchases_includes_all_books_of_two_cart_after_checkout
    @seconds = 1
    @debit = Proc.new {}
    rest_interface = Factory.rest_interface_with_clientId_1_and_catalog self, self
    client_id = Factory.a_user_with_a_password.keys.first
    password = Factory.a_user_with_a_password[client_id]
    credit_card = Factory.valid_credit_card
    cart_id_first_cart = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id_first_cart, 1, 1)
    rest_interface.add_to_cart(cart_id_first_cart, 2, 3)
    rest_interface.checkout(cart_id_first_cart, credit_card)
    cart_id_second_cart = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id_second_cart, 2, 2)
    rest_interface.checkout(cart_id_second_cart, credit_card)
    assert_equal "1|2|2|2|2|2|6", rest_interface.list_of_purchases(client_id, password)
  end

  def now
    self
  end

  def -(_)
    @seconds
  end

  def debit(credit_card, total)
    @debit.call
  end

end
