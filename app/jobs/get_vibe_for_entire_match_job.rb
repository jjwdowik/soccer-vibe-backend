class GetVibeForEntireMatchJob < ApplicationJob
  queue_as :default

  SLEEP_TIME = 0.5
  MAX_VIBE_COUNT = 1000

  def perform(match_id)
    do_job(match_id)
  end

  def do_job(match_id)
    match = Match.find(match_id)
    matches_service = MatchesService.new
    finished_analying = false
    until finished_analying
      analyzed_tweets = matches_service.analyze_match(match)
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
