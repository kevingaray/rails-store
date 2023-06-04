class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.references :user
      t.text :body
      t.integer :rate
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
