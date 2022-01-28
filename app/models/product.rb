class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  mount_uploader  :primary_img, ProductImageUploader
  mount_uploaders :other_imgs,  ProductImageUploader
  serialize :other_imgs, JSON # For SQLlite
  validates :category_id,     presence: true
  validates :sub_category_id, presence: true
  validates :name,            presence: true
  validates :price,           presence: true,
                              format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                              numericality: { greater_than: 0, less_than: 100 }
  validates :quantity,        presence: true, numericality: { only_integer: true }
  validate :image_size

  def has_stock?
    return self.quantity > 0 ? true : false
  end

  def update_stock(int)
    update_attributes(quantity: quantity - int)
    if quantity == 0
      AdminMailer.stock_empty(self).deliver_now
    end
  end

  def as_json(options = nil)
    hash = super({ :only => [:id, :name, :description, :quantity, :price, :updated_at] })
    hash.store(:product_name, hash.delete("name"))
    hash[:updated_at] = self.updated_at.to_datetime.strftime("%d-%m-%Y %H:%M")
    return hash
  end

  private

    # Validates the size of an uploaded picture.
    def image_size
      if primary_img.size > 5.megabytes
        errors.add(:primary_img, "should be less than 5MB")
      end
    end
end
