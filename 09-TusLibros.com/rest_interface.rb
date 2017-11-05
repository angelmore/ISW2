require './cashier'

class RestInterface
  def initialize(clients, catalog, clock)
    @clients = clients
    @catalog = catalog
    @carts = {}
    @last_cart_id = 0
    @sales_book = {}
    @carts_time = {}
    @clock = clock
  end

  def create_cart(client_id, password)
    raise Exception, RestInterface.nonexistent_client_error_description unless existing_client? client_id
    raise Exception, RestInterface.invalid_password_error_description unless valid_password? client_id, password

    @carts[next_cart_id] = Cart.new @catalog
    @carts_time[@last_cart_id] = @clock.now
    @last_cart_id
  end

  def add_to_cart(cart_id, isbn, quantity)
    validate_cart(cart_id)

    @carts[cart_id].add(isbn, quantity)
  end

  def list_cart(cart_id)
    validate_cart(cart_id)

    @carts[cart_id].list
  end

  def checkout(cart_id, credit_card)
    validate_cart(cart_id)
  end

  def list_of_purchases(client_id, password)
    raise Exception, RestInterface.nonexistent_client_error_description unless existing_client? client_id
    raise Exception, RestInterface.invalid_password_error_description unless valid_password? client_id, password
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
    (@carts_time[cart_id] - @clock.now) >= 30 * 60
  end

  def validate_cart(cart_id)
    raise Exception, RestInterface.nonexistent_cart_error_description unless existing_cart? cart_id
    raise Exception, RestInterface.expired_cart_error_description if expired_cart? cart_id
  end

  def next_cart_id
    @last_cart_id = @last_cart_id + 1
  end
end
