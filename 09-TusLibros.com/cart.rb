class Cart
  def initialize(catalog)
    @list = []
    @catalog = catalog
  end

  def empty?
    @list.empty?
  end

  def add(isbn, quantity)
    raise Exception, Cart.invalid_isbn_error_description unless @catalog.include?(isbn)
    raise Exception, Cart.invalid_quantity_error_description unless (quantity > 0 && quantity.class == Fixnum)
    @list.concat [isbn] * quantity
  end

  def list
    @list
  end

  def self.invalid_isbn_error_description
    "Invalid isbn"
  end

  def self.invalid_quantity_error_description
    "Invalid quantity"
  end
end
