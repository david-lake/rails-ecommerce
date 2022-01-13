class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy
  validates :name, presence: true
  validates :category_id, presence: true

  def display_name
    name.capitalize
  end
end
