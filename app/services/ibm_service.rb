require "json"
require "ibm_watson/natural_language_understanding_v1"
include IBMWatson

class IBMService

  def initialize
    @natural_language_understanding = IBMWatson::NaturalLanguageUnderstandingV1.new(
      version: "2018-11-16",
      iam_apikey: ENV['IBM_API_KEY'],
      url: ENV['IMB_API_URL']
    )
  end

  def analyze_tweets(tweets)
    analyzed_tweets_arr = []

    tweets.attrs[:statuses].each do |tweet|
      if MatchTwitterVibe.exists?(:twitter_id => tweet[:id])
        Raven.capture_message("Tweet already exists for #{tweet[:id]} : #{tweet[:full_text]}")
        next
      end
      response = analyze_text(tweet[:full_text])
      if response
        score = response.result["sentiment"]["document"]["score"]
        label = response.result["sentiment"]["document"]["label"]
        created_at = tweet[:created_at]
        analyzed_tweets_arr.push({score: score, label: label, created_at: created_at, full_text: tweet[:full_text], response: response, id: tweet[:id]})
      end
    end
    return analyzed_tweets_arr
  end

  def analyze_text(text)
    begin
      response = @natural_language_understanding.analyze(
        text: text,
        features: {sentiment: {}},
        language: 'en'
      )
      return response
    rescue WatsonApiException => e
      Raven.extra_context text: text
      Raven.capture_exception(e)
      return false
    end
  end

end
