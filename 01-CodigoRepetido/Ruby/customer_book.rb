class CustomerBook

  def initialize
    @books = Array.new
  end

  def add_customer_named (aName)
    raise self.class.customer_name_can_not_be_empty_error_description if aName.empty?
    @books << aName
  end

  def remove_customer_named (aName)
    raise self.class.customer_does_not_exist_error_description if !@books.include? aName
    @books.delete aName
  end

  def self.customer_does_not_exist_error_description
    "Customer does not exist"
  end

  def self.customer_name_can_not_be_empty_error_description
    "Customer can not have an empty name"
  end

  def empty?
    @books.empty?
  end
end