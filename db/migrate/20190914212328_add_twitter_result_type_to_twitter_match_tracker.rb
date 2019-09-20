class AddTwitterResultTypeToTwitterMatchTracker < ActiveRecord::Migration[5.2]
  def change
    add_column :twitter_match_trackers, :twitter_result_type, :text
  end
end
