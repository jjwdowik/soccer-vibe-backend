
class GetVibeJobTest < ApplicationJob
  queue_as :default

  def perform(match_id, amount_to_create)
    @current_time = Time.now
    @match_id = match_id
    @amount_to_create = amount_to_create
    do_job
  end

  def do_job
    match = Match.find(@match_id)
    twitter_result_type = "popular"
    tmt = TwitterMatchTracker.find_or_initialize_by(:match_id => @match_id, :twitter_result_type => twitter_result_type)
    start_id = match.match_twitter_vibes.maximum(:id)
    (0..@amount_to_create).each do |number|
      MatchTwitterVibe.create(:match_id => @match_id,
                              :twitter_full_text => "#{number} :FULL TEXT WOHOO!!!",
                              # :score => rand(-1.00...1.00),
                              :score => 1.00,
                              :label => "positive",
                              :twitter_created_at => Time.current,
                              :twitter_id => Time.current.to_i)
    end
    end_id = match.match_twitter_vibes.maximum(:id)
    if start_id != end_id
      CHANNELS_CLIENT.trigger('soccer-vibe', 'new-vibes', {
        start_id: start_id,
        end_id: end_id
      })
    end
  end

end
