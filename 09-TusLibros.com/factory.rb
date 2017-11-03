class Factory
  def self.isbn_prices(isbn)
    prices = Hash.new
    prices[isbn] = 5
    prices
  end

  def self.isbns_1_2_prices_5_10
    { 1 => 5, 2 => 10 }
  end

  def self.empty_catalog
    {}
  end

  def self.month_year
    MonthYear.new 10, 2020
  end

  def self.expired_month_year
    MonthYear.new 10, 1900
  end

  def self.valid_credit_card
    CreditCard.new '9' * 16, 'Pepito Casimiro', Factory.month_year
  end

  def self.expired_credit_card
    CreditCard.new '9' * 16, 'Pepito Casimiro', Factory.expired_month_year
  end

  def self.user_id_1_password_pepito
    { 1 => 'pepito' }
  end

  def self.empty_rest_interface
    RestInterface.new Hash.new, Array.new
  end

  def self.rest_interface_with_user_and_catalog
    RestInterface.new Factory.user_id_1_password_pepito, Factory.isbns_1_2_prices_5_10
  end
end