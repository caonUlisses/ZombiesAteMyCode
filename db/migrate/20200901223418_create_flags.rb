class CreateFlags < ActiveRecord::Migration[6.0]
  def change
    create_table :flags, id: :uuid do |t|
      t.references :flagger, null: false, type: :uuid, foreign_key: { to_table: :people }
      t.references :flagged, null: false, type: :uuid, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end
