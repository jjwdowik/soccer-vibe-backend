
class GetVibeJob < ApplicationJob
  queue_as :default

  WAIT_TIME_IN_MINUTES = 1

  def perform
    @current_time = Time.now
    do_job
  end

  def do_job
    # job runs for active games, and gets latest 10 tweets and analyzes them
    laliga_id = "PD"
    # do it only for barcelona right now
    team_id = 81
    matches_service = MatchesService.new

    end_time_check = @current_time - Match::MATCH_DURATION_IN_HOURS.hours

    barcelona_active_match = Match.by_team_id(team_id).where("matches.league_id = ?", laliga_id).is_active_game(@current_time, end_time_check).first
    if !barcelona_active_match.nil? && !barcelona_active_match.twitter_hashtag.nil?
      start_id = barcelona_active_match.match_twitter_vibes.maximum(:id)
      matches_service.analyze_match(barcelona_active_match)
      end_id = barcelona_active_match.match_twitter_vibes.maximum(:id)
      if start_id != end_id
        CHANNELS_CLIENT.trigger('soccer-vibe', 'new-vibes', {
          start_id: start_id,
          end_id: end_id
        })
      end
    end
  end

end
