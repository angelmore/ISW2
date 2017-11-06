class Cart
  def initialize(catalog)
    @isbn_amount = Hash.new(0)
    @catalog = catalog
  end

  def empty?
    @isbn_amount.empty?
  end

  def add(isbn, quantity)
    raise Exception, Cart.invalid_isbn_error_description unless @catalog.keys.include?(isbn)
    raise Exception, Cart.invalid_quantity_error_description unless (quantity > 0 && quantity.class == Fixnum)
    @isbn_amount[isbn]+= quantity
  end

  def list
    @isbn_amount
  end

  def catalog
    @catalog
  end

  def self.invalid_isbn_error_description
    "Invalid isbn"
  end

  def self.invalid_quantity_error_description
    "Invalid quantity"
  end
end