class AddTwitterIdToMatchTwitterVibe < ActiveRecord::Migration[5.2]
  def change
    add_column :match_twitter_vibes, :twitter_id, :bigint
  end
end
