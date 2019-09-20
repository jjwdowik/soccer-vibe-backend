class CreateMatchTwitterVibe < ActiveRecord::Migration[5.2]
  def change
    create_table :match_twitter_vibes do |t|
      t.bigint :match_id
      t.text :twitter_full_text
      t.float :score
      t.string :label
      t.datetime :twitter_created_at

      t.timestamps
    end
  end
end
