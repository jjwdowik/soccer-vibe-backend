class AddExtraDataToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :winner_side, :text
    add_column :matches, :winner_external_id, :integer
    add_column :matches, :away_team_external_id, :integer
    add_column :matches, :away_team, :text
    add_column :matches, :home_team_external_id, :integer
    add_column :matches, :home_team, :text
    add_column :matches, :status, :text

    add_index :matches, :winner_external_id
    add_index :matches, :away_team_external_id
    add_index :matches, :home_team_external_id
  end
end
