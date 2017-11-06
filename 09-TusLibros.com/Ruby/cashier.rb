require './cart'
require './credit_card'

class Cashier
  def initialize(sales_book, cart, credit_card)
    @sales_book = sales_book
    @cart = cart
    @credit_card = credit_card
  end

  def checkout(merchant_processor)
    raise Exception, Cashier.invalid_cart_error_description if @cart.empty?
    raise Exception, Cashier.credit_card_expired_error_description if @credit_card.is_expired?(Time.now)

    total = calculate_total

    merchant_processor.debit(@credit_card, total)

    update_sales_book_isbn(total)
    total
  end

  def sales_book
    @sales_book
  end

  def calculate_total
    @cart.list.keys.inject(0) do |total, isbn|
      total + @cart.catalog[isbn]*@cart.list[isbn]
    end
  end

  def update_sales_book_isbn(total)
    @cart.list.each do |isbn, cant| 
        sales_book["isbn_amount"][isbn]+= cant
    end

    sales_book["total"] += total
  end


  def self.invalid_cart_error_description
    'The cart cannot be empty'
  end

  def self.credit_card_expired_error_description
    'The credit card cannot be expired'
  end

end