class Match < ActiveRecord::Base

  has_many :match_twitter_vibes
  has_many :twitter_match_trackers

  MATCH_DURATION_IN_HOURS = 3

  scope :by_team_id, -> (team_id){ where("matches.home_team_external_id = ? OR matches.away_team_external_id = ?", team_id, team_id) }
  scope :is_active_game, -> (current_time, end_time_check){ where("matches.start_time < ? AND matches.start_time > ?", current_time, end_time_check) }

end
