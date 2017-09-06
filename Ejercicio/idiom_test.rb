require 'minitest/autorun'
require 'minitest/reporters'
require './customer_book'

MiniTest::Reporters.use!

class IdiomTest < Minitest::Test

  def customer_book_operation_takes_less_than_x_milliseconds?(customer, operation, parameters, x)
    millisecondsBeforeRunning = Time.now
    customer.send(operation, *parameters)
    millisecondsAfterRunning = Time.now
    (millisecondsAfterRunning-millisecondsBeforeRunning) < x
  end

  def test_01_adding_a_customer_should_not_take_more_than_50_milliseconds
    assert customer_book_operation_takes_less_than_x_milliseconds?(CustomerBook.new, :add_customer_named, ["John Lenon"], 50)
  end

  def  test_02_removing_a_customer_should_not_take_more_than_100_milliseconds
    customerBook = CustomerBook.new
    paulMcCartney = "Paul McCartney"
    customerBook.add_customer_named paulMcCartney
    assert customer_book_operation_takes_less_than_x_milliseconds?(customerBook, :remove_customer_named, ["Paul McCartney"], 100)
  end

  def customer_book_verifies_exception_message_and_conditions?(customer_book_message)
    customer_book = CustomerBook.new

    begin
      customer_book.send *customer_book_message
      self.fail
    rescue Exception => anException
      yield customer_book, anException
    end
  end

  def test_03_can_not_add_a_customer_with_emtpy_name
    customer_book_verifies_exception_message_and_conditions?([:add_customer_named, ""]) do |customer_book, anException|
      assert_equal CustomerBook.customer_name_can_not_be_empty_error_description, anException.message
      assert customer_book.empty?
    end
  end

  def test_04_can_not_remove_not_added_customer
    customer_book_verifies_exception_message_and_conditions?([:remove_customer_named, ""]) do |customer_book, anException|
      assert_equal CustomerBook.customer_does_not_exist_error_description, anException.message
    end
  end
end
