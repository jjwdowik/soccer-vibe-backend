class AddExternalAnalyzerResponseToMatchTwitterVibe < ActiveRecord::Migration[5.2]
  def change
    add_column :match_twitter_vibes, :external_analyzer_response, :jsonb
  end
end
