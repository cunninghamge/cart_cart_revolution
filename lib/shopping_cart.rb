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

  def is_full?
    total_number_of_products >= @capacity
  end

  def products_by_category(category)
    @products.select do |product|
      product.category == category
    end
  end

  def percentage_occupied
    (100.0 * total_number_of_products / @capacity).round(2)
  end

  def sorted_products_by_quantity
    @products.sort_by do |product|
      -product.quantity
    end
  end

  def product_breakdown
    breakdown = {}
    @products.each do |product|
      if breakdown.key?(product.category)
        breakdown[product.category] << product
      else
        breakdown[product.category] = [product]
      end
    end
    breakdown
  end
end
