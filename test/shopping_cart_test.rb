require "minitest/autorun"
require "minitest/pride"
require './lib/shopping_cart'
require './lib/product'

class ShoppingCartTest < Minitest::Test
  def setup
    @cart = ShoppingCart.new("King Soopers", "30items")
    @product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    @product2 = Product.new(:meat, 'chicken', 4.50, '2')
    @product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    @product4 = Product.new(:produce, 'apples', 0.99, '20')
    @product5 = Product.new(:produce, 'carrots', 0.25, '5')
    @product6 = Product.new(:bakery, 'bagels', 1.65, '12')
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
    @cart.add_product(@product1)
    @cart.add_product(@product2)

    assert_equal [@product1, @product2], @cart.products
  end

  def test_cart_details
    expected = {name: "King Soopers", capacity: 30}
    assert_equal expected, @cart.details
  end

  def test_total_number_of_products
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    assert_equal 13, @cart.total_number_of_products
  end

  def test_is_full?
    assert_equal false, @cart.is_full?

    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    assert_equal false, @cart.is_full?

    @cart.add_product(@product4)

    assert_equal true, @cart.is_full?
  end

  def test_products_by_category
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    assert_equal [@product1, @product3], @cart.products_by_category(:paper)
  end

  def test_percentage_occupied
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    assert_equal 43.33, @cart.percentage_occupied

    @cart.add_product(@product5)
    assert_equal 60.0, @cart.percentage_occupied

    @cart.add_product(@product6)
    assert_equal 100.0, @cart.percentage_occupied
  end

  def test_sorted_products_by_quantity
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)
    assert_equal [@product4, @product1, @product2, @product3], @cart.sorted_products_by_quantity
  end

  def test_product_breakdown
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    expected = {:meat=> [@product2], :paper=> [@product1, @product3], :produce=> [@product4]}
    assert_equal expected, @cart.product_breakdown

    @cart.add_product(@product5)
    @cart.add_product(@product6)

    expected = {:bakery=> [@product6], :meat=> [@product2], :paper=> [@product1, @product3], :produce=> [@product4, @product5]}
    assert_equal expected, @cart.product_breakdown
  end
end
