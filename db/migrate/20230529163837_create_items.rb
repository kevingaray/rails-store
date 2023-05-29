class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string "name"
      t.decimal "price", precision: 8, scale: 2
      t.integer "stock"
      t.datetime "deleted_at"
      t.string "stripe_product_id"
      t.string "stripe_price_id"  
      t.timestamps
    end
  end
end
