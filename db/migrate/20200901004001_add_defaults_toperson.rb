class AddDefaultsToperson < ActiveRecord::Migration[6.0]
  def change
    change_column_default :people, :infected, 0
  end
end
