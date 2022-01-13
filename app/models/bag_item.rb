class BagItem < ApplicationRecord
  belongs_to :shopping_bag
  belongs_to :product
  validates :shopping_bag_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }  
end
