require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:avatar].any?
  end

  test "product title length" do
    product = Product.new(
      description: '$$$',
      avatar: sample_file('bob.jpg'),
      price: 19.90
    )

    product.title = 'ab'
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"],
      product.errors[:title]

    product.title = 'The Great Programmer Book'
    assert product.valid?
  end

  test "product price must be positive" do
    product = Product.new(
      title: 'How I became a billionaire',
      description: '$$$',
      avatar: sample_file('bob.jpg'),
    )

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "product is not valid without a unique title" do
    product = Product.new(
      title: products(:ruby).title,
      description: "yyy",
      price: 1,
      avatar: sample_file('bob.jpg')
    )
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end

  def new_product(file_name)
    @title =  "How I became a billionaire #{rand(1000)}"
    Product.new(
      title: @title,
      description: "$$$",
      price: 1,
      avatar_file_name: file_name
    )
  end

  test "avatar file format" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/x/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
        assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is valid" do
    product = Product.new(
      title: "HELLLOOO THERE",
      description: "yyy",
      price: 1,
      avatar: sample_file('bob.jpg')
    )
    assert_equal true, product.save
  end
end