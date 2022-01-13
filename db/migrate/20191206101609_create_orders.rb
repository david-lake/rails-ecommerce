class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.decimal :item_total
      t.decimal :postage
      t.integer :status, default: 0
      t.references :shipping_address, foreign_key: false
      t.references :billing_address, foreign_key: false

      t.timestamps
    end
  end
end
