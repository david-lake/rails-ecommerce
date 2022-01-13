class CreateBagItems < ActiveRecord::Migration[5.1]
  def change
    create_table :bag_items do |t|
      t.references :shopping_bag, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
