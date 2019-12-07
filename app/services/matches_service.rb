class MatchesService

  def initialize
  end

  def analyze_match(match, twitter_result_type = "popular")
    hashtag = match.twitter_hashtag
    # 1. Call Twitter API and get latest tweets
    # 2. Make sure all tweets are within last minute (set wait time)
    twitter_service = TwitterService.new
    ibm_service = IBMService.new
    # get since id
    tmt = TwitterMatchTracker.find_or_initialize_by(:match_id => match.id, :twitter_result_type => twitter_result_type)
    if tmt.twitter_since_id.nil?
      since_datetime = match.start_time-1.day
      tweets = twitter_service.get_tweets_by_twitter_hashtag(hashtag, {
        since_datetime: since_datetime, 
        until_datetime: match.start_time+1.day,
        result_type: twitter_result_type
      })
    else
      tweets = twitter_service.get_tweets_by_twitter_hashtag(hashtag, {
        since_id: tmt.twitter_since_id, 
        until_datetime: match.start_time+1.day,
        result_type: twitter_result_type
      })
    end

    potential_max_id = 0
    tweets.attrs[:statuses].each do |tweet|
      if tweet[:id] > potential_max_id
        potential_max_id = tweet[:id]
      end
    end

    next_results = tweets.attrs.dig(:search_metadata, :next_results)

    if next_results
      max_id = tweets.attrs.dig(:search_metadata, :next_results).split('max_id=')[1].split('&')[0]
    else
      max_id = tmt.twitter_since_id
    end

    if potential_max_id > max_id.to_i
      max_id = potential_max_id
    end

    tmt.update_attributes(:twitter_since_id => max_id)

    tweets_analyzed = ibm_service.analyze_tweets(tweets)

    tweets_analyzed.each do |tweet_analyzed|
      MatchTwitterVibe.create(:match_id => match.id,
                              :twitter_full_text => tweet_analyzed[:full_text],
                              :score => tweet_analyzed[:score],
                              :label => tweet_analyzed[:label],
                              :twitter_created_at => tweet_analyzed[:created_at],
                              :twitter_id => tweet_analyzed[:id],
                              :external_analyzer_response => tweet_analyzed[:response])
    end
    return tweets_analyzed
  end

end
