class ShoppingBag < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bag_items

  def add_product(product, params)
    current_item = bag_items.find_by(product: product)
    if current_item
      current_item.quantity += params[:quantity].to_i
      current_item
    else
      bag_items.build(product: product, quantity: params[:quantity])
    end
  end

  def total
    price = 0
    bag_items.each do |item|
      price += item.product.price * item.quantity
    end
    price
  end

  def calculate_postage
    2.95
  end

  def enough_stock?
    self.bag_items.each do |item|
      return false if item.product.quantity < item.quantity
    end
  end
end
