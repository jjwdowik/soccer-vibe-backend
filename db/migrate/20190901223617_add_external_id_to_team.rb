class AddExternalIdToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :external_id, :bigint
  end
end
