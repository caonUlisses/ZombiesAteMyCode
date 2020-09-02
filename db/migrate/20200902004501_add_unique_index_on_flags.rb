class AddUniqueIndexOnFlags < ActiveRecord::Migration[6.0]
  def change
    add_index :flags, [:flagged_id, :flagger_id], unique: true
  end
end
