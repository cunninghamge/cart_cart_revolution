require "minitest/autorun"
require "minitest/pride"
require './lib/shopping_cart'
require './lib/product'

class ShoppingCartTest < Minitest::Test
  def setup
    @cart = ShoppingCart.new("King Soopers", "30items")
  end

  def test_it_exists
    assert_instance_of ShoppingCart, @cart
  end

  def test_attributes
    assert_equal "King Soopers", @cart.name
    assert_equal 30, @cart.capacity
    assert_equal [], @cart.products
  end

  def test_add_products
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    @cart.add_product(product1)
    @cart.add_product(product2)

    assert_equal [product1, product2], @cart.products
  end
  # assert_equal {name: "King Soopers", capacity: 30}, @cart.details
end
