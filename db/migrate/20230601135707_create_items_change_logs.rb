class CreateItemsChangeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :items_change_logs do |t|
      t.references :item
      t.references :user
      t.string :column_name
      t.string :prev_value
      t.string :new_value
      t.timestamps
    end
  end
end
