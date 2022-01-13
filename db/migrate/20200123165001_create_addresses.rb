class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :town
      t.string :county
      t.string :postcode

      t.timestamps
    end
  end
end
