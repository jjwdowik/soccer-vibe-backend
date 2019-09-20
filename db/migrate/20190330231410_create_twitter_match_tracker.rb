class CreateTwitterMatchTracker < ActiveRecord::Migration[5.2]
  def change
    create_table :twitter_match_trackers do |t|
      t.bigint :match_id
      t.bigint :twitter_since_id
    end
  end
end
