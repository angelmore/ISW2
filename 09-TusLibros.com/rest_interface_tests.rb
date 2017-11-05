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
    rest_interface = Factory.empty_rest_interface

    exception = assert_raises Exception do
      rest_interface.create_cart(1, 'asd')
    end

    assert_equal exception.message, RestInterface.nonexistent_client_error_description
  end

  def test_02_cannot_create_cart_with_invalid_password
    rest_interface = Factory.rest_interface_with_user_and_catalog

    exception = assert_raises Exception do
      rest_interface.create_cart(1, 'asd')
    end

    assert_equal exception.message, RestInterface.invalid_password_error_description
  end

  def test_03_a_created_new_cart_is_empty
    rest_interface = Factory.rest_interface_with_user_and_catalog
    cart_id = Factory.create_cart(rest_interface)
    assert_equal rest_interface.list_cart(cart_id), []
  end

  def test_04_a_book_can_be_added_to_a_existing_cart
    rest_interface = Factory.rest_interface_with_user_and_catalog
    cart_id = Factory.create_cart(rest_interface)
    rest_interface.add_to_cart(cart_id, 1, 1)
    assert_equal rest_interface.list_cart(cart_id), [1]
  end

  def test_05_a_book_cannot_be_added_to_a_nonexisting_cart
    rest_interface = Factory.rest_interface_with_user_and_catalog
    cart_id = Factory.create_cart(rest_interface)
    exception = assert_raises Exception do
      rest_interface.add_to_cart(cart_id + 1, 1, 1)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_06_cannot_list_nonexistent_cart
    rest_interface = Factory.rest_interface_with_user_and_catalog

    exception = assert_raises Exception do
      rest_interface.list_cart(4)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_07_cannot_checkout_nonexistent_cart
    rest_interface = Factory.rest_interface_with_user_and_catalog

    exception = assert_raises Exception do
      rest_interface.checkout(1, Factory.valid_credit_card)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_08_cannot_checkout_nonexistent_cart
    rest_interface = Factory.rest_interface_with_user_and_catalog

    exception = assert_raises Exception do
      rest_interface.checkout(1, Factory.valid_credit_card)
    end

    assert_equal exception.message, RestInterface.nonexistent_cart_error_description
  end

  def test_09_cannot_list_the_purchases_of_nonexistent_client_id
    rest_interface = Factory.empty_rest_interface

    exception = assert_raises Exception do
      rest_interface.list_of_purchases(1, 'asd')
    end

    assert_equal exception.message, RestInterface.nonexistent_client_error_description
  end

  def test_10_cannot_list_the_purchases_of_a_client_with_invalid_password
    rest_interface = Factory.rest_interface_with_user_and_catalog
    client_id = Factory.a_user_with_a_password.keys.first
    password = Factory.a_user_with_a_password[client_id] + "1"

    exception = assert_raises Exception do
      rest_interface.list_of_purchases(client_id, password)
    end

    assert_equal exception.message, RestInterface.invalid_password_error_description
  end



end
