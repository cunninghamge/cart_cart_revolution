class ShoppingCart
  attr_reader :name, :capacity, :products

  def initialize(name, capacity)
    @name = name
    @capacity = capacity.to_i
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def details
    details = {}
    details[:name] = @name
    details[:capacity] = @capacity
    details
  end

  def total_number_of_products
    @products.sum do |product|
      product.quantity
    end
  end
end
