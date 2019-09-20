class AddExternalMatchIdToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :external_match_id, :integer
    add_index :matches, :external_match_id
  end
end
