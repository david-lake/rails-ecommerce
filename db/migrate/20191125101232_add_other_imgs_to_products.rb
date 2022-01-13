class AddOtherImgsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :other_imgs, :string
  end
end
