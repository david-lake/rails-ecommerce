class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :billing_address,  class_name: "Address"
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  has_many :order_items
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :status, presence: true
end
