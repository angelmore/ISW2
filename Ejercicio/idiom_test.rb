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

    # customerBook = CustomerBook.new
    #
    # millisecondsBeforeRunning = Time.now
    # customerBook.add_customer_named "John Lenon"
    # millisecondsAfterRunning = Time.now
    #
    # assert (millisecondsAfterRunning-millisecondsBeforeRunning) < 50

    assert customer_book_operation_takes_less_than_x_milliseconds?(CustomerBook.new, :add_customer_named, ["John Lenon"], 50)
  end

  def  test_02_removing_a_customer_should_not_take_more_than_100_milliseconds
    customerBook = CustomerBook.new
    paulMcCartney = "Paul McCartney"
    customerBook.add_customer_named paulMcCartney
    #
    # millisecondsBeforeRunning = Time.now
    # customerBook.remove_customer_named paulMcCartney
    # millisecondsAfterRunning = Time.now
    #
    # assert (millisecondsAfterRunning-millisecondsBeforeRunning) < 100
    assert customer_book_operation_takes_less_than_x_milliseconds?(customerBook, :remove_customer_named, ["Paul McCartney"], 100)
  end

  def test_03_can_not_add_a_customer_with_emtpy_name
    customerBook = CustomerBook.new

    begin
      customerBook.add_customer_named ""
      self.fail
    rescue Exception => anException
      assert_equal CustomerBook.customer_name_can_not_be_empty_error_description, anException.message
      assert customerBook.empty?
    end

  end

  def test_04_can_not_remove_not_added_customer

    customerBook = CustomerBook.new

    begin
      customerBook.remove_customer_named "John Lennon"
      self.fail
    rescue Exception => anException
      assert_equal CustomerBook.customer_does_not_exist_error_description, anException.message
    end

  end
end
