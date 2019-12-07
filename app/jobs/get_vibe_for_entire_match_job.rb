class GetVibeForEntireMatchJob < ApplicationJob
  queue_as :default

  SLEEP_TIME = 0.5
  MAX_VIBE_COUNT = 1000
  # twitter_result_type other option is "recent"
  def perform(match_id, twitter_result_type = "popular")
    do_job(match_id, twitter_result_type)
  end

  def do_job(match_id, twitter_result_type)
    match = Match.find(match_id)
    matches_service = MatchesService.new
    finished_analying = false
    until finished_analying
      analyzed_tweets = matches_service.analyze_match(match, twitter_result_type)
      puts "analyzed_tweets"
      puts analyzed_tweets.count
      puts analyzed_tweets
      if MatchTwitterVibe.where("match_twitter_vibes.match_id = ?", match.id).count >= MAX_VIBE_COUNT || analyzed_tweets.count == 0
        finished_analying = true
      end
      sleep SLEEP_TIME
    end
  end

end
