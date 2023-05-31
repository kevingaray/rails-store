class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 1
      t.references :item, null: false, foreign_key: true
      t.integer :cart_id, null: true
      t.integer :order_id, null: true
      t.timestamps
    end
  end
end
