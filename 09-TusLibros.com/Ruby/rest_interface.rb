require './cashier'

class RestInterface
  A_MINUTE = 30 * 60
  
  def initialize(clients, catalog, clock, merchant_processor)
    @clients = clients
    @catalog = catalog
    @carts = {}
    @last_cart_id = 0
    @last_transaction_id = 0
    @sales_book_by_clientId = Hash.new({"isbn_amount" => Hash.new(0), "total" => 0})
    @carts_time = {}
    @clock = clock
    @merchant_processor = merchant_processor
  end

  def create_cart(client_id, password)
    raise Exception, RestInterface.nonexistent_client_error_description unless existing_client? client_id
    raise Exception, RestInterface.invalid_password_error_description unless valid_password? client_id, password

    @carts[next_cart_id] = {"cart" => (Cart.new @catalog), "clientId" => client_id}
    @carts_time[@last_cart_id] = @clock.now
    @last_cart_id
  end

  def add_to_cart(cart_id, isbn, quantity)
    validate_cart(cart_id)

    @carts[cart_id]["cart"].add(isbn, quantity)
  end

  def list_cart(cart_id)
    validate_cart(cart_id)

    @carts[cart_id]["cart"].list
  end

  def checkout(cart_id, credit_card)
    validate_cart(cart_id)
    clientIdOfTheCart = @carts[cart_id]["clientId"]
    cashier = Cashier.new @sales_book_by_clientId[clientIdOfTheCart], @carts[cart_id]["cart"], credit_card
    cashier.checkout(@merchant_processor)
    next_transaction_id
  end

  def list_of_purchases(client_id, password)
    raise Exception, RestInterface.nonexistent_client_error_description unless existing_client? client_id
    raise Exception, RestInterface.invalid_password_error_description unless valid_password? client_id, password
  
    @sales_book_by_clientId[client_id]
  end

  def self.nonexistent_client_error_description
    'Nonexistent users cannot create carts'
  end

  def self.invalid_password_error_description
    'The password must be valid in order to create a cart'
  end

  def self.nonexistent_cart_error_description
    'The cart does not exist'
  end

  def self.expired_cart_error_description
    'The cart does not exist anymore'
  end

  private

  def existing_cart?(cart_id)
    @carts.keys.include? cart_id
  end

  def existing_client?(client_id)
    @clients.keys.include? client_id
  end

  def valid_password?(client_id, password)
    @clients[client_id] == password
  end

  def expired_cart?(cart_id)
    (@carts_time[cart_id] - @clock.now) >= A_MINUTE
  end

  def validate_cart(cart_id)
    raise Exception, RestInterface.nonexistent_cart_error_description unless existing_cart? cart_id
    raise Exception, RestInterface.expired_cart_error_description if expired_cart? cart_id
  end

  def next_cart_id
    @last_cart_id = @last_cart_id + 1
  end

  def next_transaction_id
    @last_transaction_id = @last_transaction_id + 1
  end

end
