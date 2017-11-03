require './cashier'

class RestInterface
  def initialize(clients, catalog)
    @clients = clients
    @catalog = catalog
    @carts = {}
    @last_cart_id = 0
  end

  def create_cart(client_id, password)
    raise Exception, RestInterface.nonexistent_client_error_description unless @clients.keys.include? client_id
    raise Exception, RestInterface.invalid_password_error_description unless @clients[client_id] == password

    @carts[next_cart_id] = Cart.new @catalog
    @last_cart_id
  end

  def add_to_cart(cart_id, isbn, quantity)
    raise Exception, RestInterface.nonexistent_cart_error_description unless @carts.keys.include? cart_id
    @carts[cart_id].add(isbn, quantity)
  end

  def list_cart(cart_id)
    raise Exception, RestInterface.nonexistent_cart_error_description unless @carts.keys.include? cart_id
    @carts[cart_id].list
  end

  def next_cart_id
    @last_cart_id = @last_cart_id + 1
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
end
