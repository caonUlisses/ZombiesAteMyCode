class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people, id: :uuid do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.point :last_location
      t.integer :infected

      t.timestamps
    end
  end
end
