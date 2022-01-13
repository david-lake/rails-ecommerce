class AddPrimaryImgToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :primary_img, :string
  end
end
