class TwitterService

  def initialize(opts = {})
    @client = ::Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    @opts = opts
  end

  def get_tweets_by_twitter_hashtag(hashtag, opts = {})
    @client.search("##{hashtag} -rt", get_options(opts[:since_id], opts[:since_datetime], opts[:until_datetime], opts[:result_type]))
  end
  # result_types can be [mixed, recent, popular]
  def get_options(since_id = nil, since_datetime = nil, until_datetime = nil, result_type)
    result_type = result_type.nil? ? "popular" : result_type
    opts = {result_type: result_type, tweet_mode: "extended", lang: "en"}
    if since_id.present?
       since = {since_id: since_id}
    else
      if since_datetime.present?
        since = {since: since_datetime.strftime("%Y-%m-%d")}
      else
        since = {since: (Time.zone.now - 2.days).strftime("%Y-%m-%d")}
      end
    end

    opts = opts.merge(since)
    if until_datetime.present?
      opts = opts.merge({until: until_datetime.strftime("%Y-%m-%d")})
    end
    return opts
  end
end
