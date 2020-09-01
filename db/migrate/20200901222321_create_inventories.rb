class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories, id: :uuid do |t|
      t.references :person, null: false, type: :uuid, foreign_key: true
      t.references :resource, null: false, type: :uuid, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
